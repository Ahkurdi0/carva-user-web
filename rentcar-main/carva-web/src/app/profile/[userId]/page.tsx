"use client";

import Link from "next/link";
import { useParams } from "next/navigation";
import { AppShell } from "@/components/AppShell";
import { ChatButton } from "@/components/ChatButton";
import { KycBadge } from "@/components/KycBadge";
import { EmptyState, PageLoading } from "@/components/ui";
import { Icon } from "@/components/Icon";
import { useAsync } from "@/lib/useAsync";
import { chatApi } from "@/lib/services";
import { imageUrl } from "@/lib/api";
import { useI18n } from "@/i18n";
import type { ChatProfile } from "@/lib/types";

export default function ProfilePage() {
  const { userId } = useParams<{ userId: string }>();
  const { t } = useI18n();
  const { data, loading, error } = useAsync<ChatProfile>(() => chatApi.profile(userId), [userId]);
  if (loading) return <AppShell><PageLoading /></AppShell>;
  if (error || !data) return <AppShell><EmptyState icon="profile" title={t("alertMessages.someThingWentWrong")} /></AppShell>;
  return <AppShell><div className="px-4 py-6"><Link href="/chat" className="mb-5 inline-flex items-center gap-1 text-sm text-muted"><Icon name="arrow" size={16} /> {t("web.chat")}</Link>
    <div className="overflow-hidden rounded-3xl border border-surface-low bg-white shadow-sm"><div className="h-28 bg-gradient-to-br from-primary/15 via-primary-container to-surface-lowest" />
      <div className="px-5 pb-6"><div className="-mt-12 flex items-end justify-between gap-4"><span className="grid h-24 w-24 place-items-center overflow-hidden rounded-3xl border-4 border-white bg-primary-container shadow-md">{data.image ? <img src={imageUrl(data.image)} alt="" className="h-full w-full object-cover" /> : <Icon name="profile" size={34} color="#B51219" />}</span><ChatButton recipientUserId={data.userId} /></div>
        <div className="mt-4 flex items-center gap-2"><h1 className="text-2xl font-extrabold">{data.name}</h1><KycBadge status={data.kycStatus} /></div><p className="mt-1 text-sm text-muted">{t("web.memberSince")} {new Date(data.joinedAt || Date.now()).toLocaleDateString()}</p>
        {data.company && <Link href={`/company/${data.company.id}`} className="mt-6 flex items-center gap-3 rounded-2xl border border-surface-low p-3 hover:bg-surface-lowest"><span className="grid h-11 w-11 place-items-center overflow-hidden rounded-xl bg-primary-container">{data.company.image ? <img src={imageUrl(data.company.image)} alt="" className="h-full w-full object-cover" /> : <Icon name="company" size={20} color="#B51219" />}</span><span className="min-w-0 flex-1"><span className="block text-xs text-muted">{t("web.ownerProfile")}</span><span className="block truncate font-semibold">{data.company.name}</span></span><Icon name="arrow_tail" size={18} color="#9e9e9e" /></Link>}
      </div></div>
  </div></AppShell>;
}
