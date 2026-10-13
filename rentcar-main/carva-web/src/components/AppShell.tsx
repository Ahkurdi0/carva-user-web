"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useEffect, useState } from "react";
import { Icon, type IconName } from "./Icon";
import { Footer } from "./Footer";
import { useI18n, LANG_NAMES } from "@/i18n";
import { useAuth } from "@/lib/auth-store";
import { imageUrl } from "@/lib/api";
import type { Lang } from "@/lib/types";
import { useChatUnread } from "@/lib/chat-store";

const TABS: { href: string; key: string; icon: IconName; active: IconName }[] = [
  { href: "/", key: "bottomNavigation.cars", icon: "car", active: "car_active" },
  { href: "/companies", key: "bottomNavigation.companies", icon: "company", active: "company_fill" },
  { href: "/chats", key: "chat.title", icon: "chat", active: "chat_active" },
  { href: "/favorites", key: "bottomNavigation.Favorites", icon: "heart", active: "heart_active" },
  { href: "/settings", key: "bottomNavigation.settings", icon: "settings", active: "settings_active" },
];

/** Red unread count on the Chats tab; polls while signed in. */
function ChatBadge({ href }: { href: string }) {
  const user = useAuth((s) => s.user);
  const count = useChatUnread((s) => s.count);
  const refresh = useChatUnread((s) => s.refresh);
  const reset = useChatUnread((s) => s.reset);
  useEffect(() => {
    if (href !== "/chats") return;
    if (!user) {
      reset();
      return;
    }
    void refresh();
    const timer = window.setInterval(refresh, 30000);
    return () => window.clearInterval(timer);
  }, [href, user, refresh, reset]);
  if (href !== "/chats" || !user || count <= 0) return null;
  return (
    <span className="absolute -end-1.5 -top-1 grid h-[18px] min-w-[18px] place-items-center rounded-full bg-primary px-1 text-[10px] font-bold leading-none text-white ring-2 ring-white">
      {count > 99 ? "99+" : count}
    </span>
  );
}

function isActive(pathname: string, href: string) {
  if (href === "/") return pathname === "/";
  return pathname === href || pathname.startsWith(href + "/");
}

function LangSwitch() {
  const { lang, setLang } = useI18n();
  const [open, setOpen] = useState(false);
  return (
    <div className="relative">
      <button
        onClick={() => setOpen((o) => !o)}
        aria-label="language"
        className="press flex h-10 items-center gap-1.5 rounded-full border border-hairline bg-white/80 px-2.5 text-[13px] font-semibold"
      >
        <Icon name="language" size={18} />
        <span className="hidden 2xl:inline">{LANG_NAMES[lang]}</span>
      </button>
      {open && (
        <>
          <div className="fixed inset-0 z-10" onClick={() => setOpen(false)} />
          <div className="sheet-up absolute end-0 z-20 mt-2 w-40 overflow-hidden rounded-2xl bg-white p-1 shadow-[var(--shadow-glass)] ring-1 ring-hairline">
            {(Object.keys(LANG_NAMES) as Lang[]).map((l) => (
              <button
                key={l}
                onClick={() => {
                  setLang(l);
                  setOpen(false);
                }}
                className={`block w-full rounded-xl px-3.5 py-2.5 text-start text-sm hover:bg-surface-lowest ${
                  l === lang ? "font-semibold text-primary" : ""
                }`}
              >
                {LANG_NAMES[l]}
              </button>
            ))}
          </div>
        </>
      )}
    </div>
  );
}

/** Material "campaign" megaphone (the app's advertise pill). */
export function MegaphoneIcon({ size = 15 }: { size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor" aria-hidden>
      <path d="M18 11v2h4v-2h-4zm-2 6.61c.96.71 2.21 1.65 3.2 2.39.4-.53.8-1.07 1.2-1.6-.99-.74-2.24-1.68-3.2-2.4-.4.54-.8 1.08-1.2 1.61zM20.4 5.6c-.4-.53-.8-1.07-1.2-1.6-.99.74-2.24 1.68-3.2 2.4.4.53.8 1.07 1.2 1.6.96-.72 2.21-1.65 3.2-2.4zM4 9c-1.1 0-2 .9-2 2v2c0 1.1.9 2 2 2h1v4h2v-4h1l5 3V6L8 9H4zm11.5 3c0-1.33-.58-2.53-1.5-3.35v6.69c.92-.81 1.5-2.01 1.5-3.34z" />
    </svg>
  );
}

/** "Want to advertise?" — dark pill with a red megaphone circle, like the app. */
function AdvertisePill() {
  const { t } = useI18n();
  return (
    <Link
      href="/advertise"
      title={t("v2.wantAdvertise")}
      className="press inline-flex h-10 shrink-0 items-center gap-2 whitespace-nowrap rounded-full bg-hero py-1.5 pe-1.5 ps-1.5 text-[13px] font-semibold text-white shadow-[var(--shadow-card)] hover:bg-hero/90 sm:pe-3.5 md:pe-1.5 2xl:pe-3.5"
    >
      <span className="grid h-[26px] w-[26px] place-items-center rounded-full bg-primary">
        <MegaphoneIcon />
      </span>
      <span className="hidden sm:inline md:hidden 2xl:inline">{t("v2.wantAdvertise")}</span>
    </Link>
  );
}

/**
 * Top bar like the app's glass navigation bar: see-through at the top of
 * the page, frosted glass with a hairline once content slides under it.
 */
export function Header() {
  const { t } = useI18n();
  const pathname = usePathname();
  const user = useAuth((s) => s.user);
  const [scrolled, setScrolled] = useState(false);
  const current = TABS.findIndex((tab) => isActive(pathname, tab.href));

  useEffect(() => {
    const on = () => setScrolled(window.scrollY > 4);
    on();
    window.addEventListener("scroll", on, { passive: true });
    return () => window.removeEventListener("scroll", on);
  }, []);

  return (
    <header
      className={`sticky top-0 z-30 transition-[background,box-shadow,border-color] duration-300 ${
        scrolled ? "glass !border-x-0 !border-t-0 border-b !border-b-hairline" : "border-b border-transparent bg-canvas"
      }`}
    >
      <div className="mx-auto flex h-16 max-w-6xl items-center gap-2 px-4">
        <Link href="/" className="flex shrink-0 items-center" aria-label="CARVA">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img src="/assets/images/carva.png" alt="CARVA" className="h-8 w-auto sm:h-9" />
        </Link>

        {/* Desktop: the tab bar as a glass segmented control */}
        <nav className="glass relative ms-4 hidden h-12 items-stretch rounded-full p-1 shadow-[var(--shadow-card)] md:flex">
          {TABS.map((tab, i) => {
            const active = i === current;
            return (
              <Link
                key={tab.href}
                href={tab.href}
                aria-current={active ? "page" : undefined}
                className={`relative flex items-center gap-1.5 rounded-full px-3 text-[13px] font-semibold transition lg:px-4 ${
                  active ? "glass-pill text-on-surface" : "text-[#4A4446] hover:text-on-surface"
                }`}
              >
                <span className="relative inline-flex">
                  <Icon name={active ? tab.active : tab.icon} size={18} color={active ? "#B51219" : "#4A4446"} />
                  <ChatBadge href={tab.href} />
                </span>
                <span className="hidden lg:inline">{t(tab.key)}</span>
              </Link>
            );
          })}
        </nav>

        <div className="ms-auto flex items-center gap-1.5 sm:gap-2">
          <AdvertisePill />
          <Link
            href="/search"
            aria-label={t("buttons.search")}
            className="press flex h-10 items-center gap-1.5 rounded-full border border-hairline bg-white/80 px-3 text-[13px] font-semibold text-on-surface"
          >
            <Icon name="search" size={16} />
            <span className="hidden sm:inline md:hidden xl:inline">{t("buttons.search")}</span>
          </Link>
          <LangSwitch />
          {user ? (
            <Link
              href="/settings"
              className="press flex h-10 items-center gap-2 rounded-full border border-hairline bg-white/80 pe-1 ps-1 sm:pe-3"
            >
              <span className="grid h-8 w-8 place-items-center overflow-hidden rounded-full bg-primary-container">
                {user.image ? (
                  // eslint-disable-next-line @next/next/no-img-element
                  <img src={imageUrl(user.image)} alt="" className="h-full w-full object-cover" />
                ) : (
                  <Icon name="profile" size={18} color="#B51219" />
                )}
              </span>
              <span className="hidden max-w-[120px] truncate text-[13px] font-semibold sm:inline">
                {user.name?.split(" ")[0]}
              </span>
            </Link>
          ) : (
            <Link
              href="/login"
              className="press hidden h-10 items-center rounded-full bg-primary px-5 text-[13px] font-semibold text-white shadow-[var(--shadow-card)] sm:flex"
            >
              {t("screens.login")}
            </Link>
          )}
        </div>
      </div>
    </header>
  );
}

/**
 * Floating glass tab bar, like the app: a frosted capsule 14px from the
 * sides, a lighter glass pill slides behind the current tab, the current
 * icon is red.
 */
export function BottomNav() {
  const { t } = useI18n();
  const pathname = usePathname();
  const current = TABS.findIndex((tab) => isActive(pathname, tab.href));
  const slot = `((100% - 10px) / ${TABS.length})`;
  // Dark glass over video and photos (Reels), light glass everywhere else.
  const dark = pathname.startsWith("/reels");
  const idle = dark ? "#FFFFFF" : "#4A4446";
  return (
    <nav className="pointer-events-none fixed inset-x-0 bottom-0 z-30 px-3.5 pb-[max(14px,env(safe-area-inset-bottom))] md:hidden">
      <div className={`${dark ? "glass-dark shadow-[var(--shadow-glass)]" : "glass-bar"} pointer-events-auto relative mx-auto flex h-[68px] max-w-md items-stretch rounded-[34px] p-[5px]`}>
        {current >= 0 && (
          <span
            aria-hidden
            className={`${dark ? "border border-white/25 bg-white/20" : "glass-pill"} absolute bottom-[5px] top-[5px] rounded-[29px] transition-[inset-inline-start] duration-500 ease-[cubic-bezier(.34,1.4,.5,1)]`}
            style={{ width: `calc${slot}`, insetInlineStart: `calc(5px + ${current} * ${slot})` }}
          />
        )}
        {TABS.map((tab, i) => {
          const active = i === current;
          return (
            <Link
              key={tab.href}
              href={tab.href}
              aria-current={active ? "page" : undefined}
              className="relative flex flex-1 flex-col items-center justify-center gap-[3px] active:scale-95 transition-transform"
            >
              <span className="relative inline-flex">
                <Icon name={active ? tab.active : tab.icon} size={22} color={active ? (dark ? "#FF4D55" : "#B51219") : idle} />
                <ChatBadge href={tab.href} />
              </span>
              <span
                className={`max-w-full truncate px-0.5 text-[10px] leading-tight ${active ? "font-bold" : "font-semibold"} ${dark ? "text-white" : active ? "text-on-surface" : "text-[#4A4446]"}`}
              >
                {t(tab.key)}
              </span>
            </Link>
          );
        })}
      </div>
    </nav>
  );
}

/**
 * `bare` drops the footer and max-width for full-screen pages (Reels).
 * `bottomBar` (car page): on phones it floats where the tab bar would be,
 * like the app's contact bar on a pushed page.
 * `focused` (a chat): a pushed page — no footer, no tab bar, and on phones
 * no site header either (the page has its own bar).
 */
export function AppShell({
  children,
  bare = false,
  bottomBar,
  focused = false,
}: {
  children: React.ReactNode;
  bare?: boolean;
  bottomBar?: React.ReactNode;
  focused?: boolean;
}) {
  if (focused)
    return (
      <div className="min-h-dvh bg-canvas">
        <div className="hidden md:block">
          <Header />
        </div>
        <main>{children}</main>
      </div>
    );
  return (
    <div className="min-h-screen bg-canvas">
      <Header />
      <main className={bare ? "" : "mx-auto max-w-6xl"}>{children}</main>
      {!bare && <Footer />}
      {!bare && <div className="pb-24 md:pb-0" />}
      {bottomBar ? (
        <div className="pointer-events-none fixed inset-x-0 bottom-0 z-30 px-3 pb-[max(12px,env(safe-area-inset-bottom))] md:hidden">
          <div className="pointer-events-auto mx-auto max-w-md">{bottomBar}</div>
        </div>
      ) : (
        <BottomNav />
      )}
    </div>
  );
}

export { LangSwitch };
