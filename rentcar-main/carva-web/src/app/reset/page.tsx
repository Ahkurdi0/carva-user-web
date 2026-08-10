"use client";

import { useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { AuthCard } from "@/components/AuthCard";
import { Button, Field, Input } from "@/components/ui";
import { useI18n } from "@/i18n";
import { otpApi } from "@/lib/services";
import { toast } from "@/components/toast";

export default function ResetPage() {
  const { t } = useI18n();
  const router = useRouter();
  const [step, setStep] = useState<0 | 1 | 2>(0);
  const [email, setEmail] = useState("");
  const [code, setCode] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);

  async function run(fn: () => Promise<unknown>, next?: () => void) {
    setLoading(true);
    try {
      await fn();
      next?.();
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    } finally {
      setLoading(false);
    }
  }

  return (
    <AuthCard title={t("buttons.reset")} subtitle={t("web.resetSubtitle")}>
      {step === 0 && (
        <form
          onSubmit={(e) => {
            e.preventDefault();
            run(() => otpApi.resetSend(email.trim().toLowerCase()), () => setStep(1));
          }}
          className="space-y-4"
        >
          <p className="text-sm text-muted">{t("auth.send.desc")}</p>
          <Field label={t("inputLabels.email")}>
            <Input type="email" required value={email} onChange={(e) => setEmail(e.target.value)} placeholder={t("inputHintText.email")} />
          </Field>
          <Button type="submit" full loading={loading}>
            {t("buttons.send")}
          </Button>
        </form>
      )}

      {step === 1 && (
        <form
          onSubmit={(e) => {
            e.preventDefault();
            run(() => otpApi.resetVerify(email.trim().toLowerCase(), code), () => setStep(2));
          }}
          className="space-y-4"
        >
          <p className="text-sm text-muted">
            {t("auth.verify.codeSent")} <span className="font-medium text-on-surface">{email}</span>
          </p>
          <Field label={t("inputLabels.otp")}>
            <Input required value={code} onChange={(e) => setCode(e.target.value)} inputMode="numeric" maxLength={6} className="text-center text-lg tracking-[0.4em]" />
          </Field>
          <Button type="submit" full loading={loading}>
            {t("buttons.verify")}
          </Button>
        </form>
      )}

      {step === 2 && (
        <form
          onSubmit={(e) => {
            e.preventDefault();
            run(
              () => otpApi.resetPassword(email.trim().toLowerCase(), code, password),
              () => {
                toast(t("alertMessages.success"), "success");
                router.push("/login");
              },
            );
          }}
          className="space-y-4"
        >
          <p className="text-sm text-muted">{t("auth.reset.desc")}</p>
          <Field label={t("inputLabels.newPassword")}>
            <Input type="password" required minLength={8} value={password} onChange={(e) => setPassword(e.target.value)} autoComplete="new-password" />
          </Field>
          <Button type="submit" full loading={loading}>
            {t("buttons.reset")}
          </Button>
        </form>
      )}

      <p className="mt-6 text-center text-sm text-muted">
        <Link href="/login" className="font-semibold text-primary">
          {t("buttons.login")}
        </Link>
      </p>
    </AuthCard>
  );
}
