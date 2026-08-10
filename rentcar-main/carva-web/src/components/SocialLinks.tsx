"use client";

import type { Company } from "@/lib/types";

/** Branded circular links to a company's social accounts — the same
 * Facebook-blue / Instagram-gradient / TikTok-black row as the app. */
export function SocialLinks({ company }: { company: Company }) {
  const items = [
    company.facebookLink && {
      href: company.facebookLink,
      label: "Facebook",
      className: "bg-[#1877F2]",
      icon: (
        <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor" aria-hidden>
          <path d="M13.5 21v-7h2.4l.5-3h-2.9V9.1c0-.9.3-1.6 1.7-1.6H16.5V4.8c-.3 0-1.2-.1-2.2-.1-2.2 0-3.8 1.4-3.8 3.9V11H8v3h2.5v7h3Z" />
        </svg>
      ),
    },
    company.instagramLink && {
      href: company.instagramLink,
      label: "Instagram",
      className: "bg-gradient-to-br from-[#7B2FF7] via-[#E1306C] to-[#FFA245]",
      icon: (
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" aria-hidden>
          <rect x="3" y="3" width="18" height="18" rx="5" />
          <circle cx="12" cy="12" r="4" />
          <circle cx="17.2" cy="6.8" r="1" fill="currentColor" stroke="none" />
        </svg>
      ),
    },
    company.tiktokLink && {
      href: company.tiktokLink,
      label: "TikTok",
      className: "bg-black",
      icon: (
        <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor" aria-hidden>
          <path d="M14.5 3h2.6c.2 1.7 1.3 3.1 3.4 3.4v2.7c-1.3 0-2.5-.4-3.5-1.1v6.2c0 3.4-2.4 5.8-5.7 5.8A5.6 5.6 0 0 1 5.5 14.4c0-3.2 2.5-5.6 5.9-5.5v2.8c-1.7-.2-3.1.9-3.1 2.7 0 1.6 1.2 2.8 2.9 2.8 1.8 0 3.3-1.3 3.3-3.3V3Z" />
        </svg>
      ),
    },
  ].filter(Boolean) as { href: string; label: string; className: string; icon: React.ReactNode }[];

  if (items.length === 0) return null;

  return (
    <div className="mt-4 flex gap-2">
      {items.map((it) => (
        <a
          key={it.label}
          href={it.href}
          target="_blank"
          rel="noreferrer"
          aria-label={it.label}
          title={it.label}
          className={`grid h-10 w-10 place-items-center rounded-full text-white transition hover:opacity-90 ${it.className}`}
        >
          {it.icon}
        </a>
      ))}
    </div>
  );
}
