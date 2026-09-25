"use client";

import { useEffect, useState } from "react";
import { Modal } from "@/components/Modal";
import { Button, Field, Input, Textarea, Toggle } from "@/components/ui";
import { Icon } from "@/components/Icon";
import { LocationPicker } from "@/components/LocationPicker";
import { imageUrl } from "@/lib/api";
import { useAsync } from "@/lib/useAsync";
import { adminApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import { toast } from "@/components/toast";
import type { CarLocation, Company, Profile } from "@/lib/types";

const dateInput = (d: Date) => d.toISOString().slice(0, 10);

type FormState = {
  name: string;
  desc: string;
  contact: string;
  international: boolean;
  delivery: boolean;
  available: boolean;
  activeDate: string;
  expiresAt: string;
  cityId: string;
  townId: string;
  lat: string;
  long: string;
};

const emptyForm = (): FormState => ({
  name: "",
  desc: "",
  contact: "",
  international: false,
  delivery: false,
  available: true,
  activeDate: dateInput(new Date()),
  expiresAt: dateInput(new Date(Date.now() + 30 * 86400000)),
  cityId: "",
  townId: "",
  lat: "",
  long: "",
});

// Company.location is either a bare {lat,long} or the richer CarLocation shape.
function asCarLocation(loc: Company["location"]): CarLocation | null {
  if (loc && typeof loc === "object" && ("city" in loc || "town" in loc)) {
    return loc as CarLocation;
  }
  return loc as CarLocation | null;
}

function fromCompany(c: Company): FormState {
  const loc = asCarLocation(c.location);
  return {
    name: c.name ?? "",
    desc: c.desc ?? "",
    contact: c.contact ?? "",
    international: !!c.international,
    delivery: !!c.delivery,
    available: c.available ?? true,
    activeDate: dateInput(c.activeDate ? new Date(c.activeDate) : new Date()),
    expiresAt: dateInput(
      c.expiresAt ? new Date(c.expiresAt) : new Date(Date.now() + 30 * 86400000),
    ),
    cityId: loc?.city?.id ?? "",
    townId: loc?.town?.id ?? "",
    lat: loc?.lat != null && loc.lat !== -1 ? String(loc.lat) : "",
    long: loc?.long != null && loc.long !== -1 ? String(loc.long) : "",
  };
}

export function CompanyFormModal({
  open,
  company,
  onClose,
  onSaved,
  userId,
}: {
  open: boolean;
  /** When provided the modal edits this company; otherwise it creates a new one. */
  company?: Company | null;
  onClose: () => void;
  onSaved: () => void;
  /** Owner id, required when creating a new company. */
  userId?: string;
}) {
  const { t, tr } = useI18n();
  const cities = useAsync(() => adminApi.cities(), []);
  const editing = !!company;
  const [form, setForm] = useState<FormState>(emptyForm());
  const [busy, setBusy] = useState(false);

  // Owner selection — only relevant when creating without a fixed `userId`.
  const needsOwnerPicker = !company && !userId;
  const [ownerSel, setOwnerSel] = useState<Profile | null>(null);
  const [search, setSearch] = useState("");
  const [q, setQ] = useState("");
  const owners = useAsync(
    () => adminApi.users(undefined, "user", q || undefined),
    [q],
    needsOwnerPicker && open && !ownerSel,
  );

  // Reset / hydrate whenever the modal opens (or the target company changes).
  useEffect(() => {
    if (!open) return;
    setForm(company ? fromCompany(company) : emptyForm());
    setOwnerSel(null);
    setSearch("");
    setQ("");
  }, [open, company]);

  const owner = company?.userId ?? company?.profile?.userId ?? userId ?? ownerSel?.userId;

  async function save() {
    if (!form.name.trim()) {
      toast(t("validations.required"), "error");
      return;
    }
    if (!owner) {
      toast(t("alertMessages.someThingWentWrong"), "error");
      return;
    }
    setBusy(true);
    try {
      const lat = parseFloat(form.lat);
      const long = parseFloat(form.long);
      const hasLoc = !Number.isNaN(lat) && !Number.isNaN(long);
      await adminApi.newCompany({
        id: company?.id ?? null,
        userId: owner,
        name: form.name.trim(),
        desc: form.desc.trim() || null,
        international: form.international,
        delivery: form.delivery,
        contact: form.contact.trim() || null,
        activeDate: new Date(form.activeDate).toISOString(),
        expiresAt: new Date(form.expiresAt).toISOString(),
        location:
          hasLoc || form.cityId
            ? {
                lat: hasLoc ? lat : -1,
                long: hasLoc ? long : -1,
                cityId: form.cityId || null,
                townId: form.townId || null,
              }
            : null,
        available: form.available,
      });
      toast(t("alertMessages.success"), "success");
      onSaved();
      onClose();
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    } finally {
      setBusy(false);
    }
  }

  const selectCls =
    "h-12 w-full rounded-xl border border-surface-low bg-surface-lowest px-3 text-sm outline-none focus:border-primary focus:bg-white disabled:opacity-50";

  return (
    <Modal open={open} onClose={onClose} title={editing ? t("buttons.editCompany") : t("buttons.newCompany")}>
      <div className="space-y-3">
        {company?.profile?.name && (
          <p className="text-xs text-muted">
            {t("buttons.company")}: <span className="font-medium text-on-surface">{company.profile.name}</span>
            {company.profile.email ? ` · ${company.profile.email}` : ""}
          </p>
        )}

        {/* Owner picker — choose the user the new company belongs to. */}
        {needsOwnerPicker && (
          <Field label={t("buttons.company") + " · " + t("inputLabels.name")}>
            {ownerSel ? (
              <div className="flex items-center gap-2 rounded-xl border border-surface-low bg-surface-lowest px-3 py-2">
                <span className="h-8 w-8 overflow-hidden rounded-full bg-primary-container">
                  {ownerSel.image ? (
                    // eslint-disable-next-line @next/next/no-img-element
                    <img src={imageUrl(ownerSel.image)} alt="" className="h-full w-full object-cover" />
                  ) : (
                    <span className="grid h-full w-full place-items-center"><Icon name="profile" size={15} color="#3957d7" /></span>
                  )}
                </span>
                <div className="min-w-0 flex-1">
                  <p className="truncate text-sm font-medium">{ownerSel.name}</p>
                  <p className="truncate text-xs text-muted">{ownerSel.email}</p>
                </div>
                <button type="button" onClick={() => setOwnerSel(null)} className="grid h-7 w-7 shrink-0 place-items-center rounded-full bg-surface-lowest" aria-label={t("buttons.cancel")}>
                  <Icon name="cancel" size={13} />
                </button>
              </div>
            ) : (
              <>
                <form onSubmit={(e) => { e.preventDefault(); setQ(search); }} className="flex gap-2">
                  <Input value={search} onChange={(e) => setSearch(e.target.value)} placeholder={t("inputHintText.searchusers")} />
                  <Button variant="outline" type="submit"><Icon name="search" size={16} /></Button>
                </form>
                <div className="mt-2 max-h-44 space-y-1 overflow-y-auto">
                  {owners.loading ? (
                    <p className="px-1 py-2 text-xs text-muted">…</p>
                  ) : (owners.data ?? []).length > 0 ? (
                    (owners.data ?? []).map((u) => (
                      <button
                        type="button"
                        key={u.userId}
                        onClick={() => setOwnerSel(u)}
                        className="flex w-full items-center gap-2 rounded-lg px-2 py-1.5 text-left transition hover:bg-surface-lowest"
                      >
                        <span className="h-7 w-7 shrink-0 overflow-hidden rounded-full bg-primary-container">
                          {u.image ? (
                            // eslint-disable-next-line @next/next/no-img-element
                            <img src={imageUrl(u.image)} alt="" className="h-full w-full object-cover" />
                          ) : (
                            <span className="grid h-full w-full place-items-center"><Icon name="profile" size={13} color="#3957d7" /></span>
                          )}
                        </span>
                        <span className="min-w-0 flex-1">
                          <span className="block truncate text-sm font-medium">{u.name}</span>
                          <span className="block truncate text-xs text-muted">{u.email}</span>
                        </span>
                        {u.company && (
                          <span className="shrink-0 rounded-full bg-surface-lowest px-2 py-0.5 text-[10px] font-medium text-muted">
                            {t("buttons.company")}
                          </span>
                        )}
                      </button>
                    ))
                  ) : (
                    <p className="px-1 py-2 text-xs text-muted">{t("empty.noUsers")}</p>
                  )}
                </div>
              </>
            )}
          </Field>
        )}

        <Field label={t("inputLabels.name")}>
          <Input value={form.name} onChange={(e) => setForm({ ...form, name: e.target.value })} />
        </Field>
        <Field label={t("inputLabels.description")}>
          <Textarea rows={3} value={form.desc} onChange={(e) => setForm({ ...form, desc: e.target.value })} />
        </Field>
        <Field label={t("inputLabels.whatsapp")} error={t("helpers.countryCode")}>
          <Input value={form.contact} onChange={(e) => setForm({ ...form, contact: e.target.value })} placeholder="96475Xxxxxxxx" />
        </Field>

        <div className="grid grid-cols-2 gap-3">
          <Field label={t("labels.activeDate")}>
            <Input type="date" value={form.activeDate} onChange={(e) => setForm({ ...form, activeDate: e.target.value })} />
          </Field>
          <Field label={t("labels.expireDate")}>
            <Input type="date" value={form.expiresAt} onChange={(e) => setForm({ ...form, expiresAt: e.target.value })} />
          </Field>
        </div>

        <div className="grid grid-cols-2 gap-3">
          <Field label={t("inputLabels.city")}>
            <select
              value={form.cityId}
              onChange={(e) => setForm({ ...form, cityId: e.target.value, townId: "" })}
              className={selectCls}
            >
              <option value="">{t("labels.selectACity")}</option>
              {(cities.data ?? []).map((c) => <option key={c.id} value={c.id}>{tr(c)}</option>)}
            </select>
          </Field>
          <Field label={t("inputLabels.town")}>
            <select
              value={form.townId}
              onChange={(e) => setForm({ ...form, townId: e.target.value })}
              className={selectCls}
              disabled={!form.cityId}
            >
              <option value="">{t("labels.selectTownOptional")}</option>
              {(cities.data ?? []).find((c) => c.id === form.cityId)?.towns?.map((tw) => (
                <option key={tw.id} value={tw.id}>{tr(tw)}</option>
              ))}
            </select>
          </Field>
        </div>

        <Field label={t("buttons.setLocation")}>
          <LocationPicker
            lat={form.lat ? Number(form.lat) : null}
            long={form.long ? Number(form.long) : null}
            onPick={(la, lo) => setForm((f) => ({ ...f, lat: la.toFixed(6), long: lo.toFixed(6) }))}
          />
        </Field>
        <div className="grid grid-cols-2 gap-3">
          <Field label="Latitude">
            <Input type="number" value={form.lat} onChange={(e) => setForm({ ...form, lat: e.target.value })} placeholder="36.19" />
          </Field>
          <Field label="Longitude">
            <Input type="number" value={form.long} onChange={(e) => setForm({ ...form, long: e.target.value })} placeholder="44.01" />
          </Field>
        </div>

        <label className="flex items-center justify-between gap-2 text-sm font-medium">
          {t("buttons.available")}
          <Toggle checked={form.available} onChange={(v) => setForm({ ...form, available: v })} label={t("buttons.available")} />
        </label>
        <label className="flex items-center justify-between gap-2 text-sm font-medium">
          {t("buttons.international")}
          <Toggle checked={form.international} onChange={(v) => setForm({ ...form, international: v })} label={t("buttons.international")} />
        </label>
        <label className="flex items-center justify-between gap-2 text-sm font-medium">
          {t("tabViews.local")}
          <Toggle checked={form.delivery} onChange={(v) => setForm({ ...form, delivery: v })} label={t("tabViews.local")} />
        </label>

        <Button full loading={busy} onClick={save}>{editing ? t("buttons.update") : t("buttons.add")}</Button>
      </div>
    </Modal>
  );
}
