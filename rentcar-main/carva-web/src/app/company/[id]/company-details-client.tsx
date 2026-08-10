"use client";

import { useCallback, useEffect, useState } from "react";
import { useParams } from "next/navigation";
import { AppShell } from "@/components/AppShell";
import { Icon, type IconName } from "@/components/Icon";
import { ImageHolder } from "@/components/ImageHolder";
import { CarCard, CarCardSkeleton } from "@/components/CarCard";
import { MiniMap } from "@/components/MiniMap";
import { GetAppBanner } from "@/components/GetAppBanner";
import { ReviewList } from "@/components/ReviewList";
import { Rating, PageLoading, EmptyState, SectionHeader, Spinner } from "@/components/ui";
import { useAsync } from "@/lib/useAsync";
import { userApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import { imageUrl } from "@/lib/api";
import type { Car, Company, Contact } from "@/lib/types";

const CONTACT_ICON: Record<string, IconName> = {
  phone: "call",
  whatsapp: "whatsapp",
  viber: "phone",
  email: "mail",
};

function ContactButton({ c, companyId }: { c: Contact; companyId: string }) {
  function open() {
    const num = `${c.countrCode ?? ""}${c.value}`.replace(/\s/g, "");
    if (c.type === "whatsapp") {
      // Open synchronously so mobile browsers keep the user-gesture; redirect
      // that tab once the contact URL resolves (fall back to a wa.me link).
      const win = window.open("", "_blank");
      const navigate = (url: string) => {
        if (win) win.location.href = url;
        else window.location.href = url;
      };
      const fallback = `https://wa.me/${num.replace("+", "")}`;
      userApi.contact({ type: "whatsapp", companyId, contactId: c.id })
        .then((url) => navigate(url || fallback))
        .catch(() => navigate(fallback));
    } else if (c.type === "email") {
      window.location.href = `mailto:${c.value}`;
    } else {
      window.location.href = `tel:${num}`;
    }
  }
  const isWa = c.type === "whatsapp";
  return (
    <button
      onClick={open}
      className={`flex items-center gap-2 rounded-full px-4 py-2 text-sm font-medium ${isWa ? "bg-tint text-white" : "border border-surface-low text-on-surface"}`}
    >
      <Icon name={CONTACT_ICON[c.type] ?? "call"} size={16} color={isWa ? "#fff" : "#23262e"} />
      {c.value}
    </button>
  );
}

function CompanyCars({ companyId }: { companyId: string }) {
  const { t } = useI18n();
  const [cars, setCars] = useState<Car[]>([]);
  const [cursor, setCursor] = useState<string | undefined>();
  const [loading, setLoading] = useState(true);
  const [done, setDone] = useState(false);

  const load = useCallback(async (cur?: string) => {
    setLoading(true);
    try {
      const res = await userApi.getCars(companyId, cur);
      setCars((p) => (cur ? [...p, ...res] : res));
      if (res.length > 0) setCursor(res[res.length - 1].id);
      if (res.length < 15) setDone(true);
    } catch {
      setDone(true);
    } finally {
      setLoading(false);
    }
  }, [companyId]);

  useEffect(() => { load(); }, [load]);

  if (loading && cars.length === 0)
    return (
      <div className="grid grid-cols-2 gap-x-3 gap-y-5 px-4 sm:grid-cols-3 lg:grid-cols-4">
        {Array.from({ length: 4 }).map((_, i) => <CarCardSkeleton key={i} />)}
      </div>
    );
  if (cars.length === 0) return <EmptyState icon="no_cars" title={t("empty.cars")} />;

  return (
    <>
      <div className="grid grid-cols-2 gap-x-3 gap-y-5 px-4 sm:grid-cols-3 lg:grid-cols-4">
        {cars.map((car) => <CarCard key={car.id} car={car} />)}
      </div>
      {!done && (
        <div className="flex justify-center py-5">
          <button onClick={() => load(cursor)} disabled={loading} className="text-sm font-medium text-primary">
            {loading ? <Spinner size={16} /> : t("web.loadMore")}
          </button>
        </div>
      )}
    </>
  );
}

export function CompanyDetailsClient() {
  const { id } = useParams<{ id: string }>();
  const { t } = useI18n();
  const { data: company, loading, error } = useAsync<Company>(() => userApi.company(id), [id]);

  if (loading) return <AppShell><PageLoading /></AppShell>;
  if (error || !company) return <AppShell><EmptyState icon="company" title={t("alertMessages.someThingWentWrong")} /></AppShell>;

  const loc = company.location as { lat?: number; long?: number } | null;

  return (
    <AppShell>
      <div className="px-4 pt-4">
        {/* Framed cover image */}
        <div className="relative h-36 w-full overflow-hidden rounded-2xl bg-primary-container sm:h-52">
          {company.coverImage ? (
            // eslint-disable-next-line @next/next/no-img-element
            <img src={imageUrl(company.coverImage)} alt="" className="h-full w-full object-cover" />
          ) : (
            <div className="h-full w-full bg-gradient-to-br from-primary/15 to-primary-container" />
          )}
        </div>

        {/* Logo overlaps the cover; name/rating sit below on white (readable) */}
        <div className="flex items-end gap-4">
          <span className="-mt-10 z-10 h-20 w-20 shrink-0 overflow-hidden rounded-2xl border-4 border-white bg-primary-container shadow-md">
            {company.image ? (
              // eslint-disable-next-line @next/next/no-img-element
              <img src={imageUrl(company.image)} alt="" className="h-full w-full object-cover" />
            ) : (
              <span className="grid h-full w-full place-items-center"><Icon name="company" size={28} color="#B51219" /></span>
            )}
          </span>
          <div className="min-w-0 flex-1 pt-3">
            <h1 className="truncate text-xl font-extrabold text-on-surface">{company.name}</h1>
            <div className="mt-1 flex items-center gap-3">
              <Rating rate={company.rate} review={company.review} />
              {company.cars != null && <span className="text-sm text-muted">· {company.cars} {t("labels.cars")}</span>}
            </div>
          </div>
        </div>

        {company.desc && <p className="mt-4 text-sm text-on-surface/80">{company.desc}</p>}

        {company.contacts && company.contacts.length > 0 && (
          <div className="mt-4 flex flex-wrap gap-2">
            {company.contacts.map((c) => <ContactButton key={c.id} c={c} companyId={company.id} />)}
          </div>
        )}

        {loc?.lat && loc?.long && (
          <div className="mt-5">
            <div className="mb-2 flex items-center justify-between">
              <h3 className="text-base font-bold text-on-surface">{t("labels.location")}</h3>
              <a
                href={`https://www.google.com/maps/search/?api=1&query=${loc.lat},${loc.long}`}
                target="_blank"
                rel="noreferrer"
                className="flex items-center gap-1 text-sm font-medium text-primary"
              >
                <Icon name="location_p" size={14} color="#B51219" /> {t("buttons.map")}
              </a>
            </div>
            <a
              href={`https://www.google.com/maps/search/?api=1&query=${loc.lat},${loc.long}`}
              target="_blank"
              rel="noreferrer"
              className="block"
            >
              <MiniMap lat={loc.lat} long={loc.long} height={200} />
            </a>
          </div>
        )}
      </div>

      <section className="mt-6">
        <SectionHeader title={t("labels.cars")} />
        <CompanyCars companyId={company.id} />
      </section>

      <div className="px-4">
        <GetAppBanner />
      </div>

      <section className="mt-6 pb-6">
        <SectionHeader title={t("labels.reviews")} />
        <ReviewList kind="company" id={company.id} />
      </section>
    </AppShell>
  );
}
