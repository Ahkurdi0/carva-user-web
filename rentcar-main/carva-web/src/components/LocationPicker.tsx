"use client";

import { useEffect, useRef } from "react";
import "leaflet/dist/leaflet.css";

// Interactive Leaflet picker: click (or drag the marker) to set a point.
// Mirrors MiniMap's client-only loading, but reports the chosen lat/long back.
// A fresh instance is created each time it mounts (the modal unmounts it when
// closed), so the `lat`/`long` props are only read for the initial center.
export function LocationPicker({
  lat,
  long,
  onPick,
  height = 220,
}: {
  lat: number | null;
  long: number | null;
  onPick: (lat: number, long: number) => void;
  height?: number;
}) {
  const ref = useRef<HTMLDivElement>(null);
  const mapRef = useRef<unknown>(null);
  // Keep the latest callback without re-running the init effect.
  const onPickRef = useRef(onPick);
  onPickRef.current = onPick;

  useEffect(() => {
    let cancelled = false;
    (async () => {
      const L = (await import("leaflet")).default;
      if (cancelled || !ref.current || mapRef.current) return;

      const hasPoint = lat != null && long != null && lat !== -1 && long !== -1;
      // Default to Erbil when there's no existing point yet.
      const center: [number, number] = hasPoint ? [lat!, long!] : [36.19, 44.01];

      const map = L.map(ref.current, {
        center,
        zoom: hasPoint ? 14 : 11,
        attributionControl: false,
      });
      mapRef.current = map;
      L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        maxZoom: 19,
      }).addTo(map);

      const icon = L.divIcon({
        className: "",
        html: `<div style="width:18px;height:18px;border-radius:50%;background:#3957d7;border:3px solid #fff;box-shadow:0 1px 4px rgba(0,0,0,.4)"></div>`,
        iconSize: [18, 18],
        iconAnchor: [9, 9],
      });

      let marker = hasPoint
        ? L.marker([lat!, long!], { icon, draggable: true }).addTo(map)
        : null;

      const place = (la: number, lo: number) => {
        if (marker) marker.setLatLng([la, lo]);
        else {
          marker = L.marker([la, lo], { icon, draggable: true }).addTo(map);
          marker.on("dragend", () => {
            const p = marker!.getLatLng();
            onPickRef.current(p.lat, p.lng);
          });
        }
        onPickRef.current(la, lo);
      };

      if (marker) {
        marker.on("dragend", () => {
          const p = marker!.getLatLng();
          onPickRef.current(p.lat, p.lng);
        });
      }

      map.on("click", (e: { latlng: { lat: number; lng: number } }) =>
        place(e.latlng.lat, e.latlng.lng),
      );

      // The map is created while the modal is still animating in; recompute the
      // size once it has settled so tiles fill the container.
      setTimeout(() => map.invalidateSize(), 200);
    })();

    return () => {
      cancelled = true;
      const m = mapRef.current as { remove?: () => void } | null;
      m?.remove?.();
      mapRef.current = null;
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <div
      ref={ref}
      style={{ height }}
      className="w-full overflow-hidden rounded-2xl border border-surface-low"
    />
  );
}
