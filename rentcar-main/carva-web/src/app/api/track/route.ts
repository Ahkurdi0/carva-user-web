// Visitor tracking beacon. The browser (and optionally the mobile app) POSTs a
// tiny payload here on every page open; the server enriches it with the real
// client IP, geolocation and a user-agent based device/bot classification, then
// appends it to the analytics store. Always returns 204 so a failed beacon never
// disrupts the page.

import { NextRequest } from "next/server";
import { geolocate, recordVisit, type Platform, type VisitEvent } from "@/lib/analytics-store";

export const runtime = "nodejs";
export const dynamic = "force-dynamic";

function clientIp(req: NextRequest): string {
  const fwd = req.headers.get("x-forwarded-for");
  if (fwd) return fwd.split(",")[0].trim();
  return req.headers.get("x-real-ip") || "";
}

const BOT_RE =
  /bot|crawl|spider|slurp|bingpreview|facebookexternalhit|embedly|quora|pinterest|vkshare|whatsapp|telegram|discord|headless|lighthouse|gptbot|claudebot|ccbot|anthropic|perplexity|python-requests|axios|curl|wget|monitor|uptime/i;

function classifyDevice(ua: string, bot: boolean): string {
  if (bot) return "bot";
  if (/tablet|ipad/i.test(ua)) return "tablet";
  if (/mobi|android|iphone|ipod/i.test(ua)) return "mobile";
  return "desktop";
}

export async function POST(req: NextRequest) {
  let body: Record<string, unknown> = {};
  try {
    body = (await req.json()) as Record<string, unknown>;
  } catch {
    /* empty / non-json beacon */
  }

  const ua = req.headers.get("user-agent") || "";
  const platform: Platform = body.platform === "app" ? "app" : "web";
  // Apps report themselves explicitly; only sniff the UA for web visitors.
  const bot = platform === "web" && BOT_RE.test(ua);
  const ip = clientIp(req);

  const geo = await geolocate(ip);

  const ev: VisitEvent = {
    ts: Date.now(),
    ip,
    path: typeof body.path === "string" ? body.path.slice(0, 300) : "/",
    platform,
    registered: body.registered === true,
    userId: typeof body.userId === "string" ? body.userId : null,
    sessionId: typeof body.sessionId === "string" ? body.sessionId.slice(0, 64) : null,
    ua: ua.slice(0, 400),
    bot,
    device: classifyDevice(ua, bot),
    ref: typeof body.ref === "string" ? body.ref.slice(0, 300) : null,
    ...geo,
  };

  try {
    await recordVisit(ev);
  } catch {
    /* never fail the beacon */
  }

  return new Response(null, { status: 204 });
}
