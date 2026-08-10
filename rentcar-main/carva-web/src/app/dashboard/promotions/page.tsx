"use client";

import { useState } from "react";
import { Card } from "@/components/DashboardShell";
import { Modal } from "@/components/Modal";
import { Button, Field, Input, PageLoading, EmptyState } from "@/components/ui";
import { Icon } from "@/components/Icon";
import { useAsync } from "@/lib/useAsync";
import { companyApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import { formatDate, formatNumber } from "@/lib/format";
import { toast } from "@/components/toast";

export default function DashboardPromotions() {
  const { t } = useI18n();
  const promos = useAsync(() => companyApi.promotions(), []);
  const cars = useAsync(() => companyApi.getCars(), []);
  const [open, setOpen] = useState(false);
  const [busy, setBusy] = useState(false);
  const [form, setForm] = useState({
    carId: "", code: "", priceType: "fixed", type: "car", value: "",
    maxUses: "100", maxUsePerUser: "1", startDate: "", endDate: "",
  });

  async function create() {
    if (!form.carId || form.code.length < 8 || !form.value || !form.startDate || !form.endDate) {
      toast(t("alertMessages.someThingWentWrong"), "error");
      return;
    }
    setBusy(true);
    try {
      await companyApi.newPromotion({
        carId: form.carId,
        code: form.code,
        priceType: form.priceType,
        type: form.type,
        value: Number(form.value),
        maxUses: Number(form.maxUses),
        maxUsePerUser: Number(form.maxUsePerUser),
        startDate: new Date(form.startDate).toISOString(),
        endDate: new Date(form.endDate).toISOString(),
        available: true,
      });
      toast(t("alertMessages.success"), "success");
      setOpen(false);
      promos.refetch();
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    } finally { setBusy(false); }
  }

  async function remove(id: string) {
    if (!confirm(t("alertMessages.deletePromotion"))) return;
    try {
      await companyApi.deletePromotion(id);
      promos.refetch();
      toast(t("alertMessages.deleted"), "success");
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    }
  }

  return (
    <div>
      <div className="mb-5 flex items-center justify-between">
        <h1 className="text-2xl font-extrabold">{t("labels.promotions")}</h1>
        <Button onClick={() => setOpen(true)}><Icon name="filter" size={16} color="#fff" /> {t("screens.newPromotion")}</Button>
      </div>

      {promos.loading ? (
        <PageLoading />
      ) : promos.data && promos.data.length > 0 ? (
        <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
          {promos.data.map((p) => {
            const pr = p as Record<string, unknown>;
            return (
              <Card key={String(pr.id)} className="p-4">
                <div className="flex items-start justify-between">
                  <span className="rounded-lg bg-primary-container px-2.5 py-1 text-sm font-bold uppercase tracking-wider text-primary">{String(pr.code)}</span>
                  <button onClick={() => remove(String(pr.id))}><Icon name="trash" size={16} color="#ef4444" /></button>
                </div>
                <p className="mt-3 text-lg font-extrabold">
                  {pr.priceType === "percentage" ? `${formatNumber(pr.value as number)}%` : formatNumber(pr.value as number)}
                </p>
                <p className="text-xs text-muted">{formatDate(pr.startDate as string)} → {formatDate(pr.endDate as string)}</p>
                <p className="mt-1 text-xs text-muted">{String(pr.usesCount ?? 0)}/{String(pr.maxUses ?? "∞")}</p>
              </Card>
            );
          })}
        </div>
      ) : (
        <EmptyState icon="filter" title={t("empty.noData")} />
      )}

      <Modal open={open} onClose={() => setOpen(false)} title={t("screens.newPromotion")}>
        <div className="space-y-3">
          <Field label={t("labels.cars")}>
            <select className="h-12 w-full rounded-xl border border-surface-low bg-surface-lowest px-3 text-sm" value={form.carId} onChange={(e) => setForm({ ...form, carId: e.target.value })}>
              <option value="">—</option>
              {(cars.data ?? []).map((c) => <option key={c.id} value={c.id}>{c.title}</option>)}
            </select>
          </Field>
          <Field label={t("inputLabels.code")}>
            <Input value={form.code} onChange={(e) => setForm({ ...form, code: e.target.value })} minLength={8} maxLength={15} />
          </Field>
          <div className="grid grid-cols-2 gap-3">
            <Field label={t("labels.promotionType")}>
              <select className="h-12 w-full rounded-xl border border-surface-low bg-surface-lowest px-3 text-sm" value={form.priceType} onChange={(e) => setForm({ ...form, priceType: e.target.value })}>
                <option value="fixed">{t("labels.fixed")}</option>
                <option value="percentage">{t("labels.percentage")}</option>
              </select>
            </Field>
            <Field label={t("labels.value")}>
              <Input value={form.value} onChange={(e) => setForm({ ...form, value: e.target.value })} inputMode="numeric" />
            </Field>
          </div>
          <div className="grid grid-cols-2 gap-3">
            <Field label={t("inputLabels.maxUses")}><Input value={form.maxUses} onChange={(e) => setForm({ ...form, maxUses: e.target.value })} inputMode="numeric" /></Field>
            <Field label={t("inputLabels.maxPerUser")}><Input value={form.maxUsePerUser} onChange={(e) => setForm({ ...form, maxUsePerUser: e.target.value })} inputMode="numeric" /></Field>
          </div>
          <div className="grid grid-cols-2 gap-3">
            <Field label={t("inputLabels.startDate")}><Input type="date" value={form.startDate} onChange={(e) => setForm({ ...form, startDate: e.target.value })} /></Field>
            <Field label={t("inputLabels.expiresAt")}><Input type="date" value={form.endDate} onChange={(e) => setForm({ ...form, endDate: e.target.value })} /></Field>
          </div>
          <Button full loading={busy} onClick={create}>{t("buttons.add")}</Button>
        </div>
      </Modal>
    </div>
  );
}
