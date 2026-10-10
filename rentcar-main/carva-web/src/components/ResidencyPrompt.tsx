"use client";

import { useEffect, useState } from "react";
import { usePathname } from "next/navigation";
import { Modal } from "./Modal";
import { Button } from "./ui";
import { toast } from "./toast";
import { ResidencyChoice, residencyComplete, type Residency } from "./ResidencyChoice";
import { useI18n } from "@/i18n";
import { useAuth } from "@/lib/auth-store";
import { authApi } from "@/lib/services";

const LATER_KEY = "carva.residencyLater";
const AGAIN_MS = 7 * 24 * 3600 * 1000;
const SKIP = ["/login", "/signup", "/reset"];

/**
 * Accounts made before sign-up asked "where do you live?" get asked once,
 * after login (Later = again in a week). Same question as the app.
 */
export function ResidencyPrompt() {
  const { t } = useI18n();
  const user = useAuth((s) => s.user);
  const setUser = useAuth((s) => s.setUser);
  const path = usePathname();
  const [open, setOpen] = useState(false);
  const [value, setValue] = useState<Residency>({ residency: null, homeCountry: null });
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    if (!user || user.residency || SKIP.some((p) => path?.startsWith(p))) return;
    let later = 0;
    try {
      later = Number(localStorage.getItem(LATER_KEY) || 0);
    } catch {}
    if (Date.now() - later < AGAIN_MS) return;
    const id = setTimeout(() => setOpen(true), 1500);
    return () => clearTimeout(id);
  }, [user, path]);

  const later = () => {
    try {
      localStorage.setItem(LATER_KEY, String(Date.now()));
    } catch {}
    setOpen(false);
  };

  async function save() {
    if (!user || !residencyComplete(value)) return;
    setSaving(true);
    try {
      await authApi.updateResidency(value.residency!, value.homeCountry ?? undefined);
      setUser({ ...user, residency: value.residency, homeCountry: value.residency === "visitor" ? value.homeCountry : null });
      toast(t("v2.saved"), "success");
      setOpen(false);
    } catch (e) {
      toast(e instanceof Error ? e.message : t("alertMessages.someThingWentWrong"), "error");
    } finally {
      setSaving(false);
    }
  }

  return (
    <Modal open={open} onClose={later} title={t("v2.whereLive")}>
      <p className="-mt-2 mb-4 text-sm text-muted">{t("v2.whereLiveSub")}</p>
      <ResidencyChoice value={value} onChange={setValue} />
      <div className="mt-5 space-y-2">
        <Button full loading={saving} disabled={!residencyComplete(value)} onClick={save}>
          {t("v2.save")}
        </Button>
        <Button full variant="ghost" onClick={later}>
          {t("v2.later")}
        </Button>
      </div>
    </Modal>
  );
}
