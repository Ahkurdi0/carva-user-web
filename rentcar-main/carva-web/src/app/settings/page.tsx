"use client";

import { useEffect, useRef, useState } from "react";
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
import type { Lang } from "@/lib/types";
import { disablePush, enablePush, pushConfigured, pushState, type PushState } from "@/lib/push";
import { KycBadge } from "@/components/KycBadge";
import { SupportModal } from "@/components/SupportModal";
import { ResidencyChoice, residencyComplete, type Residency } from "@/components/ResidencyChoice";
import { countryName, flag } from "@/lib/countries";

function Row({ icon, label, onClick, href, danger }: { icon: IconName; label: string; onClick?: () => void; href?: string; danger?: boolean }) {
  const inner = (
    <div className={`flex items-center gap-3 rounded-xl px-3 py-3.5 transition hover:bg-surface-lowest ${danger ? "text-danger" : "text-on-surface"}`}>
      <Icon name={icon} size={20} color={danger ? "#ef4444" : "#B51219"} />
      <span className="flex-1 text-sm font-medium">{label}</span>
      <Icon name="arrow_tail" size={16} color="#c4c4c4" />
    </div>
  );
  if (href) return <Link href={href}>{inner}</Link>;
  return <button onClick={onClick} className="w-full text-start">{inner}</button>;
}


export default function SettingsPage() {
  const { t, lang, setLang } = useI18n();
  const router = useRouter();
  const user = useAuth((s) => s.user);
  const setUser = useAuth((s) => s.setUser);
  const logout = useAuth((s) => s.logout);
  const signOutLocal = useAuth((s) => s.signOutLocal);

  const [modal, setModal] = useState<null | "profile" | "password" | "lang" | "support" | "residency" | "delete">(null);
  const [residency, setResidency] = useState<Residency>({ residency: null, homeCountry: null });
  const [name, setName] = useState(user?.name ?? "");
  const [oldPwd, setOldPwd] = useState("");
  const [newPwd, setNewPwd] = useState("");
  const [busy, setBusy] = useState(false);
  const fileRef = useRef<HTMLInputElement>(null);
  const [push, setPush] = useState<PushState | null>(null);

  useEffect(() => {
    if (user && pushConfigured()) pushState().then(setPush);
  }, [user]);

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

  async function saveResidency() {
    if (!residencyComplete(residency)) return;
    setBusy(true);
    try {
      await authApi.updateResidency(residency.residency!, residency.homeCountry ?? undefined);
      setUser({ ...user!, residency: residency.residency, homeCountry: residency.residency === "visitor" ? residency.homeCountry : null });
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

  async function togglePush() {
    if (push === "blocked") {
      toast(t("web.notificationsBlockedHelp"), "error");
      return;
    }
    if (push === "unsupported") {
      toast(t("web.notificationsUnsupported"), "error");
      return;
    }
    setPush(push === "on" ? await disablePush() : await enablePush());
  }

  const pushLabel =
    push === "on"
      ? t("web.notificationsOn")
      : push === "blocked"
        ? t("web.notificationsBlocked")
        : push === "unsupported"
          ? t("web.notificationsUnsupported")
          : t("web.notificationsOff");

  async function doLogout() {
    await logout();
    router.push("/");
  }

  // Same as the app: a clear warning first; once deleted, signed out here at once.
  async function deleteAccount() {
    setBusy(true);
    try {
      await authApi.deleteAccount();
      signOutLocal();
      setModal(null);
      toast(t("v2.accountDeleted"), "success");
      router.replace("/");
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    } finally {
      setBusy(false);
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
              <span className="grid h-full w-full place-items-center"><Icon name="profile" size={26} color="#B51219" /></span>
            )}
            <span className="absolute bottom-0 right-0 grid h-6 w-6 place-items-center rounded-full bg-primary text-white">
              <Icon name="edit" size={12} color="#fff" />
            </span>
          </button>
          <input ref={fileRef} type="file" accept="image/*" hidden onChange={(e) => e.target.files?.[0] && uploadAvatar(e.target.files[0])} />
          <div className="min-w-0">
            <p className="truncate text-lg font-bold">{user.name}</p>
            <p className="truncate text-sm text-muted">{user.email}</p>
            <div className="mt-1"><KycBadge status={user.kycStatus} level={user.kycLevel} showPending small /></div>
          </div>
        </div>

        {/* Identity check: easy to find until it's done */}
        {user.kycStatus !== "verified" && (
          <Link
            href="/verify"
            className="mt-4 flex items-center gap-3 rounded-2xl bg-sky-500/10 p-4 ring-1 ring-sky-500/20 transition hover:bg-sky-500/15"
          >
            <span className="grid h-11 w-11 shrink-0 place-items-center rounded-full bg-sky-600 text-white">
              <Icon name="checked" size={20} color="#fff" />
            </span>
            <span className="min-w-0 flex-1">
              <span className="block font-bold text-on-surface">{t("v2.kycIntroTitle")}</span>
              <span className="mt-0.5 block text-sm text-muted">
                {user.kycStatus === "pending" ? t("v2.verifyPendingCard") : t("v2.kycIntro")}
              </span>
            </span>
            {user.kycStatus !== "pending" && (
              <span className="hidden shrink-0 rounded-full bg-sky-600 px-4 py-2 text-sm font-semibold text-white sm:inline">{t("v2.verifyCardBtn")}</span>
            )}
          </Link>
        )}

        <div className="mt-6 space-y-1">
          <p className="px-3 pb-1 text-xs font-semibold uppercase text-muted">{t("web.account")}</p>
          <Row icon="profile" label={t("web.editProfile")} onClick={() => { setName(user.name); setModal("profile"); }} />
          <Row icon="status" label={t("web.changePassword")} onClick={() => setModal("password")} />
          <Row icon="receipt" label={t("web.myTrips")} href="/trips" />
          <Row
            icon="checked"
            label={`${t("v2.kycRow")}${user.kycStatus === "verified" ? " · ✓" : user.kycStatus === "pending" ? ` · ${t("v2.badgePending")}` : ""}`}
            href="/verify"
          />
          <Row
            icon="location_p"
            label={`${t("v2.residencyRow")} · ${
              user.residency === "iraq" ? "🇮🇶" : user.residency === "visitor" && user.homeCountry ? `${flag(user.homeCountry)} ${countryName(user.homeCountry, lang)}` : "—"
            }`}
            onClick={() => { setResidency({ residency: user.residency ?? null, homeCountry: user.homeCountry ?? null }); setModal("residency"); }}
          />
          <Row icon="language" label={`${t("web.language")} · ${LANG_NAMES[lang]}`} onClick={() => setModal("lang")} />
          {push && <Row icon="notification" label={`${t("web.notifications")} · ${pushLabel}`} onClick={togglePush} />}
          <Row icon="support" label={t("web.support")} onClick={() => setModal("support")} />
          <Row icon="receipt" label={t("v2.terms")} href="/terms" />
          <Row icon="status" label={t("v2.privacy")} href="/privacy" />

          <p className="px-3 pb-1 pt-4 text-xs font-semibold uppercase text-muted"> </p>
          <Row icon="logout" label={t("web.logout")} onClick={doLogout} danger />
          <Row icon="trash" label={t("web.deleteAccount")} onClick={() => setModal("delete")} danger />
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
              {l === lang && <Icon name="check" size={18} color="#B51219" />}
            </button>
          ))}
        </div>
      </Modal>

      {/* Where you live */}
      <Modal open={modal === "residency"} onClose={() => setModal(null)} title={t("v2.whereLive")}>
        <ResidencyChoice value={residency} onChange={setResidency} />
        <Button full className="mt-5" loading={busy} disabled={!residencyComplete(residency)} onClick={saveResidency}>{t("v2.save")}</Button>
      </Modal>

      <SupportModal open={modal === "support"} onClose={() => setModal(null)} />

      {/* Delete account: clear warning */}
      <Modal open={modal === "delete"} onClose={() => !busy && setModal(null)} title={t("web.deleteAccount")}>
        <div className="flex flex-col items-center text-center">
          <span className="grid h-14 w-14 place-items-center rounded-full bg-red-50">
            <Icon name="trash" size={26} color="#ef4444" />
          </span>
          <p className="mt-4 text-[15px] leading-relaxed text-on-surface">{t("v2.deleteConfirm")}</p>
        </div>
        <div className="mt-6 grid grid-cols-2 gap-2.5">
          <Button variant="outline" full disabled={busy} onClick={() => setModal(null)}>{t("v2.cancel")}</Button>
          <Button variant="danger" full loading={busy} onClick={deleteAccount}>{t("v2.deleteBtn")}</Button>
        </div>
      </Modal>
    </AppShell>
  );
}
