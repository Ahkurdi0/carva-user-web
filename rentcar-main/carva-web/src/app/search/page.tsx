"use client";

import { useMemo, useState } from "react";
import { AppShell } from "@/components/AppShell";
import { CarCard, CarCardSkeleton } from "@/components/CarCard";
import { Button, Chip, EmptyState, Field } from "@/components/ui";
import { Icon } from "@/components/Icon";
import { useAsync } from "@/lib/useAsync";
import { userApi } from "@/lib/services";
import { uniqueById } from "@/lib/format";
import { useI18n } from "@/i18n";
import type { Car, FiltersData, Fuel, Transmission } from "@/lib/types";

const FUELS: Fuel[] = ["gasoline", "diesel", "electric", "hybird", "lpg", "cng"];
const TRANSMISSIONS: Transmission[] = ["automatic", "manual", "cvt", "amt", "dct", "sp"];

export default function SearchPage() {
  const { t, tr } = useI18n();
  const { data: filters } = useAsync<FiltersData>(() => userApi.filters(), []);
  const suggested = useAsync<Car[]>(() => userApi.suggestedCars(), []);

  const [brandId, setBrandId] = useState<string>();
  const [typeId, setTypeId] = useState<string>();
  const [cityId, setCityId] = useState<string>();
  const [townId, setTownId] = useState<string>();
  const [fuel, setFuel] = useState<Fuel>();
  const [transmission, setTransmission] = useState<Transmission>();
  const [minYear, setMinYear] = useState("");
  const [maxYear, setMaxYear] = useState("");

  const [results, setResults] = useState<Car[] | null>(null);
  const [loading, setLoading] = useState(false);
  const [searched, setSearched] = useState(false);
  const [showFilters, setShowFilters] = useState(true);

  const towns = useMemo(
    () => filters?.cities.find((c) => c.id === cityId)?.towns ?? [],
    [filters, cityId],
  );

  async function search() {
    setLoading(true);
    setSearched(true);
    try {
      const params: Record<string, unknown> = {};
      if (brandId) params.brandId = brandId;
      if (typeId) params.typeId = typeId;
      const feature: Record<string, unknown> = {};
      if (fuel) feature.fuel = fuel;
      if (transmission) feature.transmission = transmission;
      if (minYear) feature.year = Number(minYear);
      if (Object.keys(feature).length) params.feature = feature;
      if (maxYear) params.maxYear = Number(maxYear);
      if (cityId || townId) params.location = { cityid: cityId, townId };
      const res = await userApi.filterCars(params);
      setResults(uniqueById(res));
    } catch {
      setResults([]);
    } finally {
      setLoading(false);
    }
  }

  function clear() {
    setBrandId(undefined); setTypeId(undefined); setCityId(undefined);
    setTownId(undefined); setFuel(undefined); setTransmission(undefined);
    setMinYear(""); setMaxYear(""); setResults(null); setSearched(false);
  }

  return (
    <AppShell>
      <div className="px-4 py-5">
        <div className="mb-4 flex items-center justify-between">
          <h1 className="text-xl font-extrabold">{t("web.filters")}</h1>
          <button onClick={() => setShowFilters((s) => !s)} className="flex items-center gap-2 text-sm font-medium text-primary md:hidden">
            <Icon name="filter" size={16} color="#B51219" /> {t("web.filters")}
          </button>
        </div>

        <div className="grid gap-6 md:grid-cols-[300px_1fr]">
          {/* Filters */}
          <div className={`${showFilters ? "block" : "hidden"} space-y-5 md:block`}>
            <div>
              <p className="mb-2 text-sm font-semibold">{t("labels.brands")}</p>
              <div className="flex flex-wrap gap-2">
                <Chip label={t("web.anyBrand")} selected={!brandId} onClick={() => setBrandId(undefined)} />
                {filters?.brands.map((b) => (
                  <Chip key={b.id} label={tr(b)} selected={brandId === b.id} onClick={() => setBrandId(b.id)} />
                ))}
              </div>
            </div>

            <div>
              <p className="mb-2 text-sm font-semibold">{t("labels.types")}</p>
              <div className="flex flex-wrap gap-2">
                <Chip label={t("web.anyType")} selected={!typeId} onClick={() => setTypeId(undefined)} />
                {filters?.types.map((ty) => (
                  <Chip key={ty.id} label={tr(ty)} selected={typeId === ty.id} onClick={() => setTypeId(ty.id)} />
                ))}
              </div>
            </div>

            <div>
              <p className="mb-2 text-sm font-semibold">{t("labels.fuel")}</p>
              <div className="flex flex-wrap gap-2">
                {FUELS.map((fl) => (
                  <Chip key={fl} label={t(`fuel.${fl === "hybird" ? "hybrid" : fl}`)} selected={fuel === fl} onClick={() => setFuel(fuel === fl ? undefined : fl)} />
                ))}
              </div>
            </div>

            <div>
              <p className="mb-2 text-sm font-semibold">{t("labels.transmission")}</p>
              <div className="flex flex-wrap gap-2">
                {TRANSMISSIONS.map((tm) => (
                  <Chip key={tm} label={t(`transmission.${tm}`)} selected={transmission === tm} onClick={() => setTransmission(transmission === tm ? undefined : tm)} />
                ))}
              </div>
            </div>

            <div className="grid grid-cols-2 gap-3">
              <Field label={`${t("labels.year")} (min)`}>
                <input value={minYear} onChange={(e) => setMinYear(e.target.value)} inputMode="numeric" className="h-11 w-full rounded-xl border border-surface-low bg-surface-lowest px-3 text-sm outline-none focus:border-primary" />
              </Field>
              <Field label={`${t("labels.year")} (max)`}>
                <input value={maxYear} onChange={(e) => setMaxYear(e.target.value)} inputMode="numeric" className="h-11 w-full rounded-xl border border-surface-low bg-surface-lowest px-3 text-sm outline-none focus:border-primary" />
              </Field>
            </div>

            <div>
              <p className="mb-2 text-sm font-semibold">{t("labels.city")}</p>
              <select value={cityId ?? ""} onChange={(e) => { setCityId(e.target.value || undefined); setTownId(undefined); }} className="h-11 w-full rounded-xl border border-surface-low bg-surface-lowest px-3 text-sm">
                <option value="">{t("labels.selectACity")}</option>
                {filters?.cities.map((c) => <option key={c.id} value={c.id}>{tr(c)}</option>)}
              </select>
              {towns.length > 0 && (
                <select value={townId ?? ""} onChange={(e) => setTownId(e.target.value || undefined)} className="mt-2 h-11 w-full rounded-xl border border-surface-low bg-surface-lowest px-3 text-sm">
                  <option value="">{t("labels.selectTownOptional")}</option>
                  {towns.map((tw) => <option key={tw.id} value={tw.id}>{tr(tw)}</option>)}
                </select>
              )}
            </div>

            <div className="flex gap-2">
              <Button full onClick={search} loading={loading}>{t("web.applyFilters")}</Button>
              <Button variant="outline" onClick={clear}>{t("web.clearFilters")}</Button>
            </div>
          </div>

          {/* Results */}
          <div>
            {loading ? (
              <div className="grid grid-cols-2 gap-x-3 gap-y-5 sm:grid-cols-3">
                {Array.from({ length: 6 }).map((_, i) => <CarCardSkeleton key={i} />)}
              </div>
            ) : results && results.length > 0 ? (
              <>
                <p className="mb-3 text-sm text-muted">{results.length} {t("web.results")}</p>
                <div className="grid grid-cols-2 gap-x-3 gap-y-5 sm:grid-cols-3">
                  {results.map((car) => <CarCard key={car.id} car={car} />)}
                </div>
              </>
            ) : searched ? (
              <EmptyState icon="no_cars" title={t("empty.cars")} />
            ) : suggested.loading ? (
              <div className="grid grid-cols-2 gap-x-3 gap-y-5 sm:grid-cols-3">
                {Array.from({ length: 6 }).map((_, i) => <CarCardSkeleton key={i} />)}
              </div>
            ) : suggested.data && suggested.data.length > 0 ? (
              <>
                <p className="mb-3 text-sm font-semibold">{t("labels.suggested")}</p>
                <div className="grid grid-cols-2 gap-x-3 gap-y-5 sm:grid-cols-3">
                  {uniqueById(suggested.data).map((car) => <CarCard key={car.id} car={car} />)}
                </div>
              </>
            ) : (
              <EmptyState icon="search" title={t("inputHintText.searchCar")} />
            )}
          </div>
        </div>
      </div>
    </AppShell>
  );
}
