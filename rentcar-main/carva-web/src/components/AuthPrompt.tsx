"use client";

import Link from "next/link";
import { Icon } from "./Icon";
import { Button } from "./ui";
import { useI18n } from "@/i18n";

export function AuthPrompt({ message }: { message?: string }) {
  const { t } = useI18n();
  return (
    <div className="flex flex-col items-center justify-center gap-4 px-6 py-20 text-center">
      <Icon name="not_loggedin" size={96} color="#d4d4d4" />
      <p className="max-w-sm text-base font-medium text-on-surface">
        {message ?? t("web.loginPrompt")}
      </p>
      <Link href="/login">
        <Button>{t("screens.login")}</Button>
      </Link>
    </div>
  );
}
