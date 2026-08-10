// Server-side API access for generateMetadata / sitemap — runs in the Next
// server, so it talks to the backend directly (API_UPSTREAM, same var the
// proxy route uses) instead of going through /api/proxy.

const UPSTREAM = (
  process.env.API_UPSTREAM ||
  process.env.NEXT_PUBLIC_API_BASE ||
  "https://carvarent.com/api/v1"
).replace(/\/$/, "");

const IMG = (process.env.NEXT_PUBLIC_IMAGE_BASE || "").replace(/\/$/, "");

/** POST an endpoint from the server. Returns null on any failure — metadata
 * callers fall back to the generic site tags rather than erroring the page. */
export async function serverApi<T>(path: string, body?: unknown): Promise<T | null> {
  try {
    const res = await fetch(`${UPSTREAM}${path}`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body ?? {}),
      // Share crawlers hit these pages in bursts; a short cache is plenty.
      next: { revalidate: 300 },
    });
    if (!res.ok) return null;
    return (await res.json()) as T;
  } catch {
    return null;
  }
}

/** Absolute image URL for og:image (crawlers need a full URL). */
export function absoluteImageUrl(key?: string | null): string | null {
  if (!key) return null;
  if (key.startsWith("http://") || key.startsWith("https://")) return key;
  return IMG ? `${IMG}/${key}` : null;
}
