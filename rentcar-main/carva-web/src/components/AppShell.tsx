"use client";

import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
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
  { href: "/reels", key: "web.reels", icon: "star", active: "star_active" },
  { href: "/favorites", key: "bottomNavigation.Favorites", icon: "heart", active: "heart_active" },
  { href: "/chats", key: "chat.title", icon: "chat", active: "chat_active" },
  { href: "/companies", key: "bottomNavigation.companies", icon: "company", active: "company_fill" },
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
        className="flex h-10 items-center gap-1.5 rounded-full bg-surface-lowest px-3 text-sm font-medium"
      >
        <Icon name="language" size={18} />
        <span className="hidden sm:inline">{LANG_NAMES[lang]}</span>
      </button>
      {open && (
        <>
          <div className="fixed inset-0 z-10" onClick={() => setOpen(false)} />
          <div className="absolute end-0 z-20 mt-1 w-36 overflow-hidden rounded-xl border border-surface-low bg-white py-1 shadow-lg">
            {(Object.keys(LANG_NAMES) as Lang[]).map((l) => (
              <button
                key={l}
                onClick={() => {
                  setLang(l);
                  setOpen(false);
                }}
                className={`block w-full px-4 py-2 text-start text-sm hover:bg-surface-lowest ${
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

export function Header() {
  const { t } = useI18n();
  const pathname = usePathname();
  const user = useAuth((s) => s.user);

  return (
    <header className="sticky top-0 z-30 border-b border-surface-low/70 bg-canvas/85 backdrop-blur-md">
      <div className="mx-auto flex h-16 max-w-6xl items-center gap-3 px-4">
        <Link href="/" className="flex items-center">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img src="/assets/images/carva.png" alt="Carva" className="h-9 w-auto" />
        </Link>

        {/* Desktop nav */}
        <nav className="ml-6 hidden items-center gap-1 md:flex">
          {TABS.map((tab) => (
            <Link
              key={tab.href}
              href={tab.href}
              className={`flex items-center gap-2 rounded-full px-4 py-2 text-sm font-medium transition ${
                isActive(pathname, tab.href)
                  ? "bg-on-surface text-white"
                  : "text-muted hover:bg-surface-lowest hover:text-on-surface"
              }`}
            >
              <span className="relative inline-flex">
                <Icon name={isActive(pathname, tab.href) ? tab.active : tab.icon} size={18} />
                <ChatBadge href={tab.href} />
              </span>
              {t(tab.key)}
            </Link>
          ))}
        </nav>

        <div className="ms-auto flex items-center gap-2">
          <Link
            href="/advertise"
            title={t("v2.wantAdvertise")}
            className="inline-flex h-10 shrink-0 items-center gap-1.5 whitespace-nowrap rounded-full bg-on-surface px-3 text-sm font-semibold text-white hover:bg-on-surface/90 sm:px-4 md:px-3 xl:px-4"
          >
            <span aria-hidden>📣</span>
            {/* Phones/tablets: text fits; laptops: the tabs need the room until xl. */}
            <span className="hidden sm:inline md:hidden xl:inline">{t("v2.wantAdvertise")}</span>
          </Link>
          <LangSwitch />
          {user ? (
            <Link
              href="/settings"
              className="flex h-10 items-center gap-2 rounded-full bg-surface-lowest pe-3 ps-1"
            >
              <span className="grid h-8 w-8 place-items-center overflow-hidden rounded-full bg-primary-container">
                {user.image ? (
                  // eslint-disable-next-line @next/next/no-img-element
                  <img src={imageUrl(user.image)} alt="" className="h-full w-full object-cover" />
                ) : (
                  <Icon name="profile" size={18} color="#B51219" />
                )}
              </span>
              <span className="hidden max-w-[120px] truncate text-sm font-medium sm:inline">
                {user.name?.split(" ")[0]}
              </span>
            </Link>
          ) : (
            <Link
              href="/login"
              className="hidden h-10 items-center rounded-full bg-primary px-5 text-sm font-semibold text-white sm:flex"
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
  return (
    <nav className="pointer-events-none fixed inset-x-0 bottom-0 z-30 px-3.5 pb-[max(14px,env(safe-area-inset-bottom))] md:hidden">
      <div className="glass-bar pointer-events-auto relative mx-auto flex h-[68px] max-w-md items-stretch rounded-[34px] p-[5px]">
        {current >= 0 && (
          <span
            aria-hidden
            className="glass-pill absolute bottom-[5px] top-[5px] rounded-[29px] transition-[inset-inline-start] duration-500 ease-[cubic-bezier(.34,1.4,.5,1)]"
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
                <Icon name={active ? tab.active : tab.icon} size={22} color={active ? "#B51219" : "#4A4446"} />
                <ChatBadge href={tab.href} />
              </span>
              <span
                className={`max-w-full truncate px-0.5 text-[10px] leading-tight ${active ? "font-bold text-on-surface" : "font-semibold text-[#4A4446]"}`}
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

/** `bare` drops the footer and max-width for full-screen pages (Reels). */
export function AppShell({ children, bare = false }: { children: React.ReactNode; bare?: boolean }) {
  return (
    <div className="min-h-screen bg-canvas">
      <Header />
      <main className={bare ? "" : "mx-auto max-w-6xl"}>{children}</main>
      {!bare && <Footer />}
      {!bare && <div className="pb-24 md:pb-0" />}
      <BottomNav />
    </div>
  );
}

export { LangSwitch };
