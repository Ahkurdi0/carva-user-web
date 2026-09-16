"use client";

import { useState } from "react";
import { Card } from "@/components/DashboardShell";
import { Chip, PageLoading, EmptyState } from "@/components/ui";
import { Icon } from "@/components/Icon";
import { imageUrl } from "@/lib/api";
import { useAsync } from "@/lib/useAsync";
import { companyApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import { formatDate } from "@/lib/format";
import type { Review } from "@/lib/types";

function ReviewRow({ r }: { r: Review }) {
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
          <p className="text-[11px] text-muted">{formatDate(r.reviewedAt)}</p>
        </div>
        <span className="inline-flex gap-0.5">
          {Array.from({ length: 5 }).map((_, i) => <Icon key={i} name="star_fill" size={13} color={i < r.rate ? "#f5b50a" : "#e2e2e2"} />)}
        </span>
      </div>
      {r.desc && <p className="mt-2 text-sm text-on-surface/80">{r.desc}</p>}
    </Card>
  );
}

export default function DashboardReviews() {
  const { t } = useI18n();
  const [tab, setTab] = useState<"car" | "company">("car");
  const carRev = useAsync(() => companyApi.carReviews(), [], tab === "car");
  const compRev = useAsync(() => companyApi.companyReviews(), [], tab === "company");
  const active = tab === "car" ? carRev : compRev;

  return (
    <div>
      <h1 className="mb-4 text-2xl font-extrabold">{t("labels.reviews")}</h1>
      <div className="mb-5 flex gap-2">
        <Chip label={t("tabViews.carReviews")} selected={tab === "car"} onClick={() => setTab("car")} />
        <Chip label={t("tabViews.companyReviews")} selected={tab === "company"} onClick={() => setTab("company")} />
      </div>
      {active.loading ? (
        <PageLoading />
      ) : active.data && active.data.length > 0 ? (
        <div className="grid gap-3 sm:grid-cols-2">
          {active.data.map((r) => <ReviewRow key={r.id} r={r} />)}
        </div>
      ) : (
        <EmptyState icon="star" title={t("empty.noReviews")} />
      )}
    </div>
  );
}
