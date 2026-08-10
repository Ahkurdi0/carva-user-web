"use client";

import { useState } from "react";
import { AppShell } from "@/components/AppShell";
import { CompanyCard } from "@/components/CompanyCard";
import { Chip, EmptyState, PageLoading } from "@/components/ui";
import { useAsync } from "@/lib/useAsync";
import { userApi } from "@/lib/services";
import { useI18n } from "@/i18n";

export default function CompaniesPage() {
  const { t } = useI18n();
  const [intl, setIntl] = useState<boolean | undefined>(undefined);
  const { data, loading } = useAsync(() => userApi.companies(undefined, intl), [intl]);

  return (
    <AppShell>
      <div className="px-4 py-5">
        <h1 className="mb-4 text-xl font-extrabold">{t("web.companiesTitle")}</h1>
        <div className="mb-5 flex gap-2">
          <Chip label={t("labels.all")} selected={intl === undefined} onClick={() => setIntl(undefined)} />
          <Chip label={t("tabViews.local")} selected={intl === false} onClick={() => setIntl(false)} />
          <Chip label={t("tabViews.international")} selected={intl === true} onClick={() => setIntl(true)} />
        </div>
        {loading ? (
          <PageLoading />
        ) : data && data.length > 0 ? (
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {data.map((c) => <CompanyCard key={c.id} company={c} />)}
          </div>
        ) : (
          <EmptyState icon="company" title={t("empty.emptyCompany")} />
        )}
      </div>
    </AppShell>
  );
}
