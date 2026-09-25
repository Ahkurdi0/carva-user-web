"use client";

import { StatCard, Card } from "@/components/DashboardShell";
import { PageLoading } from "@/components/ui";
import { useAsync } from "@/lib/useAsync";
import { adminApi } from "@/lib/services";
import { useI18n } from "@/i18n";

type MonthRow = { month: number; total: number };

function MiniBars({ data, label }: { data: MonthRow[]; label: string }) {
  const max = Math.max(1, ...data.map((d) => d.total));
  const byMonth = Array.from({ length: 12 }, (_, i) => data.find((d) => Number(d.month) === i + 1)?.total ?? 0);
  return (
    <Card className="p-4">
      <p className="mb-3 text-sm font-bold">{label}</p>
      <div className="flex h-32 items-end gap-1.5">
        {byMonth.map((v, i) => (
          <div key={i} className="flex flex-1 flex-col items-center gap-1">
            <div className="w-full rounded-t bg-primary/80" style={{ height: `${(v / max) * 100}%`, minHeight: v > 0 ? 4 : 0 }} title={`${v}`} />
            <span className="text-[9px] text-muted">{i + 1}</span>
          </div>
        ))}
      </div>
    </Card>
  );
}

export default function AdminStatistics() {
  const { t } = useI18n();
  const { data, loading } = useAsync(() => adminApi.statistics(), []);

  if (loading) return <PageLoading />;
  const s = (data ?? {}) as Record<string, unknown>;
  const num = (k: string) => Number(s[k] ?? 0);

  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-extrabold">{t("buttons.statistics")}</h1>

      <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-6">
        <StatCard label={t("labels.cars")} value={num("totalcars")} icon="car" />
        <StatCard label={t("tabViews.reservations")} value={num("totalReservations")} icon="receipt" />
        <StatCard label={t("bookStatus.pending")} value={num("totalPendingReservations")} icon="clock" />
        <StatCard label={t("bookStatus.ongoing")} value={num("totalOngoinReservations")} icon="status" />
        <StatCard label={t("bookStatus.completed")} value={num("totalCompletedReservations")} icon="check" />
        <StatCard label={t("bookStatus.canceled")} value={num("totalCanceledReservations")} icon="cancel" />
      </div>

      <div className="grid gap-4 lg:grid-cols-3">
        <MiniBars data={(s.totalUserPerMonths as MonthRow[]) ?? []} label={t("bottomNavigation.users")} />
        <MiniBars data={(s.totalCompaniesPerMonths as MonthRow[]) ?? []} label={t("bottomNavigation.companies")} />
        <MiniBars data={(s.totalCarsPerMonths as MonthRow[]) ?? []} label={t("labels.cars")} />
      </div>
    </div>
  );
}
