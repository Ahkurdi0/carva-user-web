# Carva Web

A web version of the **Carva / KCars** car‑rental app, built with **Next.js 16 (App Router) + TypeScript + Tailwind v4**. It reuses the mobile app's real design tokens (colors, Plus Jakarta font, SVG icons, Iraq map) and translations (English / Arabic / Kurdish, with RTL), and talks to the **same backend API** as the Flutter app.

It covers the three roles of the app:

- **Customer** — welcome/auth, browse (suggested, brands, sliders, recently viewed, near‑you, all cars), search & filters, car details (gallery, specs, map, reviews), company details, booking + promo codes, favorites, trips, settings (profile, password, language, support).
- **Company dashboard** (`/dashboard`) — overview, cars (list/create/availability/delete), bookings (status management), promotions (create/delete), reviews, company profile editing.
- **Admin panel** (`/admin`) — statistics, users (roles/permissions, ban), companies, cars, bookings, review moderation + flags, content management (brands, car types, cities, supports, sliders, notifications).

## Getting started

```bash
npm install
npm run dev      # http://localhost:3000
```

### 1. Point it at your backend

Edit `.env.local`:

```bash
# API base URL INCLUDING the /api/v1 prefix (your Contabo server)
NEXT_PUBLIC_API_BASE=https://YOUR-API-HOST/api/v1

# Public base URL where images are served (the server's BASE_IMAGE / S3 origin)
NEXT_PUBLIC_IMAGE_BASE=https://YOUR-IMAGE-HOST
```

### 2. Allow this site in the backend CORS ⚠️

The Express backend (`KCars-server/src/app.ts`) restricts CORS to a single
origin from the `DOMAIN` env var and only allows `POST`. For the website to
reach the API from the browser, add the site's origin (e.g.
`http://localhost:3000` in dev, your real domain in prod) to that allowlist.

Either set `DOMAIN` to the web origin, or change the `cors({ origin })` option
to accept an array / function that includes it.

## How it maps to the app

| Concern | Implementation |
| --- | --- |
| API client (POST‑only, JWT bearer, transparent refresh on 401) | `src/lib/api.ts` |
| Endpoint wrappers | `src/lib/services.ts` (`authApi`, `userApi`, `companyApi`, `adminApi`) |
| Types from the Prisma schema | `src/lib/types.ts` |
| Auth/session store | `src/lib/auth-store.ts` (Zustand) |
| i18n (en/ar/ku + RTL) | `src/i18n/` (reuses the app's translation JSON) |
| Design tokens (colors, font) | `src/app/globals.css` (`@theme`) |
| Icons | `src/components/Icon.tsx` (the app's SVGs via CSS mask) |
| Maps | `src/components/MiniMap.tsx` (Leaflet + OpenStreetMap, like `flutter_map`) |

Build for production:

```bash
npm run build && npm run start
```
