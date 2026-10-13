import type { Metadata } from "next";
import { LegalView } from "@/components/LegalView";

export const metadata: Metadata = { title: "Terms & conditions · CARVA" };

export default function Page() {
  return <LegalView page="terms" />;
}
