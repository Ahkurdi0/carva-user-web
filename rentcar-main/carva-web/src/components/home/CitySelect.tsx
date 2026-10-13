"use client";

import { useState } from "react";
import type { FiltersData } from "@/lib/types";
import { useI18n } from "@/i18n";
import { Modal } from "../Modal";
import { Button } from "../ui";

type City = FiltersData["cities"][number];

export const cityKey = (v?: string | null) => (v ?? "").trim().toLowerCase();

/**
 * Home's city narrowing, like the app's top bar: "📍 All cities ˅" opens a
 * sheet with check boxes. Picking every city is the same as none.
 */
export function CitySelect({
  cities,
  selected,
  onChange,
}: {
  cities: City[];
  selected: Set<string>;
  onChange: (next: Set<string>) => void;
}) {
  const { t, tr } = useI18n();
  const [open, setOpen] = useState(false);
  const [temp, setTemp] = useState<Set<string>>(new Set());
  if (cities.length === 0) return null;

  const label =
    selected.size === 0
      ? t("v2.allCities")
      : selected.size === 1
        ? cities.filter((c) => selected.has(cityKey(c.en))).map((c) => tr(c)).join("")
        : `${selected.size} ${t("v2.cities")}`;

  const box = (on: boolean) => (
    <span className={`grid h-5 w-5 shrink-0 place-items-center rounded-md border-2 transition ${on ? "border-primary bg-primary" : "border-border-strong bg-white"}`}>
      {on && (
        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="3.5" strokeLinecap="round" strokeLinejoin="round" aria-hidden>
          <path d="M5 12.5l4.5 4.5L19 7.5" />
        </svg>
      )}
    </span>
  );

  return (
    <>
      <button
        onClick={() => {
          setTemp(new Set(selected));
          setOpen(true);
        }}
        className="press inline-flex h-10 max-w-full items-center gap-1 rounded-full bg-white px-3 text-[15px] font-semibold text-on-surface shadow-[var(--shadow-card)] ring-1 ring-hairline"
      >
        <svg width="18" height="18" viewBox="0 0 24 24" fill="#B51219" aria-hidden className="shrink-0">
          <path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5a2.5 2.5 0 0 1 0-5 2.5 2.5 0 0 1 0 5z" />
        </svg>
        <span className="truncate">{label}</span>
        <svg width="18" height="18" viewBox="0 0 24 24" fill="#6E6866" aria-hidden className="shrink-0">
          <path d="M7.41 8.59 12 13.17l4.59-4.58L18 10l-6 6-6-6z" />
        </svg>
      </button>
      <Modal open={open} onClose={() => setOpen(false)} title={t("v2.selectCity")}>
        <button onClick={() => setTemp(new Set())} className="flex w-full items-center gap-3 rounded-xl px-1 py-3 text-start text-[15px]">
          {box(temp.size === 0)}
          {t("v2.allCities")}
        </button>
        <div className="my-1 h-px bg-hairline" />
        <div className="max-h-[50vh] overflow-y-auto">
          {cities.map((c) => {
            const k = cityKey(c.en);
            const on = temp.has(k);
            return (
              <button
                key={c.id}
                onClick={() => {
                  const n = new Set(temp);
                  if (on) n.delete(k);
                  else n.add(k);
                  setTemp(n);
                }}
                className="flex w-full items-center gap-3 rounded-xl px-1 py-3 text-start text-[15px]"
              >
                {box(on)}
                {tr(c)}
              </button>
            );
          })}
        </div>
        <Button
          full
          className="mt-4 !rounded-full"
          onClick={() => {
            onChange(temp.size >= cities.length ? new Set() : temp);
            setOpen(false);
          }}
        >
          {t("v2.confirm")}
        </Button>
      </Modal>
    </>
  );
}
