"use client";

import { useState } from "react";
import { Card } from "@/components/DashboardShell";
import { ImageHolder } from "@/components/ImageHolder";
import { Chip, PageLoading, EmptyState, useEnumLabel } from "@/components/ui";
import { useAsync } from "@/lib/useAsync";
import { companyApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import { formatDate, formatNumber } from "@/lib/format";
import { toast } from "@/components/toast";
import type { BookStatus } from "@/lib/types";

const STATUSES: BookStatus[] = ["pending", "ongoing", "completed", "canceled", "rejected", "refunded"];

export default function DashboardBookings() {
  const { t } = useI18n();
  const e = useEnumLabel();
  const [filter, setFilter] = useState<BookStatus | undefined>();
  const { data, loading, refetch } = useAsync(() => companyApi.booked(undefined, filter), [filter]);

  async function update(bookId: string, status: BookStatus) {
    try {
      await companyApi.updateBook(bookId, status);
      toast(t("alertMessages.updated"), "success");
      refetch();
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    }
  }

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
            <Card key={b.id} className="p-3">
              <div className="flex gap-3">
                <ImageHolder src={b.car?.images?.[0]?.image} className="h-20 w-28" rounded="rounded-xl" />
                <div className="min-w-0 flex-1">
                  <div className="flex items-start justify-between gap-2">
                    <div>
                      <p className="font-semibold">{b.car?.title}</p>
                      <p className="text-xs text-muted">#{b.bookId}</p>
                    </div>
                    <span className="text-sm font-bold text-primary">{formatNumber(b.finalPrice)}</span>
                  </div>
                  <p className="mt-1 text-xs text-muted">{formatDate(b.startDate)} → {formatDate(b.endDate)}</p>
                  <div className="mt-3 flex items-center gap-2">
                    <span className="text-xs text-muted">{t("labels.status")}:</span>
                    <select
                      value={b.status}
                      onChange={(ev) => update(b.id, ev.target.value as BookStatus)}
                      className="h-9 rounded-lg border border-surface-low bg-surface-lowest px-2 text-sm"
                    >
                      {STATUSES.map((s) => <option key={s} value={s}>{e.bookStatus(s)}</option>)}
                    </select>
                  </div>
                </div>
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
