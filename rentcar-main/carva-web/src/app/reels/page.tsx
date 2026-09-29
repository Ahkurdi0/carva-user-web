"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import Link from "next/link";
import { AppShell } from "@/components/AppShell";
import { Icon } from "@/components/Icon";
import { FavoriteButton } from "@/components/CarCard";
import { ChatButton } from "@/components/ChatButton";
import { toast } from "@/components/toast";
import { PageLoading, EmptyState, useEnumLabel } from "@/components/ui";
import { useAsync } from "@/lib/useAsync";
import { userApi } from "@/lib/services";
import { imageUrl } from "@/lib/api";
import { formatNumber } from "@/lib/format";
import { useI18n } from "@/i18n";
import type { Car } from "@/lib/types";

const PHOTO_MS = 5000;
// One wheel gesture moves one reel; ignore the rest of that gesture's events.
const WHEEL_LOCK_MS = 700;

/**
 * One full-height reel. Only the reel on screen cycles its photos (and it
 * pauses while hovered); photos step with the side arrows or a sideways
 * swipe, so clicking the photo never changes it by surprise. Reels more
 * than one away from the current one don't load their images at all.
 */
function Reel({ car, active, near }: { car: Car; active: boolean; near: boolean }) {
  const { t, tr } = useI18n();
  const e = useEnumLabel();
  const images = car.images ?? [];
  const [idx, setIdx] = useState(0);
  const [paused, setPaused] = useState(false);
  const [cycle, setCycle] = useState(0);
  const touchX = useRef<number | null>(null);
  const many = images.length > 1;
  const running = active && !paused && many;

  useEffect(() => {
    if (!running) return;
    const timer = window.setTimeout(() => setIdx((i) => (i + 1) % images.length), PHOTO_MS);
    return () => window.clearTimeout(timer);
  }, [running, images.length, idx, cycle]);

  function step(delta: number) {
    if (!many) return;
    setIdx((i) => (i + delta + images.length) % images.length);
    setCycle((c) => c + 1);
  }

  const plan = car.rentalPlan?.find((p) => p.periodType === car.displayPlan) ?? car.rentalPlan?.[0];
  const city = car.location?.city ?? car.company?.location?.city;
  const src = near ? imageUrl(images[idx]?.image) : undefined;

  async function whatsapp() {
    const win = window.open("", "_blank");
    try {
      const url = await userApi.contact({ type: "whatsapp", companyId: car.companyId, carId: car.id });
      if (url) {
        if (win) win.location.href = url;
        else window.location.href = url;
      } else win?.close();
    } catch {
      win?.close();
    }
  }

  async function share() {
    const url = `${window.location.origin}/car/${car.carId}`;
    if (navigator.share) {
      navigator.share({ title: car.title, url }).catch(() => {});
    } else {
      await navigator.clipboard.writeText(url).catch(() => {});
      toast(t("web.linkCopied"), "success");
    }
  }

  return (
    <section
      className="relative h-full w-full shrink-0 snap-start snap-always overflow-hidden bg-ink"
      onMouseEnter={() => setPaused(true)}
      onMouseLeave={() => setPaused(false)}
      onTouchStart={(ev) => {
        touchX.current = ev.touches[0].clientX;
      }}
      onTouchEnd={(ev) => {
        if (touchX.current == null) return;
        const dx = ev.changedTouches[0].clientX - touchX.current;
        touchX.current = null;
        if (Math.abs(dx) < 50) return;
        const rtl = document.documentElement.dir === "rtl";
        step((dx < 0) !== rtl ? 1 : -1);
      }}
    >
      {src ? (
        <>
          {/* Blurred copy fills the frame; the sharp photo is never cropped. */}
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img src={src} alt="" aria-hidden className="absolute inset-0 h-full w-full scale-110 object-cover opacity-60 blur-2xl" />
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img key={idx} src={src} alt={car.title} className="relative h-full w-full object-contain" />
        </>
      ) : (
        <div className="hero-texture h-full w-full" />
      )}

      {/* Photo progress: the current segment fills while it's shown. */}
      {many && (
        <div className="pointer-events-none absolute inset-x-3 top-3 z-10 flex gap-1">
          {images.map((_, i) => (
            <span key={i} className="h-[3px] flex-1 overflow-hidden rounded-full bg-white/30">
              <span
                key={i === idx ? `${idx}-${cycle}-${running}` : i}
                className="block h-full rounded-full bg-white"
                style={
                  i === idx && running
                    ? { animation: `reel-fill ${PHOTO_MS}ms linear forwards`, width: 0 }
                    : { width: i <= idx ? "100%" : "0%" }
                }
              />
            </span>
          ))}
        </div>
      )}

      {many && (
        <>
          <button
            aria-label="previous photo"
            onClick={() => step(-1)}
            className="absolute start-2 top-1/2 z-10 grid h-9 w-9 -translate-y-1/2 place-items-center rounded-full bg-black/35 backdrop-blur transition hover:bg-black/55"
          >
            <Icon name="arrow" size={16} color="#fff" className="rtl:rotate-180" />
          </button>
          <button
            aria-label="next photo"
            onClick={() => step(1)}
            className="absolute end-2 top-1/2 z-10 grid h-9 w-9 -translate-y-1/2 place-items-center rounded-full bg-black/35 backdrop-blur transition hover:bg-black/55"
          >
            <Icon name="arrow" size={16} color="#fff" className="rotate-180 rtl:rotate-0" />
          </button>
        </>
      )}

      {/* Side actions */}
      <div className="absolute bottom-48 end-3 z-10 flex flex-col items-center gap-3">
        <FavoriteButton car={car} />
        <button
          onClick={share}
          aria-label={t("web.share")}
          className="grid h-8 w-8 place-items-center rounded-full bg-white/90 shadow-sm backdrop-blur transition hover:scale-105"
        >
          <Icon name="arrow_tail" size={15} color="#171214" className="-rotate-90" />
        </button>
      </div>

      {/* Bottom info */}
      <div className="absolute inset-x-0 bottom-0 z-10 bg-gradient-to-t from-black/90 via-black/55 to-transparent px-4 pb-4 pt-24">
        {car.company && (
          <Link
            href={`/company/${car.companyId}`}
            className="mb-2.5 inline-flex max-w-full items-center gap-2 rounded-full bg-white/10 py-1 pe-3 ps-1 backdrop-blur"
          >
            <span className="h-7 w-7 shrink-0 overflow-hidden rounded-full bg-white/20">
              {car.company.image ? (
                // eslint-disable-next-line @next/next/no-img-element
                <img src={imageUrl(car.company.image)} alt="" className="h-full w-full object-cover" />
              ) : (
                <span className="grid h-full w-full place-items-center">
                  <Icon name="company" size={13} color="#fff" />
                </span>
              )}
            </span>
            <span className="truncate text-[13px] font-semibold text-white">{car.company.name}</span>
          </Link>
        )}

        <p className="text-[22px] font-extrabold leading-tight tracking-[-0.02em] text-white">{car.title}</p>

        <div className="mt-1.5 flex flex-wrap items-center gap-x-3 gap-y-1">
          {plan && (
            <p className="text-sm">
              <span className="num text-lg font-bold text-white">
                {formatNumber(plan.price)} {e.currency(plan.currency)}
              </span>{" "}
              <span className="text-white/60">/ {e.period(plan.periodType)}</span>
            </p>
          )}
          {city && (
            <span className="flex items-center gap-1 text-[13px] text-white/75">
              <Icon name="location_p" size={12} color="#ffffff" />
              {tr(city)}
            </span>
          )}
        </div>

        <div className="mt-3.5 grid grid-cols-[auto_1fr_1fr] gap-2">
          <Link
            href={`/car/${car.carId}`}
            className="grid h-11 place-items-center rounded-2xl border border-white/40 bg-white/10 px-4 text-sm font-bold text-white backdrop-blur transition hover:bg-white/20"
          >
            {t("web.details")}
          </Link>
          <ChatButton companyId={car.companyId} carId={car.carId} className="!h-11 !gap-1.5 !px-2 !text-sm" />
          <button
            onClick={whatsapp}
            className="flex h-11 items-center justify-center gap-2 rounded-2xl bg-tint text-sm font-bold text-white transition hover:opacity-90"
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
  const feed = useRef<HTMLDivElement>(null);
  const [active, setActive] = useState(0);
  const lockUntil = useRef(0);

  const goTo = useCallback(
    (i: number) => {
      const el = feed.current;
      if (!el || cars.length === 0) return;
      const next = Math.max(0, Math.min(cars.length - 1, i));
      el.scrollTo({ top: next * el.clientHeight, behavior: "smooth" });
    },
    [cars.length],
  );

  // Track which reel is on screen.
  useEffect(() => {
    const el = feed.current;
    if (!el) return;
    const onScroll = () => setActive(Math.round(el.scrollTop / Math.max(1, el.clientHeight)));
    el.addEventListener("scroll", onScroll, { passive: true });
    return () => el.removeEventListener("scroll", onScroll);
  }, [cars.length]);

  // Mouse wheel / trackpad: exactly one reel per gesture.
  useEffect(() => {
    const el = feed.current;
    if (!el) return;
    const onWheel = (ev: WheelEvent) => {
      if (Math.abs(ev.deltaY) < 4) return;
      ev.preventDefault();
      const now = Date.now();
      if (now < lockUntil.current) return;
      lockUntil.current = now + WHEEL_LOCK_MS;
      goTo(active + (ev.deltaY > 0 ? 1 : -1));
    };
    el.addEventListener("wheel", onWheel, { passive: false });
    return () => el.removeEventListener("wheel", onWheel);
  }, [active, goTo, cars.length]);

  // Keyboard: ↑/↓ (and j/k) move between reels.
  useEffect(() => {
    const onKey = (ev: KeyboardEvent) => {
      if ((ev.target as HTMLElement)?.closest("input, textarea")) return;
      if (ev.key === "ArrowDown" || ev.key === "j") {
        ev.preventDefault();
        goTo(active + 1);
      } else if (ev.key === "ArrowUp" || ev.key === "k") {
        ev.preventDefault();
        goTo(active - 1);
      }
    };
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [active, goTo]);

  return (
    <AppShell bare>
      <style>{`@keyframes reel-fill { from { width: 0% } to { width: 100% } }`}</style>
      {loading ? (
        <PageLoading />
      ) : cars.length === 0 ? (
        <EmptyState icon="no_cars" title={t("empty.noData")} />
      ) : (
        <div className="relative flex h-[calc(100dvh-4rem-4.75rem)] justify-center bg-ink md:h-[calc(100dvh-4rem)] md:py-5">
          <div
            ref={feed}
            className="h-full w-full max-w-[440px] snap-y snap-mandatory overflow-y-auto overscroll-contain md:rounded-[28px] md:shadow-[0_30px_80px_-30px_rgba(0,0,0,0.9)] md:ring-1 md:ring-white/10 [&::-webkit-scrollbar]:hidden"
            style={{ scrollbarWidth: "none" }}
          >
            {cars.map((car, i) => (
              <Reel key={car.id} car={car} active={i === active} near={Math.abs(i - active) <= 1} />
            ))}
          </div>

          {/* Desktop controls beside the phone-like column */}
          <div className="absolute end-8 top-1/2 hidden -translate-y-1/2 flex-col items-center gap-3 md:flex">
            <button
              onClick={() => goTo(active - 1)}
              disabled={active === 0}
              aria-label="previous"
              className="grid h-12 w-12 place-items-center rounded-full bg-white/10 backdrop-blur transition hover:bg-white/20 disabled:opacity-30"
            >
              <Icon name="arrow" size={18} color="#fff" className="rotate-90" />
            </button>
            <span className="num text-xs font-semibold text-white/60">
              {active + 1} / {cars.length}
            </span>
            <button
              onClick={() => goTo(active + 1)}
              disabled={active >= cars.length - 1}
              aria-label="next"
              className="grid h-12 w-12 place-items-center rounded-full bg-white/10 backdrop-blur transition hover:bg-white/20 disabled:opacity-30"
            >
              <Icon name="arrow" size={18} color="#fff" className="-rotate-90" />
            </button>
          </div>
        </div>
      )}
    </AppShell>
  );
}
