"use client";

import Link from "next/link";
import { useState } from "react";
import { useRouter } from "next/navigation";
import type { Car, RentalPlan } from "@/lib/types";
import { ImageHolder } from "./ImageHolder";
import { Icon } from "./Icon";
import { useEnumLabel, SkeletonBox } from "./ui";
import { useI18n } from "@/i18n";
import { useAuth } from "@/lib/auth-store";
import { userApi } from "@/lib/services";
import { formatNumber } from "@/lib/format";
import { imageUrl } from "@/lib/api";
import { isRented } from "@/lib/car-status";
import { carName } from "@/lib/car-name";
import { RentedBadge } from "./CarBadges";
import { toast } from "./toast";
import { useLongPress, usePreview } from "./ContextPreview";

export function displayPlan(car: Car) {
  return (
    car.rentalPlan?.find((p) => p.periodType === car.displayPlan) ??
    car.rentalPlan?.[0]
  );
}

/** "$65" or "75,000 دینار", and " / day" — the app's PriceText. */
export function usePrice() {
  const { t } = useI18n();
  const e = useEnumLabel();
  return {
    amount: (p: RentalPlan) =>
      p.currency === "usd" ? `$${formatNumber(p.price)}` : `${formatNumber(p.price)}${p.currency ? ` ${e.currency(p.currency)}` : ""}`,
    unit: (p: RentalPlan) => t(`v2.unit_${p.periodType}`),
  };
}

/** Heart button. `onPhoto`: white heart in a dark see-through circle (cards, galleries). */
export function FavoriteButton({ car, onPhoto = false }: { car: Car; onPhoto?: boolean }) {
  const { t } = useI18n();
  const router = useRouter();
  const user = useAuth((s) => s.user);
  const [own, setOwn] = useState(!!car.isFavorite);
  // A save / unsave from the long-press preview wins over the card's own state.
  const synced = usePreview((s) => s.fav[car.id]);
  const setSynced = usePreview((s) => s.setFav);
  const fav = synced ?? own;
  const setFav = (f: (v: boolean) => boolean) => {
    const next = f(fav);
    setOwn(next);
    setSynced(car.id, next);
  };
  const [busy, setBusy] = useState(false);
  const [pop, setPop] = useState(0);

  async function toggle(e: React.MouseEvent) {
    e.preventDefault();
    e.stopPropagation();
    if (!user) {
      router.push("/login");
      return;
    }
    setBusy(true);
    if (!fav) setPop((n) => n + 1);
    setFav((v) => !v);
    try {
      await userApi.toggleFavorite(car.id);
    } catch {
      setFav((v) => !v);
      toast(t("alertMessages.someThingWentWrong"), "error");
    } finally {
      setBusy(false);
    }
  }

  return (
    <button
      onClick={toggle}
      disabled={busy}
      aria-label="favorite"
      className={`press grid h-8 w-8 place-items-center rounded-full backdrop-blur transition ${
        onPhoto ? "bg-ink/45 hover:bg-ink/60" : "bg-white/90 shadow-sm hover:bg-white"
      }`}
    >
      <span key={pop} className={pop ? "heart-pop inline-flex" : "inline-flex"}>
        <Icon
          name={fav ? "favorited" : "heart"}
          size={16}
          color={fav ? (onPhoto ? "#FF4D55" : "#B51219") : onPhoto ? "#fff" : "#171214"}
        />
      </span>
    </button>
  );
}

/** Office logo, or its first letter on a dark circle. */
export function OfficeLogo({ name, image, size }: { name: string; image?: string | null; size: number }) {
  if (image)
    // eslint-disable-next-line @next/next/no-img-element
    return <img src={imageUrl(image)} alt="" style={{ width: size, height: size }} className="shrink-0 rounded-full object-cover ring-1 ring-hairline" />;
  const letter = (name.trim()[0] ?? "?").toUpperCase();
  return (
    <span style={{ width: size, height: size, fontSize: size * 0.45 }} className="grid shrink-0 place-items-center rounded-full bg-ink font-bold leading-none text-white">
      {letter}
    </span>
  );
}

function Chip({ icon, text, ltr, mono, small }: { icon: React.ReactNode; text: string; ltr?: boolean; mono?: boolean; small?: boolean }) {
  return (
    <span
      className={`inline-flex min-w-0 items-center bg-surface-lowest font-semibold text-on-surface ${
        small ? "h-[22px] gap-[3px] rounded-[7px] px-1.5 text-[10px]" : "h-6 gap-1 rounded-lg px-[7px] text-[11px]"
      }`}
    >
      <span className="shrink-0 text-muted">{icon}</span>
      <span className={`truncate ${mono ? "num" : ""}`} dir={ltr ? "ltr" : undefined}>{text}</span>
    </span>
  );
}

const I = {
  gear: (s: number) => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="currentColor" aria-hidden><path d="M17.41 6.59 15 5.5l2.41-1.09L18.5 2l1.09 2.41L22 5.5l-2.41 1.09L18.5 9l-1.09-2.41zm3.87 6.13L20.5 11l-.78 1.72-1.72.78 1.72.78.78 1.72.78-1.72L23 13.5l-1.72-.78zm-5.04 1.65 1.94 1.47-2.5 4.33-2.24-.94c-.2.13-.42.26-.64.37l-.3 2.4h-5l-.3-2.41c-.22-.11-.43-.23-.64-.37l-2.24.94-2.5-4.33 1.94-1.47a4.1 4.1 0 0 1 0-.74L1.82 12.1l2.5-4.33 2.24.94c.2-.13.42-.26.64-.37L7.5 5.93h5l.3 2.41c.22.11.43.23.64.37l2.24-.94 2.5 4.33-1.94 1.47c.02.25.02.5 0 .74zM13 14c0-1.65-1.35-3-3-3s-3 1.35-3 3 1.35 3 3 3 3-1.35 3-3z" /></svg>
  ),
  speed: (s: number) => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="currentColor" aria-hidden><path d="m20.38 8.57-1.23 1.85a8 8 0 0 1-.22 7.58H5.07A8 8 0 0 1 15.58 6.85l1.85-1.23A10 10 0 0 0 3.35 19a2 2 0 0 0 1.72 1h13.85a2 2 0 0 0 1.74-1 10 10 0 0 0-.27-10.44zm-9.79 6.84a2 2 0 0 0 2.83 0l5.66-8.49-8.49 5.66a2 2 0 0 0 0 2.83z" /></svg>
  ),
  cal: (s: number) => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="currentColor" aria-hidden><path d="M20 3h-1V1h-2v2H7V1H5v2H4c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 18H4V10h16v11zm0-13H4V5h16v3z" /></svg>
  ),
  pin: (s: number) => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="currentColor" aria-hidden><path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5a2.5 2.5 0 0 1 0-5 2.5 2.5 0 0 1 0 5z" /></svg>
  ),
  star: (s: number) => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="currentColor" aria-hidden><path d="M12 17.27 18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z" /></svg>
  ),
};
export const CardIcons = I;

/**
 * The app's car card: one component for both layouts.
 * - tall (default): photo on top — grids and horizontal rails.
 * - wide: one per row — photo on the start side, details beside it.
 * Same order everywhere: name (make · model · trim), office, chips
 * (transmission, odometer, year), city, price. `featured` adds the red
 * border, light red wash and "Featured" pill; rented cars get the amber
 * badge and a slightly dimmer photo.
 */
export function CarCard({
  car,
  className = "",
  mode = "tall",
  featured,
}: {
  car: Car;
  className?: string;
  mode?: "tall" | "wide";
  featured?: boolean;
}) {
  const { t, tr, num } = useI18n();
  const e = useEnumLabel();
  const price = usePrice();
  const plan = displayPlan(car);
  const wide = mode === "wide";
  const isFeatured = featured ?? !!car.featuredCars;
  const rented = isRented(car);
  const name = carName(car.title, car.brand?.en);
  const city = car.location?.city ?? car.company?.location?.city;
  const f = car.feature;
  const odo = f?.odometer ? num(f.odometer).trim() : "";
  const year = f?.year ? num(f.year) : "";
  const s = wide ? 12 : 11;
  const hold = useLongPress(() => ({ kind: "car", car }));

  const photo = (
    <div className={`relative overflow-hidden bg-[#1A1517] ${wide ? "w-[132px] shrink-0 sm:w-44" : "aspect-[3/2] w-full"}`}>
      <ImageHolder
        src={car.images?.[0]?.image}
        alt={car.title}
        rounded="rounded-none"
        className={`h-full w-full [&_img]:transition [&_img]:duration-500 group-hover:[&_img]:scale-[1.04] ${rented ? "opacity-85" : ""}`}
      />
      {rented && (
        <div className={`absolute top-1.5 max-w-[calc(100%-52px)] ${wide ? "end-1.5" : "start-1.5"}`}>
          <RentedBadge car={car} small />
        </div>
      )}
      <div className={`absolute top-1.5 ${wide ? "start-1.5" : "end-1.5"}`}>
        <FavoriteButton car={car} onPhoto />
      </div>
      {isFeatured && (
        <span className="absolute bottom-2 start-2 inline-flex h-6 items-center gap-1 rounded-xl bg-gradient-to-br from-[#D21B23] to-[#9E0F15] px-[9px] text-[11px] font-bold text-white shadow-[0_4px_10px_-3px_rgba(181,18,25,0.6)]">
          {I.star(13)}
          {t("v2.featured")}
        </span>
      )}
    </div>
  );

  const priceEl =
    plan && Number(plan.price) > 0 ? (
      <p className="flex min-w-0 items-baseline gap-1 truncate">
        <span className={`num font-semibold text-on-surface ${wide ? "text-[17px]" : "text-[15px]"}`}>{price.amount(plan)}</span>
        <span className={`text-muted ${wide ? "text-[11px]" : "text-[10px]"}`}>/ {price.unit(plan)}</span>
      </p>
    ) : (
      <p className={`truncate font-semibold text-primary ${wide ? "text-[13px]" : "text-[11px]"}`}>{t("v2.contactForPrice")}</p>
    );

  const cityEl = city && (
    <span className={`inline-flex min-w-0 items-center gap-[3px] font-semibold text-muted ${wide ? "text-[11px]" : "text-[10px]"}`}>
      <span className="shrink-0 text-primary">{I.pin(wide ? 13 : 12)}</span>
      <span className="truncate">{tr(city)}</span>
    </span>
  );

  const info = (
    <div
      className={`flex min-w-0 flex-1 flex-col ${wide ? "gap-[7px] px-3 py-[11px]" : "gap-1.5 px-[11px] pb-3 pt-2.5"} ${
        isFeatured ? "bg-gradient-to-bl from-featured-tint via-white to-white rtl:bg-gradient-to-br" : ""
      }`}
    >
      {/* Make in grey, model in bold black, trim in red — always left to right. */}
      {wide ? (
        <p dir="ltr" className="truncate text-[16px] font-bold leading-tight text-on-surface rtl:text-right">
          {name.make && <span className="font-semibold text-micro">{name.make} </span>}
          {name.model}
          {name.trim && <span className="text-primary"> {name.trim}</span>}
        </p>
      ) : (
        <div dir="ltr" className="min-w-0 rtl:text-right">
          {name.make && <p className="truncate text-[11px] font-semibold leading-tight text-micro">{name.make}</p>}
          <p className="truncate text-[15px] font-bold leading-tight text-on-surface">
            {name.model}
            {name.trim && <span className="text-primary"> {name.trim}</span>}
          </p>
        </div>
      )}
      {car.company?.name?.trim() && (
        <span className={`flex min-w-0 items-center gap-[5px] font-semibold text-muted ${wide ? "text-[12px]" : "text-[11px]"}`}>
          <OfficeLogo name={car.company.name} image={car.company.image} size={wide ? 18 : 16} />
          <span className="truncate">{car.company.name}</span>
        </span>
      )}
      {(f?.transmission || odo || year) && (
        <div className="flex flex-wrap gap-1">
          {f?.transmission && <Chip small={!wide} icon={I.gear(s)} text={e.transmission(f.transmission)} />}
          {odo && <Chip small={!wide} icon={I.speed(s)} text={odo} ltr />}
          {year && <Chip small={!wide} icon={I.cal(s - 1)} text={year} mono />}
        </div>
      )}
      <div className="flex-1" />
      {wide ? (
        <div className="flex items-center justify-between gap-2">
          {priceEl}
          {cityEl}
        </div>
      ) : (
        <div className="flex flex-col gap-[3px]">
          {cityEl}
          {priceEl}
        </div>
      )}
    </div>
  );

  return (
    <Link
      href={`/car/${car.carId}`}
      data-reveal
      {...hold}
      className={`press no-callout group relative flex overflow-hidden rounded-[18px] bg-white transition-shadow duration-300 hover:shadow-[var(--shadow-lift)] ${
        wide ? "min-h-[168px] flex-row" : "h-full flex-col"
      } ${isFeatured ? "shadow-[var(--shadow-featured)]" : "shadow-[var(--shadow-card)]"} ${className}`}
    >
      {photo}
      {info}
      {/* Featured border painted over everything, same width all round */}
      {isFeatured && <span aria-hidden className="pointer-events-none absolute inset-0 rounded-[18px] border-2 border-featured-border" />}
    </Link>
  );
}

export function CarCardSkeleton({ mode = "tall" }: { mode?: "tall" | "wide" }) {
  if (mode === "wide")
    return (
      <div className="flex min-h-[168px] overflow-hidden rounded-[18px] bg-white shadow-[var(--shadow-card)]">
        <SkeletonBox className="w-[132px] !rounded-none" />
        <div className="flex-1 space-y-2 p-3">
          <SkeletonBox className="h-4 w-3/4" />
          <SkeletonBox className="h-3 w-1/2" />
          <SkeletonBox className="h-5 w-2/3" />
        </div>
      </div>
    );
  return (
    <div className="overflow-hidden rounded-[18px] bg-white shadow-[var(--shadow-card)]">
      <SkeletonBox className="aspect-[3/2] w-full !rounded-none" />
      <div className="space-y-2 p-3">
        <SkeletonBox className="h-3 w-1/3" />
        <SkeletonBox className="h-4 w-3/4" />
        <SkeletonBox className="h-5 w-full" />
        <SkeletonBox className="h-4 w-1/2" />
      </div>
    </div>
  );
}
