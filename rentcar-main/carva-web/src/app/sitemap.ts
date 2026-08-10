import type { MetadataRoute } from "next";
import { SITE } from "@/lib/seo";

// Public, indexable routes. (Car/company detail pages could be added here
// dynamically from the API later; the homepage is what ranks for the brand.)
export default function sitemap(): MetadataRoute.Sitemap {
  const now = new Date();
  const routes: { path: string; priority: number; freq: MetadataRoute.Sitemap[number]["changeFrequency"] }[] = [
    { path: "", priority: 1, freq: "daily" },
    { path: "/search", priority: 0.8, freq: "daily" },
    { path: "/companies", priority: 0.7, freq: "weekly" },
    { path: "/login", priority: 0.3, freq: "monthly" },
    { path: "/signup", priority: 0.3, freq: "monthly" },
  ];
  return routes.map((r) => ({
    url: `${SITE.url}${r.path}`,
    lastModified: now,
    changeFrequency: r.freq,
    priority: r.priority,
  }));
}
