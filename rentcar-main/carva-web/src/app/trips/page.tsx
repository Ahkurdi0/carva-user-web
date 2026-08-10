"use client";

import { useState } from "react";
import Link from "next/link";
import { AppShell } from "@/components/AppShell";
import { AuthPrompt } from "@/components/AuthPrompt";
import { ImageHolder } from "@/components/ImageHolder";
import { Button, EmptyState, PageLoading, useEnumLabel } from "@/components/ui";
import { useAsync } from "@/lib/useAsync";
import { userApi } from "@/lib/services";
import { useAuth } from "@/lib/auth-store";
import { useI18n } from "@/i18n";
import { formatDate, formatNumber } from "@/lib/format";
import { toast } from "@/components/toast";
import type { Book, BookStatus } from "@/lib/types";

const STATUS_STYLE: Record<BookStatus, string> = {
  pending: "bg-amber-100 text-amber-700",
  ongoing: "bg-blue-100 text-blue-700",
  completed: "bg-green-100 text-green-700",
  canceled: "bg-gray-100 text-gray-600",
  rejected: "bg-red-100 text-red-700",
  refunded: "bg-purple-100 text-purple-700",
};

function BookCard({ book, onCancel }: { book: Book; onCancel: (id: string) => void }) {
  const { t } = useI18n();
  const e = useEnumLabel();
  const [busy, setBusy] = useState(false);
  const car = book.car;

  async function cancel() {
    setBusy(true);
    try {
      await userApi.cancelBook(book.id);
      onCancel(book.id);
      toast(t("alertMessages.success"), "success");
    } catch (err) {
      toast(err instanceof Error ? err.message : t("alertMessages.someThingWentWrong"), "error");
    } finally {
      setBusy(false);
    }
  }

  return (
    <div className="rounded-2xl border border-surface-low p-3">
      <div className="flex gap-3">
        {car && (
          <Link href={`/car/${car.carId}`}>
            <ImageHolder src={car.images?.[0]?.image} className="h-20 w-28" rounded="rounded-xl" />
          </Link>
        )}
        <div className="min-w-0 flex-1">
          <div className="flex items-start justify-between gap-2">
            <p className="truncate font-semibold">{car?.title ?? "Car"}</p>
            <span className={`shrink-0 rounded-full px-2.5 py-0.5 text-[11px] font-semibold ${STATUS_STYLE[book.status]}`}>
              {e.bookStatus(book.status)}
            </span>
          </div>
          <p className="mt-1 text-xs text-muted">
            {formatDate(book.startDate)} → {formatDate(book.endDate)}
          </p>
          <p className="mt-1 text-sm font-bold text-primary">{formatNumber(book.finalPrice)}</p>
        </div>
      </div>
      {book.status === "pending" && (
        <div className="mt-3 flex justify-end">
          <Button variant="outline" onClick={cancel} loading={busy} className="h-9 px-4 text-xs">
            {t("buttons.cancel")}
          </Button>
        </div>
      )}
    </div>
  );
}

export default function TripsPage() {
  const { t } = useI18n();
  const user = useAuth((s) => s.user);
  const { data, loading, setData } = useAsync<Book[]>(() => userApi.booked(), [!!user], !!user);

  if (!user)
    return <AppShell><AuthPrompt message={t("alertMessages.notLoggedInTripScreen")} /></AppShell>;

  return (
    <AppShell>
      <div className="px-4 py-5">
        <h1 className="mb-4 text-xl font-extrabold">{t("web.myTrips")}</h1>
        {loading ? (
          <PageLoading />
        ) : data && data.length > 0 ? (
          <div className="grid gap-3 sm:grid-cols-2">
            {data.map((b) => (
              <BookCard
                key={b.id}
                book={b}
                onCancel={(id) =>
                  setData((data ?? []).map((x) => (x.id === id ? { ...x, status: "canceled" } : x)))
                }
              />
            ))}
          </div>
        ) : (
          <EmptyState icon="receipt" title={t("empty.noBookings")} />
        )}
      </div>
    </AppShell>
  );
}
