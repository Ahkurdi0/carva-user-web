"use client";

import { useState, useRef, useEffect, type ReactNode } from "react";
import { Icon } from "./Icon";
import { ImageHolder } from "./ImageHolder";
import { imageUrl } from "@/lib/api";
import type { CarImage } from "@/lib/types";

// Swipeable car photo gallery: finger swipe + prev/next arrows on the main
// image, a thumbnail strip, and a tap-to-open fullscreen lightbox.
export function CarGallery({
  images,
  title = "",
  featuredLabel,
  favorite,
}: {
  images: CarImage[];
  title?: string;
  featuredLabel?: string;
  favorite?: ReactNode;
}) {
  const [active, setActive] = useState(0);
  const [lightbox, setLightbox] = useState(false);
  const startX = useRef<number | null>(null);
  const count = images.length;

  function go(delta: number) {
    if (count <= 1) return;
    setActive((i) => (i + delta + count) % count);
  }

  function onTouchStart(e: React.TouchEvent) {
    startX.current = e.touches[0].clientX;
  }
  function onTouchEnd(e: React.TouchEvent) {
    if (startX.current === null) return;
    const dx = e.changedTouches[0].clientX - startX.current;
    if (Math.abs(dx) > 40) go(dx < 0 ? 1 : -1);
    startX.current = null;
  }

  // Lock body scroll + wire keyboard nav while the lightbox is open.
  useEffect(() => {
    if (!lightbox) return;
    const prevOverflow = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    function onKey(ev: KeyboardEvent) {
      if (ev.key === "Escape") setLightbox(false);
      else if (ev.key === "ArrowRight") go(1);
      else if (ev.key === "ArrowLeft") go(-1);
    }
    window.addEventListener("keydown", onKey);
    return () => {
      document.body.style.overflow = prevOverflow;
      window.removeEventListener("keydown", onKey);
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [lightbox]);

  const current = images[active]?.image;

  const arrowBtn =
    "absolute top-1/2 grid h-9 w-9 -translate-y-1/2 place-items-center rounded-full bg-black/45 text-white backdrop-blur transition hover:bg-black/65";

  return (
    <div>
      <div className="relative select-none">
        <button
          type="button"
          onClick={() => count > 0 && setLightbox(true)}
          onTouchStart={onTouchStart}
          onTouchEnd={onTouchEnd}
          className="block w-full cursor-zoom-in"
          aria-label={title}
        >
          <ImageHolder src={current} alt={title} className="aspect-[16/10] max-h-[420px] w-full" />
        </button>

        {count > 1 && (
          <>
            <button type="button" onClick={() => go(-1)} aria-label="Previous photo" className={`${arrowBtn} left-2`}>
              <Icon name="arrow" size={18} color="#fff" />
            </button>
            <button type="button" onClick={() => go(1)} aria-label="Next photo" className={`${arrowBtn} right-2`}>
              <Icon name="arrow" size={18} color="#fff" className="rotate-180" />
            </button>
            <span className="pointer-events-none absolute bottom-2 left-1/2 -translate-x-1/2 rounded-full bg-black/55 px-2 py-0.5 text-[11px] font-medium text-white">
              {active + 1} / {count}
            </span>
          </>
        )}

        {favorite && <div className="absolute right-3 top-3">{favorite}</div>}
        {featuredLabel && (
          <span className="absolute left-3 top-3 rounded-full bg-tint px-2.5 py-1 text-[10px] font-bold uppercase text-white">
            {featuredLabel}
          </span>
        )}
      </div>

      {count > 1 && (
        <div className="no-scrollbar mt-3 flex gap-2 overflow-x-auto">
          {images.map((img, i) => (
            <button
              key={img.id ?? i}
              onClick={() => setActive(i)}
              className={`shrink-0 overflow-hidden rounded-lg border-2 ${i === active ? "border-primary" : "border-transparent"}`}
            >
              <ImageHolder src={img.image} className="h-16 w-20" rounded="rounded-md" />
            </button>
          ))}
        </div>
      )}

      {lightbox && (
        <div
          className="fixed inset-0 z-[200] flex items-center justify-center bg-black/90"
          onClick={() => setLightbox(false)}
          onTouchStart={onTouchStart}
          onTouchEnd={onTouchEnd}
        >
          <button
            type="button"
            onClick={() => setLightbox(false)}
            aria-label="Close"
            className="absolute right-4 top-4 z-10 grid h-10 w-10 place-items-center rounded-full bg-white/10 text-white transition hover:bg-white/20"
          >
            <Icon name="cancel" size={20} color="#fff" />
          </button>

          {count > 1 && (
            <button
              type="button"
              onClick={(e) => { e.stopPropagation(); go(-1); }}
              aria-label="Previous photo"
              className="absolute left-3 top-1/2 z-10 grid h-11 w-11 -translate-y-1/2 place-items-center rounded-full bg-white/10 text-white transition hover:bg-white/20"
            >
              <Icon name="arrow" size={22} color="#fff" />
            </button>
          )}

          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src={imageUrl(current) || undefined}
            alt={title}
            onClick={(e) => e.stopPropagation()}
            className="max-h-[85vh] max-w-[92vw] object-contain"
          />

          {count > 1 && (
            <button
              type="button"
              onClick={(e) => { e.stopPropagation(); go(1); }}
              aria-label="Next photo"
              className="absolute right-3 top-1/2 z-10 grid h-11 w-11 -translate-y-1/2 place-items-center rounded-full bg-white/10 text-white transition hover:bg-white/20"
            >
              <Icon name="arrow" size={22} color="#fff" className="rotate-180" />
            </button>
          )}

          {count > 1 && (
            <span className="pointer-events-none absolute bottom-5 left-1/2 -translate-x-1/2 rounded-full bg-white/10 px-3 py-1 text-sm text-white">
              {active + 1} / {count}
            </span>
          )}
        </div>
      )}
    </div>
  );
}
