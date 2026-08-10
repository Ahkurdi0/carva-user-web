"use client";

import { useRef, useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { AppShell } from "@/components/AppShell";
import { AuthPrompt } from "@/components/AuthPrompt";
import { Icon, type IconName } from "@/components/Icon";
import { Modal } from "@/components/Modal";
import { Button, Field, Input } from "@/components/ui";
import { useAuth } from "@/lib/auth-store";
import { useI18n, LANG_NAMES } from "@/i18n";
import { authApi, userApi } from "@/lib/services";
import { imageUrl } from "@/lib/api";
import { toast } from "@/components/toast";
import { useAsync } from "@/lib/useAsync";
import type { Lang, Support } from "@/lib/types";

function Row({ icon, label, onClick, href, danger }: { icon: IconName; label: string; onClick?: () => void; href?: string; danger?: boolean }) {
  const inner = (
    <div className={`flex items-center gap-3 rounded-xl px-3 py-3.5 transition hover:bg-surface-lowest ${danger ? "text-danger" : "text-on-surface"}`}>
      <Icon name={icon} size={20} color={danger ? "#ef4444" : "#3957d7"} />
      <span className="flex-1 text-sm font-medium">{label}</span>
      <Icon name="arrow_tail" size={16} color="#c4c4c4" />
    </div>
  );
  if (href) return <Link href={href}>{inner}</Link>;
  return <button onClick={onClick} className="w-full text-start">{inner}</button>;
}

function SupportModal({ open, onClose }: { open: boolean; onClose: () => void }) {
  const { t, tr } = useI18n();
  const { data } = useAsync<Support[]>(() => userApi.supports(), [], open);
  return (
    <Modal open={open} onClose={onClose} title={t("buttons.supprt")}>
      <div className="space-y-2">
        {(data ?? []).map((s) => (
          <a
            key={s.id}
            href={s.content}
            target="_blank"
            rel="noopener noreferrer"
            className="flex items-center justify-between gap-3 rounded-xl border border-surface-low p-3 transition hover:border-primary hover:bg-surface-lowest"
          >
            <div className="min-w-0">
              <p className="font-semibold">{tr(s)}</p>
              <p className="mt-1 truncate text-sm text-muted">{s.content}</p>
            </div>
            <Icon name="arrow" size={18} color="#9e9e9e" />
          </a>
        ))}
        {data && data.length === 0 && <p className="text-sm text-muted">{t("empty.noData")}</p>}
      </div>
    </Modal>
  );
}

export default function SettingsPage() {
  const { t, lang, setLang } = useI18n();
  const router = useRouter();
  const user = useAuth((s) => s.user);
  const setUser = useAuth((s) => s.setUser);
  const logout = useAuth((s) => s.logout);
  const isAdmin = useAuth((s) => s.isAdmin)();
  const isCompany = useAuth((s) => s.isCompany)();

  const [modal, setModal] = useState<null | "profile" | "password" | "lang" | "support">(null);
  const [name, setName] = useState(user?.name ?? "");
  const [oldPwd, setOldPwd] = useState("");
  const [newPwd, setNewPwd] = useState("");
  const [busy, setBusy] = useState(false);
  const fileRef = useRef<HTMLInputElement>(null);

  if (!user) return <AppShell><AuthPrompt /></AppShell>;

  async function saveName() {
    setBusy(true);
    try {
      await authApi.updateName(name.trim());
      setUser({ ...user!, name: name.trim() });
      toast(t("alertMessages.updated"), "success");
      setModal(null);
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    } finally { setBusy(false); }
  }

  async function savePassword() {
    setBusy(true);
    try {
      await authApi.updatePassword(oldPwd, newPwd);
      toast(t("alertMessages.updated"), "success");
      setModal(null); setOldPwd(""); setNewPwd("");
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    } finally { setBusy(false); }
  }

  async function uploadAvatar(file: File) {
    setBusy(true);
    try {
      const res = await authApi.updateProfilePicture(file);
      setUser({ ...user!, image: res.imageUrl });
      toast(t("alertMessages.updated"), "success");
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    } finally { setBusy(false); }
  }

  async function doLogout() {
    await logout();
    router.push("/");
  }

  async function deleteAccount() {
    if (!confirm(t("alertMessages.deleteAccount"))) return;
    try {
      await authApi.deleteAccount();
      setUser(null);
      router.push("/");
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    }
  }

  return (
    <AppShell>
      <div className="px-4 py-5">
        <h1 className="mb-4 text-xl font-extrabold">{t("web.settingsTitle")}</h1>

        {/* Profile header */}
        <div className="flex items-center gap-4 rounded-2xl border border-surface-low p-4">
          <button onClick={() => fileRef.current?.click()} className="relative h-16 w-16 overflow-hidden rounded-full bg-primary-container">
            {user.image ? (
              // eslint-disable-next-line @next/next/no-img-element
              <img src={imageUrl(user.image)} alt="" className="h-full w-full object-cover" />
            ) : (
              <span className="grid h-full w-full place-items-center"><Icon name="profile" size={26} color="#3957d7" /></span>
            )}
            <span className="absolute bottom-0 right-0 grid h-6 w-6 place-items-center rounded-full bg-primary text-white">
              <Icon name="edit" size={12} color="#fff" />
            </span>
          </button>
          <input ref={fileRef} type="file" accept="image/*" hidden onChange={(e) => e.target.files?.[0] && uploadAvatar(e.target.files[0])} />
          <div className="min-w-0">
            <p className="truncate text-lg font-bold">{user.name}</p>
            <p className="truncate text-sm text-muted">{user.email}</p>
          </div>
        </div>

        <div className="mt-6 space-y-1">
          <p className="px-3 pb-1 text-xs font-semibold uppercase text-muted">{t("web.account")}</p>
          <Row icon="profile" label={t("web.editProfile")} onClick={() => { setName(user.name); setModal("profile"); }} />
          <Row icon="status" label={t("web.changePassword")} onClick={() => setModal("password")} />
          <Row icon="receipt" label={t("web.myTrips")} href="/trips" />
          <Row icon="language" label={`${t("web.language")} · ${LANG_NAMES[lang]}`} onClick={() => setModal("lang")} />
          <Row icon="support" label={t("web.support")} onClick={() => setModal("support")} />

          {(isCompany || isAdmin) && (
            <>
              <p className="px-3 pb-1 pt-4 text-xs font-semibold uppercase text-muted">{t("buttons.dashbord")}</p>
              {isCompany && <Row icon="company" label={t("web.dashboard")} href="/dashboard" />}
              {isAdmin && <Row icon="settings" label={t("web.adminPanel")} href="/admin" />}
            </>
          )}

          <p className="px-3 pb-1 pt-4 text-xs font-semibold uppercase text-muted"> </p>
          <Row icon="logout" label={t("web.logout")} onClick={doLogout} danger />
          <Row icon="trash" label={t("web.deleteAccount")} onClick={deleteAccount} danger />
        </div>
      </div>

      {/* Edit profile */}
      <Modal open={modal === "profile"} onClose={() => setModal(null)} title={t("web.editProfile")}>
        <div className="space-y-4">
          <Field label={t("inputLabels.name")}>
            <Input value={name} onChange={(e) => setName(e.target.value)} />
          </Field>
          <Button full loading={busy} onClick={saveName}>{t("web.save")}</Button>
        </div>
      </Modal>

      {/* Change password */}
      <Modal open={modal === "password"} onClose={() => setModal(null)} title={t("web.changePassword")}>
        <div className="space-y-4">
          <Field label={t("inputLabels.previousPassword")}>
            <Input type="password" value={oldPwd} onChange={(e) => setOldPwd(e.target.value)} />
          </Field>
          <Field label={t("inputLabels.newPassword")}>
            <Input type="password" value={newPwd} onChange={(e) => setNewPwd(e.target.value)} minLength={8} />
          </Field>
          <Button full loading={busy} onClick={savePassword}>{t("buttons.update")}</Button>
        </div>
      </Modal>

      {/* Language */}
      <Modal open={modal === "lang"} onClose={() => setModal(null)} title={t("web.language")}>
        <div className="space-y-1">
          {(Object.keys(LANG_NAMES) as Lang[]).map((l) => (
            <button
              key={l}
              onClick={() => { setLang(l); authApi.updatePrefLang(l).catch(() => {}); setModal(null); }}
              className={`flex w-full items-center justify-between rounded-xl px-4 py-3 text-start hover:bg-surface-lowest ${l === lang ? "font-semibold text-primary" : ""}`}
            >
              {LANG_NAMES[l]}
              {l === lang && <Icon name="check" size={18} color="#3957d7" />}
            </button>
          ))}
        </div>
      </Modal>

      <SupportModal open={modal === "support"} onClose={() => setModal(null)} />
    </AppShell>
  );
}
