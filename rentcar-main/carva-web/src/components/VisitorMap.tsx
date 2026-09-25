"use client";

import { useEffect, useRef } from "react";
import "leaflet/dist/leaflet.css";

export interface MapPoint {
  lat: number;
  lon: number;
  city?: string;
  count: number;
}

// Plots every visitor location as a circle sized/coloured by visit count, on an
// OpenStreetMap base. Client-only (Leaflet touches window). Auto-fits to the
// points so the admin sees the real spread of traffic.
export function VisitorMap({ points, height = 320 }: { points: MapPoint[]; height?: number }) {
  const ref = useRef<HTMLDivElement>(null);
  const mapRef = useRef<unknown>(null);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      const L = (await import("leaflet")).default;
      if (cancelled || !ref.current || mapRef.current) return;
      const map = L.map(ref.current, {
        center: [20, 0],
        zoom: 2,
        zoomControl: true,
        attributionControl: false,
        scrollWheelZoom: false,
      });
      mapRef.current = map;
      L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        maxZoom: 19,
      }).addTo(map);

      const max = Math.max(1, ...points.map((p) => p.count));
      const latlngs: [number, number][] = [];
      for (const p of points) {
        const r = 6 + (p.count / max) * 16;
        L.circleMarker([p.lat, p.lon], {
          radius: r,
          color: "#fff",
          weight: 1.5,
          fillColor: "#3957d7",
          fillOpacity: 0.6,
        })
          .addTo(map)
          .bindTooltip(`${p.city || "Unknown"} — ${p.count}`, { direction: "top" });
        latlngs.push([p.lat, p.lon]);
      }
      if (latlngs.length) {
        try {
          map.fitBounds(latlngs, { padding: [30, 30], maxZoom: 8 });
        } catch {
          /* single point / bad bounds */
        }
      }
    })();
    return () => {
      cancelled = true;
      const m = mapRef.current as { remove?: () => void } | null;
      m?.remove?.();
      mapRef.current = null;
    };
  }, [points]);

  return (
    <div
      ref={ref}
      style={{ height }}
      className="w-full overflow-hidden rounded-2xl border border-surface-low"
    />
  );
}
