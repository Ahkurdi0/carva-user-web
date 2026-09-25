"use client";

import { DashboardShell, type NavItem } from "@/components/DashboardShell";
import { useI18n } from "@/i18n";

export default function DashboardLayout({ children }: { children: React.ReactNode }) {
  const { t } = useI18n();
  const nav: NavItem[] = [
    { href: "/dashboard", label: t("web.overview"), icon: "status" },
    { href: "/dashboard/cars", label: t("labels.cars"), icon: "car" },
    { href: "/dashboard/bookings", label: t("tabViews.reservations"), icon: "receipt" },
    { href: "/dashboard/promotions", label: t("labels.promotions"), icon: "filter" },
    { href: "/dashboard/reviews", label: t("labels.reviews"), icon: "star" },
    { href: "/dashboard/profile", label: t("buttons.editCompany"), icon: "company" },
  ];
  return (
    <DashboardShell title={t("web.dashboard")} nav={nav} require="company">
      {children}
    </DashboardShell>
  );
}
