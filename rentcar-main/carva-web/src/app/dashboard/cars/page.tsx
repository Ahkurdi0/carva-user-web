"use client";

import { useState } from "react";
import { Card } from "@/components/DashboardShell";
import { ImageHolder } from "@/components/ImageHolder";
import { CarFormModal } from "@/components/CarFormModal";
import { Button, PageLoading, EmptyState, useEnumLabel } from "@/components/ui";
import { Icon } from "@/components/Icon";
import { useAsync } from "@/lib/useAsync";
import { companyApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import { formatNumber } from "@/lib/format";
import { toast } from "@/components/toast";
import type { Car } from "@/lib/types";

export default function DashboardCars() {
  const { t, tr } = useI18n();
  const e = useEnumLabel();
  const cars = useAsync(() => companyApi.getCars(), []);
  const brands = useAsync(() => companyApi.brands(), []);
  const types = useAsync(() => companyApi.carTypes(), []);
  const plans = useAsync(() => companyApi.plans(), []);
  const [open, setOpen] = useState(false);
  const [editing, setEditing] = useState<Car | null>(null);

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
    try {
      const fd = new FormData();
      fd.append("id", car.id);
      fd.append("available", String(!car.available));
      await companyApi.updateCar(fd);
      cars.refetch();
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    }
  }

  return (
    <div>
      <div className="mb-5 flex items-center justify-between">
        <h1 className="text-2xl font-extrabold">{t("labels.cars")}</h1>
        <Button onClick={() => { setEditing(null); setOpen(true); }}><Icon name="car" size={16} color="#fff" /> {t("screens.newCar")}</Button>
      </div>

      {cars.loading ? (
        <PageLoading />
      ) : cars.data && cars.data.length > 0 ? (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {cars.data.map((car) => {
            const plan = car.rentalPlan?.[0];
            return (
              <Card key={car.id} className="overflow-hidden">
                <ImageHolder src={car.images?.[0]?.image} className="aspect-[16/10] w-full" rounded="rounded-none" />
                <div className="p-3">
                  <p className="truncate font-semibold">{car.title}</p>
                  <p className="text-xs text-muted">{tr(car.brand)} {car.feature?.year ? `· ${car.feature.year}` : ""}</p>
                  {plan && <p className="mt-1 text-sm font-bold text-primary">{formatNumber(plan.price)} {e.currency(plan.currency)} · {e.period(plan.periodType)}</p>}
                  <div className="mt-3 flex gap-2">
                    <Button variant="outline" className="h-9 flex-1 px-3 text-xs" onClick={() => toggle(car)}>
                      {car.available ? t("labels.available") : t("buttons.available")}
                    </Button>
                    <Button variant="outline" className="h-9 px-3 text-xs" onClick={() => { setEditing(car); setOpen(true); }}>
                      <Icon name="edit" size={14} />
                    </Button>
                    <Button variant="outline" className="h-9 px-3 text-xs text-danger" onClick={() => remove(car)}>
                      <Icon name="trash" size={14} color="#ef4444" />
                    </Button>
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
