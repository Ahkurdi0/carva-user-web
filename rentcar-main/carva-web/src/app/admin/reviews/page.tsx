"use client";

import { useState } from "react";
import { Card } from "@/components/DashboardShell";
import { Chip, Button, PageLoading, EmptyState } from "@/components/ui";
import { Icon } from "@/components/Icon";
import { imageUrl } from "@/lib/api";
import { useAsync } from "@/lib/useAsync";
import { adminApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import { formatDate } from "@/lib/format";
import { toast } from "@/components/toast";
import type { Review } from "@/lib/types";

type Tab = "car" | "company" | "carFlags" | "companyFlags";

export default function AdminReviews() {
  const { t } = useI18n();
  const [tab, setTab] = useState<Tab>("car");

  const carRev = useAsync(() => adminApi.allCarReviews(), [], tab === "car");
  const compRev = useAsync(() => adminApi.allCompanyReviews(), [], tab === "company");
  const carFlags = useAsync(() => adminApi.carReviewFlags(), [], tab === "carFlags");
  const compFlags = useAsync(() => adminApi.companyReviewFlags(), [], tab === "companyFlags");

  async function moderate(kind: "car" | "company", id: string, status: "accepted" | "deleted", refetch: () => void) {
    try {
      if (kind === "car") await adminApi.updateCarReview(id, status);
      else await adminApi.updateCompanyReview(id, status);
      toast(t("alertMessages.updated"), "success");
      refetch();
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    }
  }

  function Row({ r, kind, refetch }: { r: Review; kind: "car" | "company"; refetch: () => void }) {
    return (
      <Card className="p-4">
        <div className="flex items-center gap-3">
          <span className="h-9 w-9 overflow-hidden rounded-full bg-primary-container">
            {r.profile?.image ? (
              // eslint-disable-next-line @next/next/no-img-element
              <img src={imageUrl(r.profile.image)} alt="" className="h-full w-full object-cover" />
            ) : <span className="grid h-full w-full place-items-center"><Icon name="profile" size={16} color="#3957d7" /></span>}
          </span>
          <div className="flex-1">
            <p className="text-sm font-semibold">{r.profile?.name ?? "User"}</p>
            <p className="text-[11px] text-muted">{formatDate(r.reviewedAt)} · {r.status}</p>
          </div>
          <span className="inline-flex gap-0.5">
            {Array.from({ length: 5 }).map((_, i) => <Icon key={i} name="star_fill" size={12} color={i < r.rate ? "#f5b50a" : "#e2e2e2"} />)}
          </span>
        </div>
        {r.desc && <p className="mt-2 text-sm text-on-surface/80">{r.desc}</p>}
        <div className="mt-3 flex justify-end gap-2">
          <Button variant="outline" className="h-8 px-3 text-xs" onClick={() => moderate(kind, r.id, "accepted", refetch)}>{t("reviewStatus.approved")}</Button>
          <Button variant="outline" className="h-8 px-3 text-xs text-danger" onClick={() => moderate(kind, r.id, "deleted", refetch)}>{t("buttons.delete")}</Button>
        </div>
      </Card>
    );
  }

  const active = tab === "car" ? carRev : tab === "company" ? compRev : tab === "carFlags" ? carFlags : compFlags;

  return (
    <div>
      <h1 className="mb-4 text-2xl font-extrabold">{t("labels.reviews")}</h1>
      <div className="no-scrollbar mb-5 flex gap-2 overflow-x-auto">
        <Chip label={t("tabViews.carReviews")} selected={tab === "car"} onClick={() => setTab("car")} />
        <Chip label={t("tabViews.companyReviews")} selected={tab === "company"} onClick={() => setTab("company")} />
        <Chip label={t("screens.carReviewFlags")} selected={tab === "carFlags"} onClick={() => setTab("carFlags")} />
        <Chip label={t("screens.companyReviewFlags")} selected={tab === "companyFlags"} onClick={() => setTab("companyFlags")} />
      </div>

      {active.loading ? (
        <PageLoading />
      ) : (tab === "car" || tab === "company") ? (
        (active.data as Review[] | null)?.length ? (
          <div className="grid gap-3 sm:grid-cols-2">
            {(active.data as Review[]).map((r) => (
              <Row key={r.id} r={r} kind={tab === "car" ? "car" : "company"} refetch={active.refetch} />
            ))}
          </div>
        ) : <EmptyState icon="star" title={t("empty.noReviews")} />
      ) : (
        (active.data as Record<string, unknown>[] | null)?.length ? (
          <div className="grid gap-3 sm:grid-cols-2">
            {(active.data as Record<string, unknown>[]).map((f) => {
              const r = f.review as Review;
              return (
                <Row
                  key={String(f.id)}
                  r={r}
                  kind={tab === "carFlags" ? "car" : "company"}
                  refetch={active.refetch}
                />
              );
            })}
          </div>
        ) : <EmptyState icon="star" title={t("empty.noReviews")} />
      )}
    </div>
  );
}
