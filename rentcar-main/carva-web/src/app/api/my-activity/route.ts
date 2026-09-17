import { NextRequest } from "next/server";
import { readVisits, type VisitEvent } from "@/lib/analytics-store";

export const runtime = "nodejs";
export const dynamic = "force-dynamic";

const UPSTREAM = (process.env.API_UPSTREAM || process.env.NEXT_PUBLIC_API_BASE || "").replace(/\/$/, "");

async function currentUserId(req: NextRequest): Promise<string | null> {
  const auth = req.headers.get("authorization");
  if (!auth || !UPSTREAM) return null;
  try {
    const response = await fetch(`${UPSTREAM}/auth/refresh`, {
      method: "POST",
      headers: { authorization: auth, accept: "application/json" },
      cache: "no-store",
    });
    if (!response.ok) return null;
    const profile = (await response.json()) as { userId?: string };
    return typeof profile.userId === "string" ? profile.userId : null;
  } catch {
    return null;
  }
}

export async function GET(req: NextRequest) {
  const userId = await currentUserId(req);
  if (!userId) return Response.json({ error: "Unauthorized" }, { status: 401 });

  const events = (await readVisits())
    .filter((event) => event.userId === userId && !event.bot)
    .sort((a, b) => b.ts - a.ts);
  const totalMs = events.reduce((sum, event) => sum + (event.durationMs || 0), 0);
  const sessions = new Set(events.map((event) => event.sessionId).filter(Boolean)).size;
  const pages = new Map<string, { views: number; durationMs: number }>();
  for (const event of events) {
    const row = pages.get(event.path) || { views: 0, durationMs: 0 };
    row.views += 1;
    row.durationMs += event.durationMs || 0;
    pages.set(event.path, row);
  }
  const byPage = [...pages.entries()]
    .map(([path, value]) => ({ path, ...value }))
    .sort((a, b) => b.durationMs - a.durationMs)
    .slice(0, 20);
  const recent = events.slice(0, 50).map((event: VisitEvent) => ({
    ts: event.ts,
    path: event.path,
    durationMs: event.durationMs || 0,
    platform: event.platform,
    device: event.device || "unknown",
  }));

  return Response.json({
    totalMs,
    sessions,
    views: events.length,
    lastActive: events[0]?.ts || null,
    byPage,
    recent,
  }, { headers: { "cache-control": "no-store" } });
}
