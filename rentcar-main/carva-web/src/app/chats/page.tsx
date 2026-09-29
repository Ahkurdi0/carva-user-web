"use client";

import { useCallback, useEffect, useState } from "react";
import Link from "next/link";
import { AppShell } from "@/components/AppShell";
import { AuthPrompt } from "@/components/AuthPrompt";
import { Icon } from "@/components/Icon";
import { Button } from "@/components/ui";
import { CompanyAvatar, useChatTime } from "@/components/chat/ChatParts";
import { useI18n } from "@/i18n";
import { useAuth } from "@/lib/auth-store";
import { chatApi, type ChatSummary } from "@/lib/chat";
import { useChatUnread } from "@/lib/chat-store";

export default function ChatsPage() {
  const { t } = useI18n();
  const { listTime } = useChatTime();
  const user = useAuth((s) => s.user);
  const authLoading = useAuth((s) => s.loading);
  const refreshUnread = useChatUnread((s) => s.refresh);
  const [items, setItems] = useState<ChatSummary[] | null>(null);
  const [next, setNext] = useState<string | null>(null);
  const [error, setError] = useState(false);
  const [more, setMore] = useState(false);

  const load = useCallback(
    () =>
      chatApi
        .list()
        .then((page) => {
          setItems(page.data);
          setNext(page.nextCursor);
          setError(false);
        })
        .catch(() => setError(true)),
    [],
  );

  useEffect(() => {
    if (!user) return;
    load();
    void refreshUnread();
    // Keep the list fresh while it's open (new replies, unread counts).
    const timer = window.setInterval(load, 15000);
    return () => window.clearInterval(timer);
  }, [user, load, refreshUnread]);

  async function loadMore() {
    if (!next) return;
    setMore(true);
    try {
      const page = await chatApi.list(next);
      setItems((cur) => [...(cur ?? []), ...page.data.filter((c) => !cur?.some((x) => x.id === c.id))]);
      setNext(page.nextCursor);
    } finally {
      setMore(false);
    }
  }

  if (!authLoading && !user) {
    return (
      <AppShell>
        <AuthPrompt message={t("chat.loginRequired")} />
      </AppShell>
    );
  }

  return (
    <AppShell>
      <div className="mx-auto max-w-2xl px-4 py-5">
        <h1 className="mb-4 text-xl font-extrabold">{t("chat.title")}</h1>

        {error && !items && (
          <div className="py-16 text-center">
            <p className="text-sm text-muted">{t("chat.error")}</p>
            <Button className="mt-3" onClick={load}>{t("chat.retry")}</Button>
          </div>
        )}

        {!items && !error && (
          <div className="space-y-2">
            {[0, 1, 2, 3].map((i) => (
              <div key={i} className="h-[76px] animate-pulse rounded-2xl bg-surface-lowest" />
            ))}
          </div>
        )}

        {items && items.length === 0 && (
          <div className="flex flex-col items-center gap-3 py-16 text-center">
            <Icon name="chat" size={72} color="#d4d4d4" />
            <p className="font-bold">{t("chat.empty")}</p>
            <p className="max-w-xs text-sm text-muted">{t("chat.emptyHint")}</p>
            <Link href="/">
              <Button>{t("chat.browseCars")}</Button>
            </Link>
          </div>
        )}

        {items && items.length > 0 && (
          <div className="divide-y divide-surface-lowest overflow-hidden rounded-2xl border border-surface-low">
            {items.map((c) => {
              const unread = c.userUnread > 0;
              return (
                <Link key={c.id} href={`/chats/${c.id}`} className="flex items-center gap-3 p-3 transition hover:bg-surface-lowest">
                  <CompanyAvatar company={c.company} size={48} />
                  <div className="min-w-0 flex-1">
                    <div className="flex items-baseline justify-between gap-2">
                      <p className={`truncate ${unread ? "font-extrabold" : "font-bold"}`}>{c.company.name}</p>
                      <span className={`shrink-0 text-[11px] ${unread ? "font-bold text-primary" : "text-muted"}`}>
                        {listTime(c.lastMessageAt)}
                      </span>
                    </div>
                    <div className="flex items-center justify-between gap-2">
                      <p dir="auto" className={`truncate text-start text-sm ${unread ? "font-semibold text-on-surface" : "text-muted"}`}>
                        {c.lastSender === "user" && t("chat.you")}
                        {c.lastMessage ?? (c.lastCar ? c.lastCar.title : "")}
                      </p>
                      {unread && (
                        <span className="grid h-5 min-w-5 shrink-0 place-items-center rounded-full bg-primary px-1.5 text-[11px] font-bold text-white">
                          {c.userUnread}
                        </span>
                      )}
                    </div>
                    {c.lastCar && (
                      <p className="mt-0.5 flex items-center gap-1 truncate text-[11px] text-muted">
                        <Icon name="car" size={12} color="#9e9e9e" /> {c.lastCar.title}
                      </p>
                    )}
                  </div>
                </Link>
              );
            })}
          </div>
        )}

        {next && (
          <div className="flex justify-center py-4">
            <Button variant="secondary" loading={more} onClick={loadMore}>{t("web.viewAll")}</Button>
          </div>
        )}
      </div>
    </AppShell>
  );
}
