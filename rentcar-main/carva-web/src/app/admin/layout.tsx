"use client";

import { DashboardShell } from "@/components/DashboardShell";
import { useI18n } from "@/i18n";

export default function AdminLayout({ children }: { children: React.ReactNode }) {
  const { t } = useI18n();
  return <DashboardShell title={t("web.adminPanel")} require="admin" nav={[{ href: "/admin/kyc", label: t("web.kycApplications"), icon: "checked" }]}>{children}</DashboardShell>;
}
