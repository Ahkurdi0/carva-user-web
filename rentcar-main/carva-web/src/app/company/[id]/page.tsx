import type { Metadata } from "next";
import { serverApi, absoluteImageUrl } from "@/lib/server-api";
import { SITE } from "@/lib/seo";
import type { Company } from "@/lib/types";
import { CompanyDetailsClient } from "./company-details-client";

// Per-company share preview: the office's cover (or logo) plus its name and
// car count, so sharing a company on WhatsApp/Messenger shows the real brand.
export async function generateMetadata({
  params,
}: {
  params: Promise<{ id: string }>;
}): Promise<Metadata> {
  const { id } = await params;
  const company = await serverApi<Company>("/user/company", { id });
  if (!company) return {};

  const photo =
    absoluteImageUrl(company.coverImage) ?? absoluteImageUrl(company.image);
  const bits = [
    company.cars ? `${company.cars} cars for rent` : null,
    "Rent on Carva",
  ].filter(Boolean);

  return {
    title: company.name,
    description: company.desc?.trim() || bits.join(" · "),
    alternates: { canonical: `/company/${id}` },
    openGraph: {
      type: "website",
      siteName: SITE.name,
      title: `${company.name} | Carva`,
      description: company.desc?.trim() || bits.join(" · "),
      url: `${SITE.url}/company/${id}`,
      images: photo ? [{ url: photo, alt: company.name }] : undefined,
    },
    twitter: {
      card: "summary_large_image",
      title: `${company.name} | Carva`,
      description: company.desc?.trim() || bits.join(" · "),
      images: photo ? [photo] : undefined,
    },
  };
}

export default async function CompanyDetailsPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  const company = await serverApi<Company>("/user/company", { id });

  // AutoRental structured data — a real local rental office with a place.
  const jsonLd = company
    ? {
        "@context": "https://schema.org",
        "@type": "AutoRental",
        name: company.name,
        url: `${SITE.url}/company/${id}`,
        ...(company.image
          ? { image: absoluteImageUrl(company.image) }
          : {}),
        ...(company.desc ? { description: company.desc } : {}),
        ...(company.location?.lat != null && company.location?.long != null
          ? {
              geo: {
                "@type": "GeoCoordinates",
                latitude: company.location.lat,
                longitude: company.location.long,
              },
            }
          : {}),
        ...(company.location?.city?.en
          ? {
              address: {
                "@type": "PostalAddress",
                addressLocality: company.location.city.en,
                addressCountry: "IQ",
              },
            }
          : {}),
        parentOrganization: { "@type": "Organization", name: SITE.name },
      }
    : null;

  return (
    <>
      {jsonLd && (
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
        />
      )}
      <CompanyDetailsClient />
    </>
  );
}
