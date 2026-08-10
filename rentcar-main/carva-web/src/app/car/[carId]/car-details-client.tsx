"use client";

import { useState } from "react";
import Link from "next/link";
import { useParams, useRouter } from "next/navigation";
import { AppShell } from "@/components/AppShell";
import { Icon, type IconName } from "@/components/Icon";
import { Button, Rating, PageLoading, EmptyState, useEnumLabel, SectionHeader } from "@/components/ui";
import { FavoriteButton } from "@/components/CarCard";
import { CarGallery } from "@/components/CarGallery";
import { GetAppBanner } from "@/components/GetAppBanner";
import { MiniMap } from "@/components/MiniMap";
import { ReviewList } from "@/components/ReviewList";
import { useAsync } from "@/lib/useAsync";
import { userApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import { imageUrl } from "@/lib/api";
import { formatNumber } from "@/lib/format";
import { toast } from "@/components/toast";
import type { Car } from "@/lib/types";

function Spec({ icon, label, value }: { icon: IconName; label: string; value?: string | number | null }) {
  if (value === null || value === undefined || value === "") return null;
  return (
    <div className="flex items-center gap-2.5 rounded-xl border border-surface-low bg-surface-lowest px-3 py-2.5">
      <Icon name={icon} size={20} color="#B51219" />
      <div className="min-w-0">
        <p className="text-[11px] text-muted">{label}</p>
        <p className="truncate text-sm font-semibold text-on-surface">{value}</p>
      </div>
    </div>
  );
}

export function CarDetailsClient() {
  const { carId } = useParams<{ carId: string }>();
  const { t, tr, num } = useI18n();
  const e = useEnumLabel();
  const router = useRouter();
  const { data: car, loading, error } = useAsync<Car>(() => userApi.carDetails(carId), [carId]);
  const [contacting, setContacting] = useState(false);

  if (loading) return <AppShell><PageLoading /></AppShell>;
  if (error || !car)
    return (
      <AppShell>
        <EmptyState icon="no_cars" title={t("alertMessages.someThingWentWrong")} subtitle={error ?? undefined} />
      </AppShell>
    );

  const images = car.images ?? [];
  const f = car.feature;
  const loc = car.location;

  async function whatsapp() {
    if (!car) return;
    // Open the tab synchronously so mobile browsers keep the user-gesture and
    // don't block it once the contact URL resolves after the await.
    const win = typeof window !== "undefined" ? window.open("", "_blank") : null;
    setContacting(true);
    try {
      const url = await userApi.contact({ type: "whatsapp", companyId: car.companyId, carId: car.id });
      if (url) {
        if (win) win.location.href = url;
        else window.location.href = url;
      } else {
        win?.close();
      }
    } catch {
      win?.close();
      toast(t("alertMessages.someThingWentWrong"), "error");
    } finally {
      setContacting(false);
    }
  }

  return (
    <AppShell>
      <div className="px-4 pt-4">
        <Link href="/" className="mb-3 inline-flex items-center gap-1 text-sm text-muted">
          <Icon name="arrow" size={16} /> {t("screens.detailsCars")}
        </Link>

        <div className="grid gap-6 lg:grid-cols-[1.2fr_1fr]">
          {/* Gallery */}
          <CarGallery
            images={images}
            title={car.title}
            featuredLabel={car.featuredCars ? t("labels.featured") : undefined}
            favorite={<FavoriteButton car={car} />}
          />

          {/* Summary + booking */}
          <div>
            <div className="flex items-start justify-between gap-3">
              <h1 className="text-2xl font-extrabold text-on-surface">{car.title}</h1>
            </div>
            <div className="mt-2 flex items-center gap-3">
              <Rating rate={car.rate} review={car.review} size={16} />
              <span className="text-sm text-muted">· {num(car.trips)} {t("bottomNavigation.trips")}</span>
              {car.brand && <span className="text-sm text-muted">· {tr(car.brand)}</span>}
            </div>

            {/* Rental plans */}
            <div className="mt-5">
              <h3 className="mb-2 text-sm font-bold text-on-surface">{t("labels.rentalPlans")}</h3>
              <div className="space-y-2">
                {(car.rentalPlan ?? []).map((p) => (
                  <div key={p.id} className="flex items-center justify-between rounded-xl border border-surface-low px-4 py-3">
                    <span className="text-sm font-medium">{e.period(p.periodType)}</span>
                    <span className="text-base font-bold text-primary">
                      {formatNumber(p.price)} {e.currency(p.currency)}
                    </span>
                  </div>
                ))}
                {(!car.rentalPlan || car.rentalPlan.length === 0) && (
                  <p className="text-sm text-muted">{t("web.noPlans")}</p>
                )}
              </div>
            </div>

            <div className="mt-5 flex flex-wrap gap-2">
              <Button onClick={() => router.push(`/booking?car=${car.carId}`)} className="flex-1">
                {t("buttons.reserveNow")}
              </Button>
              <Button variant="secondary" onClick={whatsapp} loading={contacting} className="bg-tint hover:bg-tint/90">
                <Icon name="whatsapp" size={18} color="#fff" /> {t("buttons.whatsapp")}
              </Button>
            </div>
          </div>
        </div>

        {/* Features */}
        <section className="mt-8">
          <h3 className="mb-3 text-base font-bold text-on-surface">{t("labels.features")}</h3>
          <div className="grid grid-cols-2 gap-2.5 sm:grid-cols-3 md:grid-cols-4">
            <Spec icon="profile" label={t("labels.seat")} value={num(f?.seat) || null} />
            <Spec icon="calender" label={t("labels.year")} value={num(f?.year) || null} />
            <Spec icon="transmission" label={t("labels.transmission")} value={e.transmission(f?.transmission)} />
            <Spec icon="fuel" label={t("labels.fuel")} value={e.fuel(f?.fuel)} />
            <Spec icon="engine" label={t("labels.horsePower")} value={f?.hp ? `${num(f.hp)} ${t("labels.hp")}` : null} />
            <Spec icon="speed" label={t("labels.speed")} value={f?.speed ? `${num(f.speed)} ${t("labels.kmH")}` : null} />
            <Spec icon="odometer" label={t("labels.odometer")} value={f?.odometer ? `${num(f.odometer)} ${t("labels.km")}` : null} />
            <Spec icon="cylinder" label={t("labels.cylinders")} value={num(f?.cylinders) || null} />
            <Spec icon="engine" label={t("labels.engineCC")} value={num(f?.engCC) || null} />
            <Spec icon="car" label={t("labels.type")} value={f?.type ? tr(f.type) : null} />
          </div>
        </section>

        {/* Company */}
        {car.company && (
          <section className="mt-8">
            <h3 className="mb-3 text-base font-bold text-on-surface">{t("web.providedBy")}</h3>
            <Link href={`/company/${car.company.id}`} className="flex items-center gap-3 rounded-2xl border border-surface-low p-3 transition hover:bg-surface-lowest">
              <span className="h-14 w-14 shrink-0 overflow-hidden rounded-full bg-primary-container">
                {car.company.image ? (
                  // eslint-disable-next-line @next/next/no-img-element
                  <img src={imageUrl(car.company.image)} alt="" className="h-full w-full object-cover" />
                ) : (
                  <span className="grid h-full w-full place-items-center"><Icon name="company" size={22} color="#B51219" /></span>
                )}
              </span>
              <div className="min-w-0 flex-1">
                <p className="truncate font-semibold text-on-surface">{car.company.name}</p>
                <Rating rate={car.company.rate} review={car.company.review} />
              </div>
              <Icon name="arrow_tail" size={18} color="#9e9e9e" />
            </Link>
          </section>
        )}

        {/* Location */}
        {loc?.lat && loc?.long && (
          <section className="mt-8">
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
            {(loc.city || loc.town) && (
              <p className="mb-2 text-sm text-muted">
                {[tr(loc.town), tr(loc.city)].filter(Boolean).join(", ")}
              </p>
            )}
            <a href={`https://www.google.com/maps/search/?api=1&query=${loc.lat},${loc.long}`} target="_blank" rel="noreferrer" className="block">
              <MiniMap lat={loc.lat} long={loc.long} />
            </a>
          </section>
        )}

        <GetAppBanner />

        {/* Reviews */}
        <section className="mt-8 pb-4">
          <SectionHeader title={t("labels.reviews")} />
          <ReviewList kind="car" id={car.id} />
        </section>
      </div>
    </AppShell>
  );
}
