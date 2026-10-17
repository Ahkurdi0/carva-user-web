"use client";

import Link from "next/link";
import { useEffect, useRef, useState } from "react";
import { AppShell } from "@/components/AppShell";
import { Icon, type IconName } from "@/components/Icon";
import { AppleMark, PlayMark, StoreButton, APP_STORE_URL, PLAY_STORE_URL } from "@/components/Footer";
import { useI18n } from "@/i18n";
import { useAsync } from "@/lib/useAsync";
import { aboutApi, userApi, type AboutNumbers } from "@/lib/services";
import type { Support } from "@/lib/types";

/** Counts up from 0 once it comes on screen. */
function CountUp({ to }: { to: number }) {
  const ref = useRef<HTMLSpanElement>(null);
  const [n, setN] = useState(0);
  useEffect(() => {
    const el = ref.current;
    if (!el || to <= 0) return;
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
      const id = requestAnimationFrame(() => setN(to));
      return () => cancelAnimationFrame(id);
    }
    let raf = 0;
    const io = new IntersectionObserver(([en]) => {
      if (!en.isIntersecting) return;
      io.disconnect();
      const start = performance.now();
      const tick = (t: number) => {
        const p = Math.min(1, (t - start) / 1200);
        setN(Math.round(to * (1 - Math.pow(1 - p, 3))));
        if (p < 1) raf = requestAnimationFrame(tick);
      };
      raf = requestAnimationFrame(tick);
    });
    io.observe(el);
    return () => {
      io.disconnect();
      cancelAnimationFrame(raf);
    };
  }, [to]);
  return <span ref={ref}>{n.toLocaleString("en-US")}</span>;
}

function Section({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <section className="mt-12 px-4 sm:mt-16">
      <h2 className="mb-5 flex items-center gap-2 text-[22px] font-bold sm:text-[26px]">
        <span className="h-5 w-[3px] rounded-sm bg-primary" aria-hidden />
        {title}
      </h2>
      {children}
    </section>
  );
}

/** "About CARVA": who we are, the numbers, how it works, for offices, contact. */
export default function AboutPage() {
  const { t, tr } = useI18n();
  const { data: numbers } = useAsync<AboutNumbers>(() => aboutApi.numbers(), []);
  const { data: supports } = useAsync<Support[]>(() => userApi.supports(), []);

  const stats = [
    { value: numbers?.cars, label: t("about.statCars"), icon: "car_fill" as IconName },
    { value: numbers?.companies, label: t("about.statCompanies"), icon: "company_fill" as IconName },
    { value: numbers?.cities?.length, label: t("about.statCities"), icon: "location_p" as IconName },
  ];
  const steps = [1, 2, 3].map((i) => ({ title: t(`about.how${i}t`), body: t(`about.how${i}`) }));
  const why: { icon: IconName; k: number }[] = [
    { icon: "call", k: 1 },
    { icon: "image", k: 2 },
    { icon: "star_fill", k: 3 },
    { icon: "chat_active", k: 4 },
    { icon: "checked", k: 5 },
    { icon: "language", k: 6 },
  ];

  return (
    <AppShell>
      {/* Hero: the dark showroom look */}
      <div className="px-4 pt-4">
        <section className="relative overflow-hidden rounded-[22px] bg-hero bg-[radial-gradient(120%_160%_at_85%_-30%,#5A090D_0%,#161112_58%)] px-6 py-10 text-white shadow-[var(--shadow-lift)] sm:px-12 sm:py-16">
          <div className="hero-texture pointer-events-none absolute inset-0" aria-hidden />
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src="/assets/images/carva-logo-white.png"
            alt=""
            aria-hidden
            className="pointer-events-none absolute -bottom-6 -end-8 w-72 opacity-[0.07] sm:w-[520px]"
          />
          <p className="see-all relative text-white/60">{t("about.eyebrow")}</p>
          <h1 className="relative mt-3 max-w-2xl text-[28px] font-bold leading-tight sm:text-[42px]">{t("about.title")}</h1>
          <p className="relative mt-3 max-w-xl text-[15px] leading-relaxed text-white/75 sm:text-[17px]">{t("about.subtitle")}</p>
          <div className="relative mt-7 flex flex-wrap gap-3">
            <Link href="/" className="press inline-flex h-12 items-center rounded-2xl bg-primary px-6 text-[15px] font-semibold shadow-[var(--shadow-card)] hover:bg-primary-hover">
              {t("about.browse")}
            </Link>
            <a href="#get-app" className="press inline-flex h-12 items-center rounded-2xl border border-white/25 bg-white/10 px-6 text-[15px] font-semibold backdrop-blur hover:bg-white/15">
              {t("about.getApp")}
            </a>
          </div>
        </section>
      </div>

      {/* Numbers (live from the server) */}
      <div className="mt-4 grid grid-cols-3 gap-3 px-4">
        {stats.map((s) => (
          <div key={s.label} data-reveal className="rounded-[18px] bg-white p-4 text-center shadow-[var(--shadow-card)] ring-1 ring-hairline sm:p-6">
            <span className="mx-auto grid h-10 w-10 place-items-center rounded-full bg-primary-container">
              <Icon name={s.icon} size={20} color="#B51219" />
            </span>
            <p className="num mt-2 text-[24px] font-bold leading-none sm:text-[34px]">
              {s.value == null ? <span className="skeleton inline-block h-7 w-12 rounded-md align-middle" /> : <CountUp to={s.value} />}
            </p>
            <p className="mt-1.5 text-[12px] font-semibold text-muted sm:text-[14px]">{s.label}</p>
          </div>
        ))}
      </div>

      <Section title={t("about.whatTitle")}>
        <div data-reveal className="max-w-3xl space-y-3 text-[16px] leading-loose text-on-surface/85">
          <p>{t("about.what1")}</p>
          <p>{t("about.what2")}</p>
        </div>
      </Section>

      <Section title={t("about.howTitle")}>
        <ol className="grid gap-3 sm:grid-cols-3">
          {steps.map((s, i) => (
            <li key={i} data-reveal className="relative rounded-[18px] bg-white p-5 shadow-[var(--shadow-card)] ring-1 ring-hairline">
              <span className="num grid h-10 w-10 place-items-center rounded-full bg-hero text-[16px] font-bold text-white">{i + 1}</span>
              <p className="mt-3 text-[17px] font-bold">{s.title}</p>
              <p className="mt-1 text-[14.5px] leading-relaxed text-muted">{s.body}</p>
            </li>
          ))}
        </ol>
      </Section>

      <Section title={t("about.whyTitle")}>
        <div className="grid grid-cols-2 gap-3 lg:grid-cols-3">
          {why.map((w) => (
            <div key={w.k} data-reveal className="rounded-[18px] border border-hairline bg-white p-4 sm:p-5">
              <span className="grid h-10 w-10 place-items-center rounded-full bg-primary-container">
                <Icon name={w.icon} size={19} color="#B51219" />
              </span>
              <p className="mt-3 text-[15px] font-bold leading-snug">{t(`about.why${w.k}t`)}</p>
              <p className="mt-1 text-[13.5px] leading-relaxed text-muted">{t(`about.why${w.k}`)}</p>
            </div>
          ))}
        </div>
      </Section>

      {(numbers?.cities?.length ?? 0) > 0 && (
        <Section title={t("about.citiesTitle")}>
          <div className="flex flex-wrap gap-2">
            {numbers!.cities.map((c) => (
              <Link
                key={c.id}
                href={`/?city=${encodeURIComponent(c.en)}`}
                data-reveal
                className="press inline-flex h-11 items-center gap-2 rounded-xl bg-white px-4 text-[14px] font-semibold ring-1 ring-hairline hover:ring-border-strong"
              >
                <Icon name="location_p" size={15} color="#B51219" />
                {tr(c)}
                <span className="num rounded-full bg-surface-lowest px-2 py-0.5 text-[11px] font-semibold text-muted">
                  {t("about.officesIn", { n: c.companies })}
                </span>
              </Link>
            ))}
          </div>
        </Section>
      )}

      {/* For rental offices */}
      <section className="mt-12 px-4 sm:mt-16">
        <div data-reveal className="flex flex-col items-start gap-4 rounded-[22px] bg-primary-container p-6 sm:flex-row sm:items-center sm:p-8">
          <span className="grid h-14 w-14 shrink-0 place-items-center rounded-2xl bg-primary text-white shadow-[var(--shadow-card)]">
            <Icon name="company_fill" size={26} color="#fff" />
          </span>
          <div className="min-w-0 flex-1">
            <p className="text-[20px] font-bold">{t("about.bizTitle")}</p>
            <p className="mt-1 text-[14.5px] leading-relaxed text-on-surface/75">{t("about.bizBody")}</p>
          </div>
          <Link href="/advertise" className="press inline-flex h-12 shrink-0 items-center rounded-2xl bg-primary px-6 text-[15px] font-semibold text-white shadow-[var(--shadow-card)] hover:bg-primary-hover">
            {t("about.bizCta")}
          </Link>
        </div>
      </section>

      {/* Contact: the support channels set in the dashboard */}
      {(supports?.length ?? 0) > 0 && (
        <Section title={t("about.contactTitle")}>
          <div className="grid gap-2 sm:grid-cols-2">
            {supports!.map((s) => (
              <a
                key={s.id}
                href={s.content}
                target="_blank"
                rel="noopener noreferrer"
                data-reveal
                className="press flex items-center justify-between gap-3 rounded-2xl bg-white p-4 ring-1 ring-hairline hover:ring-border-strong"
              >
                <span className="min-w-0">
                  <span className="block font-semibold">{tr(s)}</span>
                  <span className="mt-0.5 block truncate text-[13px] text-muted" dir="ltr">{s.content}</span>
                </span>
                <Icon name="arrow" size={16} color="#A29A96" className="ltr:rotate-180" />
              </a>
            ))}
          </div>
        </Section>
      )}

      {/* Get the app (the footer band below has it too; this anchors the hero button) */}
      <section id="get-app" className="mt-12 scroll-mt-24 px-4 sm:mt-16">
        <div data-reveal className="flex flex-col items-center gap-4 rounded-[22px] bg-white p-6 text-center shadow-[var(--shadow-card)] ring-1 ring-hairline sm:flex-row sm:justify-between sm:text-start">
          <div className="flex items-center gap-4">
            {/* eslint-disable-next-line @next/next/no-img-element */}
            <img src="/assets/images/app-icon.png" alt="CARVA" className="h-14 w-14 rounded-2xl ring-1 ring-hairline" />
            <p className="text-[18px] font-bold">{t("v2.getAppTitle")}</p>
          </div>
          <div className="flex flex-wrap justify-center gap-3 [&_a]:bg-hero [&_a]:ring-0">
            <StoreButton href={APP_STORE_URL} top={t("web.downloadOn")} bottom="App Store" mark={<AppleMark />} />
            <StoreButton href={PLAY_STORE_URL} top={t("web.getItOn")} bottom="Google Play" mark={<PlayMark />} />
          </div>
        </div>
      </section>
    </AppShell>
  );
}
