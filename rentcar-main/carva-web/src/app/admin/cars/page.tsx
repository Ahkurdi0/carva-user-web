"use client";

import { useMemo, useRef, useState } from "react";
import { Card } from "@/components/DashboardShell";
import { ImageHolder } from "@/components/ImageHolder";
import { CarFormModal } from "@/components/CarFormModal";
import { Button, Input, PageLoading, EmptyState, ErrorState, Toggle, useEnumLabel } from "@/components/ui";
import { Icon } from "@/components/Icon";
import { useAsync } from "@/lib/useAsync";
import { adminApi, companyApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import { formatNumber } from "@/lib/format";
import { toast } from "@/components/toast";
import type { Car } from "@/lib/types";

export default function AdminCars() {
  const { t, tr } = useI18n();
  const e = useEnumLabel();
  const [search, setSearch] = useState("");
  const [q, setQ] = useState("");
  // The backend paginates 15 at a time (cursor = last car id). Walk every page
  // so the panel shows all cars, not just the first batch.
  const cars = useAsync(async () => {
    const all: Car[] = [];
    let cursor: string | undefined;
    for (let page = 0; page < 1000; page++) {
      const batch = await adminApi.allCars(cursor, q || undefined);
      if (!batch?.length) break;
      all.push(...batch);
      if (batch.length < 15) break;
      cursor = batch[batch.length - 1].id;
      if (!cursor) break;
    }
    return all;
  }, [q]);
  // Brands/types/plans are admin-capable through the company endpoints.
  const brands = useAsync(() => companyApi.brands(), []);
  const types = useAsync(() => companyApi.carTypes(), []);
  const plans = useAsync(() => companyApi.plans(), []);
  const [open, setOpen] = useState(false);
  const [editing, setEditing] = useState<Car | null>(null);
  const [toggling, setToggling] = useState<string | null>(null);
  const filtersRef = useRef<HTMLDivElement>(null);

  // Client-side filters over the fully-loaded list (company / brand / availability).
  const [brandFilter, setBrandFilter] = useState("");
  const [companyFilter, setCompanyFilter] = useState("");
  const [availFilter, setAvailFilter] = useState<"all" | "available" | "unavailable">("all");

  // Distinct companies present in the loaded cars, for the company dropdown.
  const companyOptions = useMemo(() => {
    const map = new Map<string, string>();
    for (const c of cars.data ?? []) {
      if (c.companyId && c.company?.name) map.set(c.companyId, c.company.name);
    }
    return [...map].map(([id, name]) => ({ id, name })).sort((a, b) => a.name.localeCompare(b.name));
  }, [cars.data]);

  const filteredCars = useMemo(() => {
    return (cars.data ?? []).filter((c) =>
      (!brandFilter || c.brandId === brandFilter) &&
      (!companyFilter || c.companyId === companyFilter) &&
      (availFilter === "all" || (availFilter === "available" ? c.available : !c.available)),
    );
  }, [cars.data, brandFilter, companyFilter, availFilter]);

  async function remove(car: Car) {
    if (!confirm(t("alertMessages.deleteCar"))) return;
    try {
      await companyApi.deleteCar(car.id);
      cars.refetch();
      toast(t("alertMessages.deleted"), "success");
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    }
  }

  async function toggle(car: Car) {
    setToggling(car.id);
    try {
      const fd = new FormData();
      fd.append("id", car.id);
      fd.append("available", String(!car.available));
      await companyApi.updateCar(fd);
      // Reflect the new state immediately without a full refetch.
      cars.setData((prev) => prev?.map((c) => c.id === car.id ? { ...c, available: !car.available } : c) ?? prev);
      toast(t("alertMessages.updated"), "success");
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    } finally {
      setToggling(null);
    }
  }

  return (
    <div>
      <h1 className="mb-4 text-2xl font-extrabold">{t("labels.cars")}</h1>
      <form onSubmit={(ev) => { ev.preventDefault(); setQ(search); }} className="mb-3 flex gap-2">
        <Input value={search} onChange={(ev) => setSearch(ev.target.value)} placeholder={t("inputHintText.searchCar")} />
        <Button variant="outline" type="submit"><Icon name="search" size={16} /></Button>
        <Button
          variant="outline"
          type="button"
          className="shrink-0 gap-1.5"
          onClick={() => filtersRef.current?.scrollIntoView({ behavior: "smooth", block: "center" })}
        >
          <Icon name="filter" size={16} />
          <span className="hidden sm:inline">{t("web.filters")}</span>
        </Button>
      </form>

      <div ref={filtersRef} className="mb-5 flex flex-wrap items-center gap-2 scroll-mt-24">
        <select
          value={companyFilter}
          onChange={(ev) => setCompanyFilter(ev.target.value)}
          className="h-10 rounded-xl border border-surface-low bg-surface-lowest px-3 text-sm"
        >
          <option value="">{t("buttons.company")}: {t("labels.all")}</option>
          {companyOptions.map((c) => <option key={c.id} value={c.id}>{c.name}</option>)}
        </select>
        <select
          value={brandFilter}
          onChange={(ev) => setBrandFilter(ev.target.value)}
          className="h-10 rounded-xl border border-surface-low bg-surface-lowest px-3 text-sm"
        >
          <option value="">{t("labels.brand")}: {t("labels.all")}</option>
          {(brands.data ?? []).map((b) => <option key={b.id} value={b.id}>{tr(b)}</option>)}
        </select>
        <select
          value={availFilter}
          onChange={(ev) => setAvailFilter(ev.target.value as "all" | "available" | "unavailable")}
          className="h-10 rounded-xl border border-surface-low bg-surface-lowest px-3 text-sm"
        >
          <option value="all">{t("labels.available")}: {t("labels.all")}</option>
          <option value="available">{t("labels.available")}</option>
          <option value="unavailable">{t("buttons.unavailable")}</option>
        </select>
        {(brandFilter || companyFilter || availFilter !== "all") && (
          <>
            <Button variant="outline" className="h-10 px-3 text-xs" onClick={() => { setBrandFilter(""); setCompanyFilter(""); setAvailFilter("all"); }}>
              {t("web.clearFilters")}
            </Button>
            <span className="text-xs text-muted">{formatNumber(filteredCars.length)} / {formatNumber((cars.data ?? []).length)}</span>
          </>
        )}
      </div>

      {cars.loading ? (
        <PageLoading />
      ) : cars.error ? (
        <ErrorState message={cars.error} onRetry={cars.refetch} />
      ) : filteredCars.length > 0 ? (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
          {filteredCars.map((car) => {
            const plan = car.rentalPlan?.[0];
            return (
              <Card key={car.id} className="overflow-hidden">
                <div className="relative">
                  <ImageHolder src={car.images?.[0]?.image} className={`aspect-[16/10] w-full ${car.available ? "" : "opacity-50"}`} rounded="rounded-none" />
                  {!car.available && (
                    <span className="absolute left-2 top-2 rounded-full bg-danger px-2 py-0.5 text-[10px] font-semibold text-white">
                      {t("buttons.unavailable")}
                    </span>
                  )}
                </div>
                <div className="p-3">
                  <p className="truncate font-semibold">{car.title}</p>
                  <p className="truncate text-xs text-muted">
                    {tr(car.brand)}{car.feature?.year ? ` · ${car.feature.year}` : ""}{car.company?.name ? ` · ${car.company.name}` : ""}
                  </p>
                  {plan && <p className="mt-1 text-sm font-bold text-primary">{formatNumber(plan.price)} {e.currency(plan.currency)} · {e.period(plan.periodType)}</p>}
                  <div className="mt-3 flex items-center justify-between gap-2">
                    <label className="flex items-center gap-2 text-xs font-medium">
                      <Toggle checked={!!car.available} disabled={toggling === car.id} onChange={() => toggle(car)} label={t("labels.available")} />
                      <span className={car.available ? "text-primary" : "text-muted"}>
                        {car.available ? t("labels.available") : t("buttons.unavailable")}
                      </span>
                    </label>
                    <div className="flex gap-2">
                      <Button variant="outline" className="h-9 px-3 text-xs" onClick={() => { setEditing(car); setOpen(true); }}>
                        <Icon name="edit" size={14} />
                      </Button>
                      <Button variant="outline" className="h-9 px-3 text-xs text-danger" onClick={() => remove(car)}>
                        <Icon name="trash" size={14} color="#ef4444" />
                      </Button>
                    </div>
                  </div>
                </div>
              </Card>
            );
          })}
        </div>
      ) : (
        <EmptyState icon="no_cars" title={t("empty.cars")} />
      )}

      <CarFormModal
        open={open}
        car={editing}
        onClose={() => setOpen(false)}
        onSaved={() => cars.refetch()}
        brands={brands.data ?? []}
        types={types.data ?? []}
        plans={plans.data ?? []}
      />
    </div>
  );
}
