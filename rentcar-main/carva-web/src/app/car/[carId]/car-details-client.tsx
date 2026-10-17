"use client";

import { useState } from "react";
import Link from "next/link";
import { useParams } from "next/navigation";
import { AppShell } from "@/components/AppShell";
import { Icon, type IconName } from "@/components/Icon";
import { Rating, PageLoading, EmptyState, useEnumLabel, SectionHeader } from "@/components/ui";
import { FavoriteButton, OfficeLogo, displayPlan, usePrice } from "@/components/CarCard";
import { PopularPill, RentedBadge } from "@/components/CarBadges";
import { CarGallery } from "@/components/CarGallery";
import { ContactButton } from "@/components/ContactButtons";
import { ChatButton } from "@/components/ChatButton";
import { ActionButton } from "@/components/ActionButton";
import { Modal } from "@/components/Modal";
import { ShareButton } from "@/components/ShareButton";
import { DetailSponsorStrip } from "@/components/DetailSponsorStrip";
import { SimilarCars } from "@/components/SimilarCars";
import { MiniMap } from "@/components/MiniMap";
import { ReviewList } from "@/components/ReviewList";
import { useAsync } from "@/lib/useAsync";
import { userApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import { toast } from "@/components/toast";
import type { Car } from "@/lib/types";

/** One feature tile, like the app's: red-tint icon circle, value, label. */
function Spec({ icon, label, value }: { icon: IconName; label: string; value?: string | number | null }) {
  if (value === null || value === undefined || value === "") return null;
  return (
    <div data-reveal className="flex flex-col items-center gap-2 rounded-[14px] border border-hairline bg-white px-1.5 py-3 text-center">
      <span className="grid h-10 w-10 place-items-center rounded-full bg-primary-container">
        <Icon name={icon} size={19} color="#B51219" />
      </span>
      <span className="max-w-full truncate text-[14px] font-semibold leading-tight text-on-surface">{value}</span>
      <span className="max-w-full truncate text-[11.5px] leading-tight text-muted">{label}</span>
    </div>
  );
}

export function CarDetailsClient() {
  const { carId } = useParams<{ carId: string }>();
  const { t, tr, num } = useI18n();
  const price = usePrice();
  const e = useEnumLabel();
  const { data: car, loading, error } = useAsync<Car>(() => userApi.carDetails(carId), [carId]);
  const [contacting, setContacting] = useState(false);
  const [contactsOpen, setContactsOpen] = useState(false);

  if (loading) return <AppShell><PageLoading /></AppShell>;
  if (error || !car)
    return (
      <AppShell>
        <EmptyState icon="no_cars" title={t("alertMessages.someThingWentWrong")} subtitle={error ?? undefined} />
      </AppShell>
    );

  const images = car.images ?? [];
  const f = car.feature;
  // Cars without their own location fall back to the company office,
  // exactly like the app's details map.
  const loc = car.location?.lat != null ? car.location : car.company?.location;

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

  const plan = displayPlan(car);
  const city = loc?.city;
  const town = loc?.town;

  // Phones: the app's floating glass contact bar (price, WhatsApp, chat, call).
  const contactBar = (
    <div className="glass flex h-16 items-center gap-2 rounded-full py-2 pe-2 ps-4 shadow-[var(--shadow-glass)]">
      {plan && Number(plan.price) > 0 && (
        <div className="max-w-[88px] shrink-0 leading-tight">
          <p className="num truncate text-[15px] font-bold text-ink">{price.amount(plan)}</p>
          <p className="truncate text-[11px] text-muted">/ {price.unit(plan)}</p>
        </div>
      )}
      <ActionButton tone="whatsapp" icon="whatsapp" label={t("buttons.whatsapp")} onClick={whatsapp} loading={contacting} className="min-w-0 flex-1 !px-3" />
      <ChatButton companyId={car.companyId} carId={car.carId} className="!w-12 !shrink-0 !px-0 min-[400px]:!w-auto min-[400px]:!flex-1 min-[400px]:!px-3 [&>span]:hidden min-[400px]:[&>span]:inline" />
      <button
        onClick={() => setContactsOpen(true)}
        aria-label={t("buttons.contact")}
        className="press grid h-12 w-12 shrink-0 place-items-center rounded-full border border-hairline bg-white"
      >
        <Icon name="call" size={20} color="#171214" />
      </button>
    </div>
  );

  return (
    <AppShell bottomBar={contactBar}>
      <div className="px-4 pt-3">
        <div className="mb-3 flex items-center justify-between gap-3">
          <Link href="/" className="press inline-flex h-9 items-center gap-1.5 rounded-full border border-hairline bg-white/80 px-3 text-[13px] font-semibold text-muted">
            <Icon name="arrow" size={14} className="rtl:rotate-180" /> {t("bottomNavigation.cars")}
          </Link>
          <ShareButton title={car.title} />
        </div>

        <div className="grid gap-6 lg:grid-cols-[1.25fr_1fr] lg:items-start">
          <CarGallery
            images={images}
            title={car.title}
            featuredLabel={car.featuredCars ? t("v2.featured") : undefined}
            favorite={<FavoriteButton car={car} onPhoto />}
          />

          {/* Summary: name, badges, city, price — then contact (desktop) */}
          <div className="lg:sticky lg:top-20">
            <div className="flex items-start gap-3">
              <div className="min-w-0 flex-1">
                <h1 className="text-[24px] font-bold leading-tight text-on-surface sm:text-[28px]"><bdi>{car.title}</bdi></h1>
                <div className="mt-1.5 flex flex-wrap items-center gap-x-3 gap-y-1 text-[13px] text-muted">
                  <Rating rate={car.rate} review={car.review} size={15} />
                  <span>· <span className="num">{num(car.trips)}</span> {t("bottomNavigation.trips")}</span>
                </div>
              </div>
              {plan && Number(plan.price) > 0 && (
                <div className="shrink-0 text-end">
                  <p className="num text-[22px] font-bold leading-none text-primary sm:text-[26px]">{price.amount(plan)}</p>
                  <p className="mt-1 text-[13px] text-muted">/ {price.unit(plan)}</p>
                </div>
              )}
            </div>

            <div className="mt-3 flex flex-wrap items-start gap-2">
              <RentedBadge car={car} />
              <PopularPill car={car} />
              {city && (
                <span className="inline-flex items-center gap-1 rounded-full bg-primary-container px-2.5 py-1.5 text-[12.5px] font-semibold text-primary">
                  <Icon name="location_p" size={14} color="#B51219" />
                  {[tr(city), tr(town)].filter(Boolean).join("، ")}
                </span>
              )}
            </div>

            {car.company && (
              <Link
                href={`/company/${car.company.id}`}
                className="press mt-4 flex items-center gap-3 rounded-2xl bg-white p-3 shadow-[var(--shadow-card)] ring-1 ring-hairline"
              >
                <OfficeLogo name={car.company.name} image={car.company.image} size={44} />
                <div className="min-w-0 flex-1">
                  <p className="truncate font-semibold text-on-surface">{car.company.name}</p>
                  <Rating rate={car.company.rate} review={car.company.review} />
                </div>
                <Icon name="arrow_tail" size={16} color="#A29A96" className="ltr:rotate-180" />
              </Link>
            )}

            {/* Rental plans */}
            <div className="mt-5">
              <h2 className="mb-2.5 text-[15px] font-bold text-on-surface">{t("labels.rentalPlans")}</h2>
              <div className="grid grid-cols-2 gap-2 sm:grid-cols-3 lg:grid-cols-2 xl:grid-cols-3">
                {(car.rentalPlan ?? []).map((p) => {
                  const main = p.id === plan?.id;
                  return (
                    <div
                      key={p.id}
                      data-reveal
                      className={`rounded-2xl px-3.5 py-3 ${main ? "bg-primary-container ring-1 ring-primary/30" : "bg-white ring-1 ring-hairline"}`}
                    >
                      <p className="text-[12px] font-semibold text-muted">{e.period(p.periodType)}</p>
                      <p className={`num mt-1 truncate text-[16px] font-bold ${main ? "text-primary" : "text-on-surface"}`}>{price.amount(p)}</p>
                    </div>
                  );
                })}
              </div>
              {(!car.rentalPlan || car.rentalPlan.length === 0) && <p className="text-sm text-muted">{t("web.noPlans")}</p>}
            </div>

            {/* Contact: inline on tablets/desktop; phones use the floating bar */}
            <div className="mt-5 hidden grid-cols-[1fr_1fr_auto] gap-2.5 md:grid">
              <ActionButton tone="whatsapp" icon="whatsapp" label={t("buttons.whatsapp")} onClick={whatsapp} loading={contacting} />
              <ChatButton companyId={car.companyId} carId={car.carId} />
              <ActionButton tone="neutral" icon="call" label={t("buttons.contact")} onClick={() => setContactsOpen(true)} compact />
            </div>
          </div>
        </div>

        <DetailSponsorStrip />

        {/* Features */}
        <section className="mt-8">
          <h2 className="mb-3 text-[17px] font-bold text-on-surface">{t("labels.features")}</h2>
          <div className="grid grid-cols-3 gap-2.5 sm:grid-cols-4 md:grid-cols-5">
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

        {/* Location */}
        {loc?.lat && loc?.long && (
          <section className="mt-8">
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
            {(loc.city || loc.town) && (
              <p className="mb-2 text-sm text-muted">
                {[tr(loc.town), tr(loc.city)].filter(Boolean).join(", ")}
              </p>
            )}
            <a href={`https://www.google.com/maps/search/?api=1&query=${loc.lat},${loc.long}`} target="_blank" rel="noreferrer" className="block overflow-hidden rounded-[18px] shadow-[var(--shadow-card)]">
              <MiniMap lat={loc.lat} long={loc.long} />
            </a>
          </section>
        )}

        <SimilarCars car={car} />

        {/* Reviews */}
        <section className="mt-8 pb-4">
          <SectionHeader title={t("labels.reviews")} />
          <ReviewList kind="car" id={car.id} />
        </section>
      </div>

      <Modal open={contactsOpen} onClose={() => setContactsOpen(false)} title={t("buttons.contact")}>
        <div className="flex flex-wrap gap-2">
          {(car.company?.contacts ?? []).map((c) => (
            <ContactButton key={c.id} c={c} companyId={car.companyId} />
          ))}
          {(car.company?.contacts ?? []).length === 0 && (
            <p className="text-sm text-muted">{t("empty.noData")}</p>
          )}
        </div>
      </Modal>
    </AppShell>
  );
}
