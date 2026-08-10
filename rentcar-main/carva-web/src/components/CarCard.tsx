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
      className="grid h-9 w-9 place-items-center rounded-full bg-white/90 shadow-sm backdrop-blur transition hover:bg-white"
    >
      <Icon
        name={fav ? "favorited" : "heart"}
        size={18}
        color={fav ? "#ef4444" : "#23262e"}
      />
    </button>
  );
}

export function CarCard({ car, className = "" }: { car: Car; className?: string }) {
  const { t, tr, num } = useI18n();
  const e = useEnumLabel();
  const plan = displayPlan(car);

  return (
    <Link
      href={`/car/${car.carId}`}
      className={`group block ${className}`}
    >
      <div className="relative">
        <ImageHolder
          src={car.images?.[0]?.image}
          alt={car.title}
          className="aspect-[4/3] w-full shadow-[0_8px_18px_-6px_rgba(24,37,94,0.25)] transition group-hover:shadow-[0_12px_24px_-6px_rgba(24,37,94,0.35)]"
        />
        <div className="absolute left-3 top-3">
          <FavoriteButton car={car} />
        </div>
        {car.featuredCars && (
          <span className="absolute right-2 top-2 rounded-full bg-tint px-2.5 py-1 text-[10px] font-bold uppercase tracking-wide text-white">
            {t("labels.featured")}
          </span>
        )}
      </div>
      <div className="mt-2 px-0.5">
        <p className="line-clamp-1 text-sm font-semibold text-on-surface">
          {car.title}
        </p>
        <p className="mt-0.5 text-xs text-muted">
          {num(car.feature?.year)}
          {car.feature?.transmission ? ` - ${e.transmission(car.feature.transmission)}` : ""}
        </p>
        {plan && (
          <p className="mt-0.5 text-xs font-medium text-on-surface">
            <span className="text-sm font-bold text-primary">
              {formatNumber(plan.price)} {e.currency(plan.currency)}
            </span>
            <span className="text-muted"> · {e.period(plan.periodType)}</span>
          </p>
        )}
        {car.brand && (
          <p className="mt-0.5 text-[11px] text-muted">{tr(car.brand)}</p>
        )}
      </div>
    </Link>
  );
}

export function CarCardSkeleton() {
  return (
    <div>
      <SkeletonBox className="aspect-[4/3] w-full" />
      <SkeletonBox className="mt-2 h-4 w-3/4" />
      <SkeletonBox className="mt-1.5 h-3 w-1/2" />
    </div>
  );
}
