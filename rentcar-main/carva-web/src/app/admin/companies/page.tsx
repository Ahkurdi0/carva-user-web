"use client";

import { useState } from "react";
import { CompanyCard } from "@/components/CompanyCard";
import { CompanyFormModal } from "@/components/CompanyFormModal";
import { Button, Chip, PageLoading, EmptyState } from "@/components/ui";
import { Icon } from "@/components/Icon";
import { useAsync } from "@/lib/useAsync";
import { adminApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import type { Company } from "@/lib/types";

export default function AdminCompanies() {
  const { t } = useI18n();
  const [expired, setExpired] = useState<boolean | undefined>(undefined);
  const { data, loading, refetch } = useAsync(() => adminApi.companies(undefined, expired), [expired]);
  const [editing, setEditing] = useState<Company | null>(null);
  const [open, setOpen] = useState(false);

  return (
    <div>
      <div className="mb-4 flex items-center justify-between gap-3">
        <h1 className="text-2xl font-extrabold">{t("bottomNavigation.companies")}</h1>
        <Button className="gap-1.5" onClick={() => { setEditing(null); setOpen(true); }}>
          <span className="text-lg leading-none">+</span>
          <span className="hidden sm:inline">{t("buttons.newCompany")}</span>
        </Button>
      </div>
      <div className="mb-5 flex gap-2">
        <Chip label={t("labels.all")} selected={expired === undefined} onClick={() => setExpired(undefined)} />
        <Chip label={t("tabViews.active")} selected={expired === false} onClick={() => setExpired(false)} />
        <Chip label={t("tabViews.expired")} selected={expired === true} onClick={() => setExpired(true)} />
      </div>
      {loading ? (
        <PageLoading />
      ) : data && data.length > 0 ? (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {data.map((c) => (
            <div key={c.id} className="relative">
              <CompanyCard company={c} />
              <button
                onClick={() => { setEditing(c); setOpen(true); }}
                className="absolute right-2 top-2 z-10 grid h-9 w-9 place-items-center rounded-full bg-white/95 shadow-md transition hover:bg-white"
                aria-label={t("buttons.editCompany")}
                title={t("buttons.editCompany")}
              >
                <Icon name="edit" size={15} />
              </button>
            </div>
          ))}
        </div>
      ) : (
        <EmptyState icon="company" title={t("empty.emptyCompany")} />
      )}

      <CompanyFormModal
        open={open}
        company={editing}
        onClose={() => setOpen(false)}
        onSaved={refetch}
      />
    </div>
  );
}
