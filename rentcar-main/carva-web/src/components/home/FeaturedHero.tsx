"use client";

import Link from "next/link";
import { useEffect, useRef, useState } from "react";
import type { Car } from "@/lib/types";
import { useI18n } from "@/i18n";
import { imageUrl } from "@/lib/api";
import { isRented } from "@/lib/car-status";
import { FavoriteButton, OfficeLogo, displayPlan, usePrice } from "../CarCard";
import { RentedBadge } from "../CarBadges";
import { useEnumLabel } from "../ui";

/**
 * The app's Featured section: one large car at a time, auto-advancing
 * every 4s (paused while hovered, touched or off screen), swipeable, with
 * expanding dots. Two at a time on wide screens.
 */
export function FeaturedHero({ cars }: { cars: Car[] }) {
  const track = useRef<HTMLDivElement>(null);
  const [active, setActive] = useState(0);
  const [paused, setPaused] = useState(false);
  const [visible, setVisible] = useState(true);

  // Which slide is showing.
  useEffect(() => {
    const el = track.current;
    if (!el) return;
    const slides = Array.from(el.children) as HTMLElement[];
    const io = new IntersectionObserver(
      (entries) => {
        for (const en of entries) if (en.isIntersecting) setActive(slides.indexOf(en.target as HTMLElement));
      },
      { root: el, threshold: 0.6 },
    );
    slides.forEach((s) => io.observe(s));
    return () => io.disconnect();
  }, [cars.length]);

  // Only run while on screen.
  useEffect(() => {
    const el = track.current;
    if (!el) return;
    const io = new IntersectionObserver(([en]) => setVisible(en.isIntersecting), { threshold: 0.3 });
    io.observe(el);
    return () => io.disconnect();
  }, []);

  function go(i: number) {
    const el = track.current;
    const slide = el?.children[i] as HTMLElement | undefined;
    if (!el || !slide) return;
    const rtl = getComputedStyle(el).direction === "rtl";
    const a = slide.getBoundingClientRect();
    const b = el.getBoundingClientRect();
    el.scrollBy({ left: rtl ? a.right - b.right : a.left - b.left, behavior: "smooth" });
  }

  useEffect(() => {
    if (cars.length < 2 || paused || !visible) return;
    const id = window.setTimeout(() => go((active + 1) % cars.length), 4000);
    return () => window.clearTimeout(id);
  }, [active, paused, visible, cars.length]);

  return (
    <div onMouseEnter={() => setPaused(true)} onMouseLeave={() => setPaused(false)} onTouchStart={() => setPaused(true)} onTouchEnd={() => setPaused(false)}>
      <div
        ref={track}
        className="no-scrollbar flex snap-x snap-mandatory gap-3 overflow-x-auto scroll-px-4 px-4"
      >
        {cars.map((car) => (
          <div key={car.id} className="w-full shrink-0 snap-start lg:w-[calc(50%-6px)]">
            <HeroCard car={car} />
          </div>
        ))}
      </div>
      {cars.length > 1 && (
        <div className="mt-3 flex justify-center gap-1.5">
          {cars.map((_, i) => (
            <button
              key={i}
              aria-label={`${i + 1}`}
              onClick={() => go(i)}
              className={`h-[7px] rounded-full transition-all duration-300 ${i === active ? "w-5 bg-primary" : "w-[7px] bg-hairline"}`}
            />
          ))}
        </div>
      )}
    </div>
  );
}

function HeroCard({ car }: { car: Car }) {
  const { t, num } = useI18n();
  const e = useEnumLabel();
  const price = usePrice();
  const plan = displayPlan(car);
  const year = car.feature?.year ? num(car.feature.year) : "–";

  return (
    <Link
      href={`/car/${car.carId}`}
      className="press group relative block h-[78vw] max-h-[440px] min-h-[280px] overflow-hidden rounded-[18px] bg-[#1A1517] shadow-[var(--shadow-card)] sm:h-[400px]"
    >
      {car.images?.[0]?.image && (
        // eslint-disable-next-line @next/next/no-img-element
        <img
          src={imageUrl(car.images[0].image)}
          alt={car.title}
          className={`absolute inset-0 h-full w-full object-cover transition duration-700 group-hover:scale-[1.03] ${isRented(car) ? "opacity-85" : ""}`}
        />
      )}
      <div className="absolute inset-0 bg-[linear-gradient(to_top,rgba(0,0,0,0.85)_0%,rgba(0,0,0,0.38)_32%,rgba(0,0,0,0.05)_50%,transparent_100%)]" />

      <div className="absolute start-4 top-4 flex max-w-[70%] flex-col items-start gap-1.5">
        <span className="rounded-full bg-primary px-3.5 py-1.5 text-[12px] font-bold leading-none text-white ltr:tracking-wider ltr:uppercase">
          {t("v2.featured")}
        </span>
        <RentedBadge car={car} small />
      </div>
      <div className="absolute end-3 top-3">
        <FavoriteButton car={car} onPhoto />
      </div>

      <div className="absolute inset-x-5 bottom-5 text-white">
        <p className="truncate text-start text-[20px] font-bold leading-tight sm:text-[22px]"><bdi>{car.title}</bdi></p>
        {car.company?.name && (
          <span className="mt-1.5 inline-flex max-w-full items-center gap-1.5 text-[13px] font-semibold text-white/90">
            <OfficeLogo name={car.company.name} image={car.company.image} size={24} />
            <span className="truncate">{car.company.name}</span>
          </span>
        )}
        <p className="mt-1 flex items-center gap-2 text-[15px] font-semibold text-white/90">
          <span className="num">{year}</span>
          {car.feature?.transmission && (
            <>
              <span className="h-1 w-1 rounded-full bg-white/60" />
              {e.transmission(car.feature.transmission)}
            </>
          )}
        </p>
        {plan && Number(plan.price) > 0 && (
          <div className="mt-2.5 flex items-end justify-between gap-3">
            <span className="num text-[24px] font-bold leading-none">{price.amount(plan)}</span>
            <span className="rounded-full border border-white/25 bg-white/15 px-3 py-1 text-[13px] font-semibold backdrop-blur">
              / {price.unit(plan)}
            </span>
          </div>
        )}
      </div>
    </Link>
  );
}
