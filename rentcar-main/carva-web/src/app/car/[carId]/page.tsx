import type { Metadata } from "next";
import { serverApi, absoluteImageUrl } from "@/lib/server-api";
import { SITE } from "@/lib/seo";
import type { Car } from "@/lib/types";
import { CarDetailsClient } from "./car-details-client";

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
  const year = car.feature?.year;
  const title = [year, car.title].filter(Boolean).join(" ");

  const plans = (car.rentalPlan ?? [])
    .map((p) => p.price)
    .filter((p): p is number => typeof p === "number" && p > 0);
  const from = plans.length ? Math.min(...plans) : null;

  const bits = [
    from ? `From $${from}` : null,
    car.company?.name ?? null,
    "Rent it on Carva",
  ].filter(Boolean);

  return {
    title,
    description: bits.join(" · "),
    alternates: { canonical: `/car/${carId}` },
    openGraph: {
      type: "website",
      siteName: SITE.name,
      title: `${title} | Carva`,
      description: bits.join(" · "),
      url: `${SITE.url}/car/${carId}`,
      images: photo ? [{ url: photo, alt: title }] : undefined,
    },
    twitter: {
      card: "summary_large_image",
      title: `${title} | Carva`,
      description: bits.join(" · "),
      images: photo ? [photo] : undefined,
    },
  };
}

export default function CarDetailsPage() {
  return <CarDetailsClient />;
}
