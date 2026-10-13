"use client";

import { Icon } from "@/components/Icon";
import { useI18n } from "@/i18n";
import type { FiltersData } from "@/lib/types";

type City = FiltersData["cities"][number];

/** The city filter row — pin-marked pills in a horizontal scroller,
 * shared by the home car list and the companies page. */
export function CityChips({
  cities,
  selectedId,
  onSelect,
}: {
  cities: City[];
  selectedId: string | null;
  onSelect: (city: City | null) => void;
}) {
  const { t, tr } = useI18n();
  if (cities.length === 0) return null;

  const base =
    "press flex h-9 shrink-0 items-center gap-1.5 rounded-xl px-3.5 text-[13px] font-semibold transition";

  return (
    <div className="no-scrollbar flex gap-2 overflow-x-auto px-4 py-1">
      <button
        onClick={() => onSelect(null)}
        className={`${base} ${
          selectedId === null
            ? "bg-hero text-white shadow-[var(--shadow-card)]"
            : "bg-white text-on-surface ring-1 ring-hairline hover:ring-border-strong"
        }`}
      >
        {t("web.allCities")}
      </button>
      {cities.map((city) => {
        const active = selectedId === city.id;
        return (
          <button
            key={city.id}
            onClick={() => onSelect(active ? null : city)}
            className={`${base} ${
              active
                ? "bg-hero text-white shadow-[var(--shadow-card)]"
                : "bg-white text-on-surface ring-1 ring-hairline hover:ring-border-strong"
            }`}
          >
            <Icon
              name="location_p"
              size={14}
              color={active ? "#FF4D55" : "#B51219"}
            />
            {tr(city)}
          </button>
        );
      })}
    </div>
  );
}
