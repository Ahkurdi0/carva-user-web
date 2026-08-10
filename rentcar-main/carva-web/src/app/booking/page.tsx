"use client";

import { Suspense, useMemo, useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import { AppShell } from "@/components/AppShell";
import { ImageHolder } from "@/components/ImageHolder";
import { Button, Field, Input, PageLoading, EmptyState, useEnumLabel } from "@/components/ui";
import { useAsync } from "@/lib/useAsync";
import { userApi } from "@/lib/services";
import { useAuth } from "@/lib/auth-store";
import { useI18n } from "@/i18n";
import { formatNumber, toNum } from "@/lib/format";
import { toast } from "@/components/toast";
import type { Car, Plan, RentalPlan } from "@/lib/types";

function periodsBetween(type: string, start: Date, end: Date): number {
  const ms = end.getTime() - start.getTime();
  if (ms <= 0) return 0;
  const hours = ms / 3_600_000;
  switch (type) {
    case "hourly": return Math.max(1, Math.ceil(hours));
    case "daily": return Math.max(1, Math.ceil(hours / 24));
    case "weekly": return Math.max(1, Math.ceil(hours / 24 / 7));
    case "monthly": return Math.max(1, Math.ceil(hours / 24 / 30));
    default: return 1;
  }
}

function BookingInner() {
  const params = useSearchParams();
  const carId = params.get("car") ?? "";
  const { t, num } = useI18n();
  const e = useEnumLabel();
  const router = useRouter();
  const user = useAuth((s) => s.user);

  const { data: car, loading } = useAsync<Car>(() => userApi.carDetails(carId), [carId], !!carId);
  const [planId, setPlanId] = useState<string | null>(null);
  const [start, setStart] = useState("");
  const [end, setEnd] = useState("");
  const [code, setCode] = useState("");
  const [contact, setContact] = useState("");
  const [discount, setDiscount] = useState<number | null>(null);
  const [finalPrice, setFinalPrice] = useState<number | null>(null);
  const [applying, setApplying] = useState(false);
  const [booking, setBooking] = useState(false);

  const plans = car?.rentalPlan ?? [];
  const selected: RentalPlan | undefined = plans.find((p) => p.id === planId) ?? plans[0];

  const estimate = useMemo(() => {
    if (!selected || !start || !end) return null;
    const periods = periodsBetween(selected.periodType, new Date(start), new Date(end));
    if (periods <= 0) return null;
    return { periods, total: periods * toNum(selected.price) };
  }, [selected, start, end]);

  if (!carId) return <EmptyState icon="no_cars" title={t("alertMessages.someThingWentWrong")} />;
  if (loading) return <PageLoading />;
  if (!car || !selected) return <EmptyState icon="no_cars" title={t("web.noPlans")} />;

  const planRef = selected.plan as Plan | undefined;

  async function applyPromo() {
    if (!code || !selected || !start || !end) return;
    setApplying(true);
    try {
      const res = await userApi.applyPromo({
        code,
        carId: car!.id,
        rentalPlanId: selected.id,
        planId: planRef?.id,
        startDate: new Date(start).toISOString(),
        endDate: new Date(end).toISOString(),
      });
      setDiscount(res.discount);
      setFinalPrice(res.finalPrice);
      toast(t("labels.discountApplied"), "success");
    } catch (err) {
      setDiscount(null);
      setFinalPrice(null);
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    } finally {
      setApplying(false);
    }
  }

  async function book() {
    if (!user) {
      toast(t("alertMessages.logInToReserve"), "info");
      router.push("/login");
      return;
    }
    if (!selected || !start || !end) {
      toast(t("web.pickDates"), "error");
      return;
    }
    setBooking(true);
    try {
      await userApi.bookCar({
        carId: car!.id,
        rentalPlanId: selected.id,
        planId: planRef?.id,
        startDate: new Date(start).toISOString(),
        endDate: new Date(end).toISOString(),
        contact: contact || undefined,
        code: code || undefined,
      });
      toast(t("alertMessages.reservationSuccess"), "success");
      router.push("/trips");
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    } finally {
      setBooking(false);
    }
  }

  const total = finalPrice ?? estimate?.total ?? 0;

  return (
    <div className="px-4 py-5">
      <h1 className="mb-4 text-xl font-extrabold">{t("screens.Booking")}</h1>
      <div className="grid gap-6 lg:grid-cols-[1fr_360px]">
        <div className="space-y-5">
          {/* Car summary */}
          <div className="flex items-center gap-3 rounded-2xl border border-surface-low p-3">
            <ImageHolder src={car.images?.[0]?.image} className="h-16 w-24" rounded="rounded-xl" />
            <div>
              <p className="font-semibold">{car.title}</p>
              <p className="text-xs text-muted">{num(car.feature?.year)} · {e.transmission(car.feature?.transmission)}</p>
            </div>
          </div>

          {/* Plan */}
          <div>
            <p className="mb-2 text-sm font-bold">{t("web.selectPlan")}</p>
            <div className="flex flex-wrap gap-2">
              {plans.map((p) => (
                <button
                  key={p.id}
                  onClick={() => { setPlanId(p.id); setDiscount(null); setFinalPrice(null); }}
                  className={`rounded-xl border px-4 py-2.5 text-sm transition ${p.id === selected.id ? "border-primary bg-primary-container" : "border-surface-low"}`}
                >
                  <span className="font-semibold">{e.period(p.periodType)}</span>
                  <span className="ms-2 text-primary">{formatNumber(p.price)} {e.currency(p.currency)}</span>
                </button>
              ))}
            </div>
          </div>

          {/* Dates */}
          <div className="grid grid-cols-1 gap-3 sm:grid-cols-2">
            <Field label={t("labels.startDate")}>
              <Input type="datetime-local" value={start} onChange={(ev) => { setStart(ev.target.value); setDiscount(null); setFinalPrice(null); }} />
            </Field>
            <Field label={t("labels.endDate")}>
              <Input type="datetime-local" value={end} onChange={(ev) => { setEnd(ev.target.value); setDiscount(null); setFinalPrice(null); }} />
            </Field>
          </div>

          {/* Contact */}
          <Field label={t("labels.contact")}>
            <Input value={contact} onChange={(ev) => setContact(ev.target.value)} placeholder="+964..." />
          </Field>

          {/* Promo */}
          <Field label={t("labels.promotionCode")}>
            <div className="flex gap-2">
              <Input value={code} onChange={(ev) => setCode(ev.target.value)} placeholder={t("labels.promotionCode")} />
              <Button variant="outline" onClick={applyPromo} loading={applying} type="button">{t("buttons.apply")}</Button>
            </div>
          </Field>
        </div>

        {/* Summary card */}
        <div className="h-fit rounded-2xl border border-surface-low p-5 lg:sticky lg:top-20">
          <p className="text-sm font-bold">{t("web.total")}</p>
          <div className="mt-3 space-y-2 text-sm">
            <Row label={e.period(selected.periodType)} value={`${formatNumber(selected.price)} ${e.currency(selected.currency)}`} />
            {estimate && <Row label={t("labels.duration")} value={`${estimate.periods}`} />}
            {discount != null && discount > 0 && (
              <Row label={t("labels.discount")} value={`- ${formatNumber(discount)}`} highlight />
            )}
            <div className="my-2 border-t border-surface-low" />
            <Row label={t("labels.totalPrice")} value={`${formatNumber(total)} ${e.currency(selected.currency)}`} bold />
          </div>
          <Button full className="mt-4" onClick={book} loading={booking}>{t("buttons.reserveNow")}</Button>
        </div>
      </div>
    </div>
  );
}

function Row({ label, value, bold, highlight }: { label: string; value: string; bold?: boolean; highlight?: boolean }) {
  return (
    <div className="flex items-center justify-between">
      <span className={highlight ? "text-tint" : "text-muted"}>{label}</span>
      <span className={`${bold ? "text-base font-bold text-on-surface" : highlight ? "font-semibold text-tint" : "font-medium text-on-surface"}`}>{value}</span>
    </div>
  );
}

export default function BookingPage() {
  return (
    <AppShell>
      <Suspense fallback={<PageLoading />}>
        <BookingInner />
      </Suspense>
    </AppShell>
  );
}
