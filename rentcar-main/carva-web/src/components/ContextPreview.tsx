"use client";

import { useEffect, useRef, useState, type ReactNode } from "react";
import { useRouter } from "next/navigation";
import { create } from "zustand";
import { useI18n } from "@/i18n";
import { useAuth } from "@/lib/auth-store";
import { userApi } from "@/lib/services";
import { imageUrl } from "@/lib/api";
import { isRented } from "@/lib/car-status";
import type { Car, Company } from "@/lib/types";
import { toast } from "./toast";
import { Rating } from "./ui";

/* ------------------------------------------------------------------ state */

type Target = { kind: "car"; car: Car } | { kind: "company"; company: Company };

interface PreviewState {
  target: Target | null;
  origin: DOMRect | null;
  open: (t: Target, origin: DOMRect | null) => void;
  close: () => void;
  /** Saved / unsaved from a preview, so the card's heart follows. */
  fav: Record<string, boolean>;
  setFav: (id: string, v: boolean) => void;
}

export const usePreview = create<PreviewState>((set) => ({
  target: null,
  origin: null,
  open: (target, origin) => set({ target, origin }),
  close: () => set({ target: null }),
  fav: {},
  setFav: (id, v) => set((s) => ({ fav: { ...s.fav, [id]: v } })),
}));

/* --------------------------------------------------------------- the hook */

const HOLD_MS = 450;

/**
 * Long-press on phones (and right-click with a mouse) opens the preview,
 * like the app. The tap that ends a long-press does not also open the link.
 */
export function useLongPress(target: () => Target) {
  const open = usePreview((s) => s.open);
  const timer = useRef<number | null>(null);
  const start = useRef<{ x: number; y: number } | null>(null);
  const fired = useRef(false);

  const cancel = () => {
    if (timer.current) window.clearTimeout(timer.current);
    timer.current = null;
    start.current = null;
  };
  const fire = (el: HTMLElement) => {
    fired.current = true;
    try {
      navigator.vibrate?.(12);
    } catch {
      /* not supported */
    }
    open(target(), el.getBoundingClientRect());
  };

  return {
    onPointerDown: (e: React.PointerEvent<HTMLElement>) => {
      fired.current = false;
      if (e.pointerType === "mouse") return;
      const el = e.currentTarget;
      start.current = { x: e.clientX, y: e.clientY };
      timer.current = window.setTimeout(() => fire(el), HOLD_MS);
    },
    onPointerMove: (e: React.PointerEvent<HTMLElement>) => {
      const s = start.current;
      if (s && Math.hypot(e.clientX - s.x, e.clientY - s.y) > 10) cancel();
    },
    onPointerUp: cancel,
    onPointerCancel: cancel,
    onPointerLeave: cancel,
    onContextMenu: (e: React.MouseEvent<HTMLElement>) => {
      e.preventDefault();
      // Touch already handled by the timer; this is a right-click.
      if (!fired.current && !timer.current) fire(e.currentTarget);
    },
    onClickCapture: (e: React.MouseEvent) => {
      if (fired.current) {
        e.preventDefault();
        e.stopPropagation();
        fired.current = false;
      }
    },
  };
}

/* ---------------------------------------------------------------- the host */

interface Action {
  label: string;
  icon: ReactNode;
  run: () => void | Promise<void>;
}

const icon = (d: string, color = "currentColor") => (
  <svg width="20" height="20" viewBox="0 0 24 24" fill={color} aria-hidden>
    <path d={d} />
  </svg>
);
const ICONS = {
  car: "M18.92 6.01C18.72 5.42 18.16 5 17.5 5h-11c-.66 0-1.21.42-1.42 1.01L3 12v8c0 .55.45 1 1 1h1c.55 0 1-.45 1-1v-1h12v1c0 .55.45 1 1 1h1c.55 0 1-.45 1-1v-8l-2.08-5.99zM6.85 7h10.29l1.08 3.11H5.77L6.85 7zM19 17H5v-5h14v5zM7.5 16a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3zm9 0a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z",
  heart: "M16.5 3c-1.74 0-3.41.81-4.5 2.09C10.91 3.81 9.24 3 7.5 3 4.42 3 2 5.42 2 8.5c0 3.78 3.4 6.86 8.55 11.54L12 21.35l1.45-1.32C18.6 15.36 22 12.28 22 8.5 22 5.42 19.58 3 16.5 3zm-4.4 15.55-.1.1-.1-.1C7.14 14.24 4 11.39 4 8.5 4 6.5 5.5 5 7.5 5c1.54 0 3.04.99 3.57 2.36h1.87C13.46 5.99 14.96 5 16.5 5c2 0 3.5 1.5 3.5 3.5 0 2.89-3.14 5.74-7.9 10.05z",
  heartFull: "M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z",
  share: "M16 5l-1.42 1.42-1.59-1.59V16h-1.98V4.83L9.42 6.42 8 5l4-4 4 4zm4 5v11c0 1.1-.9 2-2 2H6c-1.11 0-2-.9-2-2V10c0-1.11.89-2 2-2h3v2H6v11h12V10h-3V8h3c1.1 0 2 .89 2 2z",
  chat: "M20 2H4c-1.1 0-2 .9-2 2v18l4-4h14c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm0 14H5.17L4 17.17V4h16v12z",
  call: "M6.62 10.79c1.44 2.83 3.76 5.14 6.59 6.59l2.2-2.2c.27-.27.67-.36 1.02-.24 1.12.37 2.33.57 3.57.57.55 0 1 .45 1 1V20c0 .55-.45 1-1 1-9.39 0-17-7.61-17-17 0-.55.45-1 1-1h3.5c.55 0 1 .45 1 1 0 1.25.2 2.45.57 3.57.11.35.03.74-.25 1.02l-2.2 2.2z",
  store: "M20 4H4v2h16V4zm1 10v-2l-1-5H4l-1 5v2h1v6h10v-6h4v6h2v-6h1zm-9 4H6v-4h6v4z",
};

function phoneOf(company?: Company | null) {
  const c = company?.contacts?.find((x) => x.type === "phone");
  return c ? `${c.countrCode ?? ""}${c.value}`.replace(/\s/g, "") : null;
}

/** The preview layer: blurred, dimmed page; the card grows from where it was; the menu under it. */
export function ContextPreviewHost() {
  const { t, tr } = useI18n();
  const router = useRouter();
  const user = useAuth((s) => s.user);
  const { target, origin, close, fav, setFav } = usePreview();
  const [shown, setShown] = useState(false);
  const [leaving, setLeaving] = useState(false);
  const [busy, setBusy] = useState(false);
  const card = useRef<HTMLDivElement>(null);

  // Enter: start at the card's place and size, then grow to the centre.
  useEffect(() => {
    if (!target) return;
    // Put the card where it was in the list (DOM only), then let it grow.
    const el = card.current;
    if (el) {
      if (origin) {
        const r = el.getBoundingClientRect();
        const s = Math.min(1, origin.width / Math.max(1, r.width));
        const dx = origin.left + origin.width / 2 - (r.left + r.width / 2);
        const dy = origin.top + origin.height / 2 - (r.top + r.height / 2);
        el.style.transform = `translate(${dx}px, ${dy}px) scale(${s})`;
      } else el.style.transform = "scale(0.92)";
    }
    const id = requestAnimationFrame(() => requestAnimationFrame(() => setShown(true)));
    document.body.style.overflow = "hidden";
    const onKey = (e: KeyboardEvent) => e.key === "Escape" && dismiss();
    window.addEventListener("keydown", onKey);
    return () => {
      cancelAnimationFrame(id);
      window.removeEventListener("keydown", onKey);
      document.body.style.overflow = "";
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [target, origin]);

  function dismiss(then?: () => void) {
    setLeaving(true);
    window.setTimeout(() => {
      close();
      setShown(false);
      setLeaving(false);
      then?.();
    }, 200);
  }

  if (!target) return null;

  const share = async (title: string, path: string) => {
    const url = `${window.location.origin}${path}`;
    try {
      if (navigator.share) await navigator.share({ title, url });
      else {
        await navigator.clipboard.writeText(url);
        toast(t("v2.linkCopied"), "success");
      }
    } catch {
      /* closed the share sheet */
    }
  };

  const whatsapp = async (companyId: string, carId?: string) => {
    const win = window.open("", "_blank");
    try {
      const url = await userApi.contact({ type: "whatsapp", companyId, carId });
      if (url && win) win.location.href = url;
      else win?.close();
    } catch {
      win?.close();
      toast(t("alertMessages.someThingWentWrong"), "error");
    }
  };

  let body: ReactNode;
  let actions: Action[];

  if (target.kind === "car") {
    const car = target.car;
    const saved = fav[car.id] ?? !!car.isFavorite;
    const plan = car.rentalPlan?.find((p) => p.periodType === car.displayPlan) ?? car.rentalPlan?.[0];
    const city = car.location?.city ?? car.company?.location?.city;
    const phone = phoneOf(car.company);
    body = (
      <>
        <div className="relative aspect-[4/3] bg-[#1A1517]">
          {car.images?.[0]?.image && (
            // eslint-disable-next-line @next/next/no-img-element
            <img src={imageUrl(car.images[0].image)} alt="" className={`h-full w-full object-cover ${isRented(car) ? "opacity-85" : ""}`} />
          )}
          <div className="absolute inset-x-0 bottom-0 h-24 bg-gradient-to-t from-black/70 to-transparent" />
          <p className="absolute inset-x-4 bottom-3 truncate text-start text-[19px] font-bold text-white"><bdi>{car.title}</bdi></p>
        </div>
        <div className="flex items-center justify-between gap-3 px-4 py-3">
          {plan && Number(plan.price) > 0 ? (
            <p className="num text-[17px] font-bold">
              {plan.currency === "usd"
                ? `$${Number(plan.price).toLocaleString("en-US")}`
                : `${Number(plan.price).toLocaleString("en-US")} ${t("currency.iqd")}`}
              <span className="text-[12px] font-normal text-muted"> / {t(`v2.unit_${plan.periodType}`)}</span>
            </p>
          ) : (
            <span />
          )}
          {city && <span className="truncate text-[13px] font-semibold text-muted">📍 {tr(city)}</span>}
        </div>
      </>
    );
    actions = [
      { label: t("actions.viewCar"), icon: icon(ICONS.car), run: () => dismiss(() => router.push(`/car/${car.carId}`)) },
      {
        label: saved ? t("actions.unsave") : t("actions.save"),
        icon: icon(saved ? ICONS.heartFull : ICONS.heart, saved ? "#B51219" : "currentColor"),
        run: async () => {
          if (!user) return dismiss(() => router.push("/login"));
          setBusy(true);
          try {
            await userApi.toggleFavorite(car.id);
            setFav(car.id, !saved);
            toast(saved ? t("actions.removedFavorite") : t("actions.save"), "success");
          } catch {
            toast(t("alertMessages.someThingWentWrong"), "error");
          } finally {
            setBusy(false);
            dismiss();
          }
        },
      },
      { label: t("actions.share"), icon: icon(ICONS.share), run: () => share(car.title, `/car/${car.carId}`) },
      { label: t("actions.whatsapp"), icon: icon(ICONS.chat), run: () => dismiss(() => whatsapp(car.companyId, car.id)) },
      ...(phone ? [{ label: t("actions.call"), icon: icon(ICONS.call), run: () => dismiss(() => (window.location.href = `tel:${phone}`)) }] : []),
    ];
  } else {
    const c = target.company;
    const phone = phoneOf(c);
    const city = c.location?.city;
    body = (
      <>
        <div className="relative h-36 bg-hero bg-[radial-gradient(120%_160%_at_85%_-30%,#5A090D_0%,#161112_58%)]">
          {c.coverImage && (
            // eslint-disable-next-line @next/next/no-img-element
            <img src={imageUrl(c.coverImage)} alt="" className="h-full w-full object-cover" />
          )}
        </div>
        <div className="relative px-4 pb-4">
          <span className="absolute -top-8 grid h-16 w-16 place-items-center overflow-hidden rounded-full border-4 border-white bg-white text-xl font-bold text-primary shadow-[var(--shadow-card)]">
            {c.image ? (
              // eslint-disable-next-line @next/next/no-img-element
              <img src={imageUrl(c.image)} alt="" className="h-full w-full object-cover" />
            ) : (
              c.name.charAt(0).toUpperCase()
            )}
          </span>
          <p className="truncate pt-10 text-[18px] font-bold"><bdi>{c.name}</bdi></p>
          <div className="mt-1 flex items-center gap-2">
            <Rating rate={c.rate} review={c.review} />
            {city && <span className="truncate text-[13px] font-semibold text-muted">· 📍 {tr(city)}</span>}
          </div>
        </div>
      </>
    );
    const wa = c.contact?.trim() || c.contacts?.find((x) => x.type === "whatsapp")?.value;
    actions = [
      { label: t("actions.companyPage"), icon: icon(ICONS.store), run: () => dismiss(() => router.push(`/company/${c.id}`)) },
      ...(wa ? [{ label: t("actions.whatsapp"), icon: icon(ICONS.chat), run: () => dismiss(() => whatsapp(c.id)) }] : []),
      ...(phone ? [{ label: t("actions.call"), icon: icon(ICONS.call), run: () => dismiss(() => (window.location.href = `tel:${phone}`)) }] : []),
      { label: t("actions.share"), icon: icon(ICONS.share), run: () => share(c.name, `/company/${c.id}`) },
    ];
  }

  const on = shown && !leaving;
  const openTarget = () =>
    dismiss(() => router.push(target.kind === "car" ? `/car/${target.car.carId}` : `/company/${target.company.id}`));

  return (
    <div className="fixed inset-0 z-[150] flex flex-col items-center justify-center gap-3 px-6" role="dialog" aria-modal="true">
      <div
        className="absolute inset-0 bg-black/30 transition-[opacity,backdrop-filter] duration-300"
        style={{ opacity: on ? 1 : 0, backdropFilter: on ? "blur(18px) saturate(140%)" : "blur(0px)", WebkitBackdropFilter: on ? "blur(18px) saturate(140%)" : "blur(0px)" }}
        onClick={() => dismiss()}
      />
      <div
        ref={card}
        onClick={openTarget}
        className="relative w-full max-w-[360px] cursor-pointer overflow-hidden rounded-[22px] bg-white shadow-[0_30px_80px_-20px_rgba(0,0,0,0.55)]"
        style={{
          transform: on ? "none" : leaving ? "scale(0.94)" : undefined,
          opacity: leaving ? 0 : 1,
          transition: shown ? (leaving ? "transform .2s ease-in, opacity .2s ease-in" : "transform .38s cubic-bezier(.34,1.32,.5,1)") : "none",
        }}
      >
        {body}
      </div>
      <div
        className="relative w-full max-w-[360px] overflow-hidden rounded-[14px] bg-white/90 shadow-[0_20px_50px_-20px_rgba(0,0,0,0.5)] backdrop-blur-xl"
        style={{
          opacity: on ? 1 : 0,
          transform: on ? "none" : "translateY(-8px) scale(0.96)",
          transition: "opacity .25s ease-out .08s, transform .3s cubic-bezier(.34,1.3,.5,1) .08s",
        }}
      >
        {actions.map((a, i) => (
          <button
            key={a.label}
            disabled={busy}
            onClick={() => void a.run()}
            className={`flex h-12 w-full items-center gap-3 px-4 text-start text-[15px] text-ink transition hover:bg-black/5 active:bg-black/10 disabled:opacity-50 ${
              i > 0 ? "border-t border-hairline" : ""
            }`}
          >
            <span className="flex-1">{a.label}</span>
            <span className="text-ink">{a.icon}</span>
          </button>
        ))}
      </div>
    </div>
  );
}
