"use client";

import Link from "next/link";

export function AuthCard({
  title,
  subtitle,
  children,
}: {
  title: string;
  subtitle?: string;
  children: React.ReactNode;
}) {
  return (
    <div className="flex min-h-screen flex-col bg-white">
      {/* Curved branded header echoing the app's welcome screen */}
      <div className="relative overflow-hidden bg-primary-container pb-10 pt-10">
        <div
          className="absolute inset-x-0 -bottom-px h-10 bg-white"
          style={{ borderTopLeftRadius: "50% 100%", borderTopRightRadius: "50% 100%" }}
        />
        <div className="relative mx-auto flex max-w-md flex-col items-center px-6">
          <Link href="/">
            {/* eslint-disable-next-line @next/next/no-img-element */}
            <img src="/assets/images/carva.png" alt="Carva" className="h-12 w-auto" />
          </Link>
        </div>
      </div>

      <div className="mx-auto w-full max-w-md flex-1 px-6 pb-16 pt-2">
        <h1 className="text-2xl font-extrabold text-on-surface">{title}</h1>
        {subtitle && <p className="mt-1 text-sm text-muted">{subtitle}</p>}
        <div className="mt-6">{children}</div>
      </div>
    </div>
  );
}
