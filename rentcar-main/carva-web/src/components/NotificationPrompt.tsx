"use client";

import { useEffect, useRef, useState } from "react";
import { useAuth } from "@/lib/auth-store";
import { useI18n } from "@/i18n";
import { enablePush, pushConfigured, pushLogin, pushLogout, pushState, pushSupported } from "@/lib/push";
import { Icon } from "./Icon";

const DISMISS_KEY = "carva.pushPromptDismissedAt";
// After "Not now", ask again in two weeks at the earliest.
const DISMISS_MS = 14 * 24 * 60 * 60 * 1000;

function recentlyDismissed() {
  try {
    const at = Number(localStorage.getItem(DISMISS_KEY) ?? 0);
    return Date.now() - at < DISMISS_MS;
  } catch {
    return false;
  }
}

/**
 * Keeps the browser's push subscription linked to the signed-in account and,
 * a few seconds after sign-in, offers to turn notifications on with a soft
 * card (the browser's own permission dialog only opens after a tap).
 */
export function NotificationPrompt() {
  const { t } = useI18n();
  const userId = useAuth((s) => s.user?.userId ?? null);
  const loading = useAuth((s) => s.loading);
  const [show, setShow] = useState(false);
  const [busy, setBusy] = useState(false);
  const linked = useRef<string | null>(null);

  useEffect(() => {
    if (loading || !pushConfigured() || !pushSupported()) return;
    if (!userId) {
      if (linked.current) {
        linked.current = null;
        void pushLogout();
      }
      return;
    }
    let cancelled = false;
    linked.current = userId;
    void pushLogin(userId);
    const timer = window.setTimeout(async () => {
      if (cancelled || recentlyDismissed()) return;
      if ((await pushState()) === "off" && Notification.permission === "default" && !cancelled) setShow(true);
    }, 5000);
    return () => {
      cancelled = true;
      window.clearTimeout(timer);
    };
  }, [userId, loading]);

  if (!show || !userId) return null;

  function dismiss() {
    try {
      localStorage.setItem(DISMISS_KEY, String(Date.now()));
    } catch {
      /* private mode */
    }
    setShow(false);
  }

  async function enable() {
    setBusy(true);
    await enablePush();
    setBusy(false);
    setShow(false);
  }

  return (
    <div className="fixed inset-x-3 bottom-20 z-50 mx-auto max-w-md rounded-2xl border border-surface-low bg-white p-4 shadow-xl md:bottom-6">
      <div className="flex items-start gap-3">
        <span className="grid h-10 w-10 shrink-0 place-items-center rounded-full bg-primary-container">
          <Icon name="notification" size={20} color="#B51219" />
        </span>
        <div className="min-w-0 flex-1">
          <p className="font-bold text-on-surface">{t("web.notifyTitle")}</p>
          <p className="mt-0.5 text-sm text-muted">{t("web.notifySubtitle")}</p>
        </div>
      </div>
      <div className="mt-3 flex justify-end gap-2">
        <button onClick={dismiss} className="rounded-full px-4 py-2 text-sm font-semibold text-muted transition hover:bg-surface-lowest">
          {t("web.notifyLater")}
        </button>
        <button
          onClick={enable}
          disabled={busy}
          className="rounded-full bg-primary px-4 py-2 text-sm font-semibold text-white transition hover:opacity-90 disabled:opacity-60"
        >
          {t("web.notifyEnable")}
        </button>
      </div>
    </div>
  );
}
