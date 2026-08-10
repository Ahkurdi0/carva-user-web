"use client";

import { useEffect, useState } from "react";
import { Modal } from "@/components/Modal";
import { ImageHolder } from "@/components/ImageHolder";
import { Button, Field, Input, useEnumLabel } from "@/components/ui";
import { Icon } from "@/components/Icon";
import { companyApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import { toast } from "@/components/toast";
import type {
  Brand,
  Car,
  CarImage,
  CarType,
  LocalizedNum,
  Plan,
  RentalPeriodType,
} from "@/lib/types";

const PERIODS: RentalPeriodType[] = ["hourly", "daily", "weekly", "monthly"];
const MAX_IMAGES = 5;

type PlanRow = {
  id?: string; // present when it came from an existing car (edit mode)
  planId: string;
  periodType: RentalPeriodType;
  price: string;
  currency: string;
};

// Feature numeric fields can come back as a number, string, or localized object.
function featNum(v: LocalizedNum | undefined): string {
  if (v == null) return "";
  if (typeof v === "number" || typeof v === "string") return String(v);
  if (typeof v === "object") return String(v.en ?? "");
  return "";
}

// Plan prices come from the backend as Decimal(18,3) strings like "150000.000".
// Strip the meaningless trailing zeros so the input shows "150000".
function cleanPrice(v: number | string | null | undefined): string {
  if (v == null || v === "") return "";
  const n = Number(v);
  return Number.isFinite(n) ? String(n) : String(v);
}

const emptyForm = {
  title: "",
  brandId: "",
  typeId: "",
  seat: "5",
  year: "",
  fuel: "gasoline",
  transmission: "automatic",
  displayPlan: "daily" as RentalPeriodType,
};

export function CarFormModal({
  open,
  onClose,
  onSaved,
  brands,
  types,
  plans,
  car,
}: {
  open: boolean;
  onClose: () => void;
  onSaved: () => void;
  brands: Brand[];
  types: CarType[];
  plans: Plan[];
  /** When provided the modal edits this car; otherwise it creates a new one. */
  car?: Car | null;
}) {
  const { t, tr } = useI18n();
  const e = useEnumLabel();
  const editing = !!car;
  const [busy, setBusy] = useState(false);
  const [form, setForm] = useState(emptyForm);
  const [planRows, setPlanRows] = useState<PlanRow[]>([]);
  const [origPlans, setOrigPlans] = useState<PlanRow[]>([]);
  const [images, setImages] = useState<File[]>([]); // newly added files
  const [existing, setExisting] = useState<CarImage[]>([]); // kept existing images
  const [removed, setRemoved] = useState<CarImage[]>([]); // existing images to delete

  // Reset / hydrate the form whenever the modal opens (or the target car changes).
  useEffect(() => {
    if (!open) return;
    if (car) {
      setForm({
        title: car.title ?? "",
        brandId: car.brandId ?? car.brand?.id ?? "",
        typeId: car.typeId ?? car.feature?.type?.id ?? "",
        seat: featNum(car.feature?.seat) || "5",
        year: featNum(car.feature?.year),
        fuel: car.feature?.fuel ?? "gasoline",
        transmission: car.feature?.transmission ?? "automatic",
        displayPlan: car.displayPlan ?? "daily",
      });
      const rows: PlanRow[] = (car.rentalPlan ?? []).map((p) => ({
        id: p.id,
        planId:
          (p.plan && "id" in p.plan ? (p.plan.id as string) : undefined) ??
          plans.find((x) => x.periodType === p.periodType)?.id ??
          "",
        periodType: p.periodType,
        price: cleanPrice(p.price),
        currency: p.currency ?? "iqd",
      }));
      setPlanRows(rows);
      setOrigPlans(rows);
      setExisting(car.images ?? []);
    } else {
      setForm(emptyForm);
      setPlanRows([]);
      setOrigPlans([]);
      setExisting([]);
    }
    setImages([]);
    setRemoved([]);
  }, [open, car, plans]);

  // Only periods that have a catalog plan can be added — otherwise the row has
  // no valid planId and the backend would store a mismatched plan.
  const planByPeriod = new Map(plans.filter((p) => p.periodType).map((p) => [p.periodType!, p]));

  function addPlan() {
    const used = new Set(planRows.map((r) => r.periodType));
    const next = PERIODS.map((pt) => planByPeriod.get(pt)).find((p) => p && !used.has(p.periodType!)) ?? plans[0];
    if (!next?.id) return;
    setPlanRows((r) => [
      ...r,
      { planId: next.id, periodType: next.periodType ?? "daily", price: "", currency: "iqd" },
    ]);
  }

  function removePlan(i: number) {
    setPlanRows((r) => r.filter((_, j) => j !== i));
  }

  function removeExisting(img: CarImage) {
    setExisting((r) => r.filter((x) => x !== img));
    if (img.id) setRemoved((r) => [...r, img]);
  }

  function addFiles(files: FileList | null) {
    if (!files) return;
    const room = MAX_IMAGES - existing.length - images.length;
    setImages((r) => [...r, ...Array.from(files).slice(0, Math.max(0, room))]);
  }

  const featurePayload = () => ({
    seat: Number(form.seat) || 1,
    year: form.year ? Number(form.year) : undefined,
    fuel: form.fuel,
    transmission: form.transmission,
    carTypeId: form.typeId || undefined,
  });

  async function submit() {
    const totalImages = editing ? existing.length + images.length : images.length;
    if (!form.title || !form.brandId || planRows.length === 0 || totalImages === 0) {
      toast(t("alertMessages.someThingWentWrong"), "error");
      return;
    }
    setBusy(true);
    try {
      const fd = new FormData();
      fd.append("title", form.title);
      fd.append("brandId", form.brandId);
      if (form.typeId) fd.append("typeId", form.typeId);
      fd.append("displayPlan", form.displayPlan);
      fd.append("feature", JSON.stringify(featurePayload()));

      if (editing) {
        fd.append("id", car!.id);

        // Plans: existing rows that were removed or changed get deleted; new and
        // changed rows get (re)created. Unchanged existing rows are left alone so
        // the backend's "<= 3 plans" guard nets out correctly.
        const kept = new Set(planRows.filter((r) => r.id).map((r) => r.id));
        const origById = new Map(origPlans.map((r) => [r.id, r]));
        const deleted: { id: string }[] = origPlans
          .filter((r) => r.id && !kept.has(r.id))
          .map((r) => ({ id: r.id! }));
        const create: PlanRow[] = [];
        for (const r of planRows) {
          if (!r.id) {
            create.push(r);
            continue;
          }
          const o = origById.get(r.id);
          const changed =
            !o ||
            Number(o.price) !== Number(r.price) ||
            o.currency !== r.currency ||
            o.periodType !== r.periodType;
          if (changed) {
            deleted.push({ id: r.id });
            create.push(r);
          }
        }
        if (create.length) {
          fd.append(
            "rentalPlan",
            JSON.stringify(
              create.map((p) => ({
                planId: p.planId,
                periodType: p.periodType,
                price: Number(p.price) || 0,
                currency: p.currency,
              })),
            ),
          );
        }
        if (deleted.length) fd.append("deletedRentalPlans", JSON.stringify(deleted));
        if (removed.length)
          fd.append(
            "deletedImages",
            JSON.stringify(removed.map((img) => ({ id: img.id, image: img.image }))),
          );
        images.forEach((img) => fd.append("images", img));
        await companyApi.updateCar(fd);
      } else {
        fd.append("available", "true");
        fd.append(
          "rentalPlan",
          JSON.stringify(
            planRows.map((p) => ({
              planId: p.planId,
              periodType: p.periodType,
              price: Number(p.price) || 0,
              currency: p.currency,
            })),
          ),
        );
        images.forEach((img) => fd.append("images", img));
        await companyApi.newCar(fd);
      }

      toast(t("alertMessages.success"), "success");
      onSaved();
      onClose();
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    } finally {
      setBusy(false);
    }
  }

  const canAddImages = existing.length + images.length < MAX_IMAGES;

  return (
    <Modal open={open} onClose={onClose} title={editing ? t("buttons.update") : t("screens.newCar")}>
      <div className="space-y-3">
        <Field label={t("inputLabels.title")}>
          <Input value={form.title} onChange={(ev) => setForm({ ...form, title: ev.target.value })} />
        </Field>
        <div className="grid grid-cols-2 gap-3">
          <Field label={t("labels.brand")}>
            <select className="h-12 w-full rounded-xl border border-surface-low bg-surface-lowest px-3 text-sm" value={form.brandId} onChange={(ev) => setForm({ ...form, brandId: ev.target.value })}>
              <option value="">{t("labels.selectABrand")}</option>
              {brands.map((b) => <option key={b.id} value={b.id}>{tr(b)}</option>)}
            </select>
          </Field>
          <Field label={t("labels.type")}>
            <select className="h-12 w-full rounded-xl border border-surface-low bg-surface-lowest px-3 text-sm" value={form.typeId} onChange={(ev) => setForm({ ...form, typeId: ev.target.value })}>
              <option value="">{t("labels.selectACarType")}</option>
              {types.map((ty) => <option key={ty.id} value={ty.id}>{tr(ty)}</option>)}
            </select>
          </Field>
        </div>
        <div className="grid grid-cols-3 gap-3">
          <Field label={t("labels.seat")}><Input value={form.seat} onChange={(ev) => setForm({ ...form, seat: ev.target.value })} inputMode="numeric" /></Field>
          <Field label={t("labels.year")}><Input value={form.year} onChange={(ev) => setForm({ ...form, year: ev.target.value })} inputMode="numeric" /></Field>
          <Field label={t("labels.fuel")}>
            <select className="h-12 w-full rounded-xl border border-surface-low bg-surface-lowest px-2 text-sm" value={form.fuel} onChange={(ev) => setForm({ ...form, fuel: ev.target.value })}>
              {["gasoline", "diesel", "electric", "hybird", "lpg", "cng"].map((f) => <option key={f} value={f}>{e.fuel(f)}</option>)}
            </select>
          </Field>
        </div>
        <Field label={t("labels.transmission")}>
          <select className="h-12 w-full rounded-xl border border-surface-low bg-surface-lowest px-3 text-sm" value={form.transmission} onChange={(ev) => setForm({ ...form, transmission: ev.target.value })}>
            {["automatic", "manual", "cvt", "amt", "dct", "sp"].map((tm) => <option key={tm} value={tm}>{e.transmission(tm)}</option>)}
          </select>
        </Field>

        {/* Rental plans */}
        <div>
          <div className="mb-2 flex items-center justify-between">
            <span className="text-sm font-medium">{t("labels.rentalPlans")}</span>
            <button onClick={addPlan} className="text-sm font-medium text-primary">+ {t("buttons.add")}</button>
          </div>
          <div className="space-y-2">
            {planRows.map((p, i) => (
              <div key={i} className="flex gap-2">
                <select className="h-11 flex-1 rounded-lg border border-surface-low bg-surface-lowest px-2 text-sm" value={p.periodType}
                  onChange={(ev) => { const next = ev.target.value as RentalPeriodType; const pl = planByPeriod.get(next); if (!pl) return; setPlanRows((r) => r.map((x, j) => j === i ? { ...x, periodType: next, planId: pl.id } : x)); }}>
                  {PERIODS.filter((pt) => planByPeriod.has(pt) || pt === p.periodType).map((pt) => <option key={pt} value={pt}>{e.period(pt)}</option>)}
                </select>
                <Input className="h-11 flex-1" placeholder={t("labels.price")} value={p.price} inputMode="numeric" onChange={(ev) => setPlanRows((r) => r.map((x, j) => j === i ? { ...x, price: ev.target.value } : x))} />
                <select className="h-11 rounded-lg border border-surface-low bg-surface-lowest px-2 text-sm" value={p.currency} onChange={(ev) => setPlanRows((r) => r.map((x, j) => j === i ? { ...x, currency: ev.target.value } : x))}>
                  <option value="iqd">IQD</option><option value="usd">USD</option>
                </select>
                <button type="button" onClick={() => removePlan(i)} className="px-1 text-danger" aria-label={t("buttons.delete")}>
                  <Icon name="trash" size={16} color="#ef4444" />
                </button>
              </div>
            ))}
          </div>
        </div>

        {/* Existing images (edit mode) */}
        {existing.length > 0 && (
          <div className="flex flex-wrap gap-2">
            {existing.map((img, i) => (
              <div key={img.id ?? i} className="relative">
                <ImageHolder src={img.image} className="h-16 w-20" />
                <button type="button" onClick={() => removeExisting(img)} className="absolute -right-1.5 -top-1.5 grid h-5 w-5 place-items-center rounded-full bg-danger text-white" aria-label={t("buttons.delete")}>
                  <Icon name="cancel" size={11} color="#fff" />
                </button>
              </div>
            ))}
          </div>
        )}

        {canAddImages && (
          <Field label={t("buttons.addImage")}>
            <input type="file" accept="image/*" multiple onChange={(ev) => addFiles(ev.target.files)} className="text-sm" />
          </Field>
        )}
        {images.length > 0 && (
          <p className="text-xs text-muted">{images.length} {t("buttons.addImage").toLowerCase()}</p>
        )}

        <Button full loading={busy} onClick={submit}>{editing ? t("buttons.update") : t("buttons.add")}</Button>
      </div>
    </Modal>
  );
}
