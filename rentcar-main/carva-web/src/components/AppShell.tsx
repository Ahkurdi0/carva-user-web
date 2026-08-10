"use client";

import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { useState } from "react";
import { Icon, type IconName } from "./Icon";
import { Footer } from "./Footer";
import { useI18n, LANG_NAMES } from "@/i18n";
import { useAuth } from "@/lib/auth-store";
import { imageUrl } from "@/lib/api";
import type { Lang } from "@/lib/types";

const TABS: { href: string; key: string; icon: IconName; active: IconName }[] = [
  { href: "/", key: "bottomNavigation.cars", icon: "car", active: "car_active" },
  { href: "/favorites", key: "bottomNavigation.Favorites", icon: "heart", active: "heart_active" },
  { href: "/companies", key: "bottomNavigation.companies", icon: "company", active: "company_fill" },
  { href: "/settings", key: "bottomNavigation.settings", icon: "settings", active: "settings_active" },
];

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
    <header className="sticky top-0 z-30 border-b border-surface-lowest bg-white/90 backdrop-blur">
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
                  ? "bg-primary-container text-primary"
                  : "text-on-surface hover:bg-surface-lowest"
              }`}
            >
              <Icon name={isActive(pathname, tab.href) ? tab.active : tab.icon} size={18} />
              {t(tab.key)}
            </Link>
          ))}
        </nav>

        <div className="ms-auto flex items-center gap-2">
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
                  <Icon name="profile" size={18} color="#3957d7" />
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

export function BottomNav() {
  const { t } = useI18n();
  const pathname = usePathname();
  return (
    <nav className="fixed inset-x-0 bottom-0 z-30 border-t border-surface-lowest bg-white shadow-[0_-2px_12px_rgba(0,0,0,0.06)] md:hidden">
      <div className="mx-auto flex max-w-md items-stretch">
        {TABS.map((tab, i) => {
          const active = isActive(pathname, tab.href);
          const color = i % 2 === 0 ? "#3957d7" : "#23262e";
          return (
            <Link
              key={tab.href}
              href={tab.href}
              className="flex flex-1 flex-col items-center gap-1 py-3"
            >
              <Icon
                name={active ? tab.active : tab.icon}
                size={24}
                color={active ? color : "#9e9e9e"}
              />
              <span
                className="text-[11px]"
                style={{
                  color: active ? "#23262e" : "#9e9e9e",
                  fontWeight: active ? 600 : 400,
                }}
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

export function AppShell({ children }: { children: React.ReactNode }) {
  return (
    <div className="min-h-screen bg-white">
      <Header />
      <main className="mx-auto max-w-6xl">{children}</main>
      <Footer />
      <div className="pb-20 md:pb-0" />
      <BottomNav />
    </div>
  );
}

export { LangSwitch };
