"use client";

import { useEffect, useRef } from "react";
import "leaflet/dist/leaflet.css";

// Lightweight Leaflet map (OpenStreetMap tiles, like the app's flutter_map).
// Loaded only on the client to avoid SSR window access.
export function MiniMap({
  lat,
  long,
  height = 180,
  zoom = 13,
}: {
  lat: number;
  long: number;
  height?: number;
  zoom?: number;
}) {
  const ref = useRef<HTMLDivElement>(null);
  const mapRef = useRef<unknown>(null);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      const L = (await import("leaflet")).default;
      if (cancelled || !ref.current || mapRef.current) return;
      const map = L.map(ref.current, {
        center: [lat, long],
        zoom,
        zoomControl: false,
        attributionControl: false,
        scrollWheelZoom: false,
      });
      mapRef.current = map;
      L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        maxZoom: 19,
      }).addTo(map);
      const icon = L.divIcon({
        className: "",
        html: `<div style="width:18px;height:18px;border-radius:50%;background:#B51219;border:3px solid #fff;box-shadow:0 1px 4px rgba(0,0,0,.4)"></div>`,
        iconSize: [18, 18],
        iconAnchor: [9, 9],
      });
      L.marker([lat, long], { icon }).addTo(map);
    })();
    return () => {
      cancelled = true;
      const m = mapRef.current as { remove?: () => void } | null;
      m?.remove?.();
      mapRef.current = null;
    };
  }, [lat, long, zoom]);

  return (
    <div
      ref={ref}
      style={{ height }}
      className="w-full overflow-hidden rounded-2xl border border-surface-low"
    />
  );
}
