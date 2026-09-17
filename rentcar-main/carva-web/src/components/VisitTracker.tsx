"use client";

// Fires a lightweight tracking beacon on every page open / route change so the
// admin analytics panel can count visitors (registered + guests), their device
// and — via server-side IP geolocation — their location. Best-effort: any
// failure is swallowed and never affects the page.

import { useEffect, useRef } from "react";
import { usePathname } from "next/navigation";
import { tokens } from "@/lib/api";
import { useAuth } from "@/lib/auth-store";

const SESSION_KEY = "carva.sid";

function sessionId(): string {
  if (typeof window === "undefined") return "";
  let id = localStorage.getItem(SESSION_KEY);
  if (!id) {
    id =
      (crypto.randomUUID?.() ??
        Math.random().toString(36).slice(2) + Date.now().toString(36));
    localStorage.setItem(SESSION_KEY, id);
  }
  return id;
}

export function VisitTracker() {
  const pathname = usePathname();
  const userId = useAuth((s) => s.user?.userId ?? null);
  const userRef = useRef<string | null>(userId);
  const active = useRef<{ path: string; startedAt: number; userId: string | null }>({ path: "", startedAt: 0, userId: null });
  userRef.current = userId;

  function send(path: string, durationMs: number, event: "view" | "heartbeat" = "view", ownerId = userRef.current) {
    const payload = JSON.stringify({
      platform: "web",
      path,
      durationMs,
      event,
      registered: !!tokens.access,
      userId: ownerId,
      sessionId: sessionId(),
      ref: document.referrer || null,
    });
    fetch("/api/track", {
      method: "POST",
      headers: { "Content-Type": "application/json", ...(tokens.access ? { Authorization: `Bearer ${tokens.access}` } : {}) },
      body: payload,
      keepalive: true,
    }).catch(() => {
      /* best effort */
    });
  }

  useEffect(() => {
    const now = Date.now();
    if (active.current.path && active.current.path !== pathname) {
      send(active.current.path, now - active.current.startedAt, "heartbeat", active.current.userId);
    }
    active.current = { path: pathname, startedAt: now, userId: userRef.current };
    send(pathname, 0, "view");
  }, [pathname]);

  useEffect(() => {
    const flush = () => {
      if (!active.current.path) return;
      send(active.current.path, Date.now() - active.current.startedAt, "heartbeat", active.current.userId);
    };
    window.addEventListener("pagehide", flush);
    return () => window.removeEventListener("pagehide", flush);
  }, []);

  return null;
}
