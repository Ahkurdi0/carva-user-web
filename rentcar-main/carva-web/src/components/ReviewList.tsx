"use client";

import { useCallback, useEffect, useState } from "react";
import { Icon } from "./Icon";
import { Spinner } from "./ui";
import { imageUrl } from "@/lib/api";
import { userApi } from "@/lib/services";
import { useI18n } from "@/i18n";
import { formatDate } from "@/lib/format";
import type { Review } from "@/lib/types";

function Stars({ rate }: { rate: number }) {
  return (
    <span className="inline-flex gap-0.5">
      {Array.from({ length: 5 }).map((_, i) => (
        <Icon key={i} name="star_fill" size={13} color={i < rate ? "#f5b50a" : "#e2e2e2"} />
      ))}
    </span>
  );
}

export function ReviewList({ kind, id }: { kind: "car" | "company"; id: string }) {
  const { t } = useI18n();
  const [reviews, setReviews] = useState<Review[]>([]);
  const [cursor, setCursor] = useState<string | undefined>();
  const [loading, setLoading] = useState(true);
  const [done, setDone] = useState(false);

  const load = useCallback(
    async (cur?: string) => {
      setLoading(true);
      try {
        const fn = kind === "car" ? userApi.carReviews : userApi.companyReviews;
        const res = await fn(id, cur);
        setReviews((prev) => (cur ? [...prev, ...res] : res));
        if (res.length > 0) setCursor(res[res.length - 1].id);
        if (res.length < 5) setDone(true);
      } catch {
        setDone(true);
      } finally {
        setLoading(false);
      }
    },
    [kind, id],
  );

  useEffect(() => {
    load();
  }, [load]);

  if (loading && reviews.length === 0)
    return <div className="flex justify-center py-6"><Spinner /></div>;

  if (reviews.length === 0)
    return <p className="px-4 text-sm text-muted">{t("empty.noReviews")}</p>;

  return (
    <div className="space-y-3 px-4">
      {reviews.map((r) => (
        <div key={r.id} className="rounded-2xl border border-surface-low p-4">
          <div className="flex items-center gap-3">
            <span className="h-9 w-9 overflow-hidden rounded-full bg-primary-container">
              {r.profile?.image ? (
                // eslint-disable-next-line @next/next/no-img-element
                <img src={imageUrl(r.profile.image)} alt="" className="h-full w-full object-cover" />
              ) : (
                <span className="grid h-full w-full place-items-center"><Icon name="profile" size={16} color="#B51219" /></span>
              )}
            </span>
            <div className="flex-1">
              <p className="text-sm font-semibold text-on-surface">{r.profile?.name ?? "User"}</p>
              <p className="text-[11px] text-muted">{formatDate(r.reviewedAt)}</p>
            </div>
            <Stars rate={r.rate} />
          </div>
          {r.desc && <p className="mt-2 text-sm text-on-surface/80">{r.desc}</p>}
        </div>
      ))}
      {!done && (
        <button
          onClick={() => load(cursor)}
          disabled={loading}
          className="mx-auto block text-sm font-medium text-primary"
        >
          {loading ? <Spinner size={16} /> : t("buttons.showMoreReview")}
        </button>
      )}
    </div>
  );
}
