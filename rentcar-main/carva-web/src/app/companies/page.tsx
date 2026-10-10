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
import { Modal } from "@/components/Modal";
import { AdvertiseContacts } from "@/components/AdvertiseContacts";
import { advertiseApi, type AdvertisePage } from "@/lib/services";

export default function CompaniesPage() {
  const { t } = useI18n();
  const [cityId, setCityId] = useState<string | null>(null);
  // "Add your office" pill → CARVA's contacts (from the Advertise settings).
  const [joinOpen, setJoinOpen] = useState(false);
  const { data: adv } = useAsync<AdvertisePage>(() => advertiseApi.page(), []);
  const joinContacts = adv?.enabled ? adv.contacts ?? [] : [];
  const { data, loading } = useAsync(() => userApi.companies(), []);
  // Same city list the car filters use — the app's companies filter fix.
  const { data: filters } = useAsync<FiltersData>(() => userApi.filters(), []);

  const companies = (data ?? []).filter(
    (c) => !cityId || c.location?.cityId === cityId,
  );

  return (
    <AppShell>
      <div className="px-4 py-5">
        <div className="mb-4 flex flex-wrap items-center gap-2">
          <h1 className="text-xl font-extrabold">{t("web.companiesTitle")}</h1>
          {joinContacts.length > 0 && (
            <button
              type="button"
              onClick={() => { setJoinOpen(true); advertiseApi.event("join"); }}
              className="ms-auto inline-flex h-9 items-center gap-1.5 rounded-full border border-primary/30 bg-primary/5 px-4 text-sm font-semibold text-primary hover:bg-primary/10"
            >
              ＋ {t("v2.addOffice")}
            </button>
          )}
        </div>
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
      <Modal open={joinOpen} onClose={() => setJoinOpen(false)} title={t("v2.addOffice")}>
        <p className="-mt-2 mb-4 text-sm text-muted">{t("v2.addOfficeSub")}</p>
        <AdvertiseContacts contacts={joinContacts} join />
      </Modal>
    </AppShell>
  );
}
