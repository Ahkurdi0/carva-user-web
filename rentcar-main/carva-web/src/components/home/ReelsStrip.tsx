"use client";

import Link from "next/link";
import type { Car } from "@/lib/types";
import { imageUrl } from "@/lib/api";

/** Entry into Reels: portrait thumbnails that open the feed at that car. */
export function ReelsStrip({ cars }: { cars: Car[] }) {
  if (cars.length === 0) return null;
  return (
    <div className="no-scrollbar flex gap-2 overflow-x-auto px-4 py-1">
      {cars.slice(0, 10).map((car) => (
        <Link
          key={car.id}
          href={`/reels?car=${encodeURIComponent(car.carId)}`}
          className="press relative aspect-[34/54] w-[34vw] max-w-[150px] shrink-0 overflow-hidden rounded-[18px] border border-hairline bg-[#1A1517]"
        >
          {car.images?.[0]?.image && (
            // eslint-disable-next-line @next/next/no-img-element
            <img src={imageUrl(car.images[0].image)} alt={car.title} loading="lazy" className="absolute inset-0 h-full w-full object-cover" />
          )}
          <span className="absolute inset-0 bg-[linear-gradient(to_top,rgba(0,0,0,0.7)_0%,transparent_60%)]" />
          <span className="absolute -top-px end-2 mt-2 grid h-6 w-6 place-items-center rounded-full bg-black/35 backdrop-blur" aria-hidden>
            <svg width="10" height="10" viewBox="0 0 24 24" fill="#fff"><path d="M8 5v14l11-7z" /></svg>
          </span>
          <span className="absolute inset-x-2.5 bottom-2.5 truncate text-start text-[13px] font-semibold text-white"><bdi>{car.title}</bdi></span>
        </Link>
      ))}
    </div>
  );
}
