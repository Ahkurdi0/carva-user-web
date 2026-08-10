"use client";

import { useRouter } from "next/navigation";
import { useAsync } from "@/lib/useAsync";
import { userApi } from "@/lib/services";
import { imageUrl } from "@/lib/api";
import type { Slider } from "@/lib/types";

/** The slim sponsor banner shown on car detail pages — same content the
 * app renders from the admin's "Detail car sponsor" section. */
export function DetailSponsorStrip() {
  const router = useRouter();
  const { data } = useAsync<Slider[]>(() => userApi.detailSponsors(), []);
  const sponsor = (data ?? []).find((s) => s.image);
  if (!sponsor) return null;

  function open() {
    if (!sponsor) return;
    userApi.slider(sponsor.id).catch(() => {});
    if (sponsor.type === "car" && sponsor.carId)
      router.push(`/car/${sponsor.car?.id ?? sponsor.carId}`);
    else if (sponsor.type === "company" && sponsor.companyId)
      router.push(`/company/${sponsor.companyId}`);
    else if (sponsor.url) window.open(sponsor.url, "_blank");
  }

  return (
    <button onClick={open} className="mt-8 block w-full">
      <span className="block h-16 w-full overflow-hidden rounded-xl bg-surface-low sm:h-20">
        {/* eslint-disable-next-line @next/next/no-img-element */}
        <img
          src={imageUrl(sponsor.image)}
          alt=""
          className="h-full w-full object-cover"
        />
      </span>
    </button>
  );
}
