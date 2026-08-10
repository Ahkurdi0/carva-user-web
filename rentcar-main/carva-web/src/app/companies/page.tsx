"use client";

import { useState } from "react";
import { AppShell } from "@/components/AppShell";
import { CompanyCard } from "@/components/CompanyCard";
import { EmptyState, PageLoading } from "@/components/ui";
import { CityChips } from "@/components/CityChips";
import { useAsync } from "@/lib/useAsync";
import { userApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import type { FiltersData } from "@/lib/types";

export default function CompaniesPage() {
  const { t } = useI18n();
  const [cityId, setCityId] = useState<string | null>(null);
  const { data, loading } = useAsync(() => userApi.companies(), []);
  // Same city list the car filters use — the app's companies filter fix.
  const { data: filters } = useAsync<FiltersData>(() => userApi.filters(), []);

  const companies = (data ?? []).filter(
    (c) => !cityId || c.location?.cityId === cityId,
  );

  return (
    <AppShell>
      <div className="px-4 py-5">
        <h1 className="mb-4 text-xl font-extrabold">{t("web.companiesTitle")}</h1>
        {(filters?.cities?.length ?? 0) > 0 && (
          <div className="-mx-4 mb-5">
            <CityChips
              cities={filters!.cities}
              selectedId={cityId}
              onSelect={(city) => setCityId(city?.id ?? null)}
            />
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
