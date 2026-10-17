"use client";

import Link from "next/link";
import type { Company } from "@/lib/types";
import { imageUrl } from "@/lib/api";
import { Icon } from "./Icon";
import { Rating } from "./ui";
import { useI18n } from "@/i18n";
import { useLongPress } from "./ContextPreview";

export function CompanyCard({ company }: { company: Company }) {
  const { t } = useI18n();
  const hold = useLongPress(() => ({ kind: "company", company }));
  return (
    <Link
      href={`/company/${company.id}`}
      data-reveal
      {...hold}
      className="press no-callout group block overflow-hidden rounded-2xl bg-white shadow-[var(--shadow-card)] ring-1 ring-hairline transition-shadow hover:shadow-[var(--shadow-lift)]"
    >
      <div className="relative h-28 bg-hero bg-[radial-gradient(120%_160%_at_85%_-30%,#5A090D_0%,#161112_58%)]">
        <div className="hero-texture absolute inset-0" aria-hidden />
        {company.coverImage && (
          // eslint-disable-next-line @next/next/no-img-element
          <img src={imageUrl(company.coverImage)} alt="" className="h-full w-full object-cover transition duration-500 group-hover:scale-[1.03]" />
        )}
      </div>
      <div className="relative px-4 pb-4">
        <span className="absolute -top-8 h-16 w-16 overflow-hidden rounded-full border-4 border-white bg-white shadow-[var(--shadow-card)]">
          {company.image ? (
            // eslint-disable-next-line @next/next/no-img-element
            <img src={imageUrl(company.image)} alt="" className="h-full w-full object-cover" />
          ) : (
            <span className="grid h-full w-full place-items-center"><Icon name="company" size={20} color="#B51219" /></span>
          )}
        </span>
        <div className="pt-10">
          <p className="truncate text-[16px] font-bold text-on-surface"><bdi>{company.name}</bdi></p>
          <div className="mt-1 flex items-center gap-2">
            <Rating rate={company.rate} review={company.review} />
          </div>
          <div className="mt-2 flex flex-wrap gap-1.5">
            {company.delivery && (
              <span className="rounded-lg bg-surface-lowest px-2 py-1 text-[11px] font-semibold text-on-surface">
                {t("tabViews.local")} · {t("buttons.map")}
              </span>
            )}
            {company.international && (
              <span className="rounded-lg bg-primary-container px-2 py-1 text-[11px] font-semibold text-primary">
                {t("tabViews.international")}
              </span>
            )}
          </div>
        </div>
      </div>
    </Link>
  );
}
