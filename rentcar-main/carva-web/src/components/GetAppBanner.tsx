"use client";

import { useI18n } from "@/i18n";

const ANDROID_URL =
  "https://play.google.com/store/apps/details?id=com.carvarent";
const IOS_URL = "https://apps.apple.com/app/carva/id6753580784";

/** Strip inviting shared-link visitors to continue in the mobile app. */
export function GetAppBanner() {
  const { t } = useI18n();
  return (
    <section className="mt-8 flex flex-col items-start gap-3 rounded-2xl bg-primary-container p-4 sm:flex-row sm:items-center">
      {/* eslint-disable-next-line @next/next/no-img-element */}
      <img src="/assets/images/carva.png" alt="Carva" className="h-8 w-auto" />
      <div className="min-w-0 flex-1">
        <p className="font-bold text-on-surface">{t("web.getAppTitle")}</p>
        <p className="text-sm text-muted">{t("web.getAppSubtitle")}</p>
      </div>
      <div className="flex gap-2">
        <a
          href={ANDROID_URL}
          target="_blank"
          rel="noreferrer"
          className="rounded-full bg-primary px-4 py-2 text-sm font-semibold text-white transition hover:opacity-90"
        >
          Google Play
        </a>
        <a
          href={IOS_URL}
          target="_blank"
          rel="noreferrer"
          className="rounded-full border border-primary px-4 py-2 text-sm font-semibold text-primary transition hover:bg-primary-container"
        >
          App Store
        </a>
      </div>
    </section>
  );
}
