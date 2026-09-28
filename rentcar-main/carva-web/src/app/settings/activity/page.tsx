"use client";

import { Card } from "@/components/DashboardShell";
import { AppShell } from "@/components/AppShell";
import { ErrorState, PageLoading } from "@/components/ui";
import { useAsync } from "@/lib/useAsync";
import { activityApi } from "@/lib/services";
import { useI18n } from "@/i18n";

function duration(ms: number) {
  const minutes = Math.max(0, Math.round(ms / 60000));
  if (minutes < 60) return `${minutes} min`;
  const hours = Math.floor(minutes / 60);
  const rest = minutes % 60;
  return rest ? `${hours}h ${rest}m` : `${hours}h`;
}

export default function MyActivityPage() {
  const { t } = useI18n();
  const activity = useAsync(() => activityApi.summary(), []);

  return <AppShell>
    <div className="mx-auto max-w-5xl px-4 py-6 sm:px-6">
      <div className="mb-6"><h1 className="text-2xl font-extrabold">{t("web.myActivity")}</h1><p className="mt-1 text-sm text-muted">{t("web.myActivityPrivacy")}</p></div>
      {activity.loading ? <PageLoading /> : activity.error ? <ErrorState message={activity.error} onRetry={activity.refetch} /> : activity.data ? <>
        <div className="grid grid-cols-2 gap-3 sm:grid-cols-4">
          <Card className="p-4"><p className="text-2xl font-extrabold">{duration(activity.data.totalMs)}</p><p className="text-xs text-muted">{t("web.timeSpent")}</p></Card>
          <Card className="p-4"><p className="text-2xl font-extrabold">{activity.data.sessions}</p><p className="text-xs text-muted">{t("web.sessions")}</p></Card>
          <Card className="p-4"><p className="text-2xl font-extrabold">{activity.data.views}</p><p className="text-xs text-muted">{t("web.pagesViewed")}</p></Card>
          <Card className="p-4"><p className="text-sm font-bold">{activity.data.lastActive ? new Date(activity.data.lastActive).toLocaleString() : "—"}</p><p className="text-xs text-muted">{t("web.lastActive")}</p></Card>
        </div>
        <div className="mt-5 grid gap-4 lg:grid-cols-2">
          <Card className="p-4"><h2 className="mb-3 font-bold">{t("web.timeByPage")}</h2><div className="space-y-2">{activity.data.byPage.length ? activity.data.byPage.map((row) => <div key={row.path} className="flex items-center justify-between gap-3 border-b border-surface-lowest pb-2 text-sm"><span className="truncate text-muted">{row.path}</span><span className="shrink-0 font-semibold">{duration(row.durationMs)} · {row.views}</span></div>) : <p className="text-sm text-muted">{t("web.noActivity")}</p>}</div></Card>
          <Card className="p-4"><h2 className="mb-3 font-bold">{t("web.recentActivity")}</h2><div className="space-y-2">{activity.data.recent.length ? activity.data.recent.map((row, i) => <div key={`${row.ts}-${i}`} className="flex items-center justify-between gap-3 border-b border-surface-lowest pb-2 text-sm"><span className="truncate text-muted">{row.path}</span><span className="shrink-0 text-xs text-muted">{duration(row.durationMs)} · {new Date(row.ts).toLocaleString()}</span></div>) : <p className="text-sm text-muted">{t("web.noActivity")}</p>}</div></Card>
        </div>
      </> : null}
    </div>
  </AppShell>;
}
