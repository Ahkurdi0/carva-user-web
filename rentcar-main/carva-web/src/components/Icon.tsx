import type { CSSProperties } from "react";

// The app ships monochrome SVGs that it tints at runtime. On the web we render
// them through a CSS mask so any `color` recolors them, matching that behaviour.

export type IconName =
  | "arrow"
  | "arrow_tail"
  | "calender"
  | "call"
  | "cancel"
  | "cancel2"
  | "car"
  | "car_active"
  | "car_fill"
  | "check"
  | "checked"
  | "clock"
  | "clock_active"
  | "clock_fill"
  | "company"
  | "company_fill"
  | "cylinder"
  | "daily"
  | "edit"
  | "engine"
  | "favorite"
  | "favorited"
  | "filter"
  | "fuel"
  | "fuel_active"
  | "fuel_fill"
  | "heart"
  | "heart_active"
  | "heart_fill"
  | "hourly"
  | "image"
  | "language"
  | "location_p"
  | "location_s"
  | "logout"
  | "mail"
  | "map_loaction"
  | "map_loaction_active"
  | "maping"
  | "maping_active"
  | "monthly"
  | "no_cars"
  | "no_location"
  | "not_loggedin"
  | "notification"
  | "odometer"
  | "phone"
  | "profile"
  | "profile_fill"
  | "receipt"
  | "search"
  | "search_active"
  | "search_fill"
  | "settings"
  | "settings_active"
  | "settings_fill"
  | "speed"
  | "speed_active"
  | "speed_fill"
  | "star"
  | "star_active"
  | "star_fill"
  | "status"
  | "support"
  | "transmission"
  | "trash"
  | "trip"
  | "trip_active"
  | "trip_fill"
  | "whatsapp"
  | "wifi_off";

export function Icon({
  name,
  size = 20,
  className = "",
  color,
  style,
}: {
  name: IconName;
  size?: number;
  className?: string;
  color?: string;
  style?: CSSProperties;
}) {
  const url = `/assets/icons/${name}.svg`;
  return (
    <span
      role="img"
      aria-hidden
      className={className}
      style={{
        display: "inline-block",
        width: size,
        height: size,
        backgroundColor: color ?? "currentColor",
        WebkitMaskImage: `url(${url})`,
        maskImage: `url(${url})`,
        WebkitMaskRepeat: "no-repeat",
        maskRepeat: "no-repeat",
        WebkitMaskPosition: "center",
        maskPosition: "center",
        WebkitMaskSize: "contain",
        maskSize: "contain",
        flexShrink: 0,
        ...style,
      }}
    />
  );
}
