import type { Metadata } from "next";
import { LegalView } from "@/components/LegalView";

export const metadata: Metadata = { title: "Privacy policy · CARVA" };

export default function Page() {
  return <LegalView page="privacy" />;
}
