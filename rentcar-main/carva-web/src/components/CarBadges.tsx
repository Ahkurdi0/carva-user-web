"use client";

import { useI18n } from "@/i18n";
import { isRented } from "@/lib/car-status";
import type { Car } from "@/lib/types";

const pad = (n: number) => String(n).padStart(2, "0");
/** yyyy/MM/dd, like the app. */
export const ymd = (iso: string) => {
  const d = new Date(iso);
  return `${d.getFullYear()}/${pad(d.getMonth() + 1)}/${pad(d.getDate())}`;
};

/**
 * Calm amber "Rented" (not an alarm) and, when the end is known,
 * "Available from {date}". Nothing when the car isn't rented now.
 */
export function RentedBadge({ car, small = false }: { car: Car; small?: boolean }) {
  const { t } = useI18n();
  if (!isRented(car)) return null;
  const from = car.rentedUntil ? t("v2.availableFrom", { date: ymd(car.rentedUntil) }) : null;
  return (
    <span
      className={`inline-flex max-w-full items-start gap-1 border border-[#A9770F]/20 bg-[#FFF5E0]/95 text-[#8A5F06] backdrop-blur ${
        small ? "rounded-[9px] px-[7px] py-[3px]" : "gap-1.5 rounded-xl px-2.5 py-[5px]"
      }`}
    >
      <svg width={small ? 12 : 15} height={small ? 12 : 15} viewBox="0 0 24 24" fill="currentColor" className="mt-px shrink-0" aria-hidden>
        <path d="M16.53 11.06 15.47 10l-4.88 4.88-2.12-2.12-1.06 1.06L10.59 17l5.94-5.94zM19 3h-1V1h-2v2H8V1H6v2H5c-1.11 0-1.99.9-1.99 2L3 19a2 2 0 0 0 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H5V8h14v11z" />
      </svg>
      <span className="min-w-0 leading-tight">
        <span className={`block truncate font-bold ${small ? "text-[10.5px]" : "text-[12.5px]"}`}>{t("v2.rented")}</span>
        {from && <span className={`block font-medium ${small ? "text-[9.5px]" : "text-[11.5px]"}`}>{from}</span>}
      </span>
    </span>
  );
}

/** "🔥 Popular · {n} views this week": warm gradient pill under the title. */
export function PopularPill({ car }: { car: Car }) {
  const { t, num } = useI18n();
  const p = car.popularity;
  if (!p?.popular) return null;
  return (
    <span className="sheet-up inline-flex items-center gap-1.5 rounded-full border border-[#E2572B]/12 bg-gradient-to-l from-[#FFE7EC] to-[#FFF1E4] px-[11px] py-1.5 text-[12.5px] font-semibold text-[#9A3A1C] rtl:bg-gradient-to-r">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="#E2572B" aria-hidden>
        <path d="M19.48 12.35c-1.57-4.08-7.16-4.3-5.81-10.23.1-.44-.37-.78-.75-.55C9.29 3.71 6.68 8 8.87 13.62c.18.46-.36.89-.75.59-1.81-1.37-2-3.34-1.84-4.75.06-.52-.62-.77-.91-.34C4.69 10.16 4 11.84 4 14.37c.38 5.6 5.11 7.32 6.81 7.54 2.43.31 5.06-.14 6.95-1.87 2.08-1.93 2.84-5.01 1.72-7.69zm-9.28 5.03c1.44-.35 2.18-1.39 2.38-2.31.33-1.43-.96-2.83-.09-5.09.33 1.87 3.27 3.04 3.27 5.08.08 2.53-2.66 4.7-5.56 2.32z" />
      </svg>
      {t("v2.popularPill", { n: num(p.views7d) })}
    </span>
  );
}
