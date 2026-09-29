"use client";

import { api } from "./api";
import type { Contact } from "./types";

/**
 * Customer chat with rental companies — the same /user/chat endpoints the
 * User app uses (kcars-server src/routes/chat.ts).
 */

export interface ChatCar {
  id: string;
  /** Public id used in /car/<carId> links. */
  carId: string;
  title: string;
  images?: { id?: string; image: string; sort?: number }[];
  rentalPlan?: { id: string; price: number; periodType: string; currency: string }[];
}

export interface ChatCompany {
  id: string;
  name: string;
  image?: string | null;
  /** WhatsApp number the car page's WhatsApp button uses. */
  contact?: string | null;
  contacts?: Contact[];
}

export interface ChatSummary {
  id: string;
  lastMessage: string | null;
  lastSender: string | null;
  lastMessageAt: string;
  userUnread: number;
  awaitingReplySince: string | null;
  company: ChatCompany;
  lastCar: ChatCar | null;
}

export interface ChatMessage {
  id: string;
  /** "user" (me), "company" or "system" */
  sender: string;
  /** "text", "car", "quickContact" or "autoReply" */
  type: string;
  body: string | null;
  readAt: string | null;
  createdAt: string;
  car: ChatCar | null;
  /** Client-only: still sending / failed to send. */
  pending?: boolean;
  failed?: boolean;
}

export interface ChatPage {
  conversation: {
    id: string;
    awaitingReplySince: string | null;
    createdAt: string;
    company: ChatCompany;
    lastCar: ChatCar | null;
  } | null;
  messages: ChatMessage[];
  hasMore: boolean;
}

export const chatApi = {
  list: (cursor?: string | null) =>
    api.json<{ data: ChatSummary[]; nextCursor: string | null }>("/user/chat/list", { cursor: cursor ?? null }),
  unread: () => api.json<{ count: number }>("/user/chat/unread", {}),
  /** Opens (or creates) the chat with a company, directly or through one of its cars. */
  start: (p: { companyId?: string; carId?: string }) => api.json<{ id: string }>("/user/chat/start", p),
  messages: (id: string, opts: { before?: string; after?: string } = {}) =>
    api.json<ChatPage>("/user/chat/messages", { id, ...opts }),
  /** carId (public) adds a card for that car before the text when it is new to the chat. */
  send: (id: string, body: string, carId?: string | null) =>
    api.json<ChatMessage[]>("/user/chat/send", { id, body, carId: carId ?? null }),
};

/** WhatsApp link for a company: Company.contact first, else a WhatsApp contact. */
export function whatsappUrl(company?: ChatCompany | null): string | null {
  const raw =
    company?.contact?.trim() ||
    company?.contacts?.find((c) => c.type === "whatsapp")?.value;
  const digits = raw?.replace(/\D/g, "");
  return digits ? `https://wa.me/${digits}` : null;
}

export function phoneOf(company?: ChatCompany | null): string | null {
  const c = company?.contacts?.find((x) => x.type === "phone");
  return c ? `${c.countrCode ?? ""}${c.value}`.replace(/\s/g, "") : null;
}
