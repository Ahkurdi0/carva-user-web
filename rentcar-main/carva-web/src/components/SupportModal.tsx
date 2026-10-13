"use client";

import { Icon } from "@/components/Icon";
import { Modal } from "@/components/Modal";
import { useI18n } from "@/i18n";
import { userApi } from "@/lib/services";
import { useAsync } from "@/lib/useAsync";
import type { Support } from "@/lib/types";

/** CARVA support contacts (Settings, and the deleted-account login message). */
export function SupportModal({ open, onClose }: { open: boolean; onClose: () => void }) {
  const { t, tr } = useI18n();
  const { data } = useAsync<Support[]>(() => userApi.supports(), [], open);
  return (
    <Modal open={open} onClose={onClose} title={t("buttons.supprt")}>
      <div className="space-y-2">
        {(data ?? []).map((s) => (
          <a
            key={s.id}
            href={s.content}
            target="_blank"
            rel="noopener noreferrer"
            className="flex items-center justify-between gap-3 rounded-xl border border-surface-low p-3 transition hover:border-primary hover:bg-surface-lowest"
          >
            <div className="min-w-0">
              <p className="font-semibold">{tr(s)}</p>
              <p className="mt-1 truncate text-sm text-muted">{s.content}</p>
            </div>
            <Icon name="arrow" size={18} color="#9e9e9e" />
          </a>
        ))}
        {data && data.length === 0 && <p className="text-sm text-muted">{t("empty.noData")}</p>}
      </div>
    </Modal>
  );
}
