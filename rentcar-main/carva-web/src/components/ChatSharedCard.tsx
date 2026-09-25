"use client";

import Link from "next/link";
import { imageUrl } from "@/lib/api";
import { Icon } from "./Icon";
import type { Car, Company } from "@/lib/types";

export type SharedListing =
  | { kind: "car"; item: Car | Record<string, unknown> }
  | { kind: "company"; item: Company | Record<string, unknown> };

function record(value: Car | Company | Record<string, unknown>) {
  return value as Record<string, unknown>;
}

function firstImage(value: Record<string, unknown>) {
  const first = value.image ?? value.imageUrl ?? (Array.isArray(value.images) ? value.images[0] : null);
  if (first && typeof first === "object") {
    const image = (first as Record<string, unknown>).image ?? (first as Record<string, unknown>).url;
    return image ? imageUrl(String(image)) : "";
  }
  return first ? imageUrl(String(first)) : "";
}

export function SharedListingCard({ listing, compact = false }: { listing: SharedListing; compact?: boolean }) {
  const item = record(listing.item);
  const isCar = listing.kind === "car";
  const id = String(item.carId ?? item.id ?? "");
  const title = String(item.title ?? item.name ?? (isCar ? "Shared car" : "Shared company"));
  const feature = item.feature && typeof item.feature === "object" ? record(item.feature as Record<string, unknown>) : {};
  const details = isCar
    ? [feature.year ?? item.year, feature.transmission ?? item.transmission, feature.type ?? item.type]
        .filter(Boolean)
        .map((v) => typeof v === "object" ? String(record(v as Record<string, unknown>).en ?? "") : String(v))
        .filter(Boolean)
        .join(" · ")
    : String(item.desc ?? "Carva company");
  const image = firstImage(item);
  const href = isCar ? `/car/${id}` : `/company/${id}`;

  return (
    <Link
      href={href}
      className={`group block overflow-hidden rounded-2xl border border-surface-low bg-white transition hover:border-primary/50 hover:shadow-md ${compact ? "max-w-sm" : ""}`}
    >
      <div className={`${compact ? "h-28" : "h-40"} relative bg-primary-container`}>
        {image ? (
          // eslint-disable-next-line @next/next/no-img-element
          <img src={image} alt={title} className="h-full w-full object-cover transition group-hover:scale-[1.02]" />
        ) : (
          <div className="grid h-full place-items-center"><Icon name={isCar ? "car" : "company"} size={38} color="#3957d7" /></div>
        )}
        <span className="absolute left-3 top-3 rounded-full bg-white/90 px-2.5 py-1 text-[10px] font-bold uppercase tracking-wide text-primary backdrop-blur">
          {isCar ? "Car" : "Company"}
        </span>
      </div>
      <div className="p-3">
        <p className="truncate text-sm font-bold text-on-surface">{title}</p>
        {details && <p className="mt-1 line-clamp-2 text-xs text-muted">{details}</p>}
        {isCar && item.rentalPlan && Array.isArray(item.rentalPlan) && item.rentalPlan[0] && (
          <p className="mt-2 text-xs font-semibold text-primary">
            {String(record(item.rentalPlan[0] as Record<string, unknown>).price ?? "")} {String(record(item.rentalPlan[0] as Record<string, unknown>).currency ?? "")}
          </p>
        )}
      </div>
    </Link>
  );
}

export const ChatSharedCard = SharedListingCard;
