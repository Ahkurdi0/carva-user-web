"use client";

import { Fragment, Suspense, useCallback, useEffect, useLayoutEffect, useRef, useState } from "react";
import Link from "next/link";
import { useParams, useSearchParams } from "next/navigation";
import { AppShell } from "@/components/AppShell";
import { AuthPrompt } from "@/components/AuthPrompt";
import { Icon } from "@/components/Icon";
import { Button } from "@/components/ui";
import { Modal } from "@/components/Modal";
import { displayPlan, usePrice } from "@/components/CarCard";
import { ChatCarCard, CompanyAvatar, ComposerCarCard, DaySeparator, MessageBubble, ReachOutCard, useChatTime } from "@/components/chat/ChatParts";
import { useI18n } from "@/i18n";
import { useAuth } from "@/lib/auth-store";
import { chatApi, phoneOf, whatsappUrl, type ChatCar, type ChatMessage, type ChatPage } from "@/lib/chat";
import { useChatUnread } from "@/lib/chat-store";
import { userApi } from "@/lib/services";
import { imageUrl } from "@/lib/api";
import type { Car } from "@/lib/types";

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
  const [hideAsked, setHideAsked] = useState(false);
  const [picker, setPicker] = useState(false);
  const [pickerCars, setPickerCars] = useState<Car[] | null>(null);
  const [composerH, setComposerH] = useState(120);
  const composerRef = useRef<HTMLDivElement>(null);
  const bottomRef = useRef<HTMLDivElement>(null);
  const price = usePrice();
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

  // Room the list leaves for the floating composer (measured, like the app).
  useLayoutEffect(() => {
    const el = composerRef.current;
    if (!el) return;
    const ro = new ResizeObserver(() => setComposerH(el.offsetHeight));
    ro.observe(el);
    return () => ro.disconnect();
  }, []);

  // "Send a car": the company's available cars.
  useEffect(() => {
    if (!picker || pickerCars || !header?.company) return;
    userApi
      .getCars(header.company.id)
      .then((cars) => setPickerCars(cars.filter((c) => c.available !== false)))
      .catch(() => setPickerCars([]));
  }, [picker, pickerCars, header?.company]);

  async function shareCar(car: Car) {
    setPicker(false);
    try {
      const created = await chatApi.shareCar(id, car.carId);
      setMessages((cur) => {
        const known = new Set(cur.map((m) => m.id));
        return [...cur, ...created.filter((m) => !known.has(m.id))];
      });
      lastId.current = created[created.length - 1]?.id ?? lastId.current;
    } catch {
      /* the picker can be opened again */
    }
  }

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

  // The customer's latest text carries the Sent / Seen label.
  const lastMine = [...messages].reverse().find((m) => m.sender === "user" && m.type === "text")?.id;

  return (
    <div className="relative mx-auto h-[100dvh] max-w-3xl md:h-[calc(100dvh-4rem)]">
      {/* Glass bar: back, company, WhatsApp and call — messages scroll under it */}
      <div className="glass absolute inset-x-0 top-0 z-20 flex h-16 items-center gap-2.5 !border-x-0 !border-t-0 border-b !border-b-hairline px-3 md:top-2 md:mx-2 md:rounded-full md:!border md:!border-white/70 md:shadow-[var(--shadow-card)]">
        <Link
          href="/chats"
          className="press glass grid h-10 w-10 shrink-0 place-items-center rounded-full shadow-[var(--shadow-card)]"
          aria-label={t("chat.title")}
        >
          <Icon name="arrow" size={18} color="#171214" className="rtl:rotate-180" />
        </Link>
        {company ? (
          <Link href={`/company/${company.id}`} className="flex min-w-0 flex-1 items-center gap-3">
            <CompanyAvatar company={company} size={40} />
            <span className="truncate text-[16px] font-bold"><bdi>{company.name}</bdi></span>
          </Link>
        ) : (
          <span className="h-10 flex-1 animate-pulse rounded-full bg-surface-lowest" />
        )}
        {whatsapp && (
          <a href={whatsapp} target="_blank" rel="noopener noreferrer" className="press grid h-10 w-10 shrink-0 place-items-center rounded-full bg-whatsapp/10" aria-label="WhatsApp">
            <Icon name="whatsapp" size={20} color="#22B053" />
          </a>
        )}
        {phone && (
          <a href={`tel:${phone}`} className="press grid h-10 w-10 shrink-0 place-items-center rounded-full bg-ink/10" aria-label={t("chat.call")}>
            <Icon name="call" size={19} color="#171214" />
          </a>
        )}
      </div>

      {/* Messages */}
      <div className="no-scrollbar h-full overflow-y-auto px-4" style={{ paddingTop: 80, paddingBottom: composerH + 12 }}>
        {error && !loaded ? null : error && messages.length === 0 ? (
          <div className="flex h-full flex-col items-center justify-center text-center">
            <p className="text-[15px]">{t("chat.error")}</p>
            <Button className="mt-4 w-48" onClick={load}>{t("chat.retry")}</Button>
          </div>
        ) : !loaded ? (
          <div className="space-y-3 pt-4">
            {[56, 72, 40, 64].map((w, i) => (
              <div key={i} className={`flex ${i % 2 ? "justify-end" : "justify-start"}`}>
                <div className="skeleton h-12 rounded-[20px]" style={{ width: `${w}%` }} />
              </div>
            ))}
          </div>
        ) : messages.length === 0 && !(askedCar && !hideAsked) ? (
          <div className="mx-auto flex h-full max-w-sm flex-col items-center justify-center px-4 text-center">
            <span className="rounded-full border-2 border-primary/25 p-1.5">
              <CompanyAvatar company={company} size={88} />
            </span>
            <p className="mt-4 text-[20px] font-bold">{t("chat.startTitle", { name: company?.name ?? "" })}</p>
            <p className="mt-2 text-[14.5px] leading-relaxed text-muted">{t("chat.startBody")}</p>
          </div>
        ) : (
          <>
            {hasMore && (
              <div className="flex justify-center py-2">
                <Button variant="outline" className="!h-9 !rounded-full !px-4 !text-[13px]" loading={olderBusy} onClick={loadOlder}>
                  {t("web.viewAll")}
                </Button>
              </div>
            )}
            {messages.map((m, i) => {
              const newDay = i === 0 || new Date(m.createdAt).toDateString() !== new Date(messages[i - 1].createdAt).toDateString();
              return (
                <Fragment key={m.id}>
                  {newDay && <DaySeparator label={dayLabel(m.createdAt)} />}
                  {m.type === "car" && m.car ? (
                    <ChatCarCard car={m.car} mine={m.sender === "user"} label={m.sender === "user" ? undefined : t("chat.carShared")} />
                  ) : m.type === "quickContact" || m.type === "autoReply" ? (
                    <ReachOutCard message={m} company={company} whatsapp={whatsapp} phone={phone} time={time(m.createdAt)} />
                  ) : (
                    <MessageBubble message={m} time={time(m.createdAt)} status={m.id === lastMine} onRetry={() => send(m.body ?? "", m.id)} />
                  )}
                </Fragment>
              );
            })}
          </>
        )}
        <div ref={bottomRef} />
      </div>

      {/* Floating composer: quick questions, the car being asked about, glass input */}
      <div ref={composerRef} className="absolute inset-x-0 bottom-0 z-20 pb-[max(10px,env(safe-area-inset-bottom))]">
        {loaded && !asked && !text.trim() && (
          <div className="no-scrollbar flex gap-2 overflow-x-auto px-4 pb-1 pt-2.5">
            {QUICK.map((k) => (
              <button
                key={k}
                onClick={() => send(t(`chat.quick.${k}`))}
                className="press h-10 shrink-0 rounded-full border border-border-strong bg-white px-3.5 text-[13.5px] text-on-surface shadow-[0_2px_8px_rgba(0,0,0,0.04)]"
              >
                {t(`chat.quick.${k}`)}
              </button>
            ))}
          </div>
        )}
        <div className="px-3 pt-2">
          {askedCar && !carInChat && !hideAsked && (
            <div className="mb-2">
              <ComposerCarCard car={askedCar} onClose={() => setHideAsked(true)} />
            </div>
          )}
          <form
            onSubmit={(e) => {
              e.preventDefault();
              void send(text);
            }}
            className="glass flex items-end gap-1.5 rounded-[30px] p-1.5 shadow-[var(--shadow-glass)]"
          >
            {company && (
              <button
                type="button"
                onClick={() => setPicker(true)}
                aria-label={t("chat.shareCar")}
                title={t("chat.shareCar")}
                className="press grid h-12 w-12 shrink-0 place-items-center rounded-full border border-white/70 bg-white/70"
              >
                <Icon name="car" size={22} color="#171214" />
              </button>
            )}
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
              className="max-h-32 min-h-12 flex-1 resize-none rounded-3xl border border-white/70 bg-white/70 px-4 py-3 text-[15px] leading-6 outline-none placeholder:text-hint focus:bg-white"
            />
            <button
              type="submit"
              disabled={!text.trim() || !loaded}
              className={`press grid h-12 w-12 shrink-0 place-items-center rounded-full transition ${
                text.trim() && loaded ? "bg-primary shadow-[var(--shadow-card)]" : "bg-surface-lowest"
              }`}
              aria-label="Send"
            >
              <svg width="20" height="20" viewBox="0 0 24 24" fill={text.trim() && loaded ? "#fff" : "#A29A96"} className="rtl:-scale-x-100" aria-hidden>
                <path d="M3.4 20.4 20.85 12.92a1 1 0 0 0 0-1.84L3.4 3.6a.99.99 0 0 0-1.39.91L2 9.12c0 .5.37.93.87.99L17 12 2.87 13.88c-.5.07-.87.5-.87 1l.01 4.61c0 .71.73 1.2 1.39.91z" />
              </svg>
            </button>
          </form>
        </div>
      </div>

      {/* "Send a car" picker */}
      <Modal open={picker} onClose={() => setPicker(false)} title={t("chat.shareCar")}>
        {!pickerCars ? (
          <div className="grid place-items-center py-10">
            <span className="h-8 w-8 animate-spin rounded-full border-2 border-primary border-t-transparent" />
          </div>
        ) : pickerCars.length === 0 ? (
          <p className="py-8 text-center text-sm text-muted">{t("empty.cars")}</p>
        ) : (
          <div className="-mx-2 max-h-[60vh] divide-y divide-hairline overflow-y-auto">
            {pickerCars.map((car) => {
              const plan = displayPlan(car);
              return (
                <button key={car.id} onClick={() => shareCar(car)} className="flex w-full items-center gap-3 px-2 py-2.5 text-start hover:bg-surface-lowest">
                  {car.images?.[0]?.image ? (
                    // eslint-disable-next-line @next/next/no-img-element
                    <img src={imageUrl(car.images[0].image)} alt="" className="h-12 w-16 shrink-0 rounded-xl object-cover" />
                  ) : (
                    <span className="h-12 w-16 shrink-0 rounded-xl bg-surface-lowest" />
                  )}
                  <span className="min-w-0 flex-1">
                    <span className="block truncate text-[15px] font-bold"><bdi>{car.title}</bdi></span>
                    {plan && Number(plan.price) > 0 && (
                      <span className="num block text-[13px] font-semibold">
                        {price.amount(plan)} <span className="font-normal text-muted">/ {price.unit(plan)}</span>
                      </span>
                    )}
                  </span>
                  <svg width="22" height="22" viewBox="0 0 24 24" fill="#B51219" aria-hidden className="shrink-0">
                    <path d="M13 7h-2v4H7v2h4v4h2v-4h4v-2h-4V7zm-1-5C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8z" />
                  </svg>
                </button>
              );
            })}
          </div>
        )}
      </Modal>
    </div>
  );
}

export default function ChatThreadPage() {
  return (
    <AppShell focused>
      <Suspense fallback={null}>
        <ChatThread />
      </Suspense>
    </AppShell>
  );
}
