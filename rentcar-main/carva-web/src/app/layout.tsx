import type { Metadata, Viewport } from "next";
import "./globals.css";
import { Providers } from "@/components/Providers";
import { Toaster } from "@/components/toast";
import { SITE, SEO_KEYWORDS } from "@/lib/seo";

export const metadata: Metadata = {
  metadataBase: new URL(SITE.url),
  title: {
    default: SITE.tagline,
    template: "%s | Carva",
  },
  description: SITE.description,
  applicationName: SITE.name,
  keywords: SEO_KEYWORDS,
  authors: [{ name: SITE.name, url: SITE.url }],
  creator: SITE.name,
  publisher: SITE.name,
  alternates: { canonical: "/" },
  manifest: "/manifest.webmanifest",
  openGraph: {
    type: "website",
    siteName: SITE.name,
    title: SITE.tagline,
    description: SITE.description,
    url: SITE.url,
    images: [{ url: SITE.logo, width: 512, height: 512, alt: SITE.name }],
  },
  twitter: {
    card: "summary_large_image",
    title: SITE.tagline,
    description: SITE.description,
    images: [SITE.logo],
  },
  robots: {
    index: true,
    follow: true,
    googleBot: { index: true, follow: true, "max-image-preview": "large", "max-snippet": -1 },
  },
  // To verify Google Search Console via meta tag, add the token here:
  // verification: { google: "YOUR_GSC_TOKEN" },
};

export const viewport: Viewport = {
  themeColor: "#B51219",
  width: "device-width",
  initialScale: 1,
};

// Structured data so Google and AI assistants recognize the brand and its
// alternate names (Carva Rent, Carvaone) and link them to this site.
const jsonLd = [
  {
    "@context": "https://schema.org",
    "@type": "Organization",
    name: SITE.name,
    alternateName: SITE.alternateNames,
    url: SITE.url,
    logo: `${SITE.url}${SITE.logo}`,
    description: SITE.description,
  },
  {
    "@context": "https://schema.org",
    "@type": "WebSite",
    name: SITE.name,
    alternateName: SITE.alternateNames,
    url: SITE.url,
    description: SITE.description,
  },
];

export default function RootLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en" className="h-full antialiased">
      <head>
        {/* Kurdish/Arabic text face and the mono face for prices (CARVA v3 kit). */}
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="anonymous" />
        {/* eslint-disable-next-line @next/next/no-page-custom-font */}
        <link
          rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+Arabic:wght@400;500;600;700&family=JetBrains+Mono:wght@500;600;700&display=swap"
        />
      </head>
      <body className="min-h-full">
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
        />
        <Providers>
          {children}
          <Toaster />
        </Providers>
      </body>
    </html>
  );
}
