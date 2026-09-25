"use client";

import * as React from "react";
import { useRouter } from "next/navigation";
import { chatApi } from "@/lib/services";
import { useAuth } from "@/lib/auth-store";
import { toast } from "./toast";
import { Button } from "./ui";
import { Icon } from "./Icon";

export interface ChatTarget {
  userId?: string | null;
  companyId?: string | null;
  carId?: string | null;
}

function conversationId(value: unknown): string | null {
  if (!value || typeof value !== "object") return null;
  const source = value as Record<string, unknown>;
  const data = source.data && typeof source.data === "object"
    ? source.data as Record<string, unknown>
    : source;
  const conversation = data.conversation && typeof data.conversation === "object"
    ? data.conversation as Record<string, unknown>
    : null;
  const id = data.conversationId ?? data.id ?? conversation?.id;
  return id == null ? null : String(id);
}

export function StartChatButton({ target, className = "" }: { target: ChatTarget; className?: string }) {
  const router = useRouter();
  const user = useAuth((s) => s.user);
  const [busy, setBusy] = React.useState(false);

  async function openChat() {
    if (!user) {
      router.push("/login");
      return;
    }
    setBusy(true);
    try {
      const result = await chatApi.start({
        userId: target.userId ?? undefined,
        companyId: target.companyId ?? undefined,
        carId: target.carId ?? undefined,
      });
      const id = conversationId(result);
      if (!id) throw new Error("The chat could not be started.");
      router.push(`/chat?conversation=${encodeURIComponent(id)}`);
    } catch (error) {
      toast(error instanceof Error ? error.message : "The chat could not be started.", "error");
    } finally {
      setBusy(false);
    }
  }

  return (
    <Button
      type="button"
      variant="outline"
      loading={busy}
      onClick={openChat}
      className={className}
    >
      {!busy && <Icon name="chat" size={17} color="#3957d7" />}
      Message
    </Button>
  );
}
