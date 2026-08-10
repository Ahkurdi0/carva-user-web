// Small formatting helpers mirroring the app's extensions (forMatNumber,
// getCurrency, period labels, etc.).

export function toNum(v: number | string | null | undefined): number {
  if (v === null || v === undefined) return 0;
  return typeof v === "number" ? v : parseFloat(v) || 0;
}

export function formatNumber(v: number | string | null | undefined): string {
  return toNum(v).toLocaleString("en-US", { maximumFractionDigits: 3 });
}

export function formatDate(v?: string | null): string {
  if (!v) return "";
  const d = new Date(v);
  if (isNaN(d.getTime())) return "";
  return d.toLocaleDateString("en-GB", {
    day: "2-digit",
    month: "short",
    year: "numeric",
  });
}

export function formatDateTime(v?: string | null): string {
  if (!v) return "";
  const d = new Date(v);
  if (isNaN(d.getTime())) return "";
  return d.toLocaleString("en-GB", {
    day: "2-digit",
    month: "short",
    year: "numeric",
    hour: "2-digit",
    minute: "2-digit",
  });
}

/** DB stores the misspelling "hybird"; the translation key is "hybrid". */
export function fuelKey(fuel?: string | null): string {
  if (!fuel) return "";
  return fuel === "hybird" ? "hybrid" : fuel;
}

export function ratingText(rate?: number | null): string {
  const r = rate ?? 0;
  return r > 0 ? r.toFixed(1) : "New";
}

/**
 * Dedupe a list by `id`, keeping first occurrence. Cursor pagination on the API
 * is inclusive (the cursor item reappears as the first row of the next page), so
 * accumulated car lists otherwise carry duplicate ids and break React keys.
 */
export function uniqueById<T extends { id: string }>(items: T[]): T[] {
  const seen = new Set<string>();
  return items.filter((it) => (seen.has(it.id) ? false : seen.add(it.id) && true));
}
