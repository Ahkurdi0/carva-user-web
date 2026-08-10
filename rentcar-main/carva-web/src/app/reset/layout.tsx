import type { Metadata } from "next";

// Private/auth page — keep it out of search results. Crawling stays
// allowed (robots.txt) so Google can actually see the noindex.
export const metadata: Metadata = {
  title: "Reset password",
  robots: { index: false, follow: false },
};

export default function Layout({ children }: { children: React.ReactNode }) {
  return children;
}
