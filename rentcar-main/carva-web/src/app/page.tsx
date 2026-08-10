"use client";

import { useEffect, useState, useCallback, useRef } from "react";
import Link from "next/link";
import { AppShell } from "@/components/AppShell";
import { CarRail } from "@/components/CarRail";
import { CarCard, CarCardSkeleton } from "@/components/CarCard";
import { SliderCarousel } from "@/components/SliderCarousel";
import { SectionHeader, Spinner } from "@/components/ui";
import { CityChips } from "@/components/CityChips";
import { Icon } from "@/components/Icon";
import { BrandLogo } from "@/components/BrandLogo";
import { useAsync } from "@/lib/useAsync";
import { userApi } from "@/lib/services";
import { uniqueById } from "@/lib/format";
import { useI18n } from "@/i18n";
import type { BrandWithCars, Car, FiltersData } from "@/lib/types";

function BrandSection() {
  const { t, tr } = useI18n();
  const { data, loading } = useAsync<BrandWithCars[]>(() => userApi.brands(), []);
  const [sel, setSel] = useState<string | null>(null);
  // The /user/brands endpoint only returns a 10-car preview per brand. Load the
  // full list for the active brand via filterCars (which paginates) so picking
  // a brand shows every car, not just the first ten.
  const [fullCars, setFullCars] = useState<Car[]>([]);
  const [carsLoading, setCarsLoading] = useState(false);

  const brandList = (data ?? []).filter((b) => b.cars?.length);
  const activeBrand = brandList.find((b) => b.id === sel) ?? brandList[0];
  const activeId = activeBrand?.id;

  useEffect(() => {
    if (!activeId) return;
    let cancelled = false;
    setCarsLoading(true);
    setFullCars([]);
    (async () => {
      const all: Car[] = [];
      let cursor: string | undefined;
      try {
        for (let page = 0; page < 1000; page++) {
          const batch = await userApi.filterCars({ brandId: activeId, cursor });
          if (!batch?.length) break;
          all.push(...batch);
          if (batch.length < 50) break;
          cursor = batch[batch.length - 1].id;
          if (!cursor) break;
        }
      } catch {
        /* keep the preview cars as a fallback */
      }
      if (!cancelled) {
        setFullCars(uniqueById(all));
        setCarsLoading(false);
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [activeId]);

  if (loading)
    return (
      <section className="py-3">
        <SectionHeader title={t("labels.brands")} />
        <div className="no-scrollbar flex gap-3 overflow-x-auto px-4">
          {Array.from({ length: 6 }).map((_, i) => (
            <div key={i} className="skeleton h-16 w-16 shrink-0 rounded-2xl" />
          ))}
        </div>
      </section>
    );

  if (brandList.length === 0 || !activeBrand) return null;
  // Show the fully-loaded list once we have it; fall back to the preview cars
  // while that request is still in flight (or if it failed).
  const shownCars = fullCars.length > 0 ? fullCars : activeBrand.cars;

  return (
    <section className="py-3">
      <SectionHeader title={t("labels.brands")} />
      <div className="no-scrollbar flex gap-3 overflow-x-auto px-4 pb-2">
        {brandList.map((b) => {
          const isActive = b.id === activeBrand.id;
          return (
            <button
              key={b.id}
              onClick={() => setSel(b.id)}
              className="flex shrink-0 flex-col items-center gap-1"
            >
              <span
                className={`grid h-16 w-16 place-items-center overflow-hidden rounded-2xl border bg-white p-2.5 transition ${
                  isActive ? "border-primary" : "border-surface-low"
                }`}
              >
                <BrandLogo name={b.en} image={b.image} size={44} />
              </span>
              <span
                className={`text-[11px] ${isActive ? "font-semibold text-primary" : "text-muted"}`}
              >
                {tr(b)}
              </span>
            </button>
          );
        })}
      </div>
      <div className="no-scrollbar flex gap-3 overflow-x-auto px-4 pt-1">
        {shownCars.map((car) => (
          <div key={car.id} className="w-44 shrink-0 sm:w-52">
            <CarCard car={car} />
          </div>
        ))}
        {carsLoading && fullCars.length === 0 && (
          <div className="grid w-44 shrink-0 place-items-center sm:w-52">
            <Spinner />
          </div>
        )}
      </div>
    </section>
  );
}

function NearbySection() {
  const { t } = useI18n();
  const [cars, setCars] = useState<Car[] | null>(null);
  useEffect(() => {
    if (!("geolocation" in navigator)) return;
    navigator.geolocation.getCurrentPosition(
      (pos) => {
        userApi
          .nearByCars(pos.coords.latitude, pos.coords.longitude)
          .then(setCars)
          .catch(() => {});
      },
      () => {},
      { timeout: 8000 },
    );
  }, []);
  if (!cars || cars.length === 0) return null;
  return <CarRail title={t("labels.nearby")} cars={cars} />;
}

function AllCars() {
  const { t, tr } = useI18n();
  const [cars, setCars] = useState<Car[]>([]);
  const [cursor, setCursor] = useState<string | undefined>();
  const [hasMore, setHasMore] = useState(true);
  const [loading, setLoading] = useState(false);
  const sentinel = useRef<HTMLDivElement>(null);

  const load = useCallback(async () => {
    if (loading || !hasMore) return;
    setLoading(true);
    try {
      const res = await userApi.allCars(cursor);
      setCars((prev) => uniqueById([...prev, ...(res.cars ?? [])]));
      setCursor(res.cursor ?? undefined);
      setHasMore(!!res.hasMore);
    } catch {
      setHasMore(false);
    } finally {
      setLoading(false);
    }
  }, [cursor, hasMore, loading]);

  useEffect(() => {
    load();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  useEffect(() => {
    const el = sentinel.current;
    if (!el) return;
    const obs = new IntersectionObserver(
      (entries) => entries[0].isIntersecting && load(),
      { rootMargin: "400px" },
    );
    obs.observe(el);
    return () => obs.disconnect();
  }, [load]);

  const { data: filters } = useAsync<FiltersData>(() => userApi.filters(), []);
  const [cityEn, setCityEn] = useState<string | null>(null);
  const [cityId, setCityId] = useState<string | null>(null);
  const cityKey = (v?: string | null) => (v ?? "").trim().toLowerCase();
  const shown = cityEn
    ? cars.filter(
        (car) =>
          cityKey(car.location?.city?.en ?? car.company?.location?.city?.en) ===
          cityKey(cityEn),
      )
    : cars;

  return (
    <section className="py-3">
      <SectionHeader title={t("labels.cars")} />
      {(filters?.cities?.length ?? 0) > 0 && (
        <div className="mb-4">
          <CityChips
            cities={filters!.cities}
            selectedId={cityId}
            onSelect={(city) => {
              setCityId(city?.id ?? null);
              setCityEn(city?.en ?? null);
            }}
          />
        </div>
      )}
      <div className="grid grid-cols-2 gap-x-3 gap-y-5 px-4 sm:grid-cols-3 lg:grid-cols-4">
        {shown.map((car) => (
          <CarCard key={car.id} car={car} />
        ))}
        {loading &&
          cars.length === 0 &&
          Array.from({ length: 6 }).map((_, i) => <CarCardSkeleton key={i} />)}
      </div>
      <div ref={sentinel} className="flex justify-center py-6">
        {loading && cars.length > 0 && <Spinner />}
      </div>
    </section>
  );
}

export default function HomePage() {
  const { t } = useI18n();
  // The hero rail mirrors the app: featured (paid) cars first, falling
  // back to suggested when nothing is featured.
  const featured = useAsync(() => userApi.featuredCars(), []);
  const suggested = useAsync(() => userApi.suggestedCars(), []);
  const sliders = useAsync(() => userApi.sliders(), []);

  return (
    <AppShell>
      <div className="px-4 pt-4">
        <Link
          href="/search"
          className="flex h-12 items-center gap-3 rounded-full border border-surface-low bg-surface-lowest px-5 text-sm text-muted"
        >
          <Icon name="search" size={18} color="#9e9e9e" />
          {t("inputHintText.searchCar")}
        </Link>
      </div>

      <CarRail
        title={t("labels.featured")}
        cars={
          featured.data && featured.data.length > 0
            ? featured.data
            : suggested.data
        }
        loading={featured.loading}
      />
      <BrandSection />
      {sliders.data && sliders.data.length > 0 && (
        <SliderCarousel slides={sliders.data} />
      )}
      <NearbySection />
      <AllCars />
    </AppShell>
  );
}
