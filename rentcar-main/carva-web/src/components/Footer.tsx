"use client";

import { useI18n } from "@/i18n";

export const APP_STORE_URL = "https://apps.apple.com/app/carva/id6753580784";
export const PLAY_STORE_URL =
  "https://play.google.com/store/apps/details?id=com.carvarent";

function AppleMark() {
  return (
    <svg viewBox="0 0 24 24" width="24" height="24" fill="#fff" aria-hidden>
      <path d="M16.365 1.43c0 1.14-.46 2.23-1.21 3.04-.79.86-2.08 1.53-3.13 1.45-.13-1.1.42-2.27 1.17-3.06.78-.83 2.16-1.45 3.17-1.43zM20.5 17.36c-.55 1.27-.82 1.84-1.53 2.97-.99 1.57-2.39 3.53-4.12 3.54-1.54.02-1.94-1-4.03-.99-2.09.01-2.53 1.01-4.07.99-1.73-.02-3.05-1.78-4.04-3.35C-.02 16.07-.32 10.6 1.78 7.69c1.04-1.46 2.68-2.38 4.22-2.38 1.57 0 2.56 1.02 3.86 1.02 1.26 0 2.03-1.02 3.85-1.02 1.37 0 2.83.75 3.86 2.04-3.39 1.86-2.84 6.7.93 8.01z" />
    </svg>
  );
}

function PlayMark() {
  return (
    <svg viewBox="0 0 512 512" width="22" height="22" aria-hidden>
      <path fill="#fff" d="M48 26v460c0 7 4 13 11 16l257-246L59 10c-7 3-11 9-11 16z" />
      <path fill="#fff" d="M392 226l-66-37-72 69 72 69 66-37c19-11 19-53 0-64z" opacity="0.85" />
      <path fill="#fff" d="M59 10l219 218 48-46L84 4c-9-5-18-2-25 6z" opacity="0.7" />
      <path fill="#fff" d="M59 502l219-218 48 46-194 178c-9 5-18 2-25-6z" opacity="0.55" />
    </svg>
  );
}

function StoreButton({
  href,
  top,
  bottom,
  mark,
}: {
  href: string;
  top: string;
  bottom: string;
  mark: React.ReactNode;
}) {
  return (
    <a
      href={href}
      target="_blank"
      rel="noreferrer"
      className="flex items-center gap-3 rounded-xl bg-secondary px-4 py-2.5 text-white transition hover:opacity-90"
    >
      <span className="grid h-6 w-6 place-items-center">{mark}</span>
      <span className="text-start leading-tight">
        <span className="block text-[10px] opacity-80">{top}</span>
        <span className="block text-sm font-semibold">{bottom}</span>
      </span>
    </a>
  );
}

/** App download CTA shown across the customer site. */
export function Footer() {
  const { t } = useI18n();
  return (
    <footer className="mt-10 border-t border-surface-lowest bg-surface-lowest">
      <div className="mx-auto flex max-w-6xl flex-col items-center gap-5 px-4 py-10 sm:flex-row sm:justify-between">
        <div className="text-center sm:text-start">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img src="/assets/images/carva.png" alt="Carva" className="mx-auto h-9 w-auto sm:mx-0" />
          <p className="mt-2 max-w-sm text-sm text-muted">{t("web.getTheApp")}</p>
        </div>
        <div className="flex flex-wrap items-center justify-center gap-3">
          <StoreButton href={APP_STORE_URL} top={t("web.downloadOn")} bottom="App Store" mark={<AppleMark />} />
          <StoreButton href={PLAY_STORE_URL} top={t("web.getItOn")} bottom="Google Play" mark={<PlayMark />} />
        </div>
      </div>
      <div className="border-t border-surface-low py-4 text-center text-xs text-muted">
        © {new Date().getFullYear()} Carva
      </div>
    </footer>
  );
}
