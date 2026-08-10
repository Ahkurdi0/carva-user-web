"use client";

import { useState } from "react";
import { AppShell } from "@/components/AppShell";
import { CompanyCard } from "@/components/CompanyCard";
import { Chip, EmptyState, PageLoading } from "@/components/ui";
import { useAsync } from "@/lib/useAsync";
import { userApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import type { FiltersData } from "@/lib/types";

export default function CompaniesPage() {
  const { t, tr } = useI18n();
  const [intl, setIntl] = useState<boolean | undefined>(undefined);
  const [cityId, setCityId] = useState<string | null>(null);
  const { data, loading } = useAsync(() => userApi.companies(undefined, intl), [intl]);
  // Same city list the car filters use — the app's companies filter fix.
  const { data: filters } = useAsync<FiltersData>(() => userApi.filters(), []);

  const companies = (data ?? []).filter(
    (c) => !cityId || c.location?.cityId === cityId,
  );

  return (
    <AppShell>
      <div className="px-4 py-5">
        <h1 className="mb-4 text-xl font-extrabold">{t("web.companiesTitle")}</h1>
        <div className="mb-3 flex gap-2">
          <Chip label={t("labels.all")} selected={intl === undefined} onClick={() => setIntl(undefined)} />
          <Chip label={t("tabViews.local")} selected={intl === false} onClick={() => setIntl(false)} />
          <Chip label={t("tabViews.international")} selected={intl === true} onClick={() => setIntl(true)} />
        </div>
        {(filters?.cities?.length ?? 0) > 0 && (
          <div className="no-scrollbar mb-5 flex gap-2 overflow-x-auto">
            <Chip
              label={t("labels.all")}
              selected={cityId === null}
              onClick={() => setCityId(null)}
            />
            {filters!.cities.map((city) => (
              <Chip
                key={city.id}
                label={tr(city)}
                selected={cityId === city.id}
                onClick={() => setCityId(cityId === city.id ? null : city.id)}
              />
            ))}
          </div>
        )}
        {loading ? (
          <PageLoading />
        ) : companies.length > 0 ? (
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {companies.map((c) => <CompanyCard key={c.id} company={c} />)}
          </div>
        ) : (
          <EmptyState icon="company" title={t("empty.emptyCompany")} />
        )}
      </div>
    </AppShell>
  );
}
