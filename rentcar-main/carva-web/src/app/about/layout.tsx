import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "About CARVA — car rental in Iraq & Kurdistan",
  description:
    "CARVA brings rental offices' cars together in one app and website: real photos and prices, chat, WhatsApp and calls straight to the office — in Kurdish, Arabic and English.",
  alternates: { canonical: "/about" },
};

export default function Layout({ children }: { children: React.ReactNode }) {
  return children;
}
