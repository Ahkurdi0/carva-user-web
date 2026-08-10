"use client";

import { useState } from "react";
import { imageUrl } from "@/lib/api";
import { Icon } from "./Icon";

// Brand logos aren't stored on the backend, so we resolve them by name from a
// car-logo dataset CDN, with a graceful fallback to a generic car icon.
const LOGO_BASE =
  "https://raw.githubusercontent.com/filippofilip95/car-logos-dataset/master/logos/optimized";

// Map the backend's English brand names to dataset slugs where they differ.
const SLUG: Record<string, string> = {
  mercedes: "mercedes-benz",
  "mercedes-benz": "mercedes-benz",
  "range rover": "land-rover",
  "land rover": "land-rover",
  hunda: "honda",
  vw: "volkswagen",
};

function slugFor(name?: string | null): string | null {
  if (!name) return null;
  const key = name.trim().toLowerCase();
  if (SLUG[key]) return SLUG[key];
  return key.replace(/[^a-z0-9]+/g, "-").replace(/^-|-$/g, "");
}

export function BrandLogo({
  name,
  image,
  size = 40,
}: {
  name?: string | null;
  /** Backend-provided logo key (preferred when present). */
  image?: string | null;
  size?: number;
}) {
  const [stage, setStage] = useState<0 | 1 | 2>(image ? 0 : 1);
  const slug = slugFor(name);

  // stage 0 = backend image, stage 1 = CDN by slug, stage 2 = generic icon
  if (stage === 2 || (stage === 1 && !slug)) {
    return <Icon name="car" size={size * 0.65} color="#9e9e9e" />;
  }

  const src = stage === 0 ? imageUrl(image) : `${LOGO_BASE}/${slug}.png`;
  return (
    // eslint-disable-next-line @next/next/no-img-element
    <img
      src={src}
      alt={name ?? ""}
      width={size}
      height={size}
      className="h-full w-full object-contain"
      onError={() => setStage((s) => (s === 0 ? 1 : 2))}
    />
  );
}
