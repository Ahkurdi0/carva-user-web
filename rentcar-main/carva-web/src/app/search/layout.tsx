import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Search Rental Cars in Iraq & Kurdistan",
  description:
    "Find and compare rental cars across Iraq and Kurdistan — economy, sedan, SUV, 4x4 and luxury cars for daily, weekly or monthly rent in Erbil, Sulaymaniyah and Duhok.",
  alternates: { canonical: "/search" },
};

export default function Layout({ children }: { children: React.ReactNode }) {
  return children;
}
