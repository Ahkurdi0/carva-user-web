"use client";

import { AppShell } from "@/components/AppShell";
import { AuthPrompt } from "@/components/AuthPrompt";
import { CarCard, CarCardSkeleton } from "@/components/CarCard";
import { EmptyState } from "@/components/ui";
import { useAsync } from "@/lib/useAsync";
import { userApi } from "@/lib/services";
import { useAuth } from "@/lib/auth-store";
import { useI18n } from "@/i18n";

export default function FavoritesPage() {
  const { t } = useI18n();
  const user = useAuth((s) => s.user);
  const { data, loading } = useAsync(() => userApi.favoriteCars(), [!!user], !!user);

  if (!user)
    return (
      <AppShell>
        <AuthPrompt message={t("alertMessages.notLoggedInFavScreen")} />
      </AppShell>
    );

  return (
    <AppShell>
      <div className="px-4 py-5">
        <h1 className="mb-4 text-xl font-extrabold">{t("bottomNavigation.Favorites")}</h1>
        {loading ? (
          <div className="grid grid-cols-2 gap-x-3 gap-y-5 sm:grid-cols-3 lg:grid-cols-4">
            {Array.from({ length: 6 }).map((_, i) => <CarCardSkeleton key={i} />)}
          </div>
        ) : data && data.length > 0 ? (
          <div className="grid grid-cols-2 gap-x-3 gap-y-5 sm:grid-cols-3 lg:grid-cols-4">
            {data.map((car) => <CarCard key={car.id} car={car} />)}
          </div>
        ) : (
          <EmptyState icon="heart" title={t("empty.emptyFavorite")} />
        )}
      </div>
    </AppShell>
  );
}
