"use client";

import { useI18n } from "@/i18n";

/**
 * Identity-check badge, same as the app: blue check + car = verified with a
 * driving licence; grey check = verified without one; "Waiting" only for
 * the user themself.
 */
export function KycBadge({
  status,
  level,
  showPending = false,
  small = false,
}: {
  status?: string | null;
  level?: string | null;
  showPending?: boolean;
  small?: boolean;
}) {
  const { t } = useI18n();
  const cls = `inline-flex shrink-0 items-center gap-1 rounded-full font-semibold ${small ? "px-2 py-0.5 text-[11px]" : "px-2.5 py-1 text-xs"}`;
  if (status === "verified") {
    const license = level === "license";
    return (
      <span
        className={`${cls} ${license ? "bg-sky-500/10 text-sky-700" : "bg-slate-500/10 text-slate-700"}`}
        title={t(license ? "v2.badgeLicense" : "v2.badgeId")}
      >
        <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor" aria-hidden>
          <path d="M12 1l2.6 2.2 3.4-.4.9 3.3 3 1.7-1.2 3.2 1.2 3.2-3 1.7-.9 3.3-3.4-.4L12 23l-2.6-2.2-3.4.4-.9-3.3-3-1.7L3.3 12 2.1 8.8l3-1.7.9-3.3 3.4.4L12 1zm-1.2 14.6l6-6-1.4-1.4-4.6 4.6-2.2-2.2-1.4 1.4 3.6 3.6z" />
        </svg>
        {t(license ? "v2.badgeLicense" : "v2.badgeId")}
        {license && <span aria-hidden>🚗</span>}
      </span>
    );
  }
  if (status === "pending" && showPending) {
    return <span className={`${cls} bg-amber-500/10 text-amber-700`}>⏳ {t("v2.badgePending")}</span>;
  }
  return null;
}
