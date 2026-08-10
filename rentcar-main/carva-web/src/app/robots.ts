import type { MetadataRoute } from "next";
import { SITE } from "@/lib/seo";

// Allow all crawlers (including AI search bots like GPTBot/PerplexityBot via
// the wildcard) on public pages; keep private app areas out of the index.
export default function robots(): MetadataRoute.Robots {
  return {
    rules: [
      {
        userAgent: "*",
        allow: "/",
        disallow: ["/api/", "/booking", "/settings", "/trips"],
      },
    ],
    sitemap: `${SITE.url}/sitemap.xml`,
    host: SITE.url,
  };
}
