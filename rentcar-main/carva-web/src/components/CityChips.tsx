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
    "flex shrink-0 items-center gap-1.5 rounded-full border px-4 py-2 text-sm font-medium transition";

  return (
    <div className="no-scrollbar flex gap-2 overflow-x-auto px-4 py-1">
      <button
        onClick={() => onSelect(null)}
        className={`${base} ${
          selectedId === null
            ? "border-primary bg-primary text-white shadow-sm"
            : "border-surface-low bg-white text-on-surface hover:border-primary/40"
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
                ? "border-primary bg-primary text-white shadow-sm"
                : "border-surface-low bg-white text-on-surface hover:border-primary/40"
            }`}
          >
            <Icon
              name="location_p"
              size={14}
              color={active ? "#ffffff" : "#B51219"}
            />
            {tr(city)}
          </button>
        );
      })}
    </div>
  );
}
