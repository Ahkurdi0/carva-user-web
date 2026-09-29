"use client";

import { Fragment, Suspense, useCallback, useEffect, useRef, useState } from "react";
import Link from "next/link";
import { useParams, useSearchParams } from "next/navigation";
import { AppShell } from "@/components/AppShell";
import { AuthPrompt } from "@/components/AuthPrompt";
import { Icon } from "@/components/Icon";
import { Button } from "@/components/ui";
import { ChatCarCard, CompanyAvatar, MessageBubble, ReachOutCard, useChatTime } from "@/components/chat/ChatParts";
import { useI18n } from "@/i18n";
import { useAuth } from "@/lib/auth-store";
import { chatApi, phoneOf, whatsappUrl, type ChatCar, type ChatMessage, type ChatPage } from "@/lib/chat";
import { useChatUnread } from "@/lib/chat-store";
import { userApi } from "@/lib/services";

const QUICK = ["available", "price", "monthly", "days", "deposit", "documents", "delivery", "insurance", "pickup"];
const POLL_MS = 4000;
// Ids for optimistic messages until the server returns the real ones.
let tmpSeq = 0;

type Header = NonNullable<ChatPage["conversation"]>;

function ChatThread() {
  const { id } = useParams<{ id: string }>();
  const carParam = useSearchParams().get("car");
  const { t } = useI18n();
  const { time, dayLabel } = useChatTime();
  const user = useAuth((s) => s.user);
  const authLoading = useAuth((s) => s.loading);
  const refreshUnread = useChatUnread((s) => s.refresh);

  const [header, setHeader] = useState<Header | null>(null);
  const [messages, setMessages] = useState<ChatMessage[]>([]);
  const [hasMore, setHasMore] = useState(false);
  const [loaded, setLoaded] = useState(false);
  const [error, setError] = useState(false);
  const [text, setText] = useState("");
  const [olderBusy, setOlderBusy] = useState(false);
  const [askedCar, setAskedCar] = useState<ChatCar | null>(null);
  const bottomRef = useRef<HTMLDivElement>(null);
  const lastId = useRef<string | null>(null);

  const lastRealId = (list: ChatMessage[]) => [...list].reverse().find((m) => !m.pending && !m.failed)?.id ?? null;

  const load = useCallback(
    () =>
      chatApi
        .messages(id)
        .then((page) => {
          setHeader(page.conversation);
          setMessages(page.messages);
          setHasMore(page.hasMore);
          lastId.current = lastRealId(page.messages);
          setError(false);
          void refreshUnread();
        })
        .catch(() => setError(true))
        .finally(() => setLoaded(true)),
    [id, refreshUnread],
  );

  useEffect(() => {
    if (!user) return;
    load();
  }, [user, load]);

  // The car the customer came from: shown above the input until it's in the chat.
  useEffect(() => {
    if (!carParam || !user) return;
    userApi
      .carDetails(carParam)
      .then((car) => setAskedCar({ id: car.id, carId: car.carId, title: car.title, images: car.images, rentalPlan: [] }))
      .catch(() => {});
  }, [carParam, user]);

  // Poll for new messages while the chat is open.
  useEffect(() => {
    if (!user || !loaded) return;
    const timer = window.setInterval(async () => {
      if (!lastId.current || document.hidden) return;
      try {
        const page = await chatApi.messages(id, { after: lastId.current });
        if (page.messages.length === 0) return;
        setMessages((cur) => {
          const known = new Set(cur.map((m) => m.id));
          return [...cur, ...page.messages.filter((m) => !known.has(m.id))];
        });
        lastId.current = page.messages[page.messages.length - 1].id;
        if (page.messages.some((m) => m.sender === "company")) {
          setHeader((h) => (h ? { ...h, awaitingReplySince: null } : h));
        }
        void refreshUnread();
      } catch {
        /* try again next tick */
      }
    }, POLL_MS);
    return () => window.clearInterval(timer);
  }, [id, user, loaded, refreshUnread]);

  const newest = messages[messages.length - 1]?.id;
  useEffect(() => {
    bottomRef.current?.scrollIntoView({ block: "end" });
  }, [newest]);

  async function loadOlder() {
    const first = messages.find((m) => !m.pending);
    if (!first) return;
    setOlderBusy(true);
    try {
      const page = await chatApi.messages(id, { before: first.id });
      setMessages((cur) => [...page.messages, ...cur]);
      setHasMore(page.hasMore);
    } finally {
      setOlderBusy(false);
    }
  }

  async function send(body: string, tempId?: string) {
    const trimmed = body.trim();
    if (!trimmed) return;
    const temp = tempId ?? `tmp-${++tmpSeq}`;
    const optimistic: ChatMessage = {
      id: temp,
      sender: "user",
      type: "text",
      body: trimmed,
      readAt: null,
      createdAt: new Date().toISOString(),
      car: null,
      pending: true,
    };
    setMessages((cur) => (tempId ? cur.map((m) => (m.id === temp ? optimistic : m)) : [...cur, optimistic]));
    if (!tempId) setText("");
    try {
      const created = await chatApi.send(id, trimmed, carParam);
      setMessages((cur) => {
        const known = new Set(cur.map((m) => m.id));
        return [...cur.filter((m) => m.id !== temp), ...created.filter((m) => !known.has(m.id))];
      });
      lastId.current = created[created.length - 1]?.id ?? lastId.current;
      setAskedCar(null);
      setHeader((h) => (h && !h.awaitingReplySince ? { ...h, awaitingReplySince: new Date().toISOString() } : h));
    } catch {
      setMessages((cur) => cur.map((m) => (m.id === temp ? { ...m, pending: false, failed: true } : m)));
    }
  }

  if (!authLoading && !user) {
    return <AuthPrompt message={t("chat.loginRequired")} />;
  }

  const company = header?.company ?? null;
  const whatsapp = whatsappUrl(company);
  const phone = phoneOf(company);
  // Quick questions stay until the customer has written something (a shared car card alone doesn't count).
  const asked = messages.some((m) => m.sender === "user" && m.type === "text");
  const carInChat = !!askedCar && messages.some((m) => m.car?.id === askedCar.id);

  return (
    <div className="mx-auto flex h-[calc(100dvh-8.5rem)] max-w-3xl flex-col md:h-[calc(100dvh-5rem)] md:py-3">
      {/* Header */}
      <div className="flex items-center gap-3 border-b border-surface-lowest bg-white px-3 py-2.5 md:rounded-t-2xl md:border md:border-surface-low">
        <Link href="/chats" className="grid h-9 w-9 place-items-center rounded-full hover:bg-surface-lowest" aria-label={t("chat.title")}>
          <Icon name="arrow" size={18} className="rtl:rotate-180" />
        </Link>
        {company ? (
          <Link href={`/company/${company.id}`} className="flex min-w-0 flex-1 items-center gap-2.5">
            <CompanyAvatar company={company} size={40} />
            <span className="truncate font-bold">{company.name}</span>
          </Link>
        ) : (
          <span className="h-10 flex-1 animate-pulse rounded-xl bg-surface-lowest" />
        )}
        {whatsapp && (
          <a href={whatsapp} target="_blank" rel="noopener noreferrer" className="grid h-10 w-10 place-items-center rounded-full bg-[#25D366]" aria-label="WhatsApp">
            <Icon name="whatsapp" size={20} color="#fff" />
          </a>
        )}
        {phone && (
          <a href={`tel:${phone}`} className="grid h-10 w-10 place-items-center rounded-full border border-surface-low" aria-label={t("chat.call")}>
            <Icon name="call" size={18} color="#B51219" />
          </a>
        )}
      </div>

      {header?.awaitingReplySince && messages.length > 0 && (
        <div className="flex items-center gap-2 bg-amber-50 px-4 py-1.5 text-xs font-medium text-amber-800">
          <Icon name="clock" size={14} color="#92400e" /> {t("chat.waiting")}
        </div>
      )}

      {/* Messages */}
      <div className="min-h-0 flex-1 space-y-2 overflow-y-auto bg-surface-lowest/50 px-3 py-4 md:border-x md:border-surface-low">
        {error && !loaded ? null : error && messages.length === 0 ? (
          <div className="py-16 text-center">
            <p className="text-sm text-muted">{t("chat.error")}</p>
            <Button className="mt-3" onClick={load}>{t("chat.retry")}</Button>
          </div>
        ) : !loaded ? (
          <div className="grid place-items-center py-16">
            <span className="h-8 w-8 animate-spin rounded-full border-2 border-primary border-t-transparent" />
          </div>
        ) : messages.length === 0 ? (
          <div className="mx-auto max-w-sm py-10 text-center">
            {company && <div className="mx-auto mb-3 w-fit"><CompanyAvatar company={company} size={64} /></div>}
            <p className="font-bold">{t("chat.startTitle", { name: company?.name ?? "" })}</p>
            <p className="mt-1 text-sm text-muted">{t("chat.startBody")}</p>
          </div>
        ) : (
          <>
            {hasMore && (
              <div className="flex justify-center">
                <Button variant="secondary" loading={olderBusy} onClick={loadOlder}>{t("web.viewAll")}</Button>
              </div>
            )}
            {messages.map((m, i) => {
              const newDay = i === 0 || new Date(m.createdAt).toDateString() !== new Date(messages[i - 1].createdAt).toDateString();
              return (
                <Fragment key={m.id}>
                  {newDay && <p className="py-2 text-center text-[11px] font-semibold text-muted">{dayLabel(m.createdAt)}</p>}
                  {m.type === "car" && m.car ? (
                    <div className={`flex ${m.sender === "user" ? "justify-end" : "justify-start"}`}>
                      <ChatCarCard car={m.car} mine={m.sender === "user"} label={m.sender === "user" ? undefined : t("chat.carShared")} />
                    </div>
                  ) : m.type === "quickContact" || m.type === "autoReply" ? (
                    <ReachOutCard message={m} company={company} whatsapp={whatsapp} phone={phone} time={time(m.createdAt)} />
                  ) : (
                    <MessageBubble message={m} time={time(m.createdAt)} onRetry={() => send(m.body ?? "", m.id)} />
                  )}
                </Fragment>
              );
            })}
          </>
        )}
        <div ref={bottomRef} />
      </div>

      {/* Composer */}
      <div className="border-t border-surface-lowest bg-white px-3 pb-3 pt-2 md:rounded-b-2xl md:border md:border-surface-low">
        {askedCar && !carInChat && (
          <div className="mb-2">
            <ChatCarCard car={askedCar} mine />
          </div>
        )}
        {loaded && !asked && (
          <div className="-mx-1 mb-2 flex gap-2 overflow-x-auto px-1 pb-1">
            {QUICK.map((k) => (
              <button
                key={k}
                onClick={() => send(t(`chat.quick.${k}`))}
                className="shrink-0 rounded-full border border-primary/30 bg-primary-container px-3 py-1.5 text-xs font-semibold text-primary transition hover:bg-primary hover:text-white"
              >
                {t(`chat.quick.${k}`)}
              </button>
            ))}
          </div>
        )}
        <form
          onSubmit={(e) => {
            e.preventDefault();
            void send(text);
          }}
          className="flex items-end gap-2"
        >
          <textarea
            dir="auto"
            value={text}
            onChange={(e) => setText(e.target.value)}
            onKeyDown={(e) => {
              if (e.key === "Enter" && !e.shiftKey) {
                e.preventDefault();
                void send(text);
              }
            }}
            rows={1}
            maxLength={2000}
            placeholder={t("chat.inputHint")}
            className="max-h-32 min-h-[44px] flex-1 resize-none rounded-2xl border border-surface-low bg-surface-lowest px-4 py-2.5 text-sm outline-none focus:border-primary"
          />
          <button
            type="submit"
            disabled={!text.trim() || !loaded}
            className="grid h-11 w-11 shrink-0 place-items-center rounded-full bg-primary transition hover:opacity-90 disabled:opacity-40"
            aria-label="Send"
          >
            <Icon name="arrow" size={18} color="#fff" className="rotate-180 rtl:rotate-0" />
          </button>
        </form>
      </div>
    </div>
  );
}

export default function ChatThreadPage() {
  return (
    <AppShell>
      <Suspense fallback={null}>
        <ChatThread />
      </Suspense>
    </AppShell>
  );
}
