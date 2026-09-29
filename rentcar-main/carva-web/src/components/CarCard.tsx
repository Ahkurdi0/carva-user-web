"use client";

import Link from "next/link";
import { useState } from "react";
import { useRouter } from "next/navigation";
import type { Car } from "@/lib/types";
import { ImageHolder } from "./ImageHolder";
import { Icon } from "./Icon";
import { useEnumLabel, SkeletonBox } from "./ui";
import { useI18n } from "@/i18n";
import { useAuth } from "@/lib/auth-store";
import { userApi } from "@/lib/services";
import { formatNumber } from "@/lib/format";
import { toast } from "./toast";

function displayPlan(car: Car) {
  return (
    car.rentalPlan?.find((p) => p.periodType === car.displayPlan) ??
    car.rentalPlan?.[0]
  );
}

export function FavoriteButton({ car }: { car: Car }) {
  const { t } = useI18n();
  const router = useRouter();
  const user = useAuth((s) => s.user);
  const [fav, setFav] = useState(!!car.isFavorite);
  const [busy, setBusy] = useState(false);

  async function toggle(e: React.MouseEvent) {
    e.preventDefault();
    e.stopPropagation();
    if (!user) {
      router.push("/login");
      return;
    }
    setBusy(true);
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
      className="grid h-8 w-8 place-items-center rounded-full bg-white/90 shadow-sm backdrop-blur transition hover:scale-105 hover:bg-white"
    >
      <Icon
        name={fav ? "favorited" : "heart"}
        size={16}
        color={fav ? "#B51219" : "#171214"}
      />
    </button>
  );
}

export function CarCard({ car, className = "" }: { car: Car; className?: string }) {
  const { t, tr, num } = useI18n();
  const e = useEnumLabel();
  const plan = displayPlan(car);
  const city = car.location?.city ?? car.company?.location?.city;

  return (
    <Link
      href={`/car/${car.carId}`}
      className={`group block overflow-hidden rounded-[18px] bg-white shadow-[var(--shadow-card)] ring-1 ring-surface-low/70 transition duration-300 hover:-translate-y-0.5 hover:shadow-[var(--shadow-lift)] ${className}`}
    >
      <div className="relative">
        <ImageHolder
          src={car.images?.[0]?.image}
          alt={car.title}
          rounded="rounded-none"
          className="aspect-[4/3] w-full [&_img]:transition [&_img]:duration-500 group-hover:[&_img]:scale-[1.04]"
        />
        <div className="pointer-events-none absolute inset-x-0 bottom-0 h-16 bg-gradient-to-t from-black/35 to-transparent" />
        <div className="absolute end-2.5 top-2.5">
          <FavoriteButton car={car} />
        </div>
        {car.featuredCars && (
          <span className="micro absolute start-2.5 top-2.5 rounded-md bg-ink/85 px-2 py-1 !text-[9px] text-white backdrop-blur">
            VIP · {t("labels.featured")}
          </span>
        )}
        {city && (
          <span className="absolute bottom-2 start-2.5 flex items-center gap-1 text-[11px] font-medium text-white drop-shadow">
            <Icon name="location_p" size={11} color="#fff" />
            {tr(city)}
          </span>
        )}
      </div>
      <div className="px-3 pb-3 pt-2.5">
        <p className="line-clamp-1 text-[14px] font-bold tracking-[-0.01em] text-on-surface">
          {car.title}
        </p>
        <p className="mt-0.5 line-clamp-1 text-[11.5px] text-muted">
          {[car.brand ? tr(car.brand) : null, car.feature?.year ? num(car.feature.year) : null, car.feature?.transmission ? e.transmission(car.feature.transmission) : null]
            .filter(Boolean)
            .join(" · ")}
        </p>
        {plan && (
          <p className="mt-2 flex items-baseline gap-1">
            <span className="num text-[15px] font-bold text-primary">
              {formatNumber(plan.price)} {e.currency(plan.currency)}
            </span>
            <span className="text-[11px] text-faint">/ {e.period(plan.periodType)}</span>
          </p>
        )}
      </div>
    </Link>
  );
}

export function CarCardSkeleton() {
  return (
    <div>
      <SkeletonBox className="aspect-[4/3] w-full !rounded-[18px]" />
      <SkeletonBox className="mt-2.5 h-4 w-3/4" />
      <SkeletonBox className="mt-1.5 h-3 w-1/2" />
    </div>
  );
}
