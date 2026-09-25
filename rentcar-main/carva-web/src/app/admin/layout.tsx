"use client";

import { DashboardShell, type NavItem } from "@/components/DashboardShell";
import { useI18n } from "@/i18n";

export default function AdminLayout({ children }: { children: React.ReactNode }) {
  const { t } = useI18n();
  const nav: NavItem[] = [
    { href: "/admin", label: t("buttons.statistics"), icon: "status" },
    { href: "/admin/analytics", label: t("analytics.title"), icon: "maping" },
    { href: "/admin/users", label: t("bottomNavigation.users"), icon: "profile" },
    { href: "/admin/companies", label: t("bottomNavigation.companies"), icon: "company" },
    { href: "/admin/cars", label: t("labels.cars"), icon: "car" },
    { href: "/admin/bookings", label: t("tabViews.reservations"), icon: "receipt" },
    { href: "/admin/reviews", label: t("labels.reviews"), icon: "star" },
    { href: "/admin/content", label: t("buttons.brands"), icon: "settings" },
  ];
  return (
    <DashboardShell title={t("web.adminPanel")} nav={nav} require="admin">
      {children}
    </DashboardShell>
  );
}
