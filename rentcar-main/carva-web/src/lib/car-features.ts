/** Renter-facing equipment fields. Keep these stable because they are stored in car.feature.extras. */
export const CAR_AMENITIES = [
  "parking_sensors",
  "apple_carplay",
  "android_auto",
  "rear_camera",
  "cruise_control",
  "adaptive_cruise",
  "infotainment_screen",
  "smart_key",
  "blind_spot_monitor",
  "lane_assist",
  "automatic_emergency_braking",
  "bluetooth",
  "usb",
  "heated_seats",
  "climate_control",
  "sunroof",
  "all_wheel_drive",
] as const;

export type CarAmenity = (typeof CAR_AMENITIES)[number];

export const carAmenityLabel = (key: string) => `web.feature_${key}`;
