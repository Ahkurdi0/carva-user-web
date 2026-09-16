"use client";

import { useState } from "react";
import { Card } from "@/components/DashboardShell";
import { Button, EmptyState, PageLoading } from "@/components/ui";
import { KycBadge } from "@/components/KycBadge";
import { imageUrl } from "@/lib/api";
import { adminApi } from "@/lib/services";
import { useAsync } from "@/lib/useAsync";
import { useI18n } from "@/i18n";
import { toast } from "@/components/toast";
import type { KycApplication } from "@/lib/types";

export default function AdminKycPage() {
  const { t } = useI18n();
  const applications = useAsync<KycApplication[]>(() => adminApi.pendingKyc(), []);
  const [busy, setBusy] = useState<string | null>(null);

  async function review(item: KycApplication, status: "approved" | "rejected") {
    const reason = status === "rejected" ? (window.prompt(t("web.kycRejectionReason")) || "") : undefined;
    if (status === "rejected" && !reason) return;
    setBusy(item.userId);
    try {
      await adminApi.reviewKyc(item.userId, status, reason);
      applications.refetch();
      toast(status === "approved" ? t("web.kycApproved") : t("web.kycRejected"), "success");
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    } finally { setBusy(null); }
  }

  return (
    <div>
      <h1 className="mb-5 text-2xl font-extrabold">{t("web.kycApplications")}</h1>
      {applications.loading ? <PageLoading /> : !applications.data?.length ? <EmptyState icon="checked" title={t("web.noKycApplications")} /> : (
        <div className="space-y-4">
          {applications.data.map((item) => (
            <Card key={item.userId} className="p-4">
              <div className="flex flex-wrap items-start justify-between gap-4">
                <div>
                  <div className="flex items-center gap-2"><h2 className="font-bold">{item.name}</h2><KycBadge status={item.kycStatus} /></div>
                  <p className="text-sm text-muted">{item.email}{item.phoneNumber ? ` · ${item.phoneNumber}` : ""}</p>
                  <p className="mt-1 text-sm font-medium text-primary">{item.kycDocumentType === "passport" ? t("web.kycPassport") : item.kycDocumentType === "driving_license" ? t("web.kycDrivingLicense") : t("web.kycNationalId")}</p>
                  <p className="mt-1 text-xs text-muted">{item.kycSubmittedAt ? new Date(item.kycSubmittedAt).toLocaleString() : ""}</p>
                </div>
                <div className="flex gap-2"><Button variant="outline" className="h-9 px-3 text-xs" loading={busy === item.userId} onClick={() => review(item, "rejected")}>{t("web.reject")}</Button><Button className="h-9 px-3 text-xs" loading={busy === item.userId} onClick={() => review(item, "approved")}>{t("web.approve")}</Button></div>
              </div>
              <div className="mt-4 grid gap-3 sm:grid-cols-3">
                {[[item.kycDocumentFront, t("web.kycFront")], [item.kycDocumentBack, t("web.kycBack")], [item.kycSelfie, t("web.kycSelfie")]].map(([src, label]) => src ? <a key={src} href={imageUrl(src)} target="_blank" rel="noreferrer" className="overflow-hidden rounded-xl border border-surface-low"><img src={imageUrl(src)} alt={label ?? ""} className="h-40 w-full object-cover" /></a> : null)}
              </div>
            </Card>
          ))}
        </div>
      )}
    </div>
  );
}
