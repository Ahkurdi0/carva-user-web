"use client";

import type { ButtonHTMLAttributes } from "react";
import { Icon, type IconName } from "./Icon";
import { Spinner } from "./ui";

type Tone = "chat" | "whatsapp" | "neutral";

const tones: Record<Tone, { button: string; badge: string; icon: string }> = {
  chat: {
    button:
      "bg-gradient-to-b from-[#c8161e] to-[#a10f16] text-white shadow-[0_10px_24px_-10px_rgba(181,18,25,0.75)] hover:shadow-[0_14px_28px_-10px_rgba(181,18,25,0.85)]",
    badge: "bg-white/20",
    icon: "#fff",
  },
  whatsapp: {
    button:
      "bg-gradient-to-b from-[#2bd96f] to-[#1fb85a] text-white shadow-[0_10px_24px_-10px_rgba(31,184,90,0.75)] hover:shadow-[0_14px_28px_-10px_rgba(31,184,90,0.85)]",
    badge: "bg-white/20",
    icon: "#fff",
  },
  neutral: {
    button: "border border-surface-low bg-white text-on-surface shadow-sm hover:border-primary/40 hover:bg-surface-lowest",
    badge: "bg-primary-container",
    icon: "#B51219",
  },
};

/**
 * The big contact buttons on the car and company pages (Chat, WhatsApp,
 * Contact): pill with a tinted icon badge, soft coloured shadow and a
 * small lift on hover. `compact` hides the label below the sm breakpoint.
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
      className={`group inline-flex h-[52px] items-center justify-center gap-2.5 rounded-2xl px-4 text-[15px] font-bold transition duration-200 hover:-translate-y-0.5 active:translate-y-0 disabled:translate-y-0 disabled:opacity-60 ${t.button} ${className}`}
    >
      {loading ? (
        <Spinner size={20} light={tone !== "neutral"} />
      ) : (
        <>
          <span className={`grid h-8 w-8 shrink-0 place-items-center rounded-full ${t.badge}`}>
            <Icon name={icon} size={17} color={t.icon} />
          </span>
          <span className={compact ? "hidden sm:inline" : ""}>{label}</span>
        </>
      )}
    </button>
  );
}
