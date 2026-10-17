"use client";

import Link from "next/link";
import { useI18n } from "@/i18n";
import { SITE } from "@/lib/seo";

export const APP_STORE_URL = "https://apps.apple.com/app/carva/id6753580784";
export const PLAY_STORE_URL =
  "https://play.google.com/store/apps/details?id=com.carvarent";

export function AppleMark() {
  return (
    <svg viewBox="0 0 24 24" width="24" height="24" fill="#fff" aria-hidden>
      <path d="M16.365 1.43c0 1.14-.46 2.23-1.21 3.04-.79.86-2.08 1.53-3.13 1.45-.13-1.1.42-2.27 1.17-3.06.78-.83 2.16-1.45 3.17-1.43zM20.5 17.36c-.55 1.27-.82 1.84-1.53 2.97-.99 1.57-2.39 3.53-4.12 3.54-1.54.02-1.94-1-4.03-.99-2.09.01-2.53 1.01-4.07.99-1.73-.02-3.05-1.78-4.04-3.35C-.02 16.07-.32 10.6 1.78 7.69c1.04-1.46 2.68-2.38 4.22-2.38 1.57 0 2.56 1.02 3.86 1.02 1.26 0 2.03-1.02 3.85-1.02 1.37 0 2.83.75 3.86 2.04-3.39 1.86-2.84 6.7.93 8.01z" />
    </svg>
  );
}

export function PlayMark() {
  return (
    <svg viewBox="0 0 512 512" width="22" height="22" aria-hidden>
      <path fill="#fff" d="M48 26v460c0 7 4 13 11 16l257-246L59 10c-7 3-11 9-11 16z" />
      <path fill="#fff" d="M392 226l-66-37-72 69 72 69 66-37c19-11 19-53 0-64z" opacity="0.85" />
      <path fill="#fff" d="M59 10l219 218 48-46L84 4c-9-5-18-2-25 6z" opacity="0.7" />
      <path fill="#fff" d="M59 502l219-218 48 46-194 178c-9 5-18 2-25-6z" opacity="0.55" />
    </svg>
  );
}

export function StoreButton({
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
      className="flex h-[52px] items-center gap-3 rounded-2xl bg-white/10 px-4 text-white ring-1 ring-white/20 backdrop-blur-md transition hover:-translate-y-0.5 hover:bg-white/15"
    >
      <span className="grid h-6 w-6 place-items-center">{mark}</span>
      <span className="text-start leading-tight">
        <span className="block text-[10px] opacity-80">{top}</span>
        <span className="block text-[15px] font-semibold" dir="ltr">{bottom}</span>
      </span>
    </a>
  );
}

/** App download CTA shown across the customer site. */
export function Footer() {
  const { t } = useI18n();
  return (
    <footer className="mt-10 bg-surface-lowest">
      {/* Get the app: CARVA's dark showroom look, same as the home hero */}
      <section className="relative overflow-hidden bg-[radial-gradient(120%_160%_at_85%_-30%,#5A090D_0%,#161112_58%)] text-white">
        <div className="hero-texture pointer-events-none absolute inset-0" aria-hidden />
        {/* eslint-disable-next-line @next/next/no-img-element */}
        <img
          src="/assets/images/carva-logo-white.png"
          alt=""
          aria-hidden
          className="pointer-events-none absolute -bottom-6 -start-8 w-72 opacity-[0.06] sm:w-[420px]"
        />
        <div className="relative mx-auto flex max-w-6xl flex-col items-center gap-6 px-4 py-10 text-center md:flex-row md:justify-between md:py-12 md:text-start">
          <div className="flex flex-col items-center gap-4 md:flex-row">
            {/* eslint-disable-next-line @next/next/no-img-element */}
            <img
              src="/assets/images/app-icon.png"
              alt="CARVA"
              className="h-16 w-16 rounded-[18px] shadow-[0_14px_30px_-12px_rgba(0,0,0,0.7)] ring-1 ring-white/15"
            />
            <div>
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img src="/assets/images/carva-logo-white.png" alt="CARVA" className="mx-auto h-6 w-auto md:mx-0" />
              <p className="mt-2 text-xl font-bold sm:text-2xl">{t("v2.getAppTitle")}</p>
              <p className="mt-1 max-w-md text-sm text-white/65">{t("v2.getAppSub")}</p>
            </div>
          </div>
          <div className="flex flex-wrap items-center justify-center gap-3">
            <StoreButton href={APP_STORE_URL} top={t("web.downloadOn")} bottom="App Store" mark={<AppleMark />} />
            <StoreButton href={PLAY_STORE_URL} top={t("web.getItOn")} bottom="Google Play" mark={<PlayMark />} />
          </div>
        </div>
      </section>
      {/* Internal links: homepage ↔ sections ↔ city-filtered listings */}
      <div className="mx-auto grid max-w-6xl gap-8 px-4 py-8 sm:grid-cols-3">
        <div>
          <p className="mb-3 text-sm font-bold text-on-surface">Carva</p>
          <ul className="space-y-2 text-sm text-muted">
            <li><Link className="hover:text-primary" href="/">{t("bottomNavigation.cars")}</Link></li>
            <li><Link className="hover:text-primary" href="/reels">{t("web.reels")}</Link></li>
            <li><Link className="hover:text-primary" href="/companies">{t("bottomNavigation.companies")}</Link></li>
            <li><Link className="hover:text-primary" href="/search">{t("inputHintText.searchCar")}</Link></li>
            <li><Link className="hover:text-primary" href="/about">{t("about.nav")}</Link></li>
          </ul>
        </div>
        <div>
          <p className="mb-3 text-sm font-bold text-on-surface">{t("labels.city")}</p>
          <ul className="space-y-2 text-sm text-muted">
            <li><Link className="hover:text-primary" href="/?city=Erbil">Rent a car in Erbil</Link></li>
            <li><Link className="hover:text-primary" href="/?city=Sulaymaniyah">Rent a car in Sulaymaniyah</Link></li>
            <li><Link className="hover:text-primary" href="/?city=Duhok">Rent a car in Duhok</Link></li>
          </ul>
        </div>
        <div>
          <p className="mb-3 text-sm font-bold text-on-surface">{t("bottomNavigation.companies")}</p>
          <ul className="space-y-2 text-sm text-muted">
            <li><Link className="hover:text-primary" href="/companies">Car rental companies in Iraq</Link></li>
            <li><Link className="hover:text-primary" href="/companies">Car rental companies in Kurdistan</Link></li>
          </ul>
        </div>
      </div>
      <div className="flex flex-wrap items-center justify-center gap-x-4 gap-y-1 border-t border-surface-low py-4 text-center text-xs text-muted">
        <span>© {new Date().getFullYear()} {SITE.name} — Car rental in Iraq &amp; Kurdistan</span>
        <Link className="hover:text-primary" href="/terms">{t("v2.terms")}</Link>
        <Link className="hover:text-primary" href="/privacy">{t("v2.privacy")}</Link>
      </div>
    </footer>
  );
}
