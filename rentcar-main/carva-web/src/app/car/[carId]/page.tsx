import type { Metadata } from "next";
import { serverApi, absoluteImageUrl } from "@/lib/server-api";
import { SITE } from "@/lib/seo";
import type { Car } from "@/lib/types";
import { CarDetailsClient } from "./car-details-client";

function carSummary(car: Car): { title: string; desc: string; from: number | null; currency: string } {
  const year = car.feature?.year;
  const title = [year, car.title].filter(Boolean).join(" ");
  const plans = (car.rentalPlan ?? [])
    .map((p) => p.price)
    .filter((p): p is number => typeof p === "number" && p > 0);
  const from = plans.length ? Math.min(...plans) : null;
  const currency =
    (car.rentalPlan?.[0]?.currency ?? "usd").toLowerCase() === "iqd"
      ? "IQD"
      : "USD";
  const bits = [
    from ? `From $${from}` : null,
    car.company?.name ?? null,
    "Rent it on Carva",
  ].filter(Boolean);
  return { title, desc: bits.join(" · "), from, currency };
}

// Share previews (WhatsApp, Messenger, Telegram…) and search engines read
// these tags — each car page carries its own photo, title and price.
export async function generateMetadata({
  params,
}: {
  params: Promise<{ carId: string }>;
}): Promise<Metadata> {
  const { carId } = await params;
  const car = await serverApi<Car>("/user/carDetails", { id: carId });
  if (!car) return {};

  const photo = absoluteImageUrl(car.images?.[0]?.image);
  const { title, desc } = carSummary(car);

  return {
    title,
    description: desc,
    alternates: { canonical: `/car/${carId}` },
    openGraph: {
      type: "website",
      siteName: SITE.name,
      title: `${title} | Carva`,
      description: desc,
      url: `${SITE.url}/car/${carId}`,
      images: photo ? [{ url: photo, alt: title }] : undefined,
    },
    twitter: {
      card: "summary_large_image",
      title: `${title} | Carva`,
      description: desc,
      images: photo ? [photo] : undefined,
    },
  };
}

export default async function CarDetailsPage({
  params,
}: {
  params: Promise<{ carId: string }>;
}) {
  const { carId } = await params;
  const car = await serverApi<Car>("/user/carDetails", { id: carId });

  // Product structured data so the listing is eligible for rich results.
  const jsonLd = car
    ? (() => {
        const { title, desc, from, currency } = carSummary(car);
        const photo = absoluteImageUrl(car.images?.[0]?.image);
        return {
          "@context": "https://schema.org",
          "@type": "Product",
          name: title,
          description: desc,
          ...(photo ? { image: [photo] } : {}),
          ...(car.brand?.en
            ? { brand: { "@type": "Brand", name: car.brand.en } }
            : {}),
          ...(from
            ? {
                offers: {
                  "@type": "Offer",
                  price: from,
                  priceCurrency: currency,
                  availability: "https://schema.org/InStock",
                  url: `${SITE.url}/car/${carId}`,
                },
              }
            : {}),
        };
      })()
    : null;

  return (
    <>
      {jsonLd && (
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
        />
      )}
      <CarDetailsClient />
    </>
  );
}
