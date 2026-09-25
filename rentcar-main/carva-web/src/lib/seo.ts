// Central SEO config so metadata, robots, sitemap and JSON-LD stay in sync.
export const SITE = {
  name: "Carva",
  url: "https://carvarent.com",
  // Brand variations people search for — surfaced in <title>, JSON-LD
  // alternateName and keywords so the brand resolves to this site.
  alternateNames: [
    "Carva Rent",
    "Carva Rent Car",
    "Carva Car Rental",
    "Carvaone",
    "CarvaOne",
  ],
  description:
    "Carva (Carva Rent) is a car rental marketplace. Browse and compare rental cars from trusted local companies, view photos and specs, then reserve online or contact the company on WhatsApp.",
  tagline: "Carva — Rent a car in minutes",
  logo: "/assets/images/carva.png",
} as const;

export const SEO_KEYWORDS = [
  "Carva",
  "Carva Rent",
  "Carva rent car",
  "Carva car rental",
  "Carvaone",
  "CarvaOne",
  "car rental",
  "rent a car",
  "car rental marketplace",
  "rent a car online",
];
