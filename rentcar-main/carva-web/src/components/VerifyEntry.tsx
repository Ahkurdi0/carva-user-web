"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import { useI18n } from "@/i18n";
import { useAuth } from "@/lib/auth-store";

const DISMISS_KEY = "carva.verifyBannerHidden";

export function ShieldIcon({ size = 16 }: { size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden>
      <path d="M12 1 3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm-2 16-4-4 1.41-1.41L10 14.17l6.59-6.59L18 9l-8 8z" />
    </svg>
  );
}

/**
 * Header shortcut to the identity check, for signed-in people who are not
 * verified yet (amber while a request is waiting). Hidden once verified.
 */
export function VerifyPill() {
  const { t } = useI18n();
  const user = useAuth((s) => s.user);
  if (!user || user.kycStatus === "verified") return null;
  const pending = user.kycStatus === "pending";
  return (
    <Link
      href="/verify"
      title={t("v2.kycRow")}
      aria-label={t("v2.kycRow")}
      className={`press inline-flex h-10 shrink-0 items-center gap-1.5 rounded-full px-2.5 text-[13px] font-semibold shadow-[var(--shadow-card)] sm:px-3.5 ${
        pending ? "bg-amber-50 text-amber-800 ring-1 ring-amber-200" : "bg-sky-600 text-white hover:bg-sky-700"
      }`}
    >
      <ShieldIcon size={17} />
      <span className="hidden sm:inline md:hidden 2xl:inline">{pending ? t("v2.badgePending") : t("v2.verifyShort")}</span>
    </Link>
  );
}

/**
 * Card on Home inviting signed-in, not-yet-verified people to verify their
 * account on the website. Can be hidden for this browser.
 */
export function VerifyBanner() {
  const { t } = useI18n();
  const user = useAuth((s) => s.user);
  const [hidden, setHidden] = useState(true);

  useEffect(() => {
    try {
      setHidden(localStorage.getItem(DISMISS_KEY) === "1");
    } catch {
      setHidden(false);
    }
  }, []);

  if (!user || hidden || user.kycStatus === "verified" || user.kycStatus === "pending") return null;
  return (
    <div className="px-4 pt-3">
      <div className="relative flex items-center gap-3 overflow-hidden rounded-[18px] bg-gradient-to-l from-sky-600 to-sky-500 p-4 text-white shadow-[var(--shadow-card)] rtl:bg-gradient-to-r">
        <span className="grid h-11 w-11 shrink-0 place-items-center rounded-full bg-white/20">
          <ShieldIcon size={22} />
        </span>
        <div className="min-w-0 flex-1">
          <p className="font-bold leading-tight">{t("v2.kycIntroTitle")}</p>
          <p className="mt-0.5 line-clamp-2 text-[13px] text-white/85">{t("v2.kycIntro")}</p>
        </div>
        <Link href="/verify" className="press shrink-0 rounded-full bg-white px-4 py-2 text-[13px] font-bold text-sky-700">
          {t("v2.verifyShort")}
        </Link>
        <button
          onClick={() => {
            setHidden(true);
            try {
              localStorage.setItem(DISMISS_KEY, "1");
            } catch {
              /* private mode: hidden for this visit only */
            }
          }}
          aria-label="close"
          className="absolute end-1.5 top-1.5 grid h-6 w-6 place-items-center rounded-full text-white/70 hover:bg-white/15"
        >
          ×
        </button>
      </div>
    </div>
  );
}
