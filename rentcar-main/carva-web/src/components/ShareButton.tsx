"use client";

import { useI18n } from "@/i18n";
import { toast } from "@/components/toast";

/** Share the current page via the native share sheet, falling back to
 * copying the link — mirrors the app's share buttons. */
export function ShareButton({ title }: { title: string }) {
  const { t } = useI18n();

  function share() {
    const url = window.location.href;
    if (typeof navigator.share === "function") {
      navigator.share({ title, url }).catch(() => {});
    } else {
      navigator.clipboard
        .writeText(`${title}\n${url}`)
        .then(() => toast(t("web.linkCopied"), "success"))
        .catch(() => {});
    }
  }

  return (
    <button
      onClick={share}
      aria-label={t("web.share")}
      title={t("web.share")}
      className="grid h-10 w-10 shrink-0 place-items-center rounded-full border border-surface-low bg-surface-lowest text-on-surface transition hover:bg-surface-low"
    >
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" aria-hidden>
        <circle cx="18" cy="5" r="3" />
        <circle cx="6" cy="12" r="3" />
        <circle cx="18" cy="19" r="3" />
        <path d="M8.6 13.5l6.8 4M15.4 6.5l-6.8 4" />
      </svg>
    </button>
  );
}
