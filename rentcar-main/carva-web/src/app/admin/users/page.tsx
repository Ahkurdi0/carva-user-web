"use client";

import { useState } from "react";
import { Card } from "@/components/DashboardShell";
import { Modal } from "@/components/Modal";
import { Button, Field, Input, Chip, PageLoading, EmptyState, ErrorState } from "@/components/ui";
import { Icon } from "@/components/Icon";
import { imageUrl } from "@/lib/api";
import { useAsync } from "@/lib/useAsync";
import { adminApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import { toast } from "@/components/toast";
import { Textarea } from "@/components/ui";
import type { Profile } from "@/lib/types";

const dateInput = (d: Date) => d.toISOString().slice(0, 10);
const emptyCompany = () => ({
  name: "",
  desc: "",
  contact: "",
  international: false,
  available: true,
  activeDate: dateInput(new Date()),
  expiresAt: dateInput(new Date(Date.now() + 30 * 86400000)),
  cityId: "",
  townId: "",
  lat: "",
  long: "",
});

export default function AdminUsers() {
  const { t, tr } = useI18n();
  const [search, setSearch] = useState("");
  const [q, setQ] = useState("");
  const [role, setRole] = useState<"admin" | "user" | undefined>();
  // The backend paginates 15 at a time (cursor = last profile id). Walk every
  // page so the panel shows all users, not just the first batch.
  const users = useAsync(async () => {
    const all: Profile[] = [];
    let cursor: string | undefined;
    for (let page = 0; page < 1000; page++) {
      const batch = await adminApi.users(cursor, role, q || undefined);
      if (!batch?.length) break;
      all.push(...batch);
      if (batch.length < 15) break;
      cursor = (batch[batch.length - 1] as Profile & { id?: string }).id;
      if (!cursor) break;
    }
    return all;
  }, [role, q]);
  const perms = useAsync(() => adminApi.permissions(), []);
  const cities = useAsync(() => adminApi.cities(), []);

  const [roleUser, setRoleUser] = useState<Profile | null>(null);
  const [banUser, setBanUser] = useState<Profile | null>(null);
  const [pwdUser, setPwdUser] = useState<Profile | null>(null);
  const [newPass, setNewPass] = useState("");
  const [companyUser, setCompanyUser] = useState<Profile | null>(null);
  const [company, setCompany] = useState(emptyCompany());
  const [selPerms, setSelPerms] = useState<string[]>([]);
  const [newRole, setNewRole] = useState<"admin" | "user">("user");
  const [ban, setBan] = useState({ title: "", description: "", until: "" });
  const [busy, setBusy] = useState(false);

  function openCompany(u: Profile) {
    const c = u.company;
    const loc = (c?.location ?? null) as { lat?: number; long?: number; city?: { id?: string }; town?: { id?: string } } | null;
    setCompany(
      c
        ? {
            name: c.name ?? "",
            desc: c.desc ?? "",
            contact: c.contact ?? "",
            international: !!c.international,
            available: c.available ?? true,
            activeDate: dateInput(new Date()),
            expiresAt: dateInput(new Date(Date.now() + 30 * 86400000)),
            cityId: loc?.city?.id ?? "",
            townId: loc?.town?.id ?? "",
            lat: loc?.lat != null ? String(loc.lat) : "",
            long: loc?.long != null ? String(loc.long) : "",
          }
        : emptyCompany(),
    );
    setCompanyUser(u);
  }

  async function saveCompany() {
    if (!companyUser || !company.name.trim()) return;
    setBusy(true);
    try {
      const lat = parseFloat(company.lat);
      const long = parseFloat(company.long);
      const hasLoc = !Number.isNaN(lat) && !Number.isNaN(long);
      await adminApi.newCompany({
        id: companyUser.company?.id ?? null,
        userId: companyUser.userId,
        name: company.name.trim(),
        desc: company.desc.trim() || null,
        international: company.international,
        contact: company.contact.trim() || null,
        activeDate: new Date(company.activeDate).toISOString(),
        expiresAt: new Date(company.expiresAt).toISOString(),
        location:
          hasLoc || company.cityId
            ? { lat: hasLoc ? lat : -1, long: hasLoc ? long : -1, cityId: company.cityId || null, townId: company.townId || null }
            : null,
        available: company.available,
      });
      toast(t("alertMessages.success"), "success");
      setCompanyUser(null);
      users.refetch();
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    } finally { setBusy(false); }
  }

  function openRole(u: Profile) {
    setRoleUser(u);
    setNewRole(u.role?.roleName === "admin" ? "admin" : "user");
    setSelPerms((u.permissions ?? []).map((p) => p.permission.permissionId));
  }

  async function saveRole() {
    if (!roleUser) return;
    setBusy(true);
    try {
      await adminApi.updateRole(roleUser.userId, newRole, newRole === "admin" ? selPerms : undefined);
      toast(t("alertMessages.updated"), "success");
      setRoleUser(null);
      users.refetch();
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    } finally { setBusy(false); }
  }

  async function saveBan() {
    if (!banUser || !ban.title || !ban.until) return;
    setBusy(true);
    try {
      await adminApi.banUser(banUser.userId, ban.title, ban.description, new Date(ban.until).toISOString());
      toast(t("alertMessages.success"), "success");
      setBanUser(null);
      setBan({ title: "", description: "", until: "" });
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    } finally { setBusy(false); }
  }

  async function savePassword() {
    if (!pwdUser || newPass.length < 8) {
      toast(t("validations.password"), "error");
      return;
    }
    setBusy(true);
    try {
      await adminApi.updateUserPassword(pwdUser.userId, newPass);
      toast(t("alertMessages.updated"), "success");
      setPwdUser(null);
      setNewPass("");
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    } finally { setBusy(false); }
  }

  return (
    <div>
      <h1 className="mb-4 text-2xl font-extrabold">{t("bottomNavigation.users")}</h1>

      <div className="mb-4 flex flex-wrap items-center gap-2">
        <form onSubmit={(e) => { e.preventDefault(); setQ(search); }} className="flex flex-1 gap-2">
          <Input value={search} onChange={(e) => setSearch(e.target.value)} placeholder={t("inputHintText.searchusers")} />
          <Button variant="outline" type="submit"><Icon name="search" size={16} /></Button>
        </form>
        <Chip label={t("labels.all")} selected={!role} onClick={() => setRole(undefined)} />
        <Chip label={t("tabViews.admins")} selected={role === "admin"} onClick={() => setRole("admin")} />
        <Chip label={t("tabViews.uesrs")} selected={role === "user"} onClick={() => setRole("user")} />
      </div>

      {users.loading ? (
        <PageLoading />
      ) : users.error ? (
        <ErrorState message={users.error} onRetry={users.refetch} />
      ) : users.data && users.data.length > 0 ? (
        <div className="space-y-2">
          {users.data.map((u) => (
            <Card key={u.userId} className="flex flex-wrap items-center gap-3 p-3">
              <span className="h-10 w-10 overflow-hidden rounded-full bg-primary-container">
                {u.image ? (
                  // eslint-disable-next-line @next/next/no-img-element
                  <img src={imageUrl(u.image)} alt="" className="h-full w-full object-cover" />
                ) : <span className="grid h-full w-full place-items-center"><Icon name="profile" size={18} color="#3957d7" /></span>}
              </span>
              <div className="min-w-0 flex-1">
                <p className="truncate font-semibold">{u.name}</p>
                <p className="truncate text-xs text-muted">{u.email}{u.phoneNumber ? ` · ${u.countryCode}${u.phoneNumber}` : ""}</p>
              </div>
              {u.role?.roleName === "admin" && <span className="rounded-full bg-primary-container px-2 py-0.5 text-[11px] font-semibold text-primary">{t("buttons.admin")}</span>}
              {u.company && <span className="rounded-full bg-surface-lowest px-2 py-0.5 text-[11px] font-medium">{t("buttons.company")}</span>}
              <div className="flex gap-2">
                <Button variant="outline" className="h-9 px-3 text-xs" onClick={() => openRole(u)}>{t("buttons.role")}</Button>
                <Button variant="outline" className="h-9 px-3 text-xs" onClick={() => openCompany(u)}>{u.company ? t("buttons.editCompany") : t("buttons.newCompany")}</Button>
                <Button variant="outline" className="h-9 px-3 text-xs" onClick={() => { setPwdUser(u); setNewPass(""); }}>{t("web.changePassword")}</Button>
                <Button variant="outline" className="h-9 px-3 text-xs text-danger" onClick={() => setBanUser(u)}>{t("buttons.ban")}</Button>
              </div>
            </Card>
          ))}
        </div>
      ) : (
        <EmptyState icon="profile" title={t("empty.noUsers")} />
      )}

      {/* Role modal */}
      <Modal open={!!roleUser} onClose={() => setRoleUser(null)} title={t("buttons.role")}>
        <div className="space-y-4">
          <div className="flex gap-2">
            <Chip label={t("buttons.user")} selected={newRole === "user"} onClick={() => setNewRole("user")} />
            <Chip label={t("buttons.admin")} selected={newRole === "admin"} onClick={() => setNewRole("admin")} />
          </div>
          {newRole === "admin" && (
            <div>
              <p className="mb-2 text-sm font-medium">{t("permissions.title") !== "permissions.title" ? t("permissions.title") : "Permissions"}</p>
              <div className="flex flex-wrap gap-2">
                {(perms.data ?? []).map((p) => {
                  const sel = selPerms.includes(p.permissionId);
                  return (
                    <Chip key={p.permissionId} label={p.permissionName} selected={sel}
                      onClick={() => setSelPerms((s) => sel ? s.filter((x) => x !== p.permissionId) : [...s, p.permissionId])} />
                  );
                })}
              </div>
            </div>
          )}
          <Button full loading={busy} onClick={saveRole}>{t("buttons.update")}</Button>
        </div>
      </Modal>

      {/* Password modal */}
      <Modal open={!!pwdUser} onClose={() => setPwdUser(null)} title={t("web.changePassword")}>
        <div className="space-y-3">
          <p className="text-sm text-muted">{pwdUser?.name} · {pwdUser?.email}</p>
          <Field label={t("inputLabels.newPassword")} error={newPass && newPass.length < 8 ? t("validations.password") : undefined}>
            <Input type="password" autoComplete="new-password" value={newPass} onChange={(e) => setNewPass(e.target.value)} placeholder="••••••••" />
          </Field>
          <Button full loading={busy} disabled={newPass.length < 8} onClick={savePassword}>{t("buttons.update")}</Button>
        </div>
      </Modal>

      {/* Ban modal */}
      <Modal open={!!banUser} onClose={() => setBanUser(null)} title={t("buttons.banUser")}>
        <div className="space-y-3">
          <Field label={t("inputLabels.title")}><Input value={ban.title} onChange={(e) => setBan({ ...ban, title: e.target.value })} /></Field>
          <Field label={t("inputLabels.description")}><Input value={ban.description} onChange={(e) => setBan({ ...ban, description: e.target.value })} /></Field>
          <Field label={t("inputLabels.banUtil")}><Input type="date" value={ban.until} onChange={(e) => setBan({ ...ban, until: e.target.value })} /></Field>
          <Button full variant="danger" loading={busy} onClick={saveBan}>{t("buttons.ban")}</Button>
        </div>
      </Modal>

      {/* Company modal */}
      <Modal open={!!companyUser} onClose={() => setCompanyUser(null)} title={companyUser?.company ? t("buttons.editCompany") : t("buttons.newCompany")}>
        <div className="space-y-3">
          <Field label={t("inputLabels.name")}><Input value={company.name} onChange={(e) => setCompany({ ...company, name: e.target.value })} /></Field>
          <Field label={t("inputLabels.description")}><Textarea rows={3} value={company.desc} onChange={(e) => setCompany({ ...company, desc: e.target.value })} /></Field>
          <Field label={t("inputLabels.whatsapp")} error={t("helpers.countryCode")}>
            <Input value={company.contact} onChange={(e) => setCompany({ ...company, contact: e.target.value })} placeholder="96475Xxxxxxxx" />
          </Field>
          <div className="grid grid-cols-2 gap-3">
            <Field label={t("labels.activeDate")}><Input type="date" value={company.activeDate} onChange={(e) => setCompany({ ...company, activeDate: e.target.value })} /></Field>
            <Field label={t("labels.expireDate")}><Input type="date" value={company.expiresAt} onChange={(e) => setCompany({ ...company, expiresAt: e.target.value })} /></Field>
          </div>
          <div className="grid grid-cols-2 gap-3">
            <Field label={t("inputLabels.city")}>
              <select
                value={company.cityId}
                onChange={(e) => setCompany({ ...company, cityId: e.target.value, townId: "" })}
                className="h-12 w-full rounded-xl border border-surface-low bg-surface-lowest px-3 text-sm outline-none focus:border-primary focus:bg-white"
              >
                <option value="">{t("labels.selectACity")}</option>
                {(cities.data ?? []).map((c) => <option key={c.id} value={c.id}>{tr(c)}</option>)}
              </select>
            </Field>
            <Field label={t("inputLabels.town")}>
              <select
                value={company.townId}
                onChange={(e) => setCompany({ ...company, townId: e.target.value })}
                className="h-12 w-full rounded-xl border border-surface-low bg-surface-lowest px-3 text-sm outline-none focus:border-primary focus:bg-white disabled:opacity-50"
                disabled={!company.cityId}
              >
                <option value="">{t("labels.selectTownOptional")}</option>
                {(cities.data ?? []).find((c) => c.id === company.cityId)?.towns?.map((tw) => <option key={tw.id} value={tw.id}>{tr(tw)}</option>)}
              </select>
            </Field>
          </div>
          <div className="grid grid-cols-2 gap-3">
            <Field label="Latitude"><Input type="number" value={company.lat} onChange={(e) => setCompany({ ...company, lat: e.target.value })} placeholder="36.19" /></Field>
            <Field label="Longitude"><Input type="number" value={company.long} onChange={(e) => setCompany({ ...company, long: e.target.value })} placeholder="44.01" /></Field>
          </div>
          <label className="flex items-center gap-2 text-sm">
            <input type="checkbox" checked={company.available} onChange={(e) => setCompany({ ...company, available: e.target.checked })} />
            {t("buttons.available")}
          </label>
          <label className="flex items-center gap-2 text-sm">
            <input type="checkbox" checked={company.international} onChange={(e) => setCompany({ ...company, international: e.target.checked })} />
            {t("buttons.international")}
          </label>
          <Button full loading={busy} onClick={saveCompany}>{companyUser?.company ? t("buttons.update") : t("buttons.add")}</Button>
        </div>
      </Modal>
    </div>
  );
}
