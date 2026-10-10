import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Advertise on CARVA",
  description: "Put your rental cars in front of renters across Iraq: home sliders, Reels and full-screen ads on CARVA.",
};

export default function Layout({ children }: { children: React.ReactNode }) {
  return children;
}
