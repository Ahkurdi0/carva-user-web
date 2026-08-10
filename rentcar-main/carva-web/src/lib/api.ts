// API client for the Carva backend. Every endpoint is POST (per the server's
// CORS config), auth is a JWT Bearer token, and a `devicelang` header carries
// the active locale. Mirrors the Flutter app's DioService behaviour, including
// transparent access-token refresh on 401.

import type { Lang } from "./types";

// By default all calls go through the Next.js proxy (/api/proxy/<endpoint>) so
// the backend's single-origin CORS never blocks the browser. Set
// NEXT_PUBLIC_USE_PROXY=false to hit the API host directly instead (requires
// the web origin to be in the backend CORS allowlist).
const USE_PROXY = process.env.NEXT_PUBLIC_USE_PROXY !== "false";

export const API_BASE = USE_PROXY
  ? "/api/proxy"
  : process.env.NEXT_PUBLIC_API_BASE?.replace(/\/$/, "") || "/api/v1";

export const IMAGE_BASE =
  process.env.NEXT_PUBLIC_IMAGE_BASE?.replace(/\/$/, "") || "";

const ACCESS_KEY = "carva.accessToken";
const REFRESH_KEY = "carva.refreshToken";
const LANG_KEY = "carva.lang";

export const tokens = {
  get access() {
    if (typeof window === "undefined") return null;
    return localStorage.getItem(ACCESS_KEY);
  },
  get refresh() {
    if (typeof window === "undefined") return null;
    return localStorage.getItem(REFRESH_KEY);
  },
  set(access: string, refresh: string) {
    localStorage.setItem(ACCESS_KEY, access);
    localStorage.setItem(REFRESH_KEY, refresh);
  },
  clear() {
    localStorage.removeItem(ACCESS_KEY);
    localStorage.removeItem(REFRESH_KEY);
  },
};

export function getLang(): Lang {
  if (typeof window === "undefined") return "en";
  return (localStorage.getItem(LANG_KEY) as Lang) || "en";
}

export function setLang(lang: Lang) {
  localStorage.setItem(LANG_KEY, lang);
}

export class ApiError extends Error {
  status: number;
  code?: string;
  constructor(status: number, message: string, code?: string) {
    super(message);
    this.status = status;
    this.code = code;
  }
}

let refreshing: Promise<string | null> | null = null;

async function doRefresh(): Promise<string | null> {
  const refresh = tokens.refresh;
  if (!refresh) return null;
  try {
    const res = await fetch(`${API_BASE}/auth/refreshToken`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${refresh}`,
      },
    });
    if (!res.ok) {
      tokens.clear();
      return null;
    }
    const data = await res.json();
    if (data?.accessToken && data?.refreshToken) {
      tokens.set(data.accessToken, data.refreshToken);
      return data.accessToken as string;
    }
    tokens.clear();
    return null;
  } catch {
    return null;
  }
}

function onUnauthorized() {
  tokens.clear();
  if (typeof window !== "undefined") {
    window.dispatchEvent(new CustomEvent("carva:logout"));
  }
}

interface RequestOptions {
  /** Send as multipart/form-data instead of JSON. */
  form?: FormData;
  /** Skip attaching the access token even if present. */
  noAuth?: boolean;
  /** Override the Authorization token (used for refresh-bearer endpoints). */
  bearer?: string;
}

async function request<T>(
  path: string,
  body?: unknown,
  opts: RequestOptions = {},
  isRetry = false,
): Promise<T> {
  const headers: Record<string, string> = {
    Accept: "application/json",
    devicelang: getLang(),
  };

  if (!opts.form) headers["Content-Type"] = "application/json";

  const token = opts.bearer ?? (opts.noAuth ? null : tokens.access);
  if (token) headers["Authorization"] = `Bearer ${token}`;

  let res: Response;
  try {
    res = await fetch(`${API_BASE}${path}`, {
      method: "POST",
      headers,
      body: opts.form ? opts.form : body !== undefined ? JSON.stringify(body) : undefined,
    });
  } catch {
    throw new ApiError(0, "Network error. Please check your connection.");
  }

  if (res.status === 401 && !opts.noAuth && !opts.bearer && !isRetry) {
    refreshing = refreshing ?? doRefresh();
    const newToken = await refreshing;
    refreshing = null;
    if (newToken) return request<T>(path, body, opts, true);
    onUnauthorized();
    throw new ApiError(401, "Session expired. Please sign in again.");
  }

  if (!res.ok) {
    let message = `Request failed (${res.status})`;
    let code: string | undefined;
    try {
      const data = await res.json();
      if (typeof data === "string") message = data;
      else if (data?.message) message = data.message;
      else if (data?.error) {
        message = data.error;
        code = data.error;
      }
    } catch {
      /* ignore non-json error bodies */
    }
    throw new ApiError(res.status, message, code);
  }

  // Some endpoints return 200 with an empty body (res.end()).
  const text = await res.text();
  if (!text) return undefined as T;
  try {
    return JSON.parse(text) as T;
  } catch {
    return text as unknown as T;
  }
}

export const api = {
  post: request,
  /** POST with a JSON body and a typed result. */
  json<T>(path: string, body?: unknown, opts?: RequestOptions) {
    return request<T>(path, body, opts);
  },
  /** POST multipart form (image uploads). */
  form<T>(path: string, form: FormData, opts?: RequestOptions) {
    return request<T>(path, undefined, { ...opts, form });
  },
};

/** Resolve a stored image key to an absolute URL. */
export function imageUrl(key?: string | null): string {
  if (!key) return "";
  if (key.startsWith("http://") || key.startsWith("https://")) return key;
  return IMAGE_BASE ? `${IMAGE_BASE}/${key}` : key;
}
