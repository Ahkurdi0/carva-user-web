// Admin-only read of the visitor analytics. Visitor IPs/locations are PII, so
// this verifies the caller is an admin by forwarding their bearer token to the
// real backend's /auth/refresh and checking the returned role — reusing the same
// auth the rest of the app relies on, with no separate secret to manage.

import { NextRequest } from "next/server";
import { summarize } from "@/lib/analytics-store";

export const runtime = "nodejs";
export const dynamic = "force-dynamic";

const UPSTREAM = (
  process.env.API_UPSTREAM ||
  process.env.NEXT_PUBLIC_API_BASE ||
  ""
).replace(/\/$/, "");

async function isAdmin(req: NextRequest): Promise<boolean> {
  const auth = req.headers.get("authorization");
  if (!auth || !UPSTREAM) return false;
  try {
    const res = await fetch(`${UPSTREAM}/auth/refresh`, {
      method: "POST",
      headers: { authorization: auth, accept: "application/json" },
      cache: "no-store",
    });
    if (!res.ok) return false;
    const profile = (await res.json()) as { role?: { roleName?: string } };
    return profile?.role?.roleName === "admin";
  } catch {
    return false;
  }
}

export async function GET(req: NextRequest) {
  if (!(await isAdmin(req))) {
    return Response.json({ error: "Forbidden" }, { status: 403 });
  }
  const data = await summarize();
  return Response.json(data, {
    headers: { "cache-control": "no-store" },
  });
}
