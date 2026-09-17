"use client";

import { useRouter } from "next/navigation";
import { Button } from "./ui";
import { Icon } from "./Icon";
import { useI18n } from "@/i18n";
import { useAuth } from "@/lib/auth-store";
import { chatApi } from "@/lib/services";
import { toast } from "./toast";
import { useState } from "react";

export function ChatButton({ carId, companyId, recipientUserId }: { carId?: string; companyId?: string; recipientUserId?: string }) {
  const { t } = useI18n();
  const user = useAuth((s) => s.user);
  const router = useRouter();
  const [busy, setBusy] = useState(false);

  async function openChat() {
    if (!user) { router.push("/login"); return; }
    setBusy(true);
    try {
      const conversation = await chatApi.start({ carId, companyId, recipientUserId });
      router.push(`/chat?conversation=${encodeURIComponent(conversation.id)}`);
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    } finally { setBusy(false); }
  }

  return <Button variant="outline" onClick={openChat} loading={busy}><Icon name="chat" size={18} color="#B51219" />{t("web.chat")}</Button>;
}
