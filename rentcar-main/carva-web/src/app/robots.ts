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
        // Only the API is blocked. The auth/private pages carry a noindex
        // meta tag instead — robots-blocking them would hide that tag from
        // Google (which is how /login ended up indexed).
        disallow: ["/api/"],
      },
    ],
    sitemap: `${SITE.url}/sitemap.xml`,
    host: SITE.url,
  };
}
