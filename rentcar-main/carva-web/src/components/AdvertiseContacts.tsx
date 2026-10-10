"use client";

import { advertiseApi, type AdvertisePage } from "@/lib/services";

const ICON: Record<string, string> = { whatsapp: "🟢", telegram: "✈️", phone: "📞", email: "✉️", instagram: "📸" };
const LABEL: Record<string, string> = { whatsapp: "WhatsApp", telegram: "Telegram", phone: "Call", email: "Email", instagram: "Instagram" };

/**
 * CARVA's contact buttons from the "Advertise" settings (dashboard). Each
 * tap is counted: "<channel>" on the Advertise page, "join_<channel>"
 * from "Add your office".
 */
export function AdvertiseContacts({ contacts, join = false }: { contacts: NonNullable<AdvertisePage["contacts"]>; join?: boolean }) {
  return (
    <div className="grid gap-2">
      {contacts.map((c) => (
        <a
          key={c.channel}
          href={c.url}
          target={c.channel === "phone" || c.channel === "email" ? undefined : "_blank"}
          rel="noopener noreferrer"
          onClick={() => advertiseApi.event(join ? `join_${c.channel}` : c.channel)}
          className={`flex h-14 items-center gap-3 rounded-2xl px-4 text-start font-semibold transition ${
            c.channel === "whatsapp" ? "bg-[#1fa855] text-white hover:bg-[#1a9549]" : "border border-surface-low bg-white hover:bg-surface-lowest"
          }`}
        >
          <span className="text-xl">{ICON[c.channel] ?? "•"}</span>
          <span className="flex-1">{LABEL[c.channel] ?? c.channel}</span>
          <span className={`text-sm ${c.channel === "whatsapp" ? "text-white/80" : "text-muted"}`} dir="ltr">
            {c.value}
          </span>
        </a>
      ))}
    </div>
  );
}
