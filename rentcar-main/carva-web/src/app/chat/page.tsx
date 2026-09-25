"use client";
/* eslint-disable react-hooks/set-state-in-effect */

import { useCallback, useEffect, useRef, useState } from "react";
import type { RefObject } from "react";
import { useRouter } from "next/navigation";
import { AppShell } from "@/components/AppShell";
import { AuthPrompt } from "@/components/AuthPrompt";
import { ChatSharedCard, type SharedListing } from "@/components/ChatSharedCard";
import { ShareListingModal } from "@/components/ShareListingModal";
import { Icon } from "@/components/Icon";
import { Button, Spinner } from "@/components/ui";
import { useAuth } from "@/lib/auth-store";
import { chatApi } from "@/lib/services";
import { imageUrl } from "@/lib/api";
import { toast } from "@/components/toast";

type RecordValue = Record<string, unknown>;
const SHARED_CAR = "__CARVA_SHARED_CAR__";
const SHARED_COMPANY = "__CARVA_SHARED_COMPANY__";

function asRecord(value: unknown): RecordValue | null {
  return value && typeof value === "object" ? value as RecordValue : null;
}

function listFrom(value: unknown, key: string): RecordValue[] {
  const root = asRecord(value);
  const data = asRecord(root?.data) ?? root;
  const list = Array.isArray(value) ? value : data?.[key] ?? data?.items ?? data?.data;
  return Array.isArray(list) ? list.filter((item): item is RecordValue => !!asRecord(item)).map((item) => asRecord(item)!) : [];
}

function idOf(value: RecordValue | null | undefined) {
  const id = value?.id ?? value?.conversationId ?? value?.userId ?? value?.companyId ?? value?.carId;
  return id == null ? "" : String(id);
}

function userOf(conversation: RecordValue) {
  return asRecord(conversation.recipient) ?? asRecord(conversation.otherUser) ?? asRecord(conversation.participant) ?? asRecord(conversation.user) ?? conversation;
}

function conversationTitle(conversation: RecordValue) {
  const user = userOf(conversation);
  return String(user.name ?? user.userName ?? user.email ?? conversation.title ?? "Carva user");
}

function imageOf(value: RecordValue) {
  const image = value.image ?? value.imageUrl;
  return image ? imageUrl(String(image)) : "";
}

function dateOf(value: RecordValue) {
  const raw = value.lastSeen ?? value.lastSeenAt ?? value.updatedAt ?? value.createdAt;
  const date = raw ? new Date(String(raw)) : null;
  return date && !Number.isNaN(date.getTime()) ? date : null;
}

function presence(value: RecordValue) {
  const date = dateOf(userOf(value));
  if (value.isOnline === true || (date && Date.now() - date.getTime() < 10 * 60 * 1000)) return { label: "Active now", active: true };
  if (!date) return { label: "Last seen unavailable", active: false };
  const days = Math.floor((Date.now() - date.getTime()) / 86400000);
  if (days < 7) return { label: `Last active ${new Intl.DateTimeFormat(undefined, { weekday: "long" }).format(date)}`, active: false };
  return { label: `Last active ${new Intl.DateTimeFormat(undefined, { dateStyle: "medium" }).format(date)}`, active: false };
}

function sharedFromMessage(message: RecordValue): SharedListing | null {
  const body = String(message.body ?? "");
  const marker = body.includes(SHARED_CAR) ? SHARED_CAR : body.includes(SHARED_COMPANY) ? SHARED_COMPANY : "";
  if (marker) {
    try {
      const raw = body.slice(body.indexOf(marker) + marker.length).trim();
      const parsed = JSON.parse(raw);
      if (parsed && typeof parsed === "object") return { kind: marker === SHARED_CAR ? "car" : "company", item: parsed as RecordValue };
    } catch { /* fall back to the structured response below */ }
  }
  const car = asRecord(message.car) ?? asRecord(message.sharedCar);
  if (car) return { kind: "car", item: car };
  const company = asRecord(message.company) ?? asRecord(message.sharedCompany);
  if (company) return { kind: "company", item: company };
  return null;
}

function visibleBody(message: RecordValue) {
  let body = String(message.body ?? "");
  for (const marker of [SHARED_CAR, SHARED_COMPANY]) {
    const index = body.indexOf(marker);
    if (index >= 0) body = body.slice(0, index).trim();
  }
  return body;
}

function payloadFor(listing: SharedListing) {
  const source = listing.item as RecordValue;
  const keys = listing.kind === "car"
    ? ["id", "carId", "title", "name", "image", "imageUrl", "images", "feature", "rentalPlan", "rentalPlans", "brand", "type", "company"]
    : ["id", "companyId", "name", "image", "coverImage", "desc", "cars"];
  return Object.fromEntries(keys.filter((key) => source[key] != null).map((key) => [key, source[key]]));
}

function listingTarget(listing: SharedListing) {
  const item = listing.item as RecordValue;
  return listing.kind === "car"
    ? { carId: String(item.carId ?? item.id ?? "") }
    : { companyId: String(item.companyId ?? item.id ?? "") };
}

function Avatar({ value, active, size = "h-11 w-11" }: { value: RecordValue; active?: boolean; size?: string }) {
  const image = imageOf(value);
  return (
    <span className={`relative grid ${size} shrink-0 place-items-center overflow-hidden rounded-full bg-primary-container`}>
      {image ? <img src={image} alt="" className="h-full w-full object-cover" /> : <Icon name="profile" size={20} color="#3957d7" />}
      {active && <span className="absolute bottom-0 right-0 h-3 w-3 rounded-full border-2 border-white bg-emerald-500" />}
    </span>
  );
}

function InboxItem({ conversation, selected, onClick }: { conversation: RecordValue; selected: boolean; onClick: () => void }) {
  const person = userOf(conversation);
  const status = presence(conversation);
  const last = asRecord(conversation.lastMessage);
  const preview = String(last?.body ?? conversation.lastMessagePreview ?? conversation.preview ?? "Start a conversation").replace(/__CARVA_SHARED_(CAR|COMPANY)__[\s\S]*$/, "Listing shared");
  return (
    <button type="button" onClick={onClick} className={`flex w-full items-center gap-3 rounded-2xl p-3 text-start transition ${selected ? "bg-primary-container" : "hover:bg-surface-lowest"}`}>
      <Avatar value={person} active={status.active} />
      <span className="min-w-0 flex-1">
        <span className="flex items-center justify-between gap-2"><span className="truncate text-sm font-bold text-on-surface">{conversationTitle(conversation)}</span><span className="shrink-0 text-[10px] text-muted">{dateOf(last ?? conversation)?.toLocaleDateString(undefined, { month: "short", day: "numeric" }) ?? ""}</span></span>
        <span className="mt-1 block truncate text-xs text-muted">{preview}</span>
        <span className={`mt-1 block text-[10px] ${status.active ? "font-semibold text-emerald-600" : "text-muted"}`}>{status.label}</span>
      </span>
    </button>
  );
}

export default function ChatPage() {
  const user = useAuth((state) => state.user);
  const router = useRouter();
  const [queryConversation, setQueryConversation] = useState("");
  const [conversations, setConversations] = useState<RecordValue[]>([]);
  const [selectedId, setSelectedId] = useState("");
  const [messages, setMessages] = useState<RecordValue[]>([]);
  const [loading, setLoading] = useState(true);
  const [messageLoading, setMessageLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [text, setText] = useState("");
  const [image, setImage] = useState<File | null>(null);
  const [listing, setListing] = useState<SharedListing | null>(null);
  const [shareOpen, setShareOpen] = useState(false);
  const [sending, setSending] = useState(false);
  const fileRef = useRef<HTMLInputElement>(null);
  const selected = conversations.find((conversation) => idOf(conversation) === selectedId);

  useEffect(() => {
    setQueryConversation(new URLSearchParams(window.location.search).get("conversation") ?? "");
  }, []);

  const loadConversations = useCallback(async () => {
    if (!user) return;
    setLoading(true);
    setError(null);
    try {
      const result = await chatApi.list();
      const next = listFrom(result, "conversations");
      setConversations(next);
      const fromUrl = queryConversation;
      setSelectedId((current) => fromUrl || current || idOf(next[0]));
    } catch (reason) {
      setError(reason instanceof Error ? reason.message : "Unable to load chats right now.");
    } finally {
      setLoading(false);
    }
  }, [user, queryConversation]);

  useEffect(() => { void loadConversations(); }, [loadConversations]);

  const loadMessages = useCallback(async (id: string, silent = false) => {
    if (!id) return;
    if (!silent) setMessageLoading(true);
    try {
      const result = await chatApi.messages(id);
      setMessages(listFrom(result, "messages"));
    } catch (reason) {
      if (!silent) toast(reason instanceof Error ? reason.message : "Unable to load messages.", "error");
    } finally {
      if (!silent) setMessageLoading(false);
    }
  }, []);

  useEffect(() => {
    if (!selectedId) { setMessages([]); return; }
    void loadMessages(selectedId);
    const timer = window.setInterval(() => void loadMessages(selectedId, true), 8000);
    return () => window.clearInterval(timer);
  }, [selectedId, loadMessages]);

  function selectConversation(id: string) {
    setSelectedId(id);
    router.replace(`/chat?conversation=${encodeURIComponent(id)}`, { scroll: false });
  }

  async function send() {
    if (!selectedId || sending || (!text.trim() && !image && !listing)) return;
    setSending(true);
    try {
      const fd = new FormData();
      fd.append("conversationId", selectedId);
      const marker = listing ? (listing.kind === "car" ? SHARED_CAR : SHARED_COMPANY) + JSON.stringify(payloadFor(listing)) : "";
      const body = [text.trim(), marker].filter(Boolean).join("\n");
      if (body) fd.append("body", body);
      if (image) fd.append("image", image, image.name);
      const target = listing ? listingTarget(listing) : {};
      Object.entries(target).forEach(([key, value]) => value && fd.append(key, String(value)));
      await chatApi.send(fd);
      setText(""); setImage(null); setListing(null);
      await loadMessages(selectedId, true);
    } catch (reason) {
      toast(reason instanceof Error ? reason.message : "Message could not be sent.", "error");
    } finally { setSending(false); }
  }

  if (!user) return <AppShell><AuthPrompt message="Sign in to chat with car owners and companies." /></AppShell>;

  return (
    <AppShell>
      <div className="px-4 py-5">
        <div className="mb-4 flex items-center justify-between"><div><h1 className="text-xl font-extrabold">Messages</h1><p className="mt-1 text-sm text-muted">Chat with companies and personal car owners.</p></div><button type="button" onClick={() => void loadConversations()} className="grid h-10 w-10 place-items-center rounded-full bg-surface-lowest" aria-label="Refresh chats"><Icon name="status" size={18} color="#3957d7" /></button></div>
        <div className="grid min-h-[650px] overflow-hidden rounded-3xl border border-surface-low bg-white shadow-[0_12px_40px_-28px_rgba(35,38,46,.35)] lg:grid-cols-[minmax(260px,340px)_1fr]">
          <aside className={`${selectedId ? "hidden lg:block" : "block"} border-b border-surface-low lg:border-b-0 lg:border-e`}>
            <div className="border-b border-surface-low p-4"><div className="flex items-center gap-2 rounded-xl bg-surface-lowest px-3"><Icon name="search" size={17} color="#9e9e9e" /><input placeholder="Search chats" className="h-11 min-w-0 flex-1 bg-transparent text-sm outline-none" /></div></div>
            <div className="space-y-1 p-2">{loading ? <div className="flex justify-center py-12"><Spinner size={28} /></div> : error ? <div className="px-4 py-10 text-center text-sm text-danger">{error}<button type="button" onClick={() => void loadConversations()} className="mt-3 block w-full font-semibold text-primary">Try again</button></div> : conversations.length === 0 ? <div className="px-4 py-12 text-center text-sm text-muted">No chats yet. Open a car or company and tap Message.</div> : conversations.map((conversation) => <InboxItem key={idOf(conversation)} conversation={conversation} selected={idOf(conversation) === selectedId} onClick={() => selectConversation(idOf(conversation))} />)}</div>
          </aside>
          <section className={`${selectedId ? "block" : "hidden lg:block"} min-w-0`}>
            {!selected ? <div className="grid h-full min-h-[650px] place-items-center p-8 text-center"><div><span className="mx-auto grid h-16 w-16 place-items-center rounded-3xl bg-primary-container"><Icon name="chat_active" size={32} color="#3957d7" /></span><h2 className="mt-4 text-lg font-bold">Choose a conversation</h2><p className="mt-1 max-w-sm text-sm text-muted">Your shared cars, companies, photos, and messages will appear here.</p></div></div> : <Conversation conversation={selected} messages={messages} loading={messageLoading} currentUserId={user.userId} text={text} setText={setText} image={image} setImage={setImage} listing={listing} setListing={setListing} sending={sending} send={send} onShare={() => setShareOpen(true)} onBack={() => { setSelectedId(""); router.replace("/chat", { scroll: false }); }} fileRef={fileRef} />}
          </section>
        </div>
      </div>
      <ShareListingModal open={shareOpen} onClose={() => setShareOpen(false)} onSelect={(value) => { setListing(value); setShareOpen(false); }} />
    </AppShell>
  );
}

function Conversation({ conversation, messages, loading, currentUserId, text, setText, image, setImage, listing, setListing, sending, send, onShare, onBack, fileRef }: { conversation: RecordValue; messages: RecordValue[]; loading: boolean; currentUserId: string; text: string; setText: (value: string) => void; image: File | null; setImage: (value: File | null) => void; listing: SharedListing | null; setListing: (value: SharedListing | null) => void; sending: boolean; send: () => void; onShare: () => void; onBack: () => void; fileRef: RefObject<HTMLInputElement | null> }) {
  const person = userOf(conversation);
  const status = presence(conversation);
  return (
    <div className="flex h-full min-h-[650px] flex-col">
      <header className="flex items-center gap-3 border-b border-surface-low p-4"><button type="button" onClick={onBack} className="grid h-9 w-9 place-items-center rounded-full bg-surface-lowest lg:hidden" aria-label="Back"><Icon name="arrow" size={17} /></button><Avatar value={person} active={status.active} /><button type="button" className="min-w-0 text-start"><span className="block truncate text-sm font-bold">{conversationTitle(conversation)}</span><span className={`block text-xs ${status.active ? "text-emerald-600" : "text-muted"}`}>{status.label}</span></button></header>
      <div className="flex-1 space-y-3 overflow-y-auto bg-surface-lowest/40 p-4">{loading ? <div className="flex justify-center py-10"><Spinner size={26} /></div> : messages.length === 0 ? <p className="py-20 text-center text-sm text-muted">Start the conversation.</p> : messages.map((message, index) => <Message key={String(message.id ?? index)} message={message} currentUserId={currentUserId} />)}</div>
      <div className="border-t border-surface-low bg-white p-3"><div className="mb-2 flex items-center gap-2">{listing && <div className="relative max-w-[220px]"><ChatSharedCard listing={listing} compact /><button type="button" onClick={() => setListing(null)} className="absolute -right-2 -top-2 grid h-6 w-6 place-items-center rounded-full bg-on-surface text-white" aria-label="Remove listing"><Icon name="cancel" size={12} color="#fff" /></button></div>}{image && <div className="flex items-center gap-2 rounded-xl bg-primary-container p-2 text-xs font-semibold text-primary"><Icon name="image" size={16} color="#3957d7" />{image.name}<button type="button" onClick={() => setImage(null)} aria-label="Remove photo"><Icon name="cancel" size={14} color="#3957d7" /></button></div>}</div><div className="flex items-end gap-2"><input ref={fileRef} type="file" accept="image/*" hidden onChange={(event) => setImage(event.target.files?.[0] ?? null)} /><button type="button" onClick={() => fileRef.current?.click()} className="grid h-11 w-11 shrink-0 place-items-center rounded-full bg-surface-lowest" aria-label="Add photo"><Icon name="image" size={19} color="#3957d7" /></button><button type="button" onClick={onShare} className="grid h-11 w-11 shrink-0 place-items-center rounded-full bg-primary-container" aria-label="Share a car or company"><Icon name="car" size={19} color="#3957d7" /></button><textarea value={text} onChange={(event) => setText(event.target.value)} onKeyDown={(event) => { if (event.key === "Enter" && !event.shiftKey) { event.preventDefault(); send(); } }} placeholder="Write a message..." rows={1} className="min-h-11 max-h-28 flex-1 resize-none rounded-2xl border border-surface-low bg-surface-lowest px-4 py-3 text-sm outline-none focus:border-primary" /><Button type="button" onClick={send} loading={sending} className="h-11 w-11 !p-0" aria-label="Send"><Icon name="arrow_tail" size={18} color="#fff" style={{ transform: "rotate(-90deg)" }} /></Button></div></div>
    </div>
  );
}

function Message({ message, currentUserId }: { message: RecordValue; currentUserId: string }) {
  const sender = asRecord(message.sender);
  const senderId = message.senderId ?? message.fromUserId ?? sender?.userId ?? sender?.id;
  const mine = message.isMine === true || message.fromMe === true || String(senderId ?? "") === currentUserId;
  const shared = sharedFromMessage(message);
  const rawImage = message.imageUrl ?? message.image;
  const image = rawImage ? String(rawImage) : "";
  const body = visibleBody(message);
  const time = message.createdAt ? new Date(String(message.createdAt)).toLocaleTimeString([], { hour: "numeric", minute: "2-digit" }) : "";
  return <div className={`flex ${mine ? "justify-end" : "justify-start"}`}><div className={`max-w-[86%] rounded-2xl px-3 py-2 ${mine ? "rounded-br-md bg-primary text-white" : "rounded-bl-md border border-surface-low bg-white text-on-surface"}`}>{shared && <div className="mb-2"><ChatSharedCard listing={shared} compact /></div>}{image && <img src={imageUrl(String(image))} alt="Shared photo" className="mb-2 max-h-64 w-full rounded-xl object-cover" />}{body && <p className="whitespace-pre-wrap text-sm leading-relaxed">{body}</p>}{time && <p className={`mt-1 text-[10px] ${mine ? "text-white/70" : "text-muted"}`}>{time}</p>}</div></div>;
}
