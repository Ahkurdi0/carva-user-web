"use client";
/* eslint-disable react-hooks/set-state-in-effect */

import { useEffect, useMemo, useState } from "react";
import { Modal } from "./Modal";
import { Icon } from "./Icon";
import { Spinner } from "./ui";
import { userApi } from "@/lib/services";
import { imageUrl } from "@/lib/api";
import type { Car, Company } from "@/lib/types";
import type { SharedListing } from "./ChatSharedCard";

type Tab = "cars" | "companies";

function previewImage(value: Car | Company) {
  const item = value as unknown as Record<string, unknown>;
  const first = item.image ?? (Array.isArray(item.images) ? item.images[0] : null);
  if (first && typeof first === "object") return imageUrl(String((first as Record<string, unknown>).image ?? ""));
  return first ? imageUrl(String(first)) : "";
}

export function ShareListingModal({
  open,
  onClose,
  onSelect,
}: {
  open: boolean;
  onClose: () => void;
  onSelect: (listing: SharedListing) => void;
}) {
  const [tab, setTab] = useState<Tab>("cars");
  const [cars, setCars] = useState<Car[]>([]);
  const [companies, setCompanies] = useState<Company[]>([]);
  const [query, setQuery] = useState("");
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (!open || cars.length > 0 || companies.length > 0) return;
    let active = true;
    setLoading(true);
    Promise.allSettled([userApi.allCars(), userApi.companies()]).then(([carResult, companyResult]) => {
      if (!active) return;
      if (carResult.status === "fulfilled") setCars(carResult.value.cars ?? []);
      if (companyResult.status === "fulfilled") setCompanies(companyResult.value ?? []);
      setLoading(false);
    });
    return () => { active = false; };
  }, [open, cars.length, companies.length]);

  const filteredCars = useMemo(() => {
    const needle = query.trim().toLowerCase();
    return needle ? cars.filter((car) => `${car.title} ${car.company?.name ?? "personal car"}`.toLowerCase().includes(needle)) : cars;
  }, [cars, query]);
  const filteredCompanies = useMemo(() => {
    const needle = query.trim().toLowerCase();
    return needle ? companies.filter((company) => company.name.toLowerCase().includes(needle)) : companies;
  }, [companies, query]);

  return (
    <Modal open={open} onClose={onClose} title="Share a listing">
      <div className="space-y-4">
        <div className="flex rounded-full bg-surface-lowest p-1">
          {(["cars", "companies"] as Tab[]).map((value) => (
            <button
              key={value}
              type="button"
              onClick={() => { setTab(value); setQuery(""); }}
              className={`flex flex-1 items-center justify-center gap-2 rounded-full py-2 text-sm font-semibold transition ${tab === value ? "bg-white text-primary shadow-sm" : "text-muted"}`}
            >
              <Icon name={value === "cars" ? "car" : "company"} size={17} color={tab === value ? "#3957d7" : "#9e9e9e"} />
              {value === "cars" ? "Cars" : "Companies"}
            </button>
          ))}
        </div>
        <div className="flex items-center gap-2 rounded-xl border border-surface-low bg-surface-lowest px-3">
          <Icon name="search" size={17} color="#9e9e9e" />
          <input value={query} onChange={(event) => setQuery(event.target.value)} placeholder={`Search ${tab}`} className="h-11 min-w-0 flex-1 bg-transparent text-sm outline-none" />
        </div>
        {loading ? (
          <div className="flex justify-center py-10"><Spinner size={28} /></div>
        ) : (
          <div className="max-h-[52vh] space-y-2 overflow-y-auto pr-1">
            {tab === "cars" && filteredCars.map((car) => (
              <button key={car.id} type="button" onClick={() => onSelect({ kind: "car", item: car })} className="flex w-full items-center gap-3 rounded-2xl border border-surface-low p-2 text-start transition hover:border-primary/50 hover:bg-surface-lowest">
                <span className="h-16 w-20 shrink-0 overflow-hidden rounded-xl bg-primary-container">
                  {previewImage(car) ? <img src={previewImage(car)} alt="" className="h-full w-full object-cover" /> : <span className="grid h-full place-items-center"><Icon name="car" size={24} color="#3957d7" /></span>}
                </span>
                <span className="min-w-0 flex-1"><span className="block truncate text-sm font-bold">{car.title}</span><span className="mt-1 block truncate text-xs text-muted">{car.company?.name ?? "Personal car"}</span></span>
                <Icon name="arrow_tail" size={17} color="#9e9e9e" />
              </button>
            ))}
            {tab === "companies" && filteredCompanies.map((company) => (
              <button key={company.id} type="button" onClick={() => onSelect({ kind: "company", item: company })} className="flex w-full items-center gap-3 rounded-2xl border border-surface-low p-2 text-start transition hover:border-primary/50 hover:bg-surface-lowest">
                <span className="h-16 w-20 shrink-0 overflow-hidden rounded-xl bg-primary-container">
                  {previewImage(company) ? <img src={previewImage(company)} alt="" className="h-full w-full object-cover" /> : <span className="grid h-full place-items-center"><Icon name="company" size={24} color="#3957d7" /></span>}
                </span>
                <span className="min-w-0 flex-1"><span className="block truncate text-sm font-bold">{company.name}</span><span className="mt-1 block truncate text-xs text-muted">{company.cars ?? 0} cars</span></span>
                <Icon name="arrow_tail" size={17} color="#9e9e9e" />
              </button>
            ))}
            {((tab === "cars" && filteredCars.length === 0) || (tab === "companies" && filteredCompanies.length === 0)) && <p className="py-10 text-center text-sm text-muted">No listings found.</p>}
          </div>
        )}
      </div>
    </Modal>
  );
}
