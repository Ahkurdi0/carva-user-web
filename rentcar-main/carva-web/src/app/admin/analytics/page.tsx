"use client";

import dynamic from "next/dynamic";
import { StatCard, Card } from "@/components/DashboardShell";
import { PageLoading, ErrorState, EmptyState } from "@/components/ui";
import { useAsync } from "@/lib/useAsync";
import { analyticsApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import type { AnalyticsSummary } from "@/lib/analytics-store";

// Leaflet map is client-only; load it lazily so it never runs during SSR.
const VisitorMap = dynamic(
  () => import("@/components/VisitorMap").then((m) => m.VisitorMap),
  { ssr: false, loading: () => <div className="h-80 animate-pulse rounded-2xl bg-surface-low" /> },
);

/* Convert an ISO country code (e.g. "IQ") into its flag emoji. */
function flag(code?: string): string {
  if (!code || code.length !== 2) return "🌐";
  return String.fromCodePoint(
    ...[...code.toUpperCase()].map((c) => 0x1f1e6 + c.charCodeAt(0) - 65),
  );
}

function TrendBars({ data, label }: { data: { day: string; count: number }[]; label: string }) {
  const max = Math.max(1, ...data.map((d) => d.count));
  return (
    <Card className="p-4">
      <p className="mb-3 text-sm font-bold">{label}</p>
      <div className="flex h-32 items-end gap-1.5">
        {data.map((d) => (
          <div key={d.day} className="flex flex-1 flex-col items-center gap-1" title={`${d.day}: ${d.count}`}>
            <div
              className="w-full rounded-t bg-primary/80"
              style={{ height: `${(d.count / max) * 100}%`, minHeight: d.count > 0 ? 4 : 0 }}
            />
            <span className="text-[9px] text-muted">{d.day.slice(5)}</span>
          </div>
        ))}
      </div>
    </Card>
  );
}

function RankList({
  title,
  rows,
}: {
  title: string;
  rows: { label: string; sub?: string; count: number }[];
}) {
  const max = Math.max(1, ...rows.map((r) => r.count));
  return (
    <Card className="p-4">
      <p className="mb-3 text-sm font-bold">{title}</p>
      {rows.length === 0 ? (
        <p className="py-6 text-center text-sm text-muted">—</p>
      ) : (
        <div className="space-y-2.5">
          {rows.map((r, i) => (
            <div key={i}>
              <div className="mb-1 flex items-center justify-between text-sm">
                <span className="truncate">
                  {r.label}
                  {r.sub ? <span className="text-muted"> · {r.sub}</span> : null}
                </span>
                <span className="font-bold tabular-nums">{r.count}</span>
              </div>
              <div className="h-1.5 w-full overflow-hidden rounded-full bg-surface-low">
                <div className="h-full rounded-full bg-primary" style={{ width: `${(r.count / max) * 100}%` }} />
              </div>
            </div>
          ))}
        </div>
      )}
    </Card>
  );
}

function SplitBar({ title, parts }: { title: string; parts: { label: string; value: number; color: string }[] }) {
  const total = Math.max(1, parts.reduce((s, p) => s + p.value, 0));
  return (
    <Card className="p-4">
      <p className="mb-3 text-sm font-bold">{title}</p>
      <div className="mb-3 flex h-3 w-full overflow-hidden rounded-full bg-surface-low">
        {parts.map((p, i) => (
          <div key={i} style={{ width: `${(p.value / total) * 100}%`, background: p.color }} title={`${p.label}: ${p.value}`} />
        ))}
      </div>
      <div className="space-y-1.5">
        {parts.map((p, i) => (
          <div key={i} className="flex items-center justify-between text-sm">
            <span className="flex items-center gap-2">
              <span className="h-2.5 w-2.5 rounded-full" style={{ background: p.color }} />
              {p.label}
            </span>
            <span className="font-bold tabular-nums">
              {p.value} <span className="font-normal text-muted">({Math.round((p.value / total) * 100)}%)</span>
            </span>
          </div>
        ))}
      </div>
    </Card>
  );
}

export default function AdminAnalytics() {
  const { t } = useI18n();
  const { data, loading, error, refetch } = useAsync<AnalyticsSummary>(() => analyticsApi.summary(), []);

  if (loading) return <PageLoading />;
  if (error) return <ErrorState message={error} onRetry={refetch} />;
  const s = data!;

  const hasAny = s.totalVisits > 0 || s.bots > 0;

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-extrabold">{t("analytics.title")}</h1>
        <p className="mt-1 text-sm text-muted">{t("analytics.subtitle")}</p>
      </div>

      {!hasAny ? (
        <EmptyState icon="no_location" title={t("analytics.noData")} subtitle={t("analytics.subtitle")} />
      ) : (
        <>
          <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-8">
            <StatCard label={t("analytics.totalVisits")} value={s.totalVisits} icon="status" />
            <StatCard label={t("analytics.uniqueVisitors")} value={s.uniqueVisitors} icon="profile" />
            <StatCard label={t("analytics.registered")} value={s.registered} icon="checked" />
            <StatCard label={t("analytics.guests")} value={s.guests} icon="not_loggedin" />
            <StatCard label={t("analytics.web")} value={s.web} icon="search" />
            <StatCard label={t("analytics.app")} value={s.app} icon="phone" />
            <StatCard label={t("analytics.today")} value={s.today} icon="clock" />
            <StatCard label={t("analytics.bots")} value={s.bots} icon="settings" />
          </div>

          <TrendBars data={s.byDay} label={t("analytics.visitsTrend")} />

          {s.mapPoints.length > 0 && (
            <Card className="p-4">
              <p className="mb-3 text-sm font-bold">{t("analytics.map")}</p>
              <VisitorMap points={s.mapPoints} />
            </Card>
          )}

          <div className="grid gap-4 lg:grid-cols-2">
            <RankList
              title={t("analytics.topCountries")}
              rows={s.topCountries.map((c) => ({ label: `${flag(c.code)}  ${c.name}`, count: c.count }))}
            />
            <RankList
              title={t("analytics.topCities")}
              rows={s.topCities.map((c) => ({ label: c.name, sub: c.country, count: c.count }))}
            />
          </div>

          <div className="grid gap-4 lg:grid-cols-2">
            <SplitBar
              title={t("analytics.byPlatform")}
              parts={[
                { label: t("analytics.web"), value: s.web, color: "#3957d7" },
                { label: t("analytics.app"), value: s.app, color: "#22b07d" },
              ]}
            />
            <SplitBar
              title={t("analytics.registeredVsGuests")}
              parts={[
                { label: t("analytics.registered"), value: s.registered, color: "#3957d7" },
                { label: t("analytics.guests"), value: s.guests, color: "#e0a92e" },
              ]}
            />
          </div>

          <RecentVisits rows={s.recent} />
        </>
      )}
    </div>
  );
}

function RecentVisits({ rows }: { rows: AnalyticsSummary["recent"] }) {
  const { t } = useI18n();
  const fmt = (ts: number) =>
    new Date(ts).toLocaleString(undefined, { month: "short", day: "numeric", hour: "2-digit", minute: "2-digit" });

  return (
    <Card className="overflow-hidden">
      <p className="border-b border-surface-low p-4 text-sm font-bold">{t("analytics.recentVisits")}</p>
      <div className="overflow-x-auto">
        <table className="w-full min-w-[760px] text-sm">
          <thead>
            <tr className="border-b border-surface-low text-start text-xs uppercase text-muted">
              <th className="p-3 text-start font-semibold">{t("analytics.time")}</th>
              <th className="p-3 text-start font-semibold">{t("analytics.location")}</th>
              <th className="p-3 text-start font-semibold">{t("analytics.visitor")}</th>
              <th className="p-3 text-start font-semibold">{t("analytics.platform")}</th>
              <th className="p-3 text-start font-semibold">{t("analytics.device")}</th>
              <th className="p-3 text-start font-semibold">{t("analytics.page")}</th>
              <th className="p-3 text-start font-semibold">{t("analytics.ip")}</th>
            </tr>
          </thead>
          <tbody>
            {rows.map((v, i) => (
              <tr key={i} className="border-b border-surface-lowest last:border-0">
                <td className="whitespace-nowrap p-3 text-muted">{fmt(v.ts)}</td>
                <td className="p-3">
                  {flag(v.countryCode)} {v.city || t("analytics.unknown")}
                  {v.country ? <span className="text-muted">, {v.country}</span> : null}
                </td>
                <td className="p-3">
                  {v.registered ? (
                    <span className="rounded-full bg-primary-container px-2 py-0.5 text-xs font-semibold text-primary">
                      {t("analytics.registered")}
                    </span>
                  ) : (
                    <span className="rounded-full bg-surface-low px-2 py-0.5 text-xs font-semibold text-muted">
                      {t("analytics.guests")}
                    </span>
                  )}
                </td>
                <td className="p-3 capitalize">{v.platform}{v.bot ? " · bot" : ""}</td>
                <td className="p-3 capitalize text-muted">{v.device || "—"}</td>
                <td className="max-w-[200px] truncate p-3 text-muted" title={v.path}>{v.path}</td>
                <td className="whitespace-nowrap p-3 font-mono text-xs text-muted">{v.ip || "—"}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </Card>
  );
}
