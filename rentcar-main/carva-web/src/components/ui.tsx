"use client";

import Link from "next/link";
import type { ButtonHTMLAttributes, ReactNode } from "react";
import { Icon, type IconName } from "./Icon";
import { useI18n } from "@/i18n";

/* ------------------------------ Button ------------------------------ */
type Variant = "primary" | "secondary" | "outline" | "ghost" | "danger" | "tint" | "whatsapp";

export function Button({
  children,
  variant = "primary",
  loading = false,
  full = false,
  className = "",
  ...props
}: {
  variant?: Variant;
  loading?: boolean;
  full?: boolean;
} & ButtonHTMLAttributes<HTMLButtonElement>) {
  const styles: Record<Variant, string> = {
    primary: "bg-primary text-white shadow-[var(--shadow-card)] hover:bg-primary-hover",
    secondary: "bg-hero text-white shadow-[var(--shadow-card)] hover:bg-hero/90",
    outline: "border border-border-strong bg-white text-on-surface hover:bg-surface-lowest",
    ghost: "text-on-surface hover:bg-surface-lowest",
    danger: "bg-danger text-white shadow-[var(--shadow-card)] hover:bg-danger/90",
    tint: "bg-primary-container text-primary hover:bg-primary-container/70",
    whatsapp: "bg-whatsapp text-white shadow-[var(--shadow-card)] hover:brightness-95",
  };
  return (
    <button
      {...props}
      disabled={loading || props.disabled}
      className={`press inline-flex h-12 items-center justify-center gap-2 rounded-2xl px-6 text-[15px] font-semibold transition disabled:opacity-60 ${
        full ? "w-full" : ""
      } ${styles[variant]} ${className}`}
    >
      {loading ? <Spinner size={18} light={variant === "primary" || variant === "secondary" || variant === "danger" || variant === "whatsapp"} /> : children}
    </button>
  );
}

/* ------------------------------ Spinner ------------------------------ */
export function Spinner({ size = 22, light = false }: { size?: number; light?: boolean }) {
  return (
    <span
      className="inline-block animate-spin rounded-full border-2 border-current border-t-transparent"
      style={{ width: size, height: size, color: light ? "#fff" : "var(--color-primary)" }}
    />
  );
}

export function PageLoading() {
  return (
    <div className="flex min-h-[40vh] items-center justify-center">
      <Spinner size={34} />
    </div>
  );
}

/* ------------------------------ Rating ------------------------------ */
export function Rating({
  rate,
  review,
  size = 14,
}: {
  rate?: number | null;
  review?: number | null;
  size?: number;
}) {
  const r = rate ?? 0;
  return (
    <span className="inline-flex items-center gap-1 text-xs font-medium text-on-surface">
      <Icon name="star_fill" size={size} color="#A9770F" />
      <span className="num font-semibold">{r > 0 ? r.toFixed(1) : "–"}</span>
      {review != null && review > 0 && (
        <span className="text-muted">({review})</span>
      )}
    </span>
  );
}

/* ------------------------------ Pill / Chip ------------------------------ */
export function Chip({
  label,
  selected = false,
  onClick,
}: {
  label: string;
  selected?: boolean;
  onClick?: () => void;
}) {
  return (
    <button
      type="button"
      onClick={onClick}
      className={`press h-9 whitespace-nowrap rounded-xl px-3.5 text-[13px] font-semibold transition ${
        selected
          ? "bg-hero text-white shadow-[var(--shadow-card)]"
          : "bg-white text-on-surface ring-1 ring-hairline hover:ring-border-strong"
      }`}
    >
      {label}
    </button>
  );
}

/* ------------------------------ Section header ------------------------------ */
export function SectionHeader({
  title,
  actionLabel,
  href,
  onAction,
}: {
  title: string;
  actionLabel?: string;
  href?: string;
  onAction?: () => void;
}) {
  return (
    <div className="mb-3.5 flex min-h-10 items-center justify-between gap-3 px-4">
      <h2 className="flex min-w-0 items-center gap-2 text-[17px] font-bold leading-tight text-on-surface">
        <span className="h-4 w-[3px] shrink-0 rounded-sm bg-primary" aria-hidden />
        <span className="truncate">{title}</span>
      </h2>
      {actionLabel &&
        (href ? (
          <Link href={href} className="see-all shrink-0 text-primary hover:opacity-80">
            {actionLabel}
          </Link>
        ) : (
          <button onClick={onAction} className="see-all shrink-0 text-primary hover:opacity-80">
            {actionLabel}
          </button>
        ))}
    </div>
  );
}

/* ------------------------------ Empty state ------------------------------ */
export function EmptyState({
  icon = "no_cars",
  title,
  subtitle,
  children,
}: {
  icon?: IconName;
  title: string;
  subtitle?: string;
  children?: ReactNode;
}) {
  return (
    <div className="flex flex-col items-center justify-center gap-3 px-6 py-16 text-center">
      <span className="grid h-24 w-24 place-items-center rounded-full bg-surface-lowest">
        <Icon name={icon} size={52} color="#BCB4B0" />
      </span>
      <p className="text-base font-semibold text-on-surface">{title}</p>
      {subtitle && <p className="max-w-sm text-sm text-muted">{subtitle}</p>}
      {children}
    </div>
  );
}

/* ------------------------------ ErrorState ------------------------------ */
export function ErrorState({ message, onRetry }: { message: string; onRetry?: () => void }) {
  const { t } = useI18n();
  return (
    <div className="flex flex-col items-center justify-center gap-3 px-6 py-16 text-center">
      <Icon name="wifi_off" size={64} color="#ef4444" />
      <p className="max-w-md text-sm font-medium text-danger">{message}</p>
      {onRetry && (
        <Button variant="outline" onClick={onRetry}>{t("buttons.tryAgain")}</Button>
      )}
    </div>
  );
}

/* ------------------------------ Toggle ------------------------------ */
export function Toggle({
  checked,
  onChange,
  disabled = false,
  label,
}: {
  checked: boolean;
  onChange: (next: boolean) => void;
  disabled?: boolean;
  label?: string;
}) {
  return (
    <button
      type="button"
      role="switch"
      aria-checked={checked}
      aria-label={label}
      disabled={disabled}
      onClick={() => onChange(!checked)}
      className={`relative inline-flex h-6 w-11 shrink-0 items-center rounded-full transition disabled:opacity-50 ${
        checked ? "bg-primary" : "bg-surface-low"
      }`}
    >
      <span
        className={`inline-block h-5 w-5 transform rounded-full bg-white shadow transition ${
          checked ? "translate-x-5" : "translate-x-0.5"
        }`}
      />
    </button>
  );
}

/* ------------------------------ Skeleton ------------------------------ */
export function SkeletonBox({ className = "" }: { className?: string }) {
  return <div className={`skeleton rounded-xl ${className}`} />;
}

/* ------------------------------ Field ------------------------------ */
export function Field({
  label,
  children,
  error,
}: {
  label?: string;
  children: ReactNode;
  error?: string;
}) {
  return (
    <label className="block">
      {label && (
        <span className="mb-1.5 block text-[13px] font-semibold text-on-surface">
          {label}
        </span>
      )}
      {children}
      {error && <span className="mt-1 block text-xs text-danger">{error}</span>}
    </label>
  );
}

export function Input({
  className = "",
  ...props
}: React.InputHTMLAttributes<HTMLInputElement>) {
  return (
    <input
      {...props}
      className={`h-12 w-full rounded-2xl border border-hairline bg-white px-4 text-[15px] outline-none transition placeholder:text-hint focus:border-primary focus:ring-4 focus:ring-primary/10 ${className}`}
    />
  );
}

export function Textarea({
  className = "",
  ...props
}: React.TextareaHTMLAttributes<HTMLTextAreaElement>) {
  return (
    <textarea
      {...props}
      className={`w-full rounded-2xl border border-hairline bg-white px-4 py-3 text-[15px] outline-none transition placeholder:text-hint focus:border-primary focus:ring-4 focus:ring-primary/10 ${className}`}
    />
  );
}

/* ------------------------------ Toast (very small) ------------------------------ */
export function useEnumLabel() {
  const { t } = useI18n();
  return {
    transmission: (v?: string | null) => (v ? t(`transmission.${v}`) : ""),
    fuel: (v?: string | null) =>
      v ? t(`fuel.${v === "hybird" ? "hybrid" : v}`) : "",
    period: (v?: string | null) => (v ? t(`rentalPeriodType.${v}`) : ""),
    periodPer: (v?: string | null) => (v ? t(`rentalPeriodPerType.${v}`) : ""),
    currency: (v?: string | null) => (v ? t(`currency.${v}`) : ""),
    bookStatus: (v?: string | null) => (v ? t(`bookStatus.${v}`) : ""),
  };
}
