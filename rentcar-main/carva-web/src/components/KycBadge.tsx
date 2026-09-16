"use client";

import type { KycStatus } from "@/lib/types";

/** Small blue check shown next to an identity-verified account. */
export function KycBadge({ status, label = true }: { status?: KycStatus | string | null; label?: boolean }) {
  if (status !== "approved") return null;
  return (
    <span
      className="inline-flex items-center gap-1 rounded-full bg-blue-50 px-1.5 py-0.5 text-[10px] font-bold text-blue-600"
      title="Identity verified"
      aria-label="Identity verified"
    >
      <span className="grid h-3.5 w-3.5 place-items-center rounded-full bg-blue-500 text-[9px] text-white">✓</span>
      {label && <span>Verified</span>}
    </span>
  );
}
