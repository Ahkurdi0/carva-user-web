// Server-side passthrough to the Carva backend. The browser calls
// /api/proxy/<endpoint>; this handler forwards it to the real API host from
// the server, so the backend's single-origin CORS never applies. Auth header,
// devicelang and the raw body (JSON or multipart) are forwarded as-is.

import { NextRequest } from "next/server";

const UPSTREAM = (
  process.env.API_UPSTREAM ||
  process.env.NEXT_PUBLIC_API_BASE ||
  ""
).replace(/\/$/, "");

export const runtime = "nodejs";
export const dynamic = "force-dynamic";

async function forward(req: NextRequest, path: string[]) {
  if (!UPSTREAM) {
    return Response.json(
      { error: "API_UPSTREAM / NEXT_PUBLIC_API_BASE is not configured" },
      { status: 500 },
    );
  }

  const search = req.nextUrl.search;
  const target = `${UPSTREAM}/${path.join("/")}${search}`;

  const headers = new Headers();
  const auth = req.headers.get("authorization");
  const lang = req.headers.get("devicelang");
  const ctype = req.headers.get("content-type");
  if (auth) headers.set("authorization", auth);
  if (lang) headers.set("devicelang", lang);
  if (ctype) headers.set("content-type", ctype);
  headers.set("accept", "application/json");

  // Forward the real visitor IP so the backend's per-IP rate limiters and
  // logging see each user, not just the web server. (The backend must
  // `app.set('trust proxy', true)` to honor these.)
  const fwd = req.headers.get("x-forwarded-for");
  const realIp = req.headers.get("x-real-ip") ?? fwd?.split(",")[0].trim();
  if (fwd) headers.set("x-forwarded-for", fwd);
  if (realIp) headers.set("x-real-ip", realIp);

  const method = req.method.toUpperCase();
  const body =
    method === "GET" || method === "HEAD" ? undefined : await req.arrayBuffer();

  let upstream: Response;
  try {
    upstream = await fetch(target, {
      method,
      headers,
      body,
      redirect: "manual",
      cache: "no-store",
    });
  } catch {
    return Response.json({ error: "Upstream unreachable" }, { status: 502 });
  }

  // Strip hop-by-hop / encoding headers (fetch already decoded the body).
  const resHeaders = new Headers();
  const passType = upstream.headers.get("content-type");
  if (passType) resHeaders.set("content-type", passType);

  const buf = await upstream.arrayBuffer();
  return new Response(buf, {
    status: upstream.status,
    headers: resHeaders,
  });
}

type Ctx = { params: Promise<{ path: string[] }> };

export async function POST(req: NextRequest, ctx: Ctx) {
  const { path } = await ctx.params;
  return forward(req, path);
}

export async function GET(req: NextRequest, ctx: Ctx) {
  const { path } = await ctx.params;
  return forward(req, path);
}
