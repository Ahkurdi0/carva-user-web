"use client";

import Link from "next/link";
import { Icon } from "@/components/Icon";
import { useI18n } from "@/i18n";
import { imageUrl } from "@/lib/api";
import { formatNumber } from "@/lib/format";
import type { ChatCar, ChatCompany, ChatMessage } from "@/lib/chat";

/** Round company logo (header, list, intro): logo on a light circle with a hairline. */
export function CompanyAvatar({ company, size = 44 }: { company?: ChatCompany | null; size?: number }) {
  return (
    <span
      className="grid shrink-0 place-items-center overflow-hidden rounded-full border border-hairline bg-surface-lowest font-bold text-primary"
      style={{ width: size, height: size, fontSize: size * 0.4 }}
    >
      {company?.image ? (
        // eslint-disable-next-line @next/next/no-img-element
        <img src={imageUrl(company.image)} alt="" className="h-full w-full object-cover" />
      ) : (
        (company?.name ?? "?").charAt(0).toUpperCase()
      )}
    </span>
  );
}

/** "14:05" for today, "Yesterday", or a short date — same rule as the app. */
export function useChatTime() {
  const { t } = useI18n();
  // Times and dates in Latin digits, like the app's mono labels.
  const locale = "en-GB";
  const time = (iso: string) => new Date(iso).toLocaleTimeString(locale, { hour: "2-digit", minute: "2-digit" });
  const dayLabel = (iso: string) => {
    const d = new Date(iso);
    const today = new Date();
    const yesterday = new Date(Date.now() - 864e5);
    if (d.toDateString() === today.toDateString()) return t("chat.today");
    if (d.toDateString() === yesterday.toDateString()) return t("chat.yesterday");
    const pad = (n: number) => String(n).padStart(2, "0");
    return `${d.getFullYear()}/${pad(d.getMonth() + 1)}/${pad(d.getDate())}`;
  };
  const listTime = (iso: string) => {
    const d = new Date(iso);
    return d.toDateString() === new Date().toDateString() ? time(iso) : dayLabel(iso);
  };
  return { time, dayLabel, listTime };
}

/** Red count bubble (chat list and tab icon). */
export function UnreadBadge({ count }: { count: number }) {
  return (
    <span className="num grid h-[22px] min-w-[22px] shrink-0 place-items-center rounded-full bg-primary px-1.5 text-[11px] font-bold leading-none text-white">
      {count > 99 ? "99+" : count}
    </span>
  );
}

/** Day pill between messages. */
export function DaySeparator({ label }: { label: string }) {
  return (
    <div className="flex justify-center py-3">
      <span className="rounded-full bg-surface-lowest px-3 py-1 text-[11px] font-semibold text-muted">{label}</span>
    </div>
  );
}

function priceOf(car: ChatCar) {
  const plan = car.rentalPlan?.[0];
  if (!plan || !(Number(plan.price) > 0)) return null;
  return plan.currency === "usd" ? `$${formatNumber(plan.price)}` : `${formatNumber(plan.price)} IQD`;
}

/** The car a question is about: photo on top, "About this car", title, price. */
export function ChatCarCard({ car, mine, label }: { car: ChatCar; mine?: boolean; label?: string }) {
  const { t } = useI18n();
  const image = car.images?.[0]?.image;
  const price = priceOf(car);
  return (
    <div className={`flex py-1 ${mine ? "justify-end" : "justify-start"}`}>
      <Link
        href={`/car/${car.carId}`}
        className="press block w-[66vw] max-w-[280px] overflow-hidden rounded-[20px] border border-hairline bg-white shadow-[0_8px_24px_-12px_rgba(0,0,0,0.18)]"
      >
        {image ? (
          // eslint-disable-next-line @next/next/no-img-element
          <img src={imageUrl(image)} alt="" className="h-[34vw] max-h-[150px] w-full object-cover" />
        ) : (
          <span className="grid h-[34vw] max-h-[150px] w-full place-items-center bg-surface-lowest">
            <Icon name="car" size={28} color="#BCB4B0" />
          </span>
        )}
        <span className="block p-3">
          <span className="block text-[11px] font-bold text-primary">{label ?? t("chat.aboutCar")}</span>
          <span className="mt-0.5 block truncate text-[15px] font-bold text-on-surface"><bdi>{car.title}</bdi></span>
          {price && <span className="num mt-0.5 block text-[14px] font-bold text-on-surface">{price}</span>}
        </span>
      </Link>
    </div>
  );
}

/** Composer version: one row on the red tint, with a close button. */
export function ComposerCarCard({ car, onClose }: { car: ChatCar; onClose: () => void }) {
  const { t } = useI18n();
  const image = car.images?.[0]?.image;
  const price = priceOf(car);
  return (
    <div className="flex items-center gap-3 rounded-2xl bg-primary-container p-2">
      {image ? (
        // eslint-disable-next-line @next/next/no-img-element
        <img src={imageUrl(image)} alt="" className="h-12 w-16 shrink-0 rounded-xl object-cover" />
      ) : (
        <span className="grid h-12 w-16 shrink-0 place-items-center rounded-xl bg-white">
          <Icon name="car" size={20} color="#BCB4B0" />
        </span>
      )}
      <span className="min-w-0 flex-1">
        <span className="block text-[11px] font-bold text-primary">{t("chat.aboutCar")}</span>
        <span className="block truncate text-[14px] font-bold"><bdi>{car.title}</bdi></span>
        {price && <span className="num block text-[12px] font-semibold">{price}</span>}
      </span>
      <button onClick={onClose} aria-label="close" className="grid h-8 w-8 shrink-0 place-items-center rounded-full text-muted hover:bg-white/60">
        <Icon name="cancel" size={14} color="#6E6866" />
      </button>
    </div>
  );
}

/** Renders text with http(s) links made clickable. */
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

/**
 * The two system messages pointing to WhatsApp and phone: "quickContact"
 * right after the first message, "autoReply" after an hour with no answer.
 * WhatsApp is the big green action (with its wa.me link); the phone is the
 * smaller second option.
 */
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
    <div className="py-2">
      <div
        className={`mx-auto w-full max-w-sm rounded-[22px] border bg-white p-4 shadow-[0_8px_24px_-14px_rgba(0,0,0,0.2)] ${
          auto ? "border-primary/25" : "border-whatsapp/25"
        }`}
      >
        <div className="flex items-start gap-3">
          <span className={`grid h-10 w-10 shrink-0 place-items-center rounded-full ${auto ? "bg-primary" : "bg-whatsapp"}`}>
            <Icon name={auto ? "clock" : "whatsapp"} size={20} color="#fff" />
          </span>
          <div className="min-w-0 flex-1">
            <p className="text-[15px] font-bold text-on-surface">{auto ? t("chat.autoReplyTitle") : t("chat.quickTitle")}</p>
            <p className="mt-1 text-[13.5px] leading-relaxed text-muted">
              {whatsapp || phone
                ? auto
                  ? t("chat.autoReplyBody", { name })
                  : t("chat.quickBody", { name })
                : message.body && <Linkified text={message.body} />}
            </p>
          </div>
        </div>
        {whatsapp && (
          <a
            href={whatsapp}
            target="_blank"
            rel="noopener noreferrer"
            className="press mt-3 flex items-center gap-3 rounded-[18px] bg-whatsapp px-4 py-3 text-white"
          >
            <Icon name="whatsapp" size={24} color="#fff" />
            <span className="min-w-0 flex-1">
              <span className="block text-[15px] font-bold">{t("chat.whatsappCta")}</span>
              <span className="num block truncate text-[12px] text-white/80 underline decoration-white/50" dir="ltr">
                {whatsapp.replace(/^https?:\/\//, "")}
              </span>
            </span>
            <span className="shrink-0 rounded-full bg-white/20 px-2 py-0.5 text-[11px] font-semibold">{t("chat.fastest")}</span>
          </a>
        )}
        {phone && (
          <a
            href={`tel:${phone}`}
            className="press mt-2 flex items-center gap-3 rounded-[18px] border border-border-strong bg-white px-4 py-3"
          >
            <Icon name="call" size={20} color="#171214" />
            <span className="flex-1 text-[14px] font-semibold">{t("chat.call")}</span>
            <span className="num text-[13px] text-muted" dir="ltr">{phone}</span>
          </a>
        )}
        <p className="num mt-2 text-end text-[11px] text-hint">{time}</p>
      </div>
    </div>
  );
}

/**
 * A text message. Mine: red, on the end side; theirs: white with a hairline.
 * `status` shows "Sent" / "Seen" under the customer's latest message.
 */
export function MessageBubble({
  message,
  time,
  status,
  onRetry,
}: {
  message: ChatMessage;
  time: string;
  status?: boolean;
  onRetry?: () => void;
}) {
  const { t } = useI18n();
  const mine = message.sender === "user";
  return (
    <div className={`flex py-[3px] ${mine ? "justify-end" : "justify-start"}`}>
      <div className={`flex max-w-[78%] flex-col ${mine ? "items-end" : "items-start"}`}>
        <div
          className={`rounded-[20px] px-[15px] pb-[7px] pt-[9px] ${
            mine
              ? `rounded-ee-[6px] text-white ${message.failed ? "bg-primary/55" : "bg-primary"}`
              : "rounded-es-[6px] border border-hairline bg-white text-on-surface shadow-[0_2px_8px_rgba(0,0,0,0.03)]"
          } ${message.pending ? "opacity-70" : ""}`}
        >
          <p dir="auto" className="whitespace-pre-wrap break-words text-[15px] leading-[1.45]">
            {message.body && <Linkified text={message.body} />}
          </p>
          <p className={`num mt-0.5 text-end text-[11px] ${mine ? "text-white/65" : "text-on-surface/65"}`}>{time}</p>
        </div>
        {message.failed ? (
          <button onClick={onRetry} className="mt-1 text-[12px] font-semibold text-primary">
            {t("chat.failed")}
          </button>
        ) : (
          status &&
          !message.pending && <span className="mt-1 text-[12px] text-hint">{message.readAt ? t("chat.seen") : t("chat.sent")}</span>
        )}
      </div>
    </div>
  );
}
