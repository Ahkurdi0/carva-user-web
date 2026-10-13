"use client";

import { useEffect, useState, useCallback, useRef, useMemo } from "react";
import { useRouter } from "next/navigation";
import { AppShell } from "@/components/AppShell";
import { CarCard, CarCardSkeleton } from "@/components/CarCard";
import { SliderCarousel } from "@/components/SliderCarousel";
import { SectionHeader, Spinner, SkeletonBox } from "@/components/ui";
import { FeaturedHero } from "@/components/home/FeaturedHero";
import { ReelsStrip } from "@/components/home/ReelsStrip";
import { CitySelect, cityKey } from "@/components/home/CitySelect";
import { useAsync } from "@/lib/useAsync";
import { userApi } from "@/lib/services";
import { imageUrl } from "@/lib/api";
import { uniqueById } from "@/lib/format";
import { useI18n } from "@/i18n";
import type { Car, FiltersData, Slider } from "@/lib/types";

/** Same as the app: 1 featured, 3 others, 1 featured, 3 others… (featured repeat). */
function arrange(featured: Car[], others: Car[]): Car[] {
  if (featured.length === 0) return others;
  if (others.length === 0) return featured;
  const out: Car[] = [];
  let r = 0;
  let f = 0;
  while (r < others.length) {
    out.push(featured[f++ % featured.length]);
    for (let i = 0; i < 3 && r < others.length; i++) out.push(others[r++]);
  }
  return out;
}

/** A full-width sponsored banner between rows of cars. */
function AdBanner({ ad }: { ad: Slider }) {
  const router = useRouter();
  const open = () => {
    userApi.slider(ad.id).catch(() => {});
    if (ad.type === "car" && ad.carId) router.push(`/car/${ad.car?.id ?? ad.carId}`);
    else if (ad.type === "company" && ad.companyId) router.push(`/company/${ad.companyId}`);
    else if (ad.url) window.open(ad.url, "_blank");
  };
  if (!ad.image) return null;
  return (
    <button onClick={open} className="press relative col-span-full block aspect-[16/7] w-full overflow-hidden rounded-[18px] bg-surface-low shadow-[var(--shadow-card)] sm:aspect-[16/5]">
      {/* eslint-disable-next-line @next/next/no-img-element */}
      <img src={imageUrl(ad.image)} alt="" loading="lazy" className="h-full w-full object-cover" />
    </button>
  );
}

function AllCars({ featured, ads, cities }: { featured: Car[]; ads: Slider[]; cities: FiltersData["cities"] }) {
  const { t } = useI18n();
  const [cars, setCars] = useState<Car[]>([]);
  const [cursor, setCursor] = useState<string | undefined>();
  const [hasMore, setHasMore] = useState(true);
  const [loading, setLoading] = useState(false);
  const [picked, setPicked] = useState<Set<string>>(new Set());
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
    const obs = new IntersectionObserver((entries) => entries[0].isIntersecting && load(), { rootMargin: "600px" });
    obs.observe(el);
    return () => obs.disconnect();
  }, [load]);

  // ?city=Erbil (footer / SEO links) narrows like picking it in the sheet.
  useEffect(() => {
    const wanted = new URLSearchParams(window.location.search).get("city");
    if (wanted && cities.some((c) => cityKey(c.en) === cityKey(wanted))) setPicked(new Set([cityKey(wanted)]));
  }, [cities]);

  const slots = useMemo(() => {
    const featuredIds = new Set(featured.map((c) => c.id));
    const isFeatured = (c: Car) => !!c.featuredCars || featuredIds.has(c.id);
    let list: Car[];
    if (picked.size === 0) {
      list = arrange(featured, cars.filter((c) => !isFeatured(c)));
    } else {
      const inCity = cars.filter((c) => picked.has(cityKey(c.location?.city?.en ?? c.company?.location?.city?.en)));
      list = arrange(inCity.filter(isFeatured), inCity.filter((c) => !isFeatured(c)));
    }
    // An ad after every 12 cars: 12 fills whole rows at 2, 3 and 4 per row,
    // so an ad never leaves a gap (a lone car) in the row above it.
    const out: ({ car: Car; featured: boolean; key: string } | { ad: Slider; key: string })[] = [];
    const usable = ads.filter((a) => a.image);
    list.forEach((car, i) => {
      out.push({ car, featured: isFeatured(car), key: `${car.id}-${i}` });
      if (usable.length && (i + 1) % 12 === 0) {
        const ad = usable[Math.floor(i / 12) % usable.length];
        out.push({ ad, key: `ad-${ad.id}-${i}` });
      }
    });
    return out;
  }, [cars, featured, ads, picked]);

  return (
    <section className="pt-2">
      <SectionHeader title={t("labels.cars")} />
      <div className="mb-4 px-4">
        <CitySelect cities={cities} selected={picked} onChange={setPicked} />
      </div>
      <div className="grid grid-cols-2 gap-3 px-4 sm:grid-cols-3 lg:grid-cols-4">
        {slots.map((s) =>
          "ad" in s ? <AdBanner key={s.key} ad={s.ad} /> : <CarCard key={s.key} car={s.car} featured={s.featured} />,
        )}
        {loading && cars.length === 0 && Array.from({ length: 6 }).map((_, i) => <CarCardSkeleton key={i} />)}
      </div>
      <div ref={sentinel} className="flex justify-center py-6">
        {loading && cars.length > 0 && <Spinner />}
      </div>
    </section>
  );
}

export default function HomePage() {
  const { t } = useI18n();
  const featured = useAsync<Car[]>(() => userApi.featuredCars(), []);
  const reels = useAsync<Car[]>(() => userApi.reelsCars(), []);
  const sliders = useAsync<Slider[]>(() => userApi.sliders(), []);
  const filters = useAsync<FiltersData>(() => userApi.filters(), []);
  const featuredCars = featured.data ?? [];

  return (
    <AppShell>
      {/* The page's title for search engines; the app shows no big heading here. */}
      <h1 className="sr-only">{t("web.heroTitle")}</h1>

      <section className="pt-3">
        <SectionHeader title={t("labels.featured")} actionLabel={t("v2.seeAll")} href="/reels" />
        {featured.loading ? (
          <div className="px-4">
            <SkeletonBox className="h-[78vw] max-h-[440px] min-h-[280px] w-full !rounded-[18px] sm:h-[400px]" />
          </div>
        ) : featuredCars.length > 0 ? (
          <FeaturedHero cars={featuredCars} />
        ) : null}
      </section>

      {(reels.data?.length ?? 0) > 0 && (
        <section className="pt-5">
          <ReelsStrip cars={reels.data!} />
        </section>
      )}

      {sliders.data && sliders.data.length > 0 && <SliderCarousel slides={sliders.data} />}

      <AllCars featured={featuredCars} ads={sliders.data ?? []} cities={filters.data?.cities ?? []} />
    </AppShell>
  );
}
