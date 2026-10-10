// Countries for "where are you from" (residency) and identity documents.
// ISO 3166-1 alpha-2 codes; names come from the browser (Intl), in the
// site's language (Kurdish = ckb), falling back to English.
import type { Lang } from "./types";
import { KU_NAMES } from "./countries-ku";

export const COUNTRY_CODES = (
  "AD AE AF AG AI AL AM AO AR AS AT AU AW AX AZ BA BB BD BE BF BG BH BI BJ BL BM BN BO BR BS BT BW BY BZ " +
  "CA CC CD CF CG CH CI CK CL CM CN CO CR CU CV CW CX CY CZ DE DJ DK DM DO DZ EC EE EG EH ER ES ET FI FJ FK FM FO FR " +
  "GA GB GD GE GF GG GH GI GL GM GN GP GQ GR GT GU GW GY HK HN HR HT HU ID IE IL IM IN IQ IR IS IT JE JM JO JP " +
  "KE KG KH KI KM KN KP KR KW KY KZ LA LB LC LI LK LR LS LT LU LV LY MA MC MD ME MF MG MH MK ML MM MN MO MP MQ MR MS " +
  "MT MU MV MW MX MY MZ NA NC NE NF NG NI NL NO NP NR NU NZ OM PA PE PF PG PH PK PL PM PN PR PS PT PW PY QA RE RO RS " +
  "RU RW SA SB SC SD SE SG SH SI SK SL SM SN SO SR SS ST SV SX SY SZ TC TD TG TH TJ TK TL TM TN TO TR TT TV TW TZ UA " +
  "UG US UY UZ VA VC VE VG VI VN VU WF WS XK YE YT ZA ZM ZW"
).split(" ");

// Where most visitors come from: shown first.
const FIRST = ["TR", "IR", "SY", "JO", "SA", "KW", "AE", "LB", "EG", "DE", "GB", "SE", "NL", "US"];

const locale = (lang: Lang) => (lang === "ku" ? "ckb" : lang);
const cache = new Map<string, Intl.DisplayNames | null>();
function names(lang: Lang) {
  const key = locale(lang);
  if (!cache.has(key)) {
    try {
      cache.set(key, new Intl.DisplayNames([key, "en"], { type: "region" }));
    } catch {
      cache.set(key, null);
    }
  }
  return cache.get(key);
}

export function countryName(code: string, lang: Lang): string {
  if (lang === "ku" && KU_NAMES[code]) return KU_NAMES[code];
  try {
    return names(lang)?.of(code) ?? code;
  } catch {
    return code;
  }
}

/** "DE" -> 🇩🇪 */
export const flag = (code: string) =>
  /^[A-Z]{2}$/.test(code) ? String.fromCodePoint(...[...code].map((c) => 0x1f1e6 + c.charCodeAt(0) - 65)) : "🏳️";

/** Visitors' list: common countries first, then A–Z in the current language. Iraq left out. */
export function visitorCountries(lang: Lang): string[] {
  const rest = COUNTRY_CODES.filter((c) => c !== "IQ" && !FIRST.includes(c)).sort((a, b) =>
    countryName(a, lang).localeCompare(countryName(b, lang), locale(lang)),
  );
  return [...FIRST, ...rest];
}

/** All countries (driving licences can be from anywhere): Iraq first. */
export function allCountries(lang: Lang): string[] {
  return ["IQ", ...visitorCountries(lang)];
}

export const matchesCountry = (code: string, lang: Lang, q: string) => {
  const s = q.trim().toLowerCase();
  if (!s) return true;
  return (
    code.toLowerCase() === s ||
    countryName(code, lang).toLowerCase().includes(s) ||
    countryName(code, "en").toLowerCase().includes(s)
  );
};
