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
  const lastSent = useRef<string>("");

  useEffect(() => {
    // De-dupe rapid re-renders for the same path.
    if (lastSent.current === pathname) return;
    lastSent.current = pathname;

    const payload = {
      platform: "web",
      path: pathname,
      registered: !!tokens.access,
      userId,
      sessionId: sessionId(),
      ref: document.referrer || null,
    };

    fetch("/api/track", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload),
      keepalive: true,
    }).catch(() => {
      /* best effort */
    });
  }, [pathname, userId]);

  return null;
}
