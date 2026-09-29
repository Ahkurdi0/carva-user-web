"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { ActionButton } from "./ActionButton";
import { toast } from "./toast";
import { useI18n } from "@/i18n";
import { useAuth } from "@/lib/auth-store";
import { chatApi } from "@/lib/chat";

/**
 * Opens the chat with a company — from a car page (carId = the car's public
 * id: its card is sent to the company right away) or a company page.
 * Signed-out visitors are sent to log in first.
 */
export function ChatButton({
  companyId,
  carId,
  className = "",
}: {
  companyId: string;
  carId?: string;
  className?: string;
}) {
  const { t } = useI18n();
  const router = useRouter();
  const user = useAuth((s) => s.user);
  const [busy, setBusy] = useState(false);

  async function open() {
    if (!user) {
      toast(t("chat.loginRequired"), "error");
      router.push("/login");
      return;
    }
    setBusy(true);
    try {
      const { id } = await chatApi.start(carId ? { carId } : { companyId });
      // From a car page, the company gets that car's card straight away;
      // the chat still opens if sharing it fails.
      if (carId) await chatApi.shareCar(id, carId).catch(() => {});
      router.push(`/chats/${id}`);
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
      setBusy(false);
    }
  }

  return (
    <ActionButton tone="chat" icon="chat" label={t("chat.button")} onClick={open} loading={busy} className={className} />
  );
}
