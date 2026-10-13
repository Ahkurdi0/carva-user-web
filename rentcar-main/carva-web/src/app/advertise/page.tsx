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
      <div className="mx-auto max-w-2xl px-4 py-6 lg:max-w-6xl lg:py-10">
        {loading ? (
          <PageLoading />
        ) : !data?.enabled ? (
          <EmptyState icon="support" title={t("v2.advertiseOff")} />
        ) : (
          <>
            <section className="relative overflow-hidden rounded-3xl bg-[radial-gradient(120%_160%_at_90%_-20%,#5A090D_0%,#141012_55%)] px-6 py-8 text-white shadow-[var(--shadow-lift)] lg:px-12 lg:py-14">
              <div className="hero-texture pointer-events-none absolute inset-0" aria-hidden />
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img
                src="/assets/images/carva-logo-white.png"
                alt=""
                aria-hidden
                className="pointer-events-none absolute -bottom-4 -end-6 w-64 opacity-[0.07] lg:w-[460px]"
              />
              <p className="relative text-3xl lg:text-4xl">📣</p>
              <h1 className="relative mt-3 max-w-2xl text-2xl font-extrabold leading-snug lg:text-4xl">{pick(data.headline)}</h1>
              {pick(data.subheadline) && <p className="relative mt-2 max-w-xl text-sm text-white/75 lg:text-base">{pick(data.subheadline)}</p>}
            </section>

            <div className="mt-6 lg:mt-8 lg:grid lg:grid-cols-[minmax(0,1fr)_380px] lg:items-start lg:gap-8">
              <div>
                {(data.benefits?.length ?? 0) > 0 && (
                  <ul className="grid gap-2 sm:grid-cols-2 lg:gap-3">
                    {data.benefits!.map((b, i) => (
                      <li key={i} className="flex items-start gap-3 rounded-2xl border border-surface-low bg-white p-4 text-sm">
                        <span className="mt-0.5 grid h-6 w-6 shrink-0 place-items-center rounded-full bg-primary/10 text-xs font-bold text-primary">✓</span>
                        {pick(b)}
                      </li>
                    ))}
                  </ul>
                )}

                {(data.packages?.length ?? 0) > 0 && (
                  <div className="mt-6 grid gap-3 sm:grid-cols-2 lg:gap-4">
                    {data.packages!.map((p, i) => (
                      <div
                        key={i}
                        className={`rounded-3xl bg-white p-5 transition hover:-translate-y-0.5 hover:shadow-[var(--shadow-lift)] lg:p-6 ${p.highlighted ? "border-2 border-primary shadow-[var(--shadow-card)]" : "border border-surface-low"}`}
                      >
                        <p className="font-bold">{pick(p.name)}</p>
                        <p className="mt-1 text-2xl font-extrabold text-primary lg:text-3xl">
                          <span className="num" dir="ltr">{p.price}</span>{" "}
                          <span className="text-sm font-medium text-muted">/ {pick(p.period)}</span>
                        </p>
                        <ul className="mt-3 space-y-1.5 text-sm">
                          {p.features.map((f, j) => (
                            <li key={j} className="flex gap-2"><span className="text-primary">•</span>{pick(f)}</li>
                          ))}
                        </ul>
                      </div>
                    ))}
                  </div>
                )}
              </div>

              {(data.contacts?.length ?? 0) > 0 && (
                <aside className="mt-6 rounded-3xl bg-white p-5 shadow-[var(--shadow-card)] ring-1 ring-surface-low lg:sticky lg:top-24 lg:mt-0 lg:p-6">
                  <p className="mb-3 text-base font-bold">{t("v2.contactUs")}</p>
                  <AdvertiseContacts contacts={data.contacts!} />
                  {pick(data.note) && <p className="mt-4 text-center text-xs text-muted">{pick(data.note)}</p>}
                </aside>
              )}
            </div>
            {!(data.contacts?.length) && pick(data.note) && <p className="mt-5 text-center text-xs text-muted">{pick(data.note)}</p>}
          </>
        )}
      </div>
    </AppShell>
  );
}
