"use client";

import { StatCard, Card } from "@/components/DashboardShell";
import { ImageHolder } from "@/components/ImageHolder";
import { PageLoading, useEnumLabel } from "@/components/ui";
import { useAsync } from "@/lib/useAsync";
import { companyApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import { imageUrl } from "@/lib/api";
import { formatDate, formatNumber } from "@/lib/format";
import Link from "next/link";

export default function DashboardOverview() {
  const { t } = useI18n();
  const e = useEnumLabel();
  const company = useAsync(() => companyApi.company(), []);
  const bookings = useAsync(() => companyApi.booked(), []);

  if (company.loading) return <PageLoading />;
  const c = company.data;

  const pending = (bookings.data ?? []).filter((b) => b.status === "pending").length;
  const ongoing = (bookings.data ?? []).filter((b) => b.status === "ongoing").length;

  return (
    <div className="space-y-6">
      <div className="flex items-center gap-4">
        <span className="h-16 w-16 overflow-hidden rounded-2xl bg-primary-container">
          {c?.image ? (
            // eslint-disable-next-line @next/next/no-img-element
            <img src={imageUrl(c.image)} alt="" className="h-full w-full object-cover" />
          ) : null}
        </span>
        <div>
          <h1 className="text-2xl font-extrabold">{c?.name}</h1>
          <p className="text-sm text-muted">{t("web.overview")}</p>
        </div>
      </div>

      <div className="grid grid-cols-2 gap-4 sm:grid-cols-4">
        <StatCard label={t("labels.rate")} value={c?.rate ? c.rate.toFixed(1) : "—"} icon="star" />
        <StatCard label={t("labels.review")} value={c?.review ?? 0} icon="star_fill" />
        <StatCard label={t("bookStatus.pending")} value={pending} icon="clock" />
        <StatCard label={t("bookStatus.ongoing")} value={ongoing} icon="receipt" />
      </div>

      <Card className="p-4">
        <div className="mb-3 flex items-center justify-between">
          <h2 className="font-bold">{t("tabViews.reservations")}</h2>
          <Link href="/dashboard/bookings" className="text-sm text-primary">{t("web.viewAll")}</Link>
        </div>
        {bookings.loading ? (
          <PageLoading />
        ) : (
          <div className="space-y-2">
            {(bookings.data ?? []).slice(0, 5).map((b) => (
              <div key={b.id} className="flex items-center gap-3 rounded-xl border border-surface-low p-2.5">
                <ImageHolder src={b.car?.images?.[0]?.image} className="h-12 w-16" rounded="rounded-lg" />
                <div className="min-w-0 flex-1">
                  <p className="truncate text-sm font-semibold">{b.car?.title}</p>
                  <p className="text-xs text-muted">{formatDate(b.startDate)} → {formatDate(b.endDate)}</p>
                </div>
                <span className="text-sm font-semibold text-primary">{formatNumber(b.finalPrice)}</span>
                <span className="rounded-full bg-surface-lowest px-2 py-0.5 text-[11px] font-medium">{e.bookStatus(b.status)}</span>
              </div>
            ))}
            {(bookings.data ?? []).length === 0 && <p className="text-sm text-muted">{t("empty.noBookings")}</p>}
          </div>
        )}
      </Card>
    </div>
  );
}
