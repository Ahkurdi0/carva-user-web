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
import { SupportModal } from "@/components/SupportModal";
import { ApiError } from "@/lib/api";

export default function LoginPage() {
  const { t } = useI18n();
  const router = useRouter();
  const signIn = useAuth((s) => s.signIn);
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  // Deleted account (403 account_locked): the server's message + Contact support.
  const [locked, setLocked] = useState<string | null>(null);
  const [supportOpen, setSupportOpen] = useState(false);

  async function submit(e: React.FormEvent) {
    e.preventDefault();
    setLoading(true);
    setLocked(null);
    try {
      const res = await authApi.login(email.trim().toLowerCase(), password);
      signIn(res);
      toast(t("web.welcomeBack"), "success");
      router.push("/");
    } catch (err) {
      if (err instanceof ApiError && err.status === 403) {
        setLocked(err.message);
        return;
      }
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    } finally {
      setLoading(false);
    }
  }

  return (
    <AuthCard eyebrow="CARVA" title={t("screens.signIn")} subtitle={t("web.signInSubtitle")}>
      {locked && (
        <div className="mb-5 rounded-2xl bg-red-50 p-4 ring-1 ring-red-200">
          <p className="text-sm leading-relaxed text-red-800">{locked}</p>
          <Button variant="outline" className="mt-3" onClick={() => setSupportOpen(true)}>
            {t("v2.contactSupport")}
          </Button>
        </div>
      )}
      <SupportModal open={supportOpen} onClose={() => setSupportOpen(false)} />
      <form onSubmit={submit} className="space-y-4">
        <Field label={t("inputLabels.email")}>
          <Input
            type="email"
            required
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder={t("inputHintText.email")}
            autoComplete="email"
          />
        </Field>
        <Field label={t("inputLabels.password")}>
          <Input
            type="password"
            required
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            autoComplete="current-password"
          />
        </Field>
        <div className="flex justify-end">
          <Link href="/reset" className="text-sm font-medium text-primary">
            {t("buttons.forgotPassword")}
          </Link>
        </div>
        <Button type="submit" full loading={loading}>
          {t("buttons.login")}
        </Button>
      </form>

      <p className="mt-6 text-center text-sm text-muted">
        {t("web.noAccount")}{" "}
        <Link href="/signup" className="font-semibold text-primary">
          {t("buttons.createAccount")}
        </Link>
      </p>
    </AuthCard>
  );
}
