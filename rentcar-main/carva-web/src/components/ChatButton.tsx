"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Icon } from "./Icon";
import { Button } from "./ui";
import { toast } from "./toast";
import { useI18n } from "@/i18n";
import { useAuth } from "@/lib/auth-store";
import { chatApi } from "@/lib/chat";

/**
 * Opens the chat with a company — from a car page (carId = the car's public
 * id, so the first message carries that car's card) or a company page.
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
      router.push(carId ? `/chats/${id}?car=${encodeURIComponent(carId)}` : `/chats/${id}`);
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
      setBusy(false);
    }
  }

  return (
    <Button onClick={open} loading={busy} className={className}>
      <Icon name="chat" size={18} color="#fff" /> {t("chat.button")}
    </Button>
  );
}
