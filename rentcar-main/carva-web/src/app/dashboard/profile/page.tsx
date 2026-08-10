"use client";

import { useEffect, useRef, useState } from "react";
import { Card } from "@/components/DashboardShell";
import { Button, Field, Input, Textarea, PageLoading } from "@/components/ui";
import { Icon } from "@/components/Icon";
import { imageUrl } from "@/lib/api";
import { useAsync } from "@/lib/useAsync";
import { companyApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import { toast } from "@/components/toast";

export default function DashboardProfile() {
  const { t } = useI18n();
  const { data, loading } = useAsync(() => companyApi.company(), []);
  const [name, setName] = useState("");
  const [desc, setDesc] = useState("");
  const [delivery, setDelivery] = useState(false);
  const [international, setInternational] = useState(false);
  const [busy, setBusy] = useState(false);
  const [image, setImage] = useState<File | null>(null);
  const [cover, setCover] = useState<File | null>(null);
  const imgRef = useRef<HTMLInputElement>(null);

  useEffect(() => {
    if (data) {
      setName(data.name ?? "");
      setDesc(data.desc ?? "");
      setDelivery(!!data.delivery);
      setInternational(!!data.international);
    }
  }, [data]);

  if (loading) return <PageLoading />;

  async function save() {
    setBusy(true);
    try {
      const fd = new FormData();
      fd.append("name", name);
      fd.append("desc", desc);
      fd.append("delivery", String(delivery));
      fd.append("international", String(international));
      if (image) fd.append("image", image);
      if (cover) fd.append("coverImage", cover);
      await companyApi.updateCompany(fd);
      toast(t("alertMessages.updated"), "success");
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    } finally { setBusy(false); }
  }

  return (
    <div className="max-w-2xl">
      <h1 className="mb-5 text-2xl font-extrabold">{t("buttons.editCompany")}</h1>
      <Card className="space-y-4 p-5">
        <div className="flex items-center gap-4">
          <button onClick={() => imgRef.current?.click()} className="relative h-20 w-20 overflow-hidden rounded-2xl bg-primary-container">
            {image ? (
              // eslint-disable-next-line @next/next/no-img-element
              <img src={URL.createObjectURL(image)} alt="" className="h-full w-full object-cover" />
            ) : data?.image ? (
              // eslint-disable-next-line @next/next/no-img-element
              <img src={imageUrl(data.image)} alt="" className="h-full w-full object-cover" />
            ) : <span className="grid h-full w-full place-items-center"><Icon name="company" size={26} color="#3957d7" /></span>}
            <span className="absolute bottom-0 right-0 grid h-6 w-6 place-items-center rounded-full bg-primary text-white"><Icon name="edit" size={12} color="#fff" /></span>
          </button>
          <input ref={imgRef} type="file" accept="image/*" hidden onChange={(e) => setImage(e.target.files?.[0] ?? null)} />
          <div>
            <p className="text-sm font-medium">{t("buttons.addImage")}</p>
            <label className="mt-1 inline-block cursor-pointer text-sm text-primary">
              Cover image
              <input type="file" accept="image/*" hidden onChange={(e) => setCover(e.target.files?.[0] ?? null)} />
            </label>
            {cover && <p className="text-xs text-muted">{cover.name}</p>}
          </div>
        </div>

        <Field label={t("inputLabels.name")}>
          <Input value={name} onChange={(e) => setName(e.target.value)} />
        </Field>
        <Field label={t("inputLabels.description")}>
          <Textarea rows={4} value={desc} onChange={(e) => setDesc(e.target.value)} />
        </Field>

        <label className="flex items-center justify-between rounded-xl border border-surface-low px-4 py-3">
          <span className="text-sm font-medium">{t("buttons.international")}</span>
          <input type="checkbox" checked={international} onChange={(e) => setInternational(e.target.checked)} className="h-5 w-5 accent-[#3957d7]" />
        </label>
        <label className="flex items-center justify-between rounded-xl border border-surface-low px-4 py-3">
          <span className="text-sm font-medium">{t("tabViews.local")} · {t("buttons.map")}</span>
          <input type="checkbox" checked={delivery} onChange={(e) => setDelivery(e.target.checked)} className="h-5 w-5 accent-[#3957d7]" />
        </label>

        <Button full loading={busy} onClick={save}>{t("buttons.updateCompany")}</Button>
      </Card>
    </div>
  );
}
