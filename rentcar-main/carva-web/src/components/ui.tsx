"use client";

import Link from "next/link";
import type { ButtonHTMLAttributes, ReactNode } from "react";
import { Icon, type IconName } from "./Icon";
import { useI18n } from "@/i18n";

/* ------------------------------ Button ------------------------------ */
type Variant = "primary" | "secondary" | "outline" | "ghost" | "danger";

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
    primary: "bg-primary text-white hover:bg-primary/90",
    secondary: "bg-secondary text-white hover:bg-secondary/90",
    outline: "border border-surface-low text-on-surface hover:bg-surface-lowest",
    ghost: "text-on-surface hover:bg-surface-lowest",
    danger: "bg-danger text-white hover:bg-danger/90",
  };
  return (
    <button
      {...props}
      disabled={loading || props.disabled}
      className={`inline-flex h-12 items-center justify-center gap-2 rounded-full px-6 text-sm font-semibold transition disabled:opacity-60 ${
        full ? "w-full" : ""
      } ${styles[variant]} ${className}`}
    >
      {loading ? <Spinner size={18} light={variant === "primary" || variant === "secondary" || variant === "danger"} /> : children}
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
      <Icon name="star_fill" size={size} color="#f5b50a" />
      {r > 0 ? r.toFixed(1) : "New"}
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
      className={`whitespace-nowrap rounded-full border px-4 py-2 text-sm font-medium transition ${
        selected
          ? "border-primary bg-primary text-white"
          : "border-surface-low bg-white text-on-surface hover:border-primary/40"
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
    <div className="mb-3 flex items-center justify-between px-4">
      <h2 className="text-base font-bold text-on-surface">{title}</h2>
      {actionLabel &&
        (href ? (
          <Link href={href} className="text-sm font-medium text-primary">
            {actionLabel}
          </Link>
        ) : (
          <button onClick={onAction} className="text-sm font-medium text-primary">
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
      <Icon name={icon} size={72} color="#d4d4d4" />
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
        <span className="mb-1.5 block text-sm font-medium text-on-surface">
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
      className={`h-12 w-full rounded-xl border border-surface-low bg-surface-lowest px-4 text-sm outline-none transition focus:border-primary focus:bg-white ${className}`}
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
      className={`w-full rounded-xl border border-surface-low bg-surface-lowest px-4 py-3 text-sm outline-none transition focus:border-primary focus:bg-white ${className}`}
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
