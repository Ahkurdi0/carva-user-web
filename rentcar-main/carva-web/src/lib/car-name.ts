// "Toyota" · "Camry" · "XSE": make, model and trim split out of the car
// title for display (same rules as the app's CarName). The title text is
// never changed — only coloured in parts.

const TRIM_WORDS = new Set([
  "denali", "platinum", "limited", "sport", "premium", "luxury", "signature", "touring", "titanium",
  "laramie", "lariat", "sahara", "rubicon", "overland", "highline", "elite", "prestige", "executive",
  "ultimate", "trailhawk", "summit", "reserve", "avenir", "nismo",
]);

export function isTrim(word: string) {
  return TRIM_WORDS.has(word.toLowerCase()) || /^(?=.*[A-Z])[A-Z0-9-]{2,6}$/.test(word);
}

export interface CarName {
  make?: string;
  model: string;
  trim?: string;
}

export function carName(title: string, brand?: string | null): CarName {
  let rest = (title ?? "").trim();
  let make: string | undefined;
  const b = (brand ?? "").trim();
  if (b) {
    const starts = rest.toLowerCase().startsWith(b.toLowerCase()) && (rest.length === b.length || rest[b.length] === " ");
    if (starts) {
      make = rest.slice(0, b.length);
      rest = rest.slice(b.length).trim();
    } else {
      make = b;
    }
  }
  const words = rest.split(/\s+/).filter(Boolean);
  if (words.length >= 2 && isTrim(words[words.length - 1])) {
    return { make, model: words.slice(0, -1).join(" "), trim: words[words.length - 1] };
  }
  return { make, model: rest || title };
}
