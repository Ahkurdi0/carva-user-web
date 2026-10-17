"use client";

import { useCallback, useEffect, useState } from "react";
import Link from "next/link";
import { AppShell } from "@/components/AppShell";
import { Icon } from "@/components/Icon";
import { Button } from "@/components/ui";
import { CompanyAvatar, UnreadBadge, useChatTime } from "@/components/chat/ChatParts";
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

  const circle = (
    <span className="grid h-24 w-24 place-items-center rounded-full bg-primary-container">
      <Icon name="chat_active" size={44} color="#B51219" />
    </span>
  );

  if (!authLoading && !user) {
    return (
      <AppShell>
        <div className="mx-auto max-w-2xl px-4 py-5">
          <h1 className="text-[28px] font-bold leading-tight">{t("chat.title")}</h1>
          <div className="mx-auto flex max-w-sm flex-col items-center py-16 text-center">
            {circle}
            <p className="mt-5 text-[15px] leading-relaxed">{t("chat.loginRequired")}</p>
            <Link href="/login" className="mt-6 w-60">
              <Button full>{t("screens.login")}</Button>
            </Link>
          </div>
        </div>
      </AppShell>
    );
  }

  return (
    <AppShell>
      <div className="mx-auto max-w-2xl py-5">
        <h1 className="mb-2 px-4 text-[28px] font-bold leading-tight">{t("chat.title")}</h1>

        {error && !items && (
          <div className="flex flex-col items-center py-16 text-center">
            <p className="text-[15px]">{t("chat.error")}</p>
            <Button className="mt-4 w-48" onClick={load}>{t("chat.retry")}</Button>
          </div>
        )}

        {!items && !error && (
          <div>
            {[0, 1, 2, 3, 4].map((i) => (
              <div key={i} className="flex items-center gap-3 px-4 py-3">
                <div className="skeleton h-14 w-14 shrink-0 rounded-full" />
                <div className="flex-1 space-y-2">
                  <div className="skeleton h-4 w-2/5 rounded-md" />
                  <div className="skeleton h-3.5 w-4/5 rounded-md" />
                </div>
              </div>
            ))}
          </div>
        )}

        {items && items.length === 0 && (
          <div className="mx-auto flex max-w-sm flex-col items-center px-6 py-16 text-center">
            {circle}
            <p className="mt-5 text-[20px] font-bold">{t("chat.empty")}</p>
            <p className="mt-2 text-[14.5px] leading-relaxed text-muted">{t("chat.emptyHint")}</p>
          </div>
        )}

        {items && items.length > 0 && (
          <ul>
            {items.map((c, i) => {
              const unread = c.userUnread > 0;
              const preview =
                c.lastSender === "system"
                  ? t("chat.autoReplyPreview")
                  : !c.lastMessage
                    ? t("chat.carShared")
                    : `${c.lastSender === "user" ? t("chat.you") : ""}${c.lastMessage}`;
              return (
                <li key={c.id} data-reveal>
                  {i > 0 && <div className="ms-[84px] me-4 h-px bg-hairline" />}
                  <Link href={`/chats/${c.id}`} className="flex items-center gap-3 px-4 py-3 transition hover:bg-white/60 md:rounded-2xl">
                    <CompanyAvatar company={c.company} size={56} />
                    <div className="min-w-0 flex-1">
                      <div className="flex items-center gap-2">
                        <p className="min-w-0 flex-1 truncate text-[16px] font-bold"><bdi>{c.company.name}</bdi></p>
                        <span className={`num shrink-0 text-[11px] ${unread ? "font-bold text-primary" : "text-muted"}`}>
                          {listTime(c.lastMessageAt)}
                        </span>
                      </div>
                      {c.lastCar && (
                        <p className="mt-0.5 flex items-center gap-1 text-[11px] font-semibold text-primary">
                          <Icon name="car" size={13} color="#B51219" />
                          <span className="truncate"><bdi>{c.lastCar.title}</bdi></span>
                        </p>
                      )}
                      <div className="mt-0.5 flex items-center gap-2">
                        <p dir="auto" className={`min-w-0 flex-1 truncate text-start text-[14px] ${unread ? "font-semibold text-on-surface" : "text-muted"}`}>
                          {preview}
                        </p>
                        {unread && <UnreadBadge count={c.userUnread} />}
                      </div>
                    </div>
                  </Link>
                </li>
              );
            })}
          </ul>
        )}

        {next && (
          <div className="flex justify-center py-4">
            <Button variant="outline" className="!h-10 !rounded-full" loading={more} onClick={loadMore}>{t("web.viewAll")}</Button>
          </div>
        )}
      </div>
    </AppShell>
  );
}
