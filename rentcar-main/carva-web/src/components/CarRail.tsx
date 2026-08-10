"use client";

import type { Car } from "@/lib/types";
import { CarCard, CarCardSkeleton } from "./CarCard";
import { SectionHeader } from "./ui";

export function CarRail({
  title,
  cars,
  loading,
  actionLabel,
  href,
}: {
  title: string;
  cars?: Car[] | null;
  loading?: boolean;
  actionLabel?: string;
  href?: string;
}) {
  if (!loading && (!cars || cars.length === 0)) return null;
  return (
    <section className="py-3">
      <SectionHeader title={title} actionLabel={actionLabel} href={href} />
      <div className="no-scrollbar flex gap-3 overflow-x-auto px-4 pb-1">
        {loading
          ? Array.from({ length: 4 }).map((_, i) => (
              <div key={i} className="w-44 shrink-0 sm:w-52">
                <CarCardSkeleton />
              </div>
            ))
          : cars!.map((car) => (
              <div key={car.id} className="w-44 shrink-0 sm:w-52">
                <CarCard car={car} />
              </div>
            ))}
      </div>
    </section>
  );
}
