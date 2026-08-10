"use client";

import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useMemo,
  useState,
} from "react";
import en from "./en.json";
import ar from "./ar.json";
import ku from "./ku.json";
import type { Lang, Localized } from "@/lib/types";
import { setLang as persistLang } from "@/lib/api";

type Dict = Record<string, unknown>;
const dicts: Record<Lang, Dict> = { en, ar, ku };

export const LANG_NAMES: Record<Lang, string> = {
  en: "English",
  ar: "عربی",
  ku: "کوردی",
};

function lookup(dict: Dict, path: string): string | undefined {
  // Supports both dot ("a.b.c") and underscore ("a_b_c") separators.
  const tryPath = (parts: string[]) => {
    let cur: unknown = dict;
    for (const p of parts) {
      if (cur && typeof cur === "object" && p in (cur as Dict)) {
        cur = (cur as Dict)[p];
      } else return undefined;
    }
    return typeof cur === "string" ? cur : undefined;
  };
  return tryPath(path.split(".")) ?? tryPath(path.split("_"));
}

interface I18nValue {
  lang: Lang;
  dir: "ltr" | "rtl";
  setLang: (l: Lang) => void;
  t: (key: string, vars?: Record<string, string | number>) => string;
  /** Pick the right field off a localized object based on the active language. */
  tr: (obj?: Localized | null) => string;
  /** Render a number/string or localized {en,ar,ku} object as a string. */
  num: (v: unknown) => string;
}

const I18nContext = createContext<I18nValue | null>(null);

export function I18nProvider({ children }: { children: React.ReactNode }) {
  const [lang, setLangState] = useState<Lang>("en");

  useEffect(() => {
    const stored = (localStorage.getItem("carva.lang") as Lang) || "en";
    setLangState(stored);
  }, []);

  const dir: "ltr" | "rtl" = lang === "en" ? "ltr" : "rtl";

  useEffect(() => {
    document.documentElement.lang = lang;
    document.documentElement.dir = dir;
  }, [lang, dir]);

  const setLang = useCallback((l: Lang) => {
    persistLang(l);
    setLangState(l);
  }, []);

  const t = useCallback(
    (key: string, vars?: Record<string, string | number>) => {
      let val = lookup(dicts[lang], key) ?? lookup(dicts.en, key) ?? key;
      if (vars) {
        for (const [k, v] of Object.entries(vars)) {
          val = val.replace(new RegExp(`{${k}}`, "g"), String(v));
        }
      }
      return val;
    },
    [lang],
  );

  const tr = useCallback(
    (obj?: Localized | null) => {
      if (!obj) return "";
      return (obj[lang] as string) || obj.en || "";
    },
    [lang],
  );

  // Render a value that may be a number/string OR a localized object
  // ({en,ar,ku}) — the backend returns some feature fields either way.
  const num = useCallback(
    (v: unknown): string => {
      if (v === null || v === undefined) return "";
      if (typeof v === "object" && v !== null && "en" in (v as object)) {
        return tr(v as Localized);
      }
      return String(v);
    },
    [tr],
  );

  const value = useMemo(
    () => ({ lang, dir, setLang, t, tr, num }),
    [lang, dir, setLang, t, tr, num],
  );

  return <I18nContext.Provider value={value}>{children}</I18nContext.Provider>;
}

export function useI18n() {
  const ctx = useContext(I18nContext);
  if (!ctx) throw new Error("useI18n must be used within I18nProvider");
  return ctx;
}
