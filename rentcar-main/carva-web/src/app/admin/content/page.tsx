"use client";

import { useState } from "react";
import { Card } from "@/components/DashboardShell";
import { Modal } from "@/components/Modal";
import { Button, Field, Input, Textarea, Chip, PageLoading, EmptyState } from "@/components/ui";
import { Icon } from "@/components/Icon";
import { ImageHolder } from "@/components/ImageHolder";
import { useAsync } from "@/lib/useAsync";
import { adminApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import { toast } from "@/components/toast";

type Tab = "brands" | "types" | "cities" | "supports" | "sliders" | "notifications";

export default function AdminContent() {
  const { t, tr } = useI18n();
  const [tab, setTab] = useState<Tab>("brands");

  const tabs: { key: Tab; label: string }[] = [
    { key: "brands", label: t("buttons.brands") },
    { key: "types", label: t("buttons.carTypes") },
    { key: "cities", label: t("buttons.cities") },
    { key: "supports", label: t("buttons.supports") },
    { key: "sliders", label: t("buttons.Slider") },
    { key: "notifications", label: t("buttons.notification") },
  ];

  return (
    <div>
      <h1 className="mb-4 text-2xl font-extrabold">{t("web.adminPanel")}</h1>
      <div className="no-scrollbar mb-5 flex gap-2 overflow-x-auto">
        {tabs.map((x) => <Chip key={x.key} label={x.label} selected={tab === x.key} onClick={() => setTab(x.key)} />)}
      </div>

      {tab === "brands" && <Brands />}
      {tab === "types" && <CarTypes />}
      {tab === "cities" && <Cities />}
      {tab === "supports" && <Supports />}
      {tab === "sliders" && <Sliders />}
      {tab === "notifications" && <Notifications />}
    </div>
  );

  /* -------- Brands -------- */
  function Brands() {
    const list = useAsync(() => adminApi.brands(), []);
    const [open, setOpen] = useState(false);
    const [f, setF] = useState({ en: "", ar: "", ku: "" });
    const [img, setImg] = useState<File | null>(null);
    const [busy, setBusy] = useState(false);
    async function create() {
      setBusy(true);
      try {
        const fd = new FormData();
        fd.append("en", f.en); fd.append("ar", f.ar); fd.append("ku", f.ku);
        if (img) fd.append("image", img);
        await adminApi.newBrand(fd);
        toast(t("alertMessages.success"), "success"); setOpen(false); setF({ en: "", ar: "", ku: "" }); setImg(null); list.refetch();
      } catch (err) { toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error"); } finally { setBusy(false); }
    }
    async function del(id: string) {
      if (!confirm(t("alertMessages.deleteBrand"))) return;
      try { await adminApi.deleteBrand(id); list.refetch(); } catch { toast(t("alertMessages.someThingWentWrong"), "error"); }
    }
    return (
      <Section onAdd={() => setOpen(true)} addLabel={t("screens.newBrand")}>
        {list.loading ? <PageLoading /> : (
          <div className="grid grid-cols-2 gap-3 sm:grid-cols-4">
            {(list.data ?? []).map((b) => (
              <Card key={b.id} className="p-3 text-center">
                <ImageHolder src={b.image} cover={false} className="mx-auto h-16 w-16 bg-white" />
                <p className="mt-2 truncate text-sm font-medium">{tr(b)}</p>
                <button onClick={() => del(b.id)} className="mt-1 text-xs text-danger">{t("buttons.delete")}</button>
              </Card>
            ))}
          </div>
        )}
        <Modal open={open} onClose={() => setOpen(false)} title={t("screens.newBrand")}>
          <div className="space-y-3">
            <Field label="English"><Input value={f.en} onChange={(e) => setF({ ...f, en: e.target.value })} /></Field>
            <Field label="عربی"><Input value={f.ar} onChange={(e) => setF({ ...f, ar: e.target.value })} /></Field>
            <Field label="کوردی"><Input value={f.ku} onChange={(e) => setF({ ...f, ku: e.target.value })} /></Field>
            <Field label={t("buttons.addImage")}><input type="file" accept="image/*" onChange={(e) => setImg(e.target.files?.[0] ?? null)} className="text-sm" /></Field>
            <Button full loading={busy} onClick={create}>{t("buttons.add")}</Button>
          </div>
        </Modal>
      </Section>
    );
  }

  /* -------- Car types -------- */
  function CarTypes() {
    const list = useAsync(() => adminApi.carTypes(), []);
    const [open, setOpen] = useState(false);
    const [f, setF] = useState({ en: "", ar: "", ku: "" });
    const [busy, setBusy] = useState(false);
    async function create() {
      setBusy(true);
      try { await adminApi.newCarType(f); toast(t("alertMessages.success"), "success"); setOpen(false); setF({ en: "", ar: "", ku: "" }); list.refetch(); }
      catch (err) { toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error"); } finally { setBusy(false); }
    }
    async function del(id: string) {
      if (!confirm(t("alertMessages.deleteCarType"))) return;
      try { await adminApi.deleteCarType(id); list.refetch(); } catch { toast(t("alertMessages.someThingWentWrong"), "error"); }
    }
    return (
      <Section onAdd={() => setOpen(true)} addLabel={t("screens.newCarType")}>
        {list.loading ? <PageLoading /> : (
          <div className="space-y-2">
            {(list.data ?? []).map((c) => (
              <Card key={c.id} className="flex items-center justify-between p-3">
                <span className="text-sm font-medium">{tr(c)}</span>
                <button onClick={() => del(c.id)}><Icon name="trash" size={16} color="#ef4444" /></button>
              </Card>
            ))}
          </div>
        )}
        <Modal open={open} onClose={() => setOpen(false)} title={t("screens.newCarType")}>
          <div className="space-y-3">
            <Field label="English"><Input value={f.en} onChange={(e) => setF({ ...f, en: e.target.value })} /></Field>
            <Field label="عربی"><Input value={f.ar} onChange={(e) => setF({ ...f, ar: e.target.value })} /></Field>
            <Field label="کوردی"><Input value={f.ku} onChange={(e) => setF({ ...f, ku: e.target.value })} /></Field>
            <Button full loading={busy} onClick={create}>{t("buttons.add")}</Button>
          </div>
        </Modal>
      </Section>
    );
  }

  /* -------- Cities -------- */
  function Cities() {
    const list = useAsync(() => adminApi.cities(), []);
    const [open, setOpen] = useState(false);
    const [f, setF] = useState({ en: "", ar: "", ku: "" });
    const [busy, setBusy] = useState(false);
    async function create() {
      setBusy(true);
      try { await adminApi.newCity(f); toast(t("alertMessages.success"), "success"); setOpen(false); setF({ en: "", ar: "", ku: "" }); list.refetch(); }
      catch (err) { toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error"); } finally { setBusy(false); }
    }
    async function del(id: string) {
      if (!confirm(t("alertMessages.deleteCity"))) return;
      try { await adminApi.deleteCity(id); list.refetch(); } catch { toast(t("alertMessages.someThingWentWrong"), "error"); }
    }
    return (
      <Section onAdd={() => setOpen(true)} addLabel={t("screens.newCity")}>
        {list.loading ? <PageLoading /> : (
          <div className="space-y-2">
            {(list.data ?? []).map((c) => (
              <Card key={c.id} className="p-3">
                <div className="flex items-center justify-between">
                  <span className="text-sm font-semibold">{tr(c)}</span>
                  <button onClick={() => del(c.id!)}><Icon name="trash" size={16} color="#ef4444" /></button>
                </div>
                {c.towns && c.towns.length > 0 && (
                  <div className="mt-2 flex flex-wrap gap-1.5">
                    {c.towns.map((tw) => <span key={tw.id} className="rounded-full bg-surface-lowest px-2 py-0.5 text-xs">{tr(tw)}</span>)}
                  </div>
                )}
              </Card>
            ))}
          </div>
        )}
        <Modal open={open} onClose={() => setOpen(false)} title={t("screens.newCity")}>
          <div className="space-y-3">
            <Field label="English"><Input value={f.en} onChange={(e) => setF({ ...f, en: e.target.value })} /></Field>
            <Field label="عربی"><Input value={f.ar} onChange={(e) => setF({ ...f, ar: e.target.value })} /></Field>
            <Field label="کوردی"><Input value={f.ku} onChange={(e) => setF({ ...f, ku: e.target.value })} /></Field>
            <Button full loading={busy} onClick={create}>{t("buttons.add")}</Button>
          </div>
        </Modal>
      </Section>
    );
  }

  /* -------- Supports -------- */
  function Supports() {
    const list = useAsync(() => adminApi.supports(), []);
    const [open, setOpen] = useState(false);
    const [f, setF] = useState({ en: "", ar: "", ku: "", content: "" });
    const [img, setImg] = useState<File | null>(null);
    const [busy, setBusy] = useState(false);
    async function create() {
      setBusy(true);
      try {
        const fd = new FormData();
        fd.append("en", f.en); fd.append("ar", f.ar); fd.append("ku", f.ku); fd.append("content", f.content);
        if (img) fd.append("image", img);
        await adminApi.newSupport(fd); toast(t("alertMessages.success"), "success"); setOpen(false); setF({ en: "", ar: "", ku: "", content: "" }); setImg(null); list.refetch();
      } catch (err) { toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error"); } finally { setBusy(false); }
    }
    async function del(id: string) {
      if (!confirm(t("alertMessages.deleteSupport"))) return;
      try { await adminApi.deleteSupport(id); list.refetch(); } catch { toast(t("alertMessages.someThingWentWrong"), "error"); }
    }
    return (
      <Section onAdd={() => setOpen(true)} addLabel={t("screens.newSupport")}>
        {list.loading ? <PageLoading /> : (
          <div className="space-y-2">
            {(list.data ?? []).map((s) => (
              <Card key={s.id} className="flex items-center justify-between p-3">
                <div><p className="text-sm font-semibold">{tr(s)}</p><p className="text-xs text-muted">{s.content}</p></div>
                <button onClick={() => del(s.id)}><Icon name="trash" size={16} color="#ef4444" /></button>
              </Card>
            ))}
          </div>
        )}
        <Modal open={open} onClose={() => setOpen(false)} title={t("screens.newSupport")}>
          <div className="space-y-3">
            <Field label="English"><Input value={f.en} onChange={(e) => setF({ ...f, en: e.target.value })} /></Field>
            <Field label="عربی"><Input value={f.ar} onChange={(e) => setF({ ...f, ar: e.target.value })} /></Field>
            <Field label="کوردی"><Input value={f.ku} onChange={(e) => setF({ ...f, ku: e.target.value })} /></Field>
            <Field label={t("inputLabels.content")}><Textarea rows={3} value={f.content} onChange={(e) => setF({ ...f, content: e.target.value })} /></Field>
            <Field label={t("buttons.addImage")}><input type="file" accept="image/*" onChange={(e) => setImg(e.target.files?.[0] ?? null)} className="text-sm" /></Field>
            <Button full loading={busy} onClick={create}>{t("buttons.add")}</Button>
          </div>
        </Modal>
      </Section>
    );
  }

  /* -------- Sliders -------- */
  function Sliders() {
    const list = useAsync(() => adminApi.sliders(), []);
    const [open, setOpen] = useState(false);
    const [url, setUrl] = useState("");
    const [img, setImg] = useState<File | null>(null);
    const [busy, setBusy] = useState(false);
    async function create() {
      setBusy(true);
      try {
        const fd = new FormData();
        fd.append("type", "url"); fd.append("available", "true");
        if (url) fd.append("url", url);
        if (img) fd.append("image", img);
        await adminApi.newSlider(fd); toast(t("alertMessages.success"), "success"); setOpen(false); setUrl(""); setImg(null); list.refetch();
      } catch (err) { toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error"); } finally { setBusy(false); }
    }
    async function del(id: string) {
      if (!confirm(t("alertMessages.deleteSlider"))) return;
      try { await adminApi.deleteSlider(id); list.refetch(); } catch { toast(t("alertMessages.someThingWentWrong"), "error"); }
    }
    return (
      <Section onAdd={() => setOpen(true)} addLabel={t("buttons.Slider")}>
        {list.loading ? <PageLoading /> : (
          <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
            {(list.data ?? []).map((s) => (
              <Card key={s.id} className="overflow-hidden">
                <ImageHolder src={s.image} className="aspect-[16/7] w-full" rounded="rounded-none" />
                <div className="flex items-center justify-between p-2">
                  <span className="truncate text-xs text-muted">{s.url ?? s.type}</span>
                  <button onClick={() => del(s.id)}><Icon name="trash" size={16} color="#ef4444" /></button>
                </div>
              </Card>
            ))}
          </div>
        )}
        <Modal open={open} onClose={() => setOpen(false)} title={t("buttons.Slider")}>
          <div className="space-y-3">
            <Field label="URL"><Input value={url} onChange={(e) => setUrl(e.target.value)} placeholder="https://" /></Field>
            <Field label={t("buttons.addImage")}><input type="file" accept="image/*" onChange={(e) => setImg(e.target.files?.[0] ?? null)} className="text-sm" /></Field>
            <Button full loading={busy} onClick={create}>{t("buttons.add")}</Button>
          </div>
        </Modal>
      </Section>
    );
  }

  /* -------- Notifications -------- */
  function Notifications() {
    const [f, setF] = useState({ enTitle: "", arTitle: "", kuTitle: "", enDescription: "", arDescription: "", kuDescription: "" });
    const [busy, setBusy] = useState(false);
    async function send() {
      setBusy(true);
      try { await adminApi.newNotification(f); toast(t("alertMessages.success"), "success"); setF({ enTitle: "", arTitle: "", kuTitle: "", enDescription: "", arDescription: "", kuDescription: "" }); }
      catch (err) { toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error"); } finally { setBusy(false); }
    }
    return (
      <Card className="max-w-2xl space-y-3 p-5">
        <h2 className="font-bold">{t("screens.notification")}</h2>
        <div className="grid grid-cols-3 gap-2">
          <Field label="Title EN"><Input value={f.enTitle} onChange={(e) => setF({ ...f, enTitle: e.target.value })} /></Field>
          <Field label="عنوان AR"><Input value={f.arTitle} onChange={(e) => setF({ ...f, arTitle: e.target.value })} /></Field>
          <Field label="ناونیشان KU"><Input value={f.kuTitle} onChange={(e) => setF({ ...f, kuTitle: e.target.value })} /></Field>
        </div>
        <div className="grid grid-cols-1 gap-2">
          <Field label="Description EN"><Textarea rows={2} value={f.enDescription} onChange={(e) => setF({ ...f, enDescription: e.target.value })} /></Field>
          <Field label="الوصف AR"><Textarea rows={2} value={f.arDescription} onChange={(e) => setF({ ...f, arDescription: e.target.value })} /></Field>
          <Field label="پێناسە KU"><Textarea rows={2} value={f.kuDescription} onChange={(e) => setF({ ...f, kuDescription: e.target.value })} /></Field>
        </div>
        <Button loading={busy} onClick={send}>{t("buttons.send")}</Button>
      </Card>
    );
  }
}

function Section({ onAdd, addLabel, children }: { onAdd: () => void; addLabel: string; children: React.ReactNode }) {
  return (
    <div>
      <div className="mb-4 flex justify-end">
        <Button onClick={onAdd}><Icon name="check" size={14} color="#fff" /> {addLabel}</Button>
      </div>
      {children}
    </div>
  );
}
