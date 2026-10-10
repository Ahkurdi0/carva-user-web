"use client";

import { useEffect, useMemo, useRef, useState } from "react";
import { AppShell } from "@/components/AppShell";
import { AuthPrompt } from "@/components/AuthPrompt";
import { KycBadge } from "@/components/KycBadge";
import { CountryList } from "@/components/ResidencyChoice";
import { Button, PageLoading } from "@/components/ui";
import { toast } from "@/components/toast";
import { useI18n } from "@/i18n";
import { useAuth } from "@/lib/auth-store";
import { allCountries, countryName, flag, visitorCountries } from "@/lib/countries";
import { preparePhoto, type PhotoResult } from "@/lib/photo-check";
import { kycApi, type KycSlot, type KycState } from "@/lib/services";

type Shot = PhotoResult | "kept";
type Step = "intro" | "doc" | "license" | "selfie" | "review";
const STEP_LABEL: Record<Step, string> = { intro: "v2.start", doc: "v2.stepDoc", license: "v2.stepLicense", selfie: "v2.stepSelfie", review: "v2.stepReview" };

/**
 * Identity check (optional), same as the app: ID (Iraqis: Iraqi national
 * ID; visitors: their country's ID or passport), driving licence from any
 * country or "I don't have one", a selfie, then review and send. Photos are
 * checked in the browser first (blurry / dark / glare).
 */
export default function VerifyPage() {
  const { t, lang } = useI18n();
  const user = useAuth((s) => s.user);
  const setUser = useAuth((s) => s.setUser);
  const [state, setState] = useState<KycState | null>(null);
  const [loading, setLoading] = useState(true);
  const [step, setStep] = useState<Step>("intro");
  const [flow, setFlow] = useState(false);

  const [docType, setDocType] = useState<"national_id" | "passport">("national_id");
  const [docCountry, setDocCountry] = useState<string | null>(null);
  const [hasLicense, setHasLicense] = useState<boolean | null>(null);
  const [licenseCountry, setLicenseCountry] = useState<string | null>("IQ");
  const [shots, setShots] = useState<Partial<Record<KycSlot, Shot>>>({});
  const [sending, setSending] = useState(false);

  const apply = (s: KycState) => {
    setState(s);
    if (user) {
      setUser({
        ...user,
        kycStatus: s.status === "none" ? null : s.status,
        kycLevel: s.level,
        kycVerifiedAt: s.verifiedAt,
      });
    }
  };

  useEffect(() => {
    if (!user) return;
    kycApi
      .status()
      .then((s) => {
        setState(s);
        setDocCountry(s.rules.docCountry);
      })
      .catch((e) => toast(e instanceof Error ? e.message : t("alertMessages.someThingWentWrong"), "error"))
      .finally(() => setLoading(false));
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [user?.userId]);

  // Release photo previews.
  useEffect(
    () => () =>
      Object.values(shots).forEach((s) => {
        if (s && s !== "kept") URL.revokeObjectURL(s.url);
      }),
    // eslint-disable-next-line react-hooks/exhaustive-deps
    [],
  );

  if (!user) return <AppShell><AuthPrompt /></AppShell>;
  if (loading || !state) return <AppShell><PageLoading /></AppShell>;

  const visitor = state.rules.docTypes.includes("passport");
  const reusable = new Set(state.status === "rejected" ? state.reusable : []);

  const startFlow = (again: boolean) => {
    const kept: Partial<Record<KycSlot, Shot>> = {};
    if (again && state.latest) {
      for (const s of reusable) kept[s] = "kept";
      setDocType((state.latest.docType as "national_id" | "passport") ?? "national_id");
      setHasLicense(state.latest.hasLicense);
    }
    setShots(kept);
    setFlow(true);
    setStep("doc");
  };

  const needed: KycSlot[] = [
    "idFront",
    ...(docType === "national_id" ? (["idBack"] as KycSlot[]) : []),
    ...(hasLicense ? (["licenseFront"] as KycSlot[]) : []),
    "selfie",
  ];
  const ready = needed.every((s) => shots[s]);

  async function send() {
    if (!ready || hasLicense === null) return;
    setSending(true);
    try {
      const fd = new FormData();
      fd.append("docType", docType);
      if (visitor && docCountry) fd.append("docCountry", docCountry);
      fd.append("hasLicense", String(hasLicense));
      if (hasLicense && licenseCountry) fd.append("licenseCountry", licenseCountry);
      const keep: KycSlot[] = [];
      const checks: Record<string, unknown> = { client: "web" };
      for (const [slot, shot] of Object.entries(shots) as [KycSlot, Shot][]) {
        if (!needed.includes(slot) && slot !== "licenseBack") continue;
        if (slot === "licenseBack" && !hasLicense) continue;
        if (shot === "kept") keep.push(slot);
        else {
          fd.append(slot, shot.blob, `${slot}.jpg`);
          checks[`${slot}.sharp`] = shot.sharp;
          checks[`${slot}.dark`] = shot.dark;
          if (slot !== "selfie") checks[`${slot}.glare`] = shot.glare;
        }
      }
      if (keep.length) fd.append("keep", JSON.stringify(keep));
      fd.append("checks", JSON.stringify(checks));
      apply(await kycApi.submit(fd));
      setFlow(false);
    } catch (e) {
      toast(e instanceof Error ? e.message : t("alertMessages.someThingWentWrong"), "error");
    } finally {
      setSending(false);
    }
  }

  // --------------------------------------------------------------- states
  if (!flow) {
    return (
      <AppShell>
        <div className="mx-auto max-w-lg px-4 py-6">
          {state.status === "verified" && (
            <Card>
              <p className="text-4xl">✅</p>
              <h1 className="mt-3 text-xl font-extrabold">{t("v2.verifiedTitle")}</h1>
              <div className="mt-3">
                <KycBadge status="verified" level={state.level} />
              </div>
              <Button
                variant="outline"
                full
                className="mt-6"
                onClick={async () => {
                  if (!confirm(t("v2.deletePhotosConfirm"))) return;
                  try {
                    apply(await kycApi.deletePhotos());
                    toast(t("v2.saved"), "success");
                  } catch (e) {
                    toast(e instanceof Error ? e.message : t("alertMessages.someThingWentWrong"), "error");
                  }
                }}
              >
                {t("v2.deletePhotos")}
              </Button>
            </Card>
          )}

          {state.status === "pending" && (
            <Card>
              <p className="text-4xl">⏳</p>
              <h1 className="mt-3 text-xl font-extrabold">{t("v2.pendingTitle")}</h1>
              <p className="mt-2 text-sm text-muted">{t("v2.pendingSub")}</p>
              <Button
                variant="outline"
                full
                className="mt-6"
                onClick={async () => {
                  if (!confirm(t("v2.cancelConfirm"))) return;
                  try {
                    apply(await kycApi.cancel());
                  } catch (e) {
                    toast(e instanceof Error ? e.message : t("alertMessages.someThingWentWrong"), "error");
                  }
                }}
              >
                {t("v2.cancelRequest")}
              </Button>
            </Card>
          )}

          {state.status === "rejected" && state.latest && (
            <Card>
              <p className="text-4xl">⚠️</p>
              <h1 className="mt-3 text-xl font-extrabold">{t("v2.rejectedTitle")}</h1>
              <ul className="mt-4 space-y-1.5 text-start text-sm">
                {state.latest.rejectReasons.map((r) => (
                  <li key={r} className="rounded-xl bg-red-50 px-3 py-2 text-red-700">• {t(`v2.rr_${r}`)}</li>
                ))}
              </ul>
              {state.latest.rejectNote && <p className="mt-3 text-start text-sm">“{state.latest.rejectNote}”</p>}
              <Button full className="mt-6" onClick={() => startFlow(true)}>
                {t("v2.sendAgain")}
              </Button>
            </Card>
          )}

          {state.status === "none" && (
            <Card>
              <p className="text-4xl">🪪</p>
              <h1 className="mt-3 text-xl font-extrabold">{t("v2.kycIntroTitle")}</h1>
              <p className="mt-2 text-sm text-muted">{t("v2.kycIntro")}</p>
              <div className="mt-4 rounded-2xl bg-surface-lowest p-4 text-start text-sm">🔒 {t("v2.kycPrivacy")}</div>
              <Button full className="mt-6" onClick={() => startFlow(false)}>
                {t("v2.start")}
              </Button>
            </Card>
          )}
        </div>
      </AppShell>
    );
  }

  // ----------------------------------------------------------------- flow
  const steps: Step[] = ["doc", "license", "selfie", "review"];
  const idx = steps.indexOf(step);
  const go = (d: 1 | -1) => setStep(steps[Math.max(0, Math.min(steps.length - 1, idx + d))]);
  const setShot = (slot: KycSlot) => (s: Shot | undefined) => setShots((cur) => ({ ...cur, [slot]: s }));
  const bad = new Set(state.status === "rejected" ? state.latest?.badSlots ?? [] : []);

  const canNext =
    step === "doc"
      ? !!shots.idFront && (docType === "passport" || !!shots.idBack) && (!visitor || !!docCountry)
      : step === "license"
        ? hasLicense === false || (hasLicense === true && !!licenseCountry && !!shots.licenseFront)
        : step === "selfie"
          ? !!shots.selfie
          : ready;

  return (
    <AppShell>
      <div className="mx-auto max-w-lg px-4 py-6">
        {/* Progress */}
        <div className="mb-5 flex items-center gap-2">
          {steps.map((s, i) => (
            <div key={s} className="flex-1">
              <div className={`h-1.5 rounded-full ${i <= idx ? "bg-primary" : "bg-surface-low"}`} />
              <p className={`mt-1 text-center text-[11px] ${i === idx ? "font-bold" : "text-muted"}`}>
                {t(STEP_LABEL[s])}
              </p>
            </div>
          ))}
        </div>
        {bad.size > 0 && <p className="mb-4 rounded-xl bg-amber-50 px-3 py-2 text-sm text-amber-800">{t("v2.redoThese")}</p>}

        {step === "doc" && (
          <div className="space-y-4">
            {visitor ? (
              <>
                <div className="grid grid-cols-2 gap-2">
                  {(["national_id", "passport"] as const).map((d) => (
                    <button
                      key={d}
                      type="button"
                      onClick={() => setDocType(d)}
                      className={`h-12 rounded-xl border text-sm font-semibold ${docType === d ? "border-on-surface bg-on-surface text-white" : "border-surface-low"}`}
                    >
                      {t(d === "passport" ? "v2.passport" : "v2.nationalId")}
                    </button>
                  ))}
                </div>
                <CountryPick label={t("v2.docCountry")} value={docCountry} onChange={setDocCountry} codes={visitorCountries(lang)} />
              </>
            ) : (
              <h2 className="text-lg font-bold">{t("v2.iraqiId")} 🇮🇶</h2>
            )}
            <p className="text-xs text-muted">{t("v2.docHint")}</p>
            <PhotoSlot label={t("v2.front")} shot={shots.idFront} onChange={setShot("idFront")} document redo={bad.has("idFront")} />
            {docType === "national_id" && (
              <PhotoSlot label={t("v2.backSide")} shot={shots.idBack} onChange={setShot("idBack")} document redo={bad.has("idBack")} />
            )}
          </div>
        )}

        {step === "license" && (
          <div className="space-y-4">
            <div className="grid gap-2">
              <ChoiceButton selected={hasLicense === true} onClick={() => setHasLicense(true)} title={`🚗 ${t("v2.haveLicense")}`} />
              <ChoiceButton selected={hasLicense === false} onClick={() => setHasLicense(false)} title={t("v2.noLicense")} />
            </div>
            {hasLicense && (
              <>
                <CountryPick label={t("v2.licenseCountry")} value={licenseCountry} onChange={setLicenseCountry} codes={allCountries(lang)} />
                <PhotoSlot label={t("v2.front")} shot={shots.licenseFront} onChange={setShot("licenseFront")} document redo={bad.has("licenseFront")} />
                <PhotoSlot
                  label={`${t("v2.backSide")} (${t("v2.optional")})`}
                  shot={shots.licenseBack}
                  onChange={setShot("licenseBack")}
                  document
                  redo={bad.has("licenseBack")}
                />
              </>
            )}
          </div>
        )}

        {step === "selfie" && (
          <div className="space-y-4">
            <p className="text-sm text-muted">{t("v2.selfieHint")}</p>
            <PhotoSlot label={t("v2.stepSelfie")} shot={shots.selfie} onChange={setShot("selfie")} selfie redo={bad.has("selfie")} />
          </div>
        )}

        {step === "review" && (
          <div className="space-y-3">
            {(["idFront", "idBack", "licenseFront", "licenseBack", "selfie"] as KycSlot[])
              .filter((s) => shots[s] && (needed.includes(s) || (s === "licenseBack" && hasLicense)))
              .map((s) => (
                <div key={s} className="flex items-center gap-3 rounded-2xl border border-surface-low p-2">
                  <Thumb shot={shots[s]!} />
                  <span className="flex-1 text-sm font-medium">
                    {
                      {
                        idFront: `${t(docType === "passport" ? "v2.passport" : "v2.nationalId")} · ${t("v2.front")}`,
                        idBack: `${t("v2.nationalId")} · ${t("v2.backSide")}`,
                        licenseFront: `${t("v2.stepLicense")} · ${t("v2.front")}`,
                        licenseBack: `${t("v2.stepLicense")} · ${t("v2.backSide")}`,
                        selfie: t("v2.stepSelfie"),
                      }[s]
                    }
                  </span>
                </div>
              ))}
            {hasLicense && licenseCountry && (
              <p className="text-sm text-muted">
                {t("v2.licenseCountry")}: {flag(licenseCountry)} {countryName(licenseCountry, lang)}
              </p>
            )}
            <p className="rounded-2xl bg-surface-lowest p-3 text-xs text-muted">🔒 {t("v2.kycPrivacy")}</p>
          </div>
        )}

        <div className="mt-6 flex gap-2">
          <Button variant="outline" className="flex-1" onClick={() => (idx === 0 ? setFlow(false) : go(-1))}>
            {t("v2.back")}
          </Button>
          {step === "review" ? (
            <Button className="flex-1" loading={sending} disabled={!ready} onClick={send}>
              {sending ? t("v2.uploading") : t("v2.send")}
            </Button>
          ) : (
            <Button className="flex-1" disabled={!canNext} onClick={() => go(1)}>
              {t("v2.next")}
            </Button>
          )}
        </div>
      </div>
    </AppShell>
  );
}

function Card({ children }: { children: React.ReactNode }) {
  return <div className="rounded-3xl border border-surface-low bg-white p-6 text-center shadow-sm">{children}</div>;
}

function ChoiceButton({ selected, onClick, title }: { selected: boolean; onClick: () => void; title: string }) {
  return (
    <button
      type="button"
      onClick={onClick}
      className={`flex h-14 items-center gap-3 rounded-2xl border px-4 text-start text-sm font-semibold ${
        selected ? "border-[1.5px] border-on-surface" : "border-surface-low"
      }`}
    >
      <span className={`grid h-5 w-5 place-items-center rounded-full text-[10px] ${selected ? "bg-on-surface text-white" : "border-[1.5px] border-[#CFC8C4]"}`}>
        {selected ? "✓" : ""}
      </span>
      {title}
    </button>
  );
}

function CountryPick({ label, value, onChange, codes }: { label: string; value: string | null; onChange: (c: string) => void; codes: string[] }) {
  const { lang } = useI18n();
  const [open, setOpen] = useState(!value);
  return (
    <div>
      <p className="mb-1.5 text-xs font-semibold text-muted">{label}</p>
      {open ? (
        <CountryList
          value={value}
          codes={codes}
          height={220}
          onChange={(c) => {
            onChange(c);
            setOpen(false);
          }}
        />
      ) : (
        <button type="button" onClick={() => setOpen(true)} className="flex h-12 w-full items-center gap-3 rounded-xl border border-surface-low px-4 text-start">
          <span className="text-xl">{value ? flag(value) : "🏳️"}</span>
          <span className="flex-1 text-sm font-medium">{value ? countryName(value, lang) : "—"}</span>
          <span className="text-xs text-primary">✎</span>
        </button>
      )}
    </div>
  );
}

function Thumb({ shot }: { shot: Shot }) {
  const { t } = useI18n();
  if (shot === "kept") {
    return <span className="grid h-14 w-20 place-items-center rounded-xl bg-emerald-50 text-[11px] font-semibold text-emerald-700">✓ {t("v2.kept")}</span>;
  }
  // eslint-disable-next-line @next/next/no-img-element
  return <img src={shot.url} alt="" className="h-14 w-20 rounded-xl object-cover" />;
}

/** One photo: take it (camera on phones), see it, retake it. Checks it first. */
function PhotoSlot({
  label,
  shot,
  onChange,
  document: isDoc,
  selfie,
  redo,
}: {
  label: string;
  shot: Shot | undefined;
  onChange: (s: Shot | undefined) => void;
  document?: boolean;
  selfie?: boolean;
  redo?: boolean;
}) {
  const { t } = useI18n();
  const ref = useRef<HTMLInputElement>(null);
  const [busy, setBusy] = useState(false);
  const [warn, setWarn] = useState<{ shot: PhotoResult; msg: string } | null>(null);
  const [tries, setTries] = useState(0);

  const problem = useMemo(
    () => (r: PhotoResult) => (!r.sharp ? t("v2.tooBlurry") : r.dark ? t("v2.tooDark") : r.glare ? t("v2.glare") : null),
    [t],
  );

  async function pick(file: File) {
    setBusy(true);
    try {
      const r = await preparePhoto(file, !!isDoc);
      const msg = problem(r);
      setTries((n) => n + 1);
      if (msg) setWarn({ shot: r, msg });
      else {
        setWarn(null);
        onChange(r);
      }
    } catch {
      toast(t("alertMessages.someThingWentWrong"), "error");
    } finally {
      setBusy(false);
      if (ref.current) ref.current.value = "";
    }
  }

  return (
    <div className={`rounded-2xl border p-3 ${redo && (!shot || shot === "kept") ? "border-red-400" : "border-surface-low"}`}>
      <div className="flex items-center gap-3">
        {shot ? (
          <Thumb shot={shot} />
        ) : (
          <span className={`grid h-14 w-20 place-items-center rounded-xl bg-surface-lowest text-2xl ${selfie ? "" : ""}`}>{selfie ? "🤳" : "🪪"}</span>
        )}
        <span className="flex-1 text-sm font-semibold">{label}</span>
        <Button type="button" variant={shot ? "outline" : "primary"} className="h-10 px-4" loading={busy} onClick={() => ref.current?.click()}>
          {shot ? t("v2.retake") : t("v2.takePhoto")}
        </Button>
        <input
          ref={ref}
          type="file"
          accept="image/*"
          capture={selfie ? "user" : "environment"}
          hidden
          onChange={(e) => e.target.files?.[0] && pick(e.target.files[0])}
        />
      </div>
      {warn && (
        <div className="mt-3 rounded-xl bg-amber-50 p-3 text-sm text-amber-800">
          {warn.msg}
          <div className="mt-2 flex gap-2">
            <Button type="button" className="h-9 px-4" onClick={() => ref.current?.click()}>
              {t("v2.retake")}
            </Button>
            {tries >= 2 && (
              <Button
                type="button"
                variant="outline"
                className="h-9 px-4"
                onClick={() => {
                  onChange(warn.shot);
                  setWarn(null);
                }}
              >
                {t("v2.useAnyway")}
              </Button>
            )}
          </div>
        </div>
      )}
    </div>
  );
}
