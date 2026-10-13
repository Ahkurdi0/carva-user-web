"use client";

import { useEffect } from "react";
import { Icon } from "./Icon";

export function Modal({
  open,
  onClose,
  title,
  children,
}: {
  open: boolean;
  onClose: () => void;
  title?: string;
  children: React.ReactNode;
}) {
  useEffect(() => {
    if (!open) return;
    const onKey = (e: KeyboardEvent) => e.key === "Escape" && onClose();
    window.addEventListener("keydown", onKey);
    document.body.style.overflow = "hidden";
    return () => {
      window.removeEventListener("keydown", onKey);
      document.body.style.overflow = "";
    };
  }, [open, onClose]);

  if (!open) return null;
  return (
    <div className="fixed inset-0 z-[80] flex items-end justify-center sm:items-center">
      <div className="sheet-fade absolute inset-0 bg-black/30" onClick={onClose} />
      <div className="sheet-up relative z-10 max-h-[90vh] w-full overflow-y-auto rounded-t-[28px] bg-white px-5 pb-[max(20px,env(safe-area-inset-bottom))] pt-2.5 shadow-[var(--shadow-glass)] sm:max-w-md sm:rounded-[28px] sm:pb-5 sm:pt-5">
        {/* Grab handle on phones, like the app's sheets */}
        <div className="mx-auto mb-3 h-[5px] w-10 rounded-full bg-[#A29A96]/40 sm:hidden" aria-hidden />
        <div className="mb-4 flex items-center justify-between gap-3">
          <h3 className="text-lg font-bold">{title}</h3>
          <button onClick={onClose} aria-label="close" className="press grid h-9 w-9 shrink-0 place-items-center rounded-full bg-surface-lowest">
            <Icon name="cancel" size={16} />
          </button>
        </div>
        {children}
      </div>
    </div>
  );
}
