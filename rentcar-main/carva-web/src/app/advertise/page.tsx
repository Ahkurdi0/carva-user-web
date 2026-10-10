"use client";

import { useEffect } from "react";
import { AppShell } from "@/components/AppShell";
import { AdvertiseContacts } from "@/components/AdvertiseContacts";
import { EmptyState, PageLoading } from "@/components/ui";
import { useI18n } from "@/i18n";
import { useAsync } from "@/lib/useAsync";
import { advertiseApi, type AdvertisePage, type AdvertiseText } from "@/lib/services";

/** "Advertise on CARVA": the page set in the dashboard (Advertise page), like the app. */
export default function AdvertisePageView() {
  const { t, lang } = useI18n();
  const { data, loading } = useAsync<AdvertisePage>(() => advertiseApi.page(), []);
  const pick = (x?: AdvertiseText) => (x ? x[lang]?.trim() || x.ku?.trim() || x.en?.trim() || x.ar?.trim() || "" : "");

  useEffect(() => {
    if (data?.enabled) advertiseApi.event("page");
  }, [data?.enabled]);

  return (
    <AppShell>
      <div className="mx-auto max-w-2xl px-4 py-6">
        {loading ? (
          <PageLoading />
        ) : !data?.enabled ? (
          <EmptyState icon="support" title={t("v2.advertiseOff")} />
        ) : (
          <>
            <section className="rounded-3xl bg-[radial-gradient(120%_160%_at_90%_-20%,#5A090D_0%,#141012_55%)] px-6 py-8 text-white">
              <p className="text-3xl">📣</p>
              <h1 className="mt-3 text-2xl font-extrabold leading-snug">{pick(data.headline)}</h1>
              {pick(data.subheadline) && <p className="mt-2 text-sm text-white/75">{pick(data.subheadline)}</p>}
            </section>

            {(data.benefits?.length ?? 0) > 0 && (
              <ul className="mt-5 space-y-2">
                {data.benefits!.map((b, i) => (
                  <li key={i} className="flex items-start gap-3 rounded-2xl border border-surface-low bg-white p-4 text-sm">
                    <span className="mt-0.5 grid h-6 w-6 shrink-0 place-items-center rounded-full bg-primary/10 text-xs font-bold text-primary">✓</span>
                    {pick(b)}
                  </li>
                ))}
              </ul>
            )}

            {(data.packages?.length ?? 0) > 0 && (
              <div className="mt-6 grid gap-3 sm:grid-cols-2">
                {data.packages!.map((p, i) => (
                  <div key={i} className={`rounded-3xl border bg-white p-5 ${p.highlighted ? "border-2 border-primary" : "border-surface-low"}`}>
                    <p className="font-bold">{pick(p.name)}</p>
                    <p className="mt-1 text-2xl font-extrabold text-primary" dir="ltr">
                      {p.price} <span className="text-sm font-medium text-muted">{pick(p.period)}</span>
                    </p>
                    <ul className="mt-3 space-y-1.5 text-sm">
                      {p.features.map((f, j) => (
                        <li key={j}>• {pick(f)}</li>
                      ))}
                    </ul>
                  </div>
                ))}
              </div>
            )}

            {(data.contacts?.length ?? 0) > 0 && (
              <div className="mt-6">
                <p className="mb-2 text-sm font-bold">{t("v2.contactUs")}</p>
                <AdvertiseContacts contacts={data.contacts!} />
              </div>
            )}
            {pick(data.note) && <p className="mt-5 text-center text-xs text-muted">{pick(data.note)}</p>}
          </>
        )}
      </div>
    </AppShell>
  );
}
