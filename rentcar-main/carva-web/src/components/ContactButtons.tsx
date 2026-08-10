"use client";

import { Icon, type IconName } from "@/components/Icon";
import { userApi } from "@/lib/services";
import type { Contact } from "@/lib/types";

const CONTACT_ICON: Record<string, IconName> = {
  phone: "call",
  whatsapp: "whatsapp",
  viber: "phone",
  email: "mail",
};

/** One tappable company contact (call / WhatsApp / email) — shared by the
 * company profile and the car page's contact modal. */
export function ContactButton({ c, companyId }: { c: Contact; companyId: string }) {
  function open() {
    const num = `${c.countrCode ?? ""}${c.value}`.replace(/\s/g, "");
    if (c.type === "whatsapp") {
      // Open synchronously so mobile browsers keep the user-gesture; redirect
      // that tab once the contact URL resolves (fall back to a wa.me link).
      const win = window.open("", "_blank");
      const navigate = (url: string) => {
        if (win) win.location.href = url;
        else window.location.href = url;
      };
      const fallback = `https://wa.me/${num.replace("+", "")}`;
      userApi.contact({ type: "whatsapp", companyId, contactId: c.id })
        .then((url) => navigate(url || fallback))
        .catch(() => navigate(fallback));
    } else if (c.type === "email") {
      window.location.href = `mailto:${c.value}`;
    } else {
      window.location.href = `tel:${num}`;
    }
  }
  const isWa = c.type === "whatsapp";
  return (
    <button
      onClick={open}
      className={`flex items-center gap-2 rounded-full px-4 py-2 text-sm font-medium ${isWa ? "bg-tint text-white" : "border border-surface-low text-on-surface"}`}
    >
      <Icon name={CONTACT_ICON[c.type] ?? "call"} size={16} color={isWa ? "#fff" : "#B51219"} />
      {c.countrCode ?? ""}{c.value}
    </button>
  );
}
