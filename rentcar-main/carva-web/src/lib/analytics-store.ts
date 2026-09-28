// Server-only visitor analytics store.
//
// The real Carva backend is a remote API we don't control, so visitor tracking
// lives entirely inside this Next.js app. Every page open (web or app) is
// appended as one JSON line to a file on disk; the admin panel reads + aggregates
// it. IPs are geolocated once and cached so we don't hammer the geo provider.
//
// Storage location defaults to <cwd>/data/visits.jsonl. Override with
// ANALYTICS_DATA_DIR to point at a path that survives redeploys.

// NOTE: import only from server contexts (route handlers) — it touches fs.
import { promises as fs } from "fs";
import path from "path";

export type Platform = "web" | "app";

export interface VisitEvent {
  ts: number; // epoch ms
  ip: string;
  path: string;
  platform: Platform;
  registered: boolean;
  userId?: string | null;
  sessionId?: string | null;
  ua: string;
  bot: boolean;
  country?: string;
  countryCode?: string;
  region?: string;
  city?: string;
  lat?: number;
  lon?: number;
  device?: string; // mobile | tablet | desktop | bot
  ref?: string | null;
}

const DATA_DIR =
  process.env.ANALYTICS_DATA_DIR || path.join(process.cwd(), "data");
const FILE = path.join(DATA_DIR, "visits.jsonl");

/* ----------------------------- IP geolocation ----------------------------- */

interface Geo {
  country?: string;
  countryCode?: string;
  region?: string;
  city?: string;
  lat?: number;
  lon?: number;
}

const geoCache = new Map<string, Geo>();

function isPrivateIp(ip: string): boolean {
  if (!ip) return true;
  if (ip === "::1" || ip.startsWith("127.") || ip === "localhost") return true;
  if (ip.startsWith("10.") || ip.startsWith("192.168.")) return true;
  // 172.16.0.0 – 172.31.255.255
  const m = ip.match(/^172\.(\d+)\./);
  if (m && +m[1] >= 16 && +m[1] <= 31) return true;
  if (ip.startsWith("fc") || ip.startsWith("fd") || ip.startsWith("fe80"))
    return true;
  return false;
}

/** Look up an IP's location, caching the result for the process lifetime. */
export async function geolocate(ip: string): Promise<Geo> {
  if (isPrivateIp(ip)) {
    const local: Geo = { country: "Local", countryCode: "" , city: "Local network" };
    return local;
  }
  const cached = geoCache.get(ip);
  if (cached) return cached;
  try {
    const res = await fetch(
      `http://ip-api.com/json/${encodeURIComponent(ip)}?fields=status,country,countryCode,regionName,city,lat,lon`,
      { cache: "no-store", signal: AbortSignal.timeout(3500) },
    );
    const data = (await res.json()) as Record<string, unknown>;
    if (data?.status === "success") {
      const geo: Geo = {
        country: (data.country as string) || undefined,
        countryCode: (data.countryCode as string) || undefined,
        region: (data.regionName as string) || undefined,
        city: (data.city as string) || undefined,
        lat: typeof data.lat === "number" ? data.lat : undefined,
        lon: typeof data.lon === "number" ? data.lon : undefined,
      };
      geoCache.set(ip, geo);
      return geo;
    }
  } catch {
    /* geo is best-effort */
  }
  const empty: Geo = {};
  geoCache.set(ip, empty);
  return empty;
}

/* ----------------------------- Write / read ----------------------------- */

export async function recordVisit(ev: VisitEvent): Promise<void> {
  await fs.mkdir(DATA_DIR, { recursive: true });
  await fs.appendFile(FILE, JSON.stringify(ev) + "\n", "utf8");
}

/** Read all stored events (newest first). Returns [] when nothing logged yet. */
export async function readVisits(): Promise<VisitEvent[]> {
  let raw: string;
  try {
    raw = await fs.readFile(FILE, "utf8");
  } catch {
    return [];
  }
  const out: VisitEvent[] = [];
  for (const line of raw.split("\n")) {
    if (!line.trim()) continue;
    try {
      out.push(JSON.parse(line) as VisitEvent);
    } catch {
      /* skip corrupt line */
    }
  }
  out.sort((a, b) => b.ts - a.ts);
  return out;
}

/* ----------------------------- Aggregation ----------------------------- */

export interface AnalyticsSummary {
  totalVisits: number;
  uniqueVisitors: number;
  registered: number;
  guests: number;
  web: number;
  app: number;
  today: number;
  last7: number;
  bots: number;
  humans: number;
  topCountries: { name: string; code?: string; count: number }[];
  topCities: { name: string; country?: string; count: number }[];
  byDay: { day: string; count: number }[]; // last 14 days, oldest→newest
  mapPoints: { lat: number; lon: number; city?: string; count: number }[];
  recent: VisitEvent[];
}

function dayKey(ts: number): string {
  return new Date(ts).toISOString().slice(0, 10); // YYYY-MM-DD
}

export async function summarize(): Promise<AnalyticsSummary> {
  const all = await readVisits();
  const humans = all.filter((v) => !v.bot);

  const now = Date.now();
  const startOfToday = new Date(new Date(now).toISOString().slice(0, 10)).getTime();
  const weekAgo = now - 7 * 86400_000;

  const uniqueKeys = new Set<string>();
  const countries = new Map<string, { code?: string; count: number }>();
  const cities = new Map<string, { country?: string; count: number }>();
  const points = new Map<string, { lat: number; lon: number; city?: string; count: number }>();

  let registered = 0;
  let web = 0;
  let app = 0;
  let today = 0;
  let last7 = 0;

  for (const v of humans) {
    uniqueKeys.add(v.sessionId || v.userId || v.ip);
    if (v.registered) registered++;
    if (v.platform === "app") app++;
    else web++;
    if (v.ts >= startOfToday) today++;
    if (v.ts >= weekAgo) last7++;

    if (v.country) {
      const c = countries.get(v.country) || { code: v.countryCode, count: 0 };
      c.count++;
      countries.set(v.country, c);
    }
    if (v.city && v.city !== "Local network") {
      const c = cities.get(v.city) || { country: v.country, count: 0 };
      c.count++;
      cities.set(v.city, c);
    }
    if (typeof v.lat === "number" && typeof v.lon === "number") {
      const key = `${v.lat.toFixed(2)},${v.lon.toFixed(2)}`;
      const p = points.get(key) || { lat: v.lat, lon: v.lon, city: v.city, count: 0 };
      p.count++;
      points.set(key, p);
    }
  }

  // last 14 days bucketed by day
  const byDay: { day: string; count: number }[] = [];
  for (let i = 13; i >= 0; i--) {
    const d = dayKey(now - i * 86400_000);
    byDay.push({ day: d, count: 0 });
  }
  const dayIndex = new Map(byDay.map((b, i) => [b.day, i]));
  for (const v of humans) {
    const idx = dayIndex.get(dayKey(v.ts));
    if (idx !== undefined) byDay[idx].count++;
  }

  const topCountries = [...countries.entries()]
    .map(([name, c]) => ({ name, code: c.code, count: c.count }))
    .sort((a, b) => b.count - a.count)
    .slice(0, 8);
  const topCities = [...cities.entries()]
    .map(([name, c]) => ({ name, country: c.country, count: c.count }))
    .sort((a, b) => b.count - a.count)
    .slice(0, 8);
  const mapPoints = [...points.values()].sort((a, b) => b.count - a.count).slice(0, 60);

  return {
    totalVisits: humans.length,
    uniqueVisitors: uniqueKeys.size,
    registered,
    guests: humans.length - registered,
    web,
    app,
    today,
    last7,
    bots: all.length - humans.length,
    humans: humans.length,
    topCountries,
    topCities,
    byDay,
    mapPoints,
    recent: all.slice(0, 100),
  };
}
