"use client";

import { CarCard } from "@/components/CarCard";
import { SectionHeader } from "@/components/ui";
import { useAsync } from "@/lib/useAsync";
import { userApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import type { Car } from "@/lib/types";

function cityKey(en?: string | null): string {
  return (en ?? "").trim().toLowerCase();
}

/** "More like this" — the app's similar-cars ranking: +2 same city
 * (company office as fallback), +1 same brand, +1 same type. */
export function SimilarCars({ car }: { car: Car }) {
  const { t } = useI18n();
  const { data } = useAsync<Car[]>(() => userApi.reelsCars(), []);
  const all = data ?? [];

  const myCity = cityKey(
    car.location?.city?.en ?? car.company?.location?.city?.en,
  );

  function score(c: Car): number {
    let s = 0;
    const otherCity = cityKey(
      c.location?.city?.en ?? c.company?.location?.city?.en,
    );
    if (myCity && otherCity && myCity === otherCity) s += 2;
    const myBrand = car.brand?.id ?? car.brandId;
    const otherBrand = c.brand?.id ?? c.brandId;
    if (myBrand && myBrand === otherBrand) s += 1;
    if (car.typeId && car.typeId === c.typeId) s += 1;
    return s;
  }

  const similar = all
    .filter((c) => c.id !== car.id && c.carId !== car.carId)
    .sort((a, b) => score(b) - score(a))
    .slice(0, 8);

  if (similar.length === 0) return null;

  return (
    <section className="mt-8">
      <SectionHeader title={t("web.similarCars")} />
      <div className="no-scrollbar flex gap-3 overflow-x-auto">
        {similar.map((c) => (
          <div key={c.id} className="w-44 shrink-0 sm:w-52">
            <CarCard car={c} />
          </div>
        ))}
      </div>
    </section>
  );
}
