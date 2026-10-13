"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { Icon } from "./Icon";

/**
 * The app's auth page (Login / Sign-up / Reset): white page, a round back
 * button and the red CARVA logo on top, a tiny red label, a big title and
 * a grey subtitle, then the form.
 */
export function AuthCard({
  title,
  subtitle,
  eyebrow,
  children,
}: {
  title: string;
  subtitle?: string;
  /** Tiny red label above the title (e.g. "SIGN IN"). */
  eyebrow?: string;
  children: React.ReactNode;
}) {
  const router = useRouter();
  return (
    <div className="flex min-h-screen flex-col bg-white">
      <div className="mx-auto grid w-full max-w-md grid-cols-[40px_1fr_40px] items-center px-6 pt-5">
        <button
          type="button"
          onClick={() => (window.history.length > 1 ? router.back() : router.push("/"))}
          aria-label="back"
          className="press grid h-10 w-10 place-items-center rounded-full border border-[#E9E4E1] bg-white"
        >
          <Icon name="arrow" size={16} color="#171214" className="rtl:rotate-180" />
        </button>
        <Link href="/" className="justify-self-center" aria-label="CARVA">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img src="/assets/images/carva.png" alt="CARVA" className="h-[26px] w-auto" />
        </Link>
      </div>

      <div className="mx-auto w-full max-w-md flex-1 px-6 pb-16 pt-10">
        {eyebrow && <p className="see-all mb-2.5 text-primary">{eyebrow}</p>}
        <h1 className="text-[30px] font-bold leading-[1.2] text-ink">{title}</h1>
        {subtitle && <p className="mt-2 text-[14px] leading-relaxed text-muted">{subtitle}</p>}
        <div className="mt-8">{children}</div>
      </div>
    </div>
  );
}
