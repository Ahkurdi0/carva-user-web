"use client";

import type { ButtonHTMLAttributes } from "react";
import { Icon, type IconName } from "./Icon";
import { Spinner } from "./ui";

type Tone = "chat" | "whatsapp" | "neutral";

const tones: Record<Tone, { button: string; icon: string }> = {
  chat: { button: "bg-primary text-white shadow-[var(--shadow-card)] hover:bg-primary-hover", icon: "#fff" },
  whatsapp: { button: "bg-whatsapp text-white shadow-[var(--shadow-card)] hover:bg-[#1C9647]", icon: "#fff" },
  neutral: { button: "border border-hairline bg-white text-on-surface hover:bg-surface-lowest", icon: "#171214" },
};

/**
 * The big contact buttons on the car and company pages (Chat, WhatsApp,
 * Contact): the app's pill buttons — red, WhatsApp green or white with a
 * hairline — with a soft shadow and a spring press. `compact` hides the label below the sm breakpoint.
 */
export function ActionButton({
  tone,
  icon,
  label,
  loading = false,
  compact = false,
  className = "",
  ...props
}: {
  tone: Tone;
  icon: IconName;
  label: string;
  loading?: boolean;
  compact?: boolean;
} & ButtonHTMLAttributes<HTMLButtonElement>) {
  const t = tones[tone];
  return (
    <button
      type="button"
      {...props}
      disabled={loading || props.disabled}
      aria-label={label}
      className={`press group inline-flex h-12 items-center justify-center gap-2 rounded-full px-4 text-[15px] font-semibold transition disabled:opacity-60 ${t.button} ${className}`}
    >
      {loading ? (
        <Spinner size={20} light={tone !== "neutral"} />
      ) : (
        <>
          <Icon name={icon} size={19} color={t.icon} />
          <span className={compact ? "hidden sm:inline" : ""}>{label}</span>
        </>
      )}
    </button>
  );
}
