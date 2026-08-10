import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Explore Rental Cars",
  description:
    "Swipe through the newest rental cars in Iraq and Kurdistan — real photos, daily and monthly prices, and one-tap WhatsApp contact with the rental office.",
  alternates: { canonical: "/reels" },
};

export default function Layout({ children }: { children: React.ReactNode }) {
  return children;
}
