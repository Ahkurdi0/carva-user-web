"use client";

import { useMemo, useState } from "react";
import { useI18n } from "@/i18n";
import { countryName, flag, matchesCountry, visitorCountries } from "@/lib/countries";

export interface Residency {
  residency: "iraq" | "visitor" | null;
  homeCountry: string | null;
}

export const residencyComplete = (r: Residency) =>
  r.residency === "iraq" || (r.residency === "visitor" && !!r.homeCountry);

/** A searchable country list with flags (one tap selects). */
export function CountryList({
  value,
  onChange,
  codes,
  height = 260,
}: {
  value: string | null;
  onChange: (code: string) => void;
  codes: string[];
  height?: number;
}) {
  const { t, lang } = useI18n();
  const [q, setQ] = useState("");
  const list = useMemo(() => codes.filter((c) => matchesCountry(c, lang, q)), [codes, lang, q]);
  return (
    <div>
      <input
        value={q}
        onChange={(e) => setQ(e.target.value)}
        placeholder={t("v2.searchCountry")}
        className="h-11 w-full rounded-xl border border-surface-low bg-white px-4 text-sm outline-none focus:border-primary"
      />
      <div className="mt-1 overflow-y-auto" style={{ maxHeight: height }}>
        {list.length === 0 && <p className="py-6 text-center text-sm text-muted">{t("v2.noCountry")}</p>}
        {list.map((c) => (
          <button
            type="button"
            key={c}
            onClick={() => onChange(c)}
            className="flex h-12 w-full items-center gap-3 border-b border-surface-low px-1 text-start"
          >
            <span className="text-xl leading-none">{flag(c)}</span>
            <span className={`flex-1 truncate text-sm ${c === value ? "font-bold" : "font-medium"}`}>{countryName(c, lang)}</span>
            {c === value && <span className="text-primary">✓</span>}
          </button>
        ))}
      </div>
    </div>
  );
}

function Option({
  title,
  sub,
  icon,
  selected,
  onClick,
}: {
  title: string;
  sub: string;
  icon: string;
  selected: boolean;
  onClick: () => void;
}) {
  return (
    <button
      type="button"
      onClick={onClick}
      aria-pressed={selected}
      className={`flex w-full items-center gap-3 rounded-2xl border bg-white p-4 text-start transition ${
        selected ? "border-on-surface border-[1.5px]" : "border-surface-low"
      }`}
    >
      <span
        className={`grid h-6 w-6 shrink-0 place-items-center rounded-full text-xs ${
          selected ? "bg-on-surface text-white" : "border-[1.5px] border-[#CFC8C4]"
        }`}
      >
        {selected ? "✓" : ""}
      </span>
      <span className="min-w-0 flex-1">
        <span className="block text-[15px] font-bold">{title}</span>
        <span className="block text-xs text-muted">{sub}</span>
      </span>
      <span className="text-xl">{icon}</span>
    </button>
  );
}

/** "Where do you live?" — Iraq, or a visitor from another country. */
export function ResidencyChoice({ value, onChange }: { value: Residency; onChange: (v: Residency) => void }) {
  const { t, lang } = useI18n();
  const codes = useMemo(() => visitorCountries(lang), [lang]);
  return (
    <div className="space-y-2.5">
      <Option
        title={t("v2.liveIraq")}
        sub={t("v2.liveIraqSub")}
        icon="🇮🇶"
        selected={value.residency === "iraq"}
        onClick={() => onChange({ residency: "iraq", homeCountry: null })}
      />
      <Option
        title={t("v2.visitor")}
        sub={t("v2.visitorSub")}
        icon="✈️"
        selected={value.residency === "visitor"}
        onClick={() => onChange({ residency: "visitor", homeCountry: value.homeCountry })}
      />
      {value.residency === "visitor" && (
        <div className="pt-2">
          <p className="mb-2 text-xs font-semibold text-muted">{t("v2.fromWhere")}</p>
          <CountryList value={value.homeCountry} codes={codes} onChange={(c) => onChange({ residency: "visitor", homeCountry: c })} />
        </div>
      )}
    </div>
  );
}
