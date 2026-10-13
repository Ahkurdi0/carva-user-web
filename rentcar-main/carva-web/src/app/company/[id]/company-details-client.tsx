"use client";

import { useCallback, useEffect, useState } from "react";
import { useParams } from "next/navigation";
import { AppShell } from "@/components/AppShell";
import { Icon, type IconName } from "@/components/Icon";
import { ImageHolder } from "@/components/ImageHolder";
import { CarCard, CarCardSkeleton } from "@/components/CarCard";
import { MiniMap } from "@/components/MiniMap";
import { ContactButton } from "@/components/ContactButtons";
import { ChatButton } from "@/components/ChatButton";
import { ShareButton } from "@/components/ShareButton";
import { SocialLinks } from "@/components/SocialLinks";
import { ReviewList } from "@/components/ReviewList";
import { Rating, PageLoading, EmptyState, SectionHeader, Spinner } from "@/components/ui";
import { useAsync } from "@/lib/useAsync";
import { userApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import { imageUrl } from "@/lib/api";
import type { Car, Company, Contact } from "@/lib/types";

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
      <div className="grid grid-cols-2 gap-3 px-4 sm:grid-cols-3 lg:grid-cols-4">
        {Array.from({ length: 4 }).map((_, i) => <CarCardSkeleton key={i} />)}
      </div>
    );
  if (cars.length === 0) return <EmptyState icon="no_cars" title={t("empty.cars")} />;

  return (
    <>
      <div className="grid grid-cols-2 gap-3 px-4 sm:grid-cols-3 lg:grid-cols-4">
        {cars.map((car) => <CarCard key={car.id} car={car} />)}
      </div>
      {!done && (
        <div className="flex justify-center py-5">
          <button onClick={() => load(cursor)} disabled={loading} className="press h-10 rounded-full border border-hairline bg-white px-5 text-[13px] font-semibold text-primary">
            {loading ? <Spinner size={16} /> : t("web.loadMore")}
          </button>
        </div>
      )}
    </>
  );
}

export function CompanyDetailsClient() {
  const { id } = useParams<{ id: string }>();
  const { t, tr } = useI18n();
  const { data: company, loading, error } = useAsync<Company>(() => userApi.company(id), [id]);

  if (loading) return <AppShell><PageLoading /></AppShell>;
  if (error || !company) return <AppShell><EmptyState icon="company" title={t("alertMessages.someThingWentWrong")} /></AppShell>;

  const loc = company.location ?? null;

  return (
    <AppShell>
      <div className="px-4 pt-4">
        {/* Framed cover image */}
        <div className="relative h-40 w-full overflow-hidden rounded-[18px] bg-hero shadow-[var(--shadow-card)] sm:h-56">
          {company.coverImage ? (
            // eslint-disable-next-line @next/next/no-img-element
            <img src={imageUrl(company.coverImage)} alt="" className="h-full w-full object-cover" />
          ) : (
            <div className="relative h-full w-full bg-[radial-gradient(120%_160%_at_85%_-30%,#5A090D_0%,#161112_58%)]">
              <div className="hero-texture absolute inset-0" aria-hidden />
            </div>
          )}
        </div>

        {/* Logo overlaps the cover; name/rating sit below on white (readable) */}
        <div className="flex items-end gap-4">
          <span className="z-10 -mt-10 ms-3 h-20 w-20 shrink-0 overflow-hidden rounded-full border-4 border-canvas bg-white shadow-[var(--shadow-card)]">
            {company.image ? (
              // eslint-disable-next-line @next/next/no-img-element
              <img src={imageUrl(company.image)} alt="" className="h-full w-full object-cover" />
            ) : (
              <span className="grid h-full w-full place-items-center"><Icon name="company" size={28} color="#B51219" /></span>
            )}
          </span>
          <div className="min-w-0 flex-1 pt-3">
            <h1 className="truncate text-[22px] font-bold text-on-surface"><bdi>{company.name}</bdi></h1>
            <div className="mt-1 flex items-center gap-3">
              <Rating rate={company.rate} review={company.review} />
              {company.cars != null && <span className="text-sm text-muted">· <span className="num">{company.cars}</span> {t("labels.cars")}</span>}
            </div>
            {(loc?.city || loc?.town) && (
              <span className="mt-1.5 inline-flex max-w-full items-center gap-1 rounded-full bg-primary-container px-2.5 py-1 text-[12.5px] font-semibold text-primary">
                <Icon name="location_p" size={13} color="#B51219" />
                <span className="truncate">{[tr(loc.city), tr(loc.town)].filter(Boolean).join("، ")}</span>
              </span>
            )}
          </div>
          <div className="pt-3">
            <ShareButton title={company.name} />
          </div>
        </div>

        {company.desc && <p className="mt-4 whitespace-pre-line text-[14.5px] leading-relaxed text-on-surface/80">{company.desc}</p>}

        <div className="mt-4 flex flex-wrap gap-2">
          <ChatButton companyId={company.id} />
          {company.contacts?.map((c) => <ContactButton key={c.id} c={c} companyId={company.id} />)}
        </div>

        <SocialLinks company={company} />

        {loc?.lat && loc?.long && (
          <div className="mt-5">
            <div className="mb-2 flex items-center justify-between">
              <h2 className="text-[17px] font-bold text-on-surface">{t("labels.location")}</h2>
              <a
                href={`https://www.google.com/maps/search/?api=1&query=${loc.lat},${loc.long}`}
                target="_blank"
                rel="noreferrer"
                className="see-all flex items-center gap-1 text-primary"
              >
                <Icon name="location_p" size={14} color="#B51219" /> {t("buttons.map")}
              </a>
            </div>
            <a
              href={`https://www.google.com/maps/search/?api=1&query=${loc.lat},${loc.long}`}
              target="_blank"
              rel="noreferrer"
              className="block overflow-hidden rounded-[18px] shadow-[var(--shadow-card)]"
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

      <section className="mt-6 pb-6">
        <SectionHeader title={t("labels.reviews")} />
        <ReviewList kind="company" id={company.id} />
      </section>
    </AppShell>
  );
}
