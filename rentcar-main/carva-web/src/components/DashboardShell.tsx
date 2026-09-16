"use client";

import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { useEffect } from "react";
import { Icon, type IconName } from "./Icon";
import { PageLoading } from "./ui";
import { useAuth } from "@/lib/auth-store";

export interface NavItem {
  href: string;
  label: string;
  icon: IconName;
}

export function DashboardShell({
  title,
  nav,
  require: req,
  children,
}: {
  title: string;
  nav: NavItem[];
  require: "company" | "admin";
  children: React.ReactNode;
}) {
  const pathname = usePathname();
  const router = useRouter();
  const { user, loading } = useAuth();
  const isAdmin = useAuth((s) => s.isAdmin)();
  const isCompany = useAuth((s) => s.isCompany)();

  const allowed = req === "admin" ? isAdmin : isCompany || isAdmin;

  useEffect(() => {
    if (!loading && !user) router.replace("/login");
    if (!loading && user && !allowed) router.replace("/");
  }, [loading, user, allowed, router]);

  if (loading || !user || !allowed) return <PageLoading />;

  return (
    <div className="min-h-screen bg-surface-lowest">
      <div className="mx-auto flex max-w-7xl">
        {/* Sidebar */}
        <aside className="sticky top-0 hidden h-screen w-60 shrink-0 flex-col border-e border-surface-low bg-white p-4 md:flex">
          <Link href="/" className="mb-6 flex items-center gap-2 px-2">
            {/* eslint-disable-next-line @next/next/no-img-element */}
            <img src="/assets/images/carva.png" alt="Carva" className="h-8 w-auto" />
          </Link>
          <p className="px-2 pb-2 text-xs font-bold uppercase text-muted">{title}</p>
          <nav className="flex-1 space-y-0.5 overflow-y-auto">
            {nav.map((item) => {
              const active = pathname === item.href || (item.href !== "/dashboard" && item.href !== "/admin" && pathname.startsWith(item.href));
              return (
                <Link
                  key={item.href}
                  href={item.href}
                  className={`flex items-center gap-3 rounded-xl px-3 py-2.5 text-sm font-medium transition ${
                    active ? "bg-primary-container text-primary" : "text-on-surface hover:bg-surface-lowest"
                  }`}
                >
                  <Icon name={item.icon} size={18} color={active ? "#3957d7" : "#23262e"} />
                  {item.label}
                </Link>
              );
            })}
          </nav>
          <Link href="/" className="mt-2 flex items-center gap-3 rounded-xl px-3 py-2.5 text-sm font-medium text-muted hover:bg-surface-lowest">
            <Icon name="arrow" size={18} /> Carva
          </Link>
        </aside>

        {/* Main */}
        <div className="min-w-0 flex-1">
          {/* Mobile top tabs */}
          <div className="no-scrollbar flex gap-2 overflow-x-auto border-b border-surface-low bg-white p-3 md:hidden">
            {nav.map((item) => {
              const active = pathname === item.href;
              return (
                <Link
                  key={item.href}
                  href={item.href}
                  className={`flex shrink-0 items-center gap-2 rounded-full px-3 py-1.5 text-sm ${
                    active ? "bg-primary text-white" : "bg-surface-lowest text-on-surface"
                  }`}
                >
                  <Icon name={item.icon} size={16} color={active ? "#fff" : "#23262e"} />
                  {item.label}
                </Link>
              );
            })}
          </div>
          <main className="p-4 sm:p-6">{children}</main>
        </div>
      </div>
    </div>
  );
}

/* Small reusable widgets for dashboards */
export function StatCard({ label, value, icon }: { label: string; value: string | number; icon: IconName }) {
  return (
    <div className="rounded-2xl border border-surface-low bg-white p-4">
      <div className="flex items-center justify-between">
        <span className="grid h-10 w-10 place-items-center rounded-xl bg-primary-container">
          <Icon name={icon} size={20} color="#3957d7" />
        </span>
      </div>
      <p className="mt-3 text-2xl font-extrabold text-on-surface">{value}</p>
      <p className="text-sm text-muted">{label}</p>
    </div>
  );
}

export function Card({ children, className = "" }: { children: React.ReactNode; className?: string }) {
  return <div className={`rounded-2xl border border-surface-low bg-white ${className}`}>{children}</div>;
}
