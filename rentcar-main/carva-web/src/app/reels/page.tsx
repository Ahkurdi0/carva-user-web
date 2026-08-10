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
  const { t } = useI18n();
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

      {/* Tap zones to step photos */}
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
          <div className="pointer-events-none absolute inset-x-0 top-3 flex justify-center gap-1">
            {images.map((_, i) => (
              <span
                key={i}
                className={`h-1 rounded-full transition-all ${i === idx ? "w-6 bg-white" : "w-2 bg-white/50"}`}
              />
            ))}
          </div>
        </>
      )}

      {/* Bottom info */}
      <div className="pointer-events-none absolute inset-x-0 bottom-0 bg-gradient-to-t from-black/80 via-black/40 to-transparent px-4 pb-4 pt-16">
        <p className="text-lg font-extrabold text-white">{car.title}</p>
        {plan && (
          <p className="mt-0.5 text-sm text-white/90">
            <span className="text-base font-bold">{formatNumber(plan.price)} {e.currency(plan.currency)}</span>
            {" · "}
            {e.period(plan.periodType)}
          </p>
        )}
        <div className="pointer-events-auto mt-3 flex gap-2">
          <Link
            href={`/car/${car.carId}`}
            className="flex-1 rounded-full bg-white/95 py-2.5 text-center text-sm font-bold text-on-surface"
          >
            {t("web.details")}
          </Link>
          <button
            onClick={whatsapp}
            className="flex flex-1 items-center justify-center gap-2 rounded-full bg-tint py-2.5 text-sm font-bold text-white"
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
        <div className="mx-auto h-[calc(100dvh-8.5rem)] max-w-md snap-y snap-mandatory overflow-y-auto md:h-[calc(100dvh-6rem)] md:py-0 [&::-webkit-scrollbar]:hidden">
          {cars.map((car) => (
            <Reel key={car.id} car={car} />
          ))}
        </div>
      )}
    </AppShell>
  );
}
