"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import type { Slider } from "@/lib/types";
import { imageUrl } from "@/lib/api";
import { userApi } from "@/lib/services";

export function SliderCarousel({ slides }: { slides: Slider[] }) {
  const router = useRouter();
  const [idx, setIdx] = useState(0);
  const valid = slides.filter((s) => s.image || s.url);

  useEffect(() => {
    if (valid.length <= 1) return;
    const id = setInterval(() => setIdx((i) => (i + 1) % valid.length), 4000);
    return () => clearInterval(id);
  }, [valid.length]);

  if (valid.length === 0) return null;

  function open(slide: Slider) {
    userApi.slider(slide.id).catch(() => {});
    if (slide.type === "car" && slide.carId) router.push(`/car/${slide.car?.id ?? slide.carId}`);
    else if (slide.type === "company" && slide.companyId) router.push(`/company/${slide.companyId}`);
    else if (slide.url) window.open(slide.url, "_blank");
  }

  return (
    <section className="px-4 py-3">
      <div className="relative aspect-[16/7] w-full overflow-hidden rounded-2xl bg-surface-low sm:aspect-[16/5]">
        {valid.map((slide, i) => (
          <button
            key={slide.id}
            onClick={() => open(slide)}
            className="absolute inset-0 transition-opacity duration-700"
            style={{ opacity: i === idx ? 1 : 0, pointerEvents: i === idx ? "auto" : "none" }}
          >
            {slide.image ? (
              // eslint-disable-next-line @next/next/no-img-element
              <img src={imageUrl(slide.image)} alt="" className="h-full w-full object-cover" />
            ) : (
              <div className="grid h-full w-full place-items-center bg-primary-container text-primary">
                {slide.url}
              </div>
            )}
          </button>
        ))}
        {valid.length > 1 && (
          <div className="absolute inset-x-0 bottom-3 flex justify-center gap-1.5">
            {valid.map((_, i) => (
              <span
                key={i}
                className={`h-1.5 rounded-full transition-all ${
                  i === idx ? "w-5 bg-white" : "w-1.5 bg-white/60"
                }`}
              />
            ))}
          </div>
        )}
      </div>
    </section>
  );
}
