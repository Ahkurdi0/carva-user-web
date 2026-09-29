"use client";

import Link from "next/link";
import { Icon } from "@/components/Icon";
import { useI18n } from "@/i18n";
import { imageUrl } from "@/lib/api";
import { formatNumber } from "@/lib/format";
import type { ChatCar, ChatCompany, ChatMessage } from "@/lib/chat";

export function CompanyAvatar({ company, size = 44 }: { company: ChatCompany; size?: number }) {
  return (
    <span
      className="grid shrink-0 place-items-center overflow-hidden rounded-full bg-primary-container font-bold text-primary"
      style={{ width: size, height: size }}
    >
      {company.image ? (
        // eslint-disable-next-line @next/next/no-img-element
        <img src={imageUrl(company.image)} alt="" className="h-full w-full object-cover" />
      ) : (
        company.name.charAt(0).toUpperCase()
      )}
    </span>
  );
}

/** "14:05" for today, "Yesterday", or a short date — same rule as the app list. */
export function useChatTime() {
  const { t, lang } = useI18n();
  const locale = lang === "en" ? "en-GB" : lang === "ar" ? "ar-IQ" : "ckb-IQ";
  const time = (iso: string) =>
    new Date(iso).toLocaleTimeString(locale, { hour: "2-digit", minute: "2-digit" });
  const dayLabel = (iso: string) => {
    const d = new Date(iso);
    const today = new Date();
    const yesterday = new Date(Date.now() - 864e5);
    if (d.toDateString() === today.toDateString()) return t("chat.today");
    if (d.toDateString() === yesterday.toDateString()) return t("chat.yesterday");
    return d.toLocaleDateString(locale, { day: "numeric", month: "short", year: "numeric" });
  };
  const listTime = (iso: string) => {
    const d = new Date(iso);
    return d.toDateString() === new Date().toDateString() ? time(iso) : dayLabel(iso);
  };
  return { time, dayLabel, listTime };
}

export function ChatCarCard({ car, mine, label }: { car: ChatCar; mine?: boolean; label?: string }) {
  const { t } = useI18n();
  const image = car.images?.[0]?.image;
  const plan = car.rentalPlan?.[0];
  return (
    <Link
      href={`/car/${car.carId}`}
      className={`flex w-72 max-w-full items-center gap-3 rounded-2xl border p-2 transition hover:opacity-90 ${
        mine ? "border-primary/30 bg-primary-container" : "border-surface-low bg-white"
      }`}
    >
      {image ? (
        // eslint-disable-next-line @next/next/no-img-element
        <img src={imageUrl(image)} alt="" className="h-14 w-20 shrink-0 rounded-xl object-cover" />
      ) : (
        <span className="grid h-14 w-20 shrink-0 place-items-center rounded-xl bg-surface-lowest">
          <Icon name="car" size={22} color="#9e9e9e" />
        </span>
      )}
      <span className="min-w-0">
        <span className="block text-[11px] font-semibold uppercase text-muted">{label ?? t("chat.aboutCar")}</span>
        <span className="block truncate text-sm font-bold text-on-surface">{car.title}</span>
        {plan && (
          <span className="block text-xs font-semibold text-primary">
            {formatNumber(plan.price)} {plan.currency === "iqd" ? "IQD" : "$"}
          </span>
        )}
      </span>
    </Link>
  );
}

/** Renders text with http(s) links made clickable (the server's reach-out messages carry a wa.me link). */
function Linkified({ text }: { text: string }) {
  const parts = text.split(/(https?:\/\/\S+)/g);
  return (
    <>
      {parts.map((p, i) =>
        /^https?:\/\//.test(p) ? (
          <a key={i} href={p} target="_blank" rel="noopener noreferrer" className="break-all underline">
            {p}
          </a>
        ) : (
          <span key={i}>{p}</span>
        ),
      )}
    </>
  );
}

/** Quick-contact (after the first message) and auto-reply (after an hour) cards: WhatsApp first, phone second. */
export function ReachOutCard({
  message,
  company,
  whatsapp,
  phone,
  time,
}: {
  message: ChatMessage;
  company?: ChatCompany | null;
  whatsapp: string | null;
  phone: string | null;
  time: string;
}) {
  const { t } = useI18n();
  const auto = message.type === "autoReply";
  const name = company?.name ?? "";
  return (
    <div className="mx-auto w-full max-w-sm rounded-2xl border border-surface-low bg-white p-4 shadow-sm">
      <div className="flex items-center gap-2">
        <span className="grid h-8 w-8 place-items-center rounded-full bg-[#25D366]/15">
          <Icon name="whatsapp" size={16} color="#1DA851" />
        </span>
        <p className="flex-1 text-sm font-bold text-on-surface">{auto ? t("chat.autoReplyTitle") : t("chat.quickTitle")}</p>
        <span className="text-[11px] text-muted">{time}</span>
      </div>
      <p className="mt-2 text-sm text-muted">
        {whatsapp || phone
          ? auto
            ? t("chat.autoReplyBody", { name })
            : t("chat.quickBody", { name })
          : message.body && <Linkified text={message.body} />}
      </p>
      {whatsapp && (
        <a
          href={whatsapp}
          target="_blank"
          rel="noopener noreferrer"
          className="mt-3 flex items-center justify-center gap-2 rounded-full bg-[#25D366] px-4 py-2.5 text-sm font-bold text-white transition hover:opacity-90"
        >
          <Icon name="whatsapp" size={18} color="#fff" /> {t("chat.whatsappCta")}
          <span className="rounded-full bg-white/25 px-2 py-0.5 text-[10px] font-semibold">{t("chat.fastest")}</span>
        </a>
      )}
      {phone && (
        <a
          href={`tel:${phone}`}
          className="mt-2 flex items-center justify-center gap-2 rounded-full border border-surface-low px-4 py-2 text-sm font-semibold text-on-surface transition hover:bg-surface-lowest"
        >
          <Icon name="call" size={16} color="#B51219" /> {t("chat.call")} · <span dir="ltr">{phone}</span>
        </a>
      )}
    </div>
  );
}

export function MessageBubble({
  message,
  time,
  onRetry,
}: {
  message: ChatMessage;
  time: string;
  onRetry?: () => void;
}) {
  const { t } = useI18n();
  const mine = message.sender === "user";
  return (
    <div className={`flex ${mine ? "justify-end" : "justify-start"}`}>
      <div className="max-w-[78%]">
        <div
          className={`rounded-2xl px-3.5 py-2 text-sm shadow-sm ${
            mine ? "rounded-ee-md bg-primary text-white" : "rounded-es-md border border-surface-low bg-white text-on-surface"
          } ${message.pending ? "opacity-70" : ""}`}
        >
          <p dir="auto" className="whitespace-pre-wrap break-words">
            {message.body && <Linkified text={message.body} />}
          </p>
          <p className={`mt-0.5 flex items-center justify-end gap-1 text-[10.5px] ${mine ? "text-white/75" : "text-muted"}`}>
            {time}
            {mine && !message.pending && !message.failed && (
              <span title={message.readAt ? t("chat.seen") : t("chat.sent")}>{message.readAt ? "✓✓" : "✓"}</span>
            )}
          </p>
        </div>
        {message.failed && (
          <button onClick={onRetry} className="mt-1 block w-full text-end text-xs font-semibold text-danger">
            {t("chat.failed")}
          </button>
        )}
      </div>
    </div>
  );
}
