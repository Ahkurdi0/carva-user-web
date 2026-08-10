import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Car Rental Companies in Iraq & Kurdistan",
  description:
    "Browse trusted car rental offices in Erbil, Sulaymaniyah, Duhok and across Iraq. Compare fleets, ratings and prices, then contact the office directly on WhatsApp.",
  alternates: { canonical: "/companies" },
};

export default function Layout({ children }: { children: React.ReactNode }) {
  return children;
}
