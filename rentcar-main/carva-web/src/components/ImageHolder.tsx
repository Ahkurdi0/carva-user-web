"use client";

import { useState } from "react";
import { imageUrl } from "@/lib/api";
import { Icon } from "./Icon";

// Mirrors the app's ImageHolder: shows a neutral placeholder while loading or
// when an image is missing/broken.
export function ImageHolder({
  src,
  alt = "",
  className = "",
  rounded = "rounded-2xl",
  cover = true,
}: {
  src?: string | null;
  alt?: string;
  className?: string;
  rounded?: string;
  cover?: boolean;
}) {
  const [error, setError] = useState(false);
  const url = imageUrl(src);
  const showImg = url && !error;

  return (
    <div
      className={`relative overflow-hidden bg-surface-low ${rounded} ${className}`}
    >
      {showImg ? (
        // eslint-disable-next-line @next/next/no-img-element
        <img
          src={url}
          alt={alt}
          onError={() => setError(true)}
          className={`h-full w-full ${cover ? "object-cover" : "object-contain"}`}
        />
      ) : (
        <div className="flex h-full w-full items-center justify-center">
          <Icon name="image" size={36} color="#c4c4c4" />
        </div>
      )}
    </div>
  );
}
