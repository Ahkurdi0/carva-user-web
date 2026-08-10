"use client";

import { useState } from "react";
import { Card } from "@/components/DashboardShell";
import { ImageHolder } from "@/components/ImageHolder";
import { Chip, PageLoading, EmptyState, useEnumLabel } from "@/components/ui";
import { useAsync } from "@/lib/useAsync";
import { adminApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import { formatDate, formatNumber } from "@/lib/format";
import type { BookStatus } from "@/lib/types";

const STATUSES: BookStatus[] = ["pending", "ongoing", "completed", "canceled", "rejected", "refunded"];

export default function AdminBookings() {
  const { t } = useI18n();
  const e = useEnumLabel();
  const [filter, setFilter] = useState<BookStatus | undefined>();
  const { data, loading } = useAsync(() => adminApi.allBooks(undefined, filter), [filter]);

  return (
    <div>
      <h1 className="mb-4 text-2xl font-extrabold">{t("tabViews.reservations")}</h1>
      <div className="no-scrollbar mb-5 flex gap-2 overflow-x-auto">
        <Chip label={t("labels.all")} selected={!filter} onClick={() => setFilter(undefined)} />
        {STATUSES.map((s) => <Chip key={s} label={e.bookStatus(s)} selected={filter === s} onClick={() => setFilter(s)} />)}
      </div>
      {loading ? (
        <PageLoading />
      ) : data && data.length > 0 ? (
        <div className="space-y-3">
          {data.map((b) => (
            <Card key={b.id} className="flex gap-3 p-3">
              <ImageHolder src={b.car?.images?.[0]?.image} className="h-16 w-24" rounded="rounded-xl" />
              <div className="min-w-0 flex-1">
                <div className="flex items-start justify-between gap-2">
                  <p className="truncate font-semibold">{b.car?.title}</p>
                  <span className="rounded-full bg-surface-lowest px-2 py-0.5 text-[11px] font-medium">{e.bookStatus(b.status)}</span>
                </div>
                <p className="text-xs text-muted">{b.company?.name}</p>
                <p className="mt-1 text-xs text-muted">{formatDate(b.startDate)} → {formatDate(b.endDate)}</p>
                <p className="mt-1 text-sm font-bold text-primary">{formatNumber(b.finalPrice)}</p>
              </div>
            </Card>
          ))}
        </div>
      ) : (
        <EmptyState icon="receipt" title={t("empty.noBookings")} />
      )}
    </div>
  );
}
