"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { AppShell } from "@/components/AppShell";
import { Icon } from "@/components/Icon";
import { PageLoading, EmptyState, useEnumLabel } from "@/components/ui";
import { useAsync } from "@/lib/useAsync";
import { userApi } from "@/lib/services";
import { imageUrl } from "@/lib/api";
import { formatNumber } from "@/lib/format";
import { useI18n } from "@/i18n";
import type { Car } from "@/lib/types";

/** One full-height reel. Photos advance every 4 s with an instant cut
 * (like the app); tapping the left/right halves steps through them. */
function Reel({ car }: { car: Car }) {
  const { t, tr } = useI18n();
  const e = useEnumLabel();
  const images = car.images ?? [];
  const [idx, setIdx] = useState(0);
  const [tick, setTick] = useState(0);

  useEffect(() => {
    if (images.length <= 1) return;
    const id = setInterval(
      () => setIdx((i) => (i + 1) % images.length),
      4000,
    );
    return () => clearInterval(id);
    // Restart the 4s timer whenever the user steps manually.
  }, [images.length, tick]);

  function step(delta: number) {
    if (images.length <= 1) return;
    setIdx((i) => (i + delta + images.length) % images.length);
    setTick((v) => v + 1);
  }

  const plan =
    car.rentalPlan?.find((p) => p.periodType === car.displayPlan) ??
    car.rentalPlan?.[0];

  const city = car.location?.city ?? car.company?.location?.city;

  async function whatsapp() {
    const win = window.open("", "_blank");
    try {
      const url = await userApi.contact({
        type: "whatsapp",
        companyId: car.companyId,
        carId: car.id,
      });
      if (url) {
        if (win) win.location.href = url;
        else window.location.href = url;
      } else win?.close();
    } catch {
      win?.close();
    }
  }

  return (
    <section className="relative h-full w-full shrink-0 snap-start snap-always overflow-hidden bg-black">
      {images.length > 0 ? (
        // eslint-disable-next-line @next/next/no-img-element
        <img
          key={idx}
          src={imageUrl(images[idx]?.image)}
          alt={car.title}
          className="h-full w-full object-cover"
        />
      ) : (
        <div className="h-full w-full bg-surface-low" />
      )}

      {/* Photo progress segments */}
      {images.length > 1 && (
        <>
          <button
            aria-label="previous photo"
            onClick={() => step(-1)}
            className="absolute inset-y-0 left-0 w-1/3"
          />
          <button
            aria-label="next photo"
            onClick={() => step(1)}
            className="absolute inset-y-0 right-0 w-1/3"
          />
          <div className="pointer-events-none absolute inset-x-3 top-3 flex gap-1">
            {images.map((_, i) => (
              <span
                key={i}
                className={`h-[3px] flex-1 rounded-full transition-colors ${i === idx ? "bg-white" : "bg-white/35"}`}
              />
            ))}
          </div>
        </>
      )}

      {/* Bottom info */}
      <div className="pointer-events-none absolute inset-x-0 bottom-0 bg-gradient-to-t from-black/85 via-black/45 to-transparent px-4 pb-4 pt-20">
        {car.company && (
          <Link
            href={`/company/${car.companyId}`}
            className="pointer-events-auto mb-2.5 flex items-center gap-2"
          >
            <span className="h-8 w-8 shrink-0 overflow-hidden rounded-full border border-white/40 bg-white/20">
              {car.company.image ? (
                // eslint-disable-next-line @next/next/no-img-element
                <img
                  src={imageUrl(car.company.image)}
                  alt=""
                  className="h-full w-full object-cover"
                />
              ) : (
                <span className="grid h-full w-full place-items-center">
                  <Icon name="company" size={14} color="#fff" />
                </span>
              )}
            </span>
            <span className="truncate text-sm font-semibold text-white/95">
              {car.company.name}
            </span>
          </Link>
        )}

        <p className="text-xl font-extrabold leading-tight text-white">
          {car.title}
        </p>

        <div className="mt-1.5 flex flex-wrap items-center gap-x-3 gap-y-1">
          {plan && (
            <p className="text-sm text-white/90">
              <span className="text-lg font-bold text-white">
                {formatNumber(plan.price)} {e.currency(plan.currency)}
              </span>{" "}
              <span className="text-white/70">/ {e.period(plan.periodType)}</span>
            </p>
          )}
          {city && (
            <span className="flex items-center gap-1 text-sm text-white/80">
              <Icon name="location_p" size={13} color="#ffffff" />
              {tr(city)}
            </span>
          )}
        </div>

        <div className="pointer-events-auto mt-3.5 flex gap-2.5">
          <Link
            href={`/car/${car.carId}`}
            className="flex-1 rounded-full border border-white/70 bg-white/10 py-2.5 text-center text-sm font-bold text-white backdrop-blur-sm transition hover:bg-white/25"
          >
            {t("web.details")}
          </Link>
          <button
            onClick={whatsapp}
            className="flex flex-1 items-center justify-center gap-2 rounded-full bg-tint py-2.5 text-sm font-bold text-white transition hover:opacity-90"
          >
            <Icon name="whatsapp" size={16} color="#fff" /> {t("buttons.whatsapp")}
          </button>
        </div>
      </div>
    </section>
  );
}

export default function ReelsPage() {
  const { t } = useI18n();
  const { data, loading } = useAsync<Car[]>(() => userApi.reelsCars(), []);
  const cars = data ?? [];

  return (
    <AppShell>
      {loading ? (
        <PageLoading />
      ) : cars.length === 0 ? (
        <EmptyState icon="no_cars" title={t("empty.noData")} />
      ) : (
        // Dark stage behind the feed; on desktop the feed sits centered in
        // a rounded phone-like column.
        <div className="bg-black md:bg-surface-lowest md:py-4">
          <div className="mx-auto h-[calc(100dvh-8.5rem)] max-w-md snap-y snap-mandatory overflow-y-auto md:h-[calc(100dvh-7rem)] md:rounded-3xl md:shadow-xl md:ring-1 md:ring-black/10 [&::-webkit-scrollbar]:hidden">
            {cars.map((car) => (
              <Reel key={car.id} car={car} />
            ))}
          </div>
        </div>
      )}
    </AppShell>
  );
}
