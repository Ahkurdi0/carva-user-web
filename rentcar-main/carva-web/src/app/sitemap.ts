import type { MetadataRoute } from "next";
import { SITE } from "@/lib/seo";
import { serverApi } from "@/lib/server-api";
import type { Car, Company } from "@/lib/types";

// Static pages plus every live car and company page, so Google can find and
// index the same inventory the app shows. Falls back to the static routes
// alone if the API is unreachable.
export const revalidate = 3600;

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const now = new Date();
  const routes: {
    path: string;
    priority: number;
    freq: MetadataRoute.Sitemap[number]["changeFrequency"];
  }[] = [
    { path: "", priority: 1, freq: "daily" },
    { path: "/search", priority: 0.8, freq: "daily" },
    { path: "/companies", priority: 0.7, freq: "weekly" },
    { path: "/login", priority: 0.3, freq: "monthly" },
    { path: "/signup", priority: 0.3, freq: "monthly" },
  ];

  const entries: MetadataRoute.Sitemap = routes.map((r) => ({
    url: `${SITE.url}${r.path}`,
    lastModified: now,
    changeFrequency: r.freq,
    priority: r.priority,
  }));

  const [cars, companies] = await Promise.all([
    serverApi<Car[]>("/user/reelsCars"),
    serverApi<Company[]>("/user/companies"),
  ]);

  for (const car of cars ?? []) {
    if (!car.carId) continue;
    entries.push({
      url: `${SITE.url}/car/${car.carId}`,
      lastModified: now,
      changeFrequency: "weekly",
      priority: 0.6,
    });
  }

  for (const company of companies ?? []) {
    entries.push({
      url: `${SITE.url}/company/${company.id}`,
      lastModified: now,
      changeFrequency: "weekly",
      priority: 0.5,
    });
  }

  return entries;
}
