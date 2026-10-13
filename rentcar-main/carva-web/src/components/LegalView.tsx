"use client";

import { AppShell } from "@/components/AppShell";
import { Button, PageLoading } from "@/components/ui";
import { useI18n } from "@/i18n";
import { legalApi } from "@/lib/services";
import { useAsync } from "@/lib/useAsync";
import type { LegalPage } from "@/lib/types";

/**
 * Terms & conditions / Privacy policy, written in the dashboard (like the
 * app): blank lines split paragraphs, lines starting with "# " are headings.
 */
export function LegalView({ page }: { page: LegalPage["page"] }) {
  const { t, lang } = useI18n();
  const { data, loading, error, refetch } = useAsync<LegalPage>(() => legalApi.page(page), [page]);
  const body = data ? data.body[lang]?.trim() || data.body.ku?.trim() || data.body.en?.trim() || data.body.ar?.trim() || "" : "";
  const blocks = body.split(/\n\s*\n/).map((b) => b.trim()).filter(Boolean);

  return (
    <AppShell>
      <article className="mx-auto max-w-3xl px-4 py-6">
        <h1 className="text-2xl font-bold text-on-surface">{t(page === "terms" ? "v2.terms" : "v2.privacy")}</h1>
        {data?.updatedAt && (
          <p className="mt-1 text-sm text-muted">
            {t("v2.updatedOn", { date: new Date(data.updatedAt).toLocaleDateString(lang === "en" ? "en-GB" : "ar-IQ", { day: "numeric", month: "long", year: "numeric" }) })}
          </p>
        )}

        {loading ? (
          <PageLoading />
        ) : error ? (
          <div className="mt-8 text-center">
            <p className="text-sm text-muted">{t("v2.legalError")}</p>
            <Button variant="outline" className="mt-3" onClick={refetch}>{t("v2.retry")}</Button>
          </div>
        ) : blocks.length === 0 ? (
          <p className="mt-8 text-center text-muted">{t("v2.legalSoon")}</p>
        ) : (
          <div className="mt-6 space-y-4 text-[15px] leading-loose text-on-surface/90">
            {blocks.map((b, i) => {
              if (!b.startsWith("# ")) return <p key={i} className="whitespace-pre-line">{b}</p>;
              const [head, ...rest] = b.split("\n");
              return (
                <div key={i}>
                  <h2 className="pt-2 text-lg font-bold text-on-surface">{head.slice(2).trim()}</h2>
                  {rest.length > 0 && <p className="mt-2 whitespace-pre-line">{rest.join("\n")}</p>}
                </div>
              );
            })}
          </div>
        )}
      </article>
    </AppShell>
  );
}
