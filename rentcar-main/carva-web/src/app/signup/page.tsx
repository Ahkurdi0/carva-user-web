"use client";

import { useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { AuthCard } from "@/components/AuthCard";
import { Button, Field, Input } from "@/components/ui";
import { useI18n } from "@/i18n";
import { authApi } from "@/lib/services";
import { useAuth } from "@/lib/auth-store";
import { toast } from "@/components/toast";

export default function SignupPage() {
  const { t } = useI18n();
  const router = useRouter();
  const signIn = useAuth((s) => s.signIn);
  const [form, setForm] = useState({
    name: "",
    email: "",
    password: "",
    countryCode: "+964",
    phoneNumber: "",
  });
  const [loading, setLoading] = useState(false);

  const set = (k: keyof typeof form) => (e: React.ChangeEvent<HTMLInputElement>) =>
    setForm((f) => ({ ...f, [k]: e.target.value }));

  async function submit(e: React.FormEvent) {
    e.preventDefault();
    setLoading(true);
    try {
      const res = await authApi.signup({
        name: form.name.trim(),
        email: form.email.trim().toLowerCase(),
        password: form.password,
        countryCode: form.countryCode,
        phoneNumber: form.phoneNumber ? form.phoneNumber.replace(/^0+/, "") : undefined,
      });
      signIn(res);
      toast(t("web.welcomeBack"), "success");
      router.push("/");
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    } finally {
      setLoading(false);
    }
  }

  return (
    <AuthCard title={t("screens.sigUp")} subtitle={t("web.signUpSubtitle")}>
      <form onSubmit={submit} className="space-y-4">
        <Field label={t("inputLabels.name")}>
          <Input required value={form.name} onChange={set("name")} placeholder={t("inputHintText.yourName")} />
        </Field>
        <Field label={t("inputLabels.email")}>
          <Input type="email" required value={form.email} onChange={set("email")} placeholder={t("inputHintText.email")} autoComplete="email" />
        </Field>
        <div className="grid grid-cols-[90px_1fr] gap-3">
          <Field label={t("inputLabels.countryCode")}>
            <Input value={form.countryCode} onChange={set("countryCode")} />
          </Field>
          <Field label={t("inputLabels.phoneNumber")}>
            <Input value={form.phoneNumber} onChange={set("phoneNumber")} inputMode="numeric" />
          </Field>
        </div>
        <Field label={t("inputLabels.password")}>
          <Input type="password" required minLength={8} value={form.password} onChange={set("password")} autoComplete="new-password" />
        </Field>
        <Button type="submit" full loading={loading}>
          {t("buttons.createAccount")}
        </Button>
      </form>

      <p className="mt-6 text-center text-sm text-muted">
        {t("web.haveAccount")}{" "}
        <Link href="/login" className="font-semibold text-primary">
          {t("buttons.login")}
        </Link>
      </p>
    </AuthCard>
  );
}
