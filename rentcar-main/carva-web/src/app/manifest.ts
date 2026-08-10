import type { MetadataRoute } from "next";
import { SITE } from "@/lib/seo";

export default function manifest(): MetadataRoute.Manifest {
  return {
    name: SITE.tagline,
    short_name: SITE.name,
    description: SITE.description,
    start_url: "/",
    display: "standalone",
    background_color: "#ffffff",
    theme_color: "#B51219",
    icons: [
      { src: "/icon.png", sizes: "512x512", type: "image/png", purpose: "any" },
    ],
  };
}
