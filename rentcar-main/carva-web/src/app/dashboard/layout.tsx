"use client";

import { DashboardShell, type NavItem } from "@/components/DashboardShell";
import { useI18n } from "@/i18n";
import { useAuth } from "@/lib/auth-store";

export default function DashboardLayout({ children }: { children: React.ReactNode }) {
  const { t } = useI18n();
  const user = useAuth((s) => s.user);
  const personal = !!user?.isPersonal;
  const nav: NavItem[] = [
    { href: "/dashboard", label: personal ? t("web.personalOverview") : t("web.overview"), icon: "status" },
    { href: "/dashboard/cars", label: personal ? t("web.myCars") : t("labels.cars"), icon: "car" },
    { href: "/dashboard/bookings", label: personal ? t("web.rentalBookings") : t("tabViews.reservations"), icon: "receipt" },
    { href: "/dashboard/promotions", label: t("labels.promotions"), icon: "filter" },
    { href: "/dashboard/reviews", label: t("labels.reviews"), icon: "star" },
    { href: "/dashboard/profile", label: personal ? t("web.personalProfile") : t("buttons.editCompany"), icon: "company" },
  ];
  return (
    <DashboardShell title={personal ? t("web.personalDashboard") : t("web.dashboard")} nav={nav} require="company">
      {children}
    </DashboardShell>
  );
}
