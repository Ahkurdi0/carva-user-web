"use client";

import Link from "next/link";
import type { Company } from "@/lib/types";
import { imageUrl } from "@/lib/api";
import { Icon } from "./Icon";
import { Rating } from "./ui";
import { useI18n } from "@/i18n";

export function CompanyCard({ company }: { company: Company }) {
  const { t } = useI18n();
  return (
    <Link
      href={`/company/${company.id}`}
      className="group block overflow-hidden rounded-2xl border border-surface-low transition hover:shadow-md"
    >
      <div className="relative h-24 bg-primary-container">
        {company.coverImage && (
          // eslint-disable-next-line @next/next/no-img-element
          <img src={imageUrl(company.coverImage)} alt="" className="h-full w-full object-cover" />
        )}
      </div>
      <div className="relative px-4 pb-4">
        <span className="absolute -top-7 h-14 w-14 overflow-hidden rounded-full border-4 border-white bg-primary-container">
          {company.image ? (
            // eslint-disable-next-line @next/next/no-img-element
            <img src={imageUrl(company.image)} alt="" className="h-full w-full object-cover" />
          ) : (
            <span className="grid h-full w-full place-items-center"><Icon name="company" size={20} color="#3957d7" /></span>
          )}
        </span>
        <div className="pt-9">
          <p className="truncate font-semibold text-on-surface">{company.name}</p>
          <div className="mt-1 flex items-center gap-2">
            <Rating rate={company.rate} review={company.review} />
          </div>
          <div className="mt-2 flex flex-wrap gap-1.5">
            {company.delivery && (
              <span className="rounded-full bg-surface-lowest px-2 py-0.5 text-[10px] font-medium text-muted">
                {t("tabViews.local")} · {t("buttons.map")}
              </span>
            )}
            {company.international && (
              <span className="rounded-full bg-primary-container px-2 py-0.5 text-[10px] font-medium text-primary">
                {t("tabViews.international")}
              </span>
            )}
          </div>
        </div>
      </div>
    </Link>
  );
}
