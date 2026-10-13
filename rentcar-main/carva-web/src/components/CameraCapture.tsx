"use client";

import { useEffect, useRef, useState } from "react";
import { Modal } from "./Modal";
import { Button } from "./ui";
import { useI18n } from "@/i18n";

/** Phones open their own camera from the file input; laptops/desktops use this. */
export function wantsWebcam() {
  if (typeof window === "undefined") return false;
  const coarse = window.matchMedia?.("(pointer: coarse)").matches;
  return !coarse && !!navigator.mediaDevices?.getUserMedia;
}

/**
 * Live webcam for the identity check on a computer: take the photo here, or
 * choose a file instead. The selfie preview is mirrored (feels natural); the
 * saved photo is not.
 */
export function CameraCapture({
  open,
  selfie,
  title,
  onShot,
  onPickFile,
  onClose,
}: {
  open: boolean;
  selfie?: boolean;
  title: string;
  onShot: (file: File) => void;
  onPickFile: () => void;
  onClose: () => void;
}) {
  const { t } = useI18n();
  const video = useRef<HTMLVideoElement>(null);
  const [state, setState] = useState<"starting" | "live" | "denied">("starting");

  useEffect(() => {
    if (!open) return;
    let stream: MediaStream | null = null;
    let stopped = false;
    setState("starting");
    navigator.mediaDevices
      .getUserMedia({ video: { facingMode: selfie ? "user" : "environment", width: { ideal: 1920 }, height: { ideal: 1080 } }, audio: false })
      .then((s) => {
        if (stopped) return s.getTracks().forEach((tr) => tr.stop());
        stream = s;
        if (video.current) {
          video.current.srcObject = s;
          void video.current.play();
        }
        setState("live");
      })
      .catch(() => !stopped && setState("denied"));
    return () => {
      stopped = true;
      stream?.getTracks().forEach((tr) => tr.stop());
    };
  }, [open, selfie]);

  function take() {
    const v = video.current;
    if (!v || !v.videoWidth) return;
    const c = document.createElement("canvas");
    c.width = v.videoWidth;
    c.height = v.videoHeight;
    c.getContext("2d")!.drawImage(v, 0, 0);
    c.toBlob((b) => b && onShot(new File([b], "camera.jpg", { type: "image/jpeg" })), "image/jpeg", 0.92);
  }

  return (
    <Modal open={open} onClose={onClose} title={title}>
      <div className="relative aspect-[4/3] overflow-hidden rounded-2xl bg-ink">
        <video
          ref={video}
          playsInline
          muted
          className={`h-full w-full object-cover ${selfie ? "-scale-x-100" : ""} ${state === "live" ? "" : "opacity-0"}`}
        />
        {state === "live" && (
          <div
            aria-hidden
            className={`pointer-events-none absolute border-2 border-white/80 shadow-[0_0_0_9999px_rgba(0,0,0,0.35)] ${
              selfie ? "inset-x-[25%] inset-y-[10%] rounded-[50%]" : "inset-x-[8%] inset-y-[18%] rounded-2xl"
            }`}
          />
        )}
        {state !== "live" && (
          <p className="absolute inset-0 grid place-items-center px-6 text-center text-sm text-white/80">
            {state === "denied" ? t("v2.cameraDenied") : "…"}
          </p>
        )}
      </div>
      <p className="mt-3 text-center text-xs text-muted">{t(selfie ? "v2.cameraHintSelfie" : "v2.cameraHintDoc")}</p>
      <div className="mt-4 grid grid-cols-2 gap-2.5">
        <Button variant="outline" full onClick={onPickFile}>{t("v2.chooseFile")}</Button>
        <Button full disabled={state !== "live"} onClick={take}>{t("v2.takePhoto")}</Button>
      </div>
    </Modal>
  );
}
