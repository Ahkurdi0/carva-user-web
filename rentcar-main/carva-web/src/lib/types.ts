// Types mirroring the KCars / Carva backend (Prisma) responses.

export type Lang = "en" | "ar" | "ku";

export type Currency = "usd" | "iqd";
export type RentalPeriodType = "hourly" | "daily" | "weekly" | "monthly";
export type Fuel = "diesel" | "gasoline" | "electric" | "hybird" | "lpg" | "cng";
export type Transmission = "manual" | "automatic" | "amt" | "cvt" | "dct" | "sp";
export type BookStatus =
  | "pending"
  | "ongoing"
  | "canceled"
  | "refunded"
  | "rejected"
  | "completed";
export type ReviewStatus =
  | "pending"
  | "accepted"
  | "canceled"
  | "flagged"
  | "deleted";
export type ContactType = "phone" | "email" | "whatsapp" | "viber";
export type CompanyStatuses = "suspended" | "loacked" | "live";
export type PromotionPriceType = "percentage" | "fixed";
export type PromotionType = "car" | "company" | "plan" | "rentalPlan";
export type SlideType = "car" | "company" | "url";

/** Multi-language label used across brands, types, cities, towns, plans */
export interface Localized {
  en: string;
  ar?: string | null;
  ku?: string | null;
}

export interface Permission {
  permissionId: string;
  permissionName: string;
  description?: string | null;
}

export interface Role {
  roleId?: string;
  roleName: string;
}

export interface CarImage {
  id?: string;
  image: string;
  sort?: number;
}

// The backend may return numeric feature fields either as plain numbers or as
// localized objects ({ id?, en, ar, ku }) so it can show Arabic/Kurdish digits.
export type LocalizedNum = number | string | (Localized & { id?: string }) | null;

export interface Feature {
  fuel?: Fuel;
  transmission?: Transmission;
  seat?: LocalizedNum;
  hp?: LocalizedNum;
  speed?: LocalizedNum;
  year?: LocalizedNum;
  odometer?: LocalizedNum;
  cylinders?: LocalizedNum;
  engCC?: LocalizedNum;
  type?: (Localized & { id?: string }) | null;
}

export interface Brand extends Localized {
  id: string;
  image?: string | null;
  sort?: number;
}

export interface CarType extends Localized {
  id: string;
  sort?: number;
}

export interface Plan extends Localized {
  id: string;
  periodType?: RentalPeriodType;
}

export interface RentalPlan {
  id: string;
  price: number | string;
  currency?: Currency;
  periodType: RentalPeriodType;
  max?: number | null;
  min?: number | null;
  plan?: Plan | Localized;
  available?: boolean;
}

export interface Contact {
  id: string;
  countrCode?: string | null;
  value: string;
  type: ContactType;
  available?: boolean;
  sort?: number | null;
}

export interface GeoCity extends Localized {
  id?: string;
}

export interface CarLocation {
  lat: number;
  long: number;
  radiusKm?: number | null;
  city?: GeoCity | null;
  town?: GeoCity | null;
  cityId?: string | null;
  townId?: string | null;
}

export interface Company {
  id: string;
  companyId?: string;
  userId?: string;
  name: string;
  desc?: string | null;
  image?: string | null;
  coverImage?: string | null;
  rate: number;
  review: number;
  available?: boolean;
  international?: boolean;
  delivery?: boolean;
  joinedAt?: string;
  activeDate?: string | null;
  expiresAt?: string | null;
  contact?: string | null;
  contacts?: Contact[];
  location?: CarLocation | null;
  facebookLink?: string | null;
  instagramLink?: string | null;
  tiktokLink?: string | null;
  // The admin endpoints attach the owning profile so the panel can edit on
  // their behalf (the owner id is needed when (re)creating a company plan).
  profile?: { userId?: string; name?: string | null; email?: string | null } | null;
  cars?: number;
}

export interface Car {
  id: string;
  carId: string;
  title: string;
  rate: number;
  review: number;
  trips: number;
  viewed?: number;
  available?: boolean;
  displayPlan: RentalPeriodType;
  pinned?: boolean;
  listedAt?: string;
  companyId: string;
  brandId?: string | null;
  typeId?: string | null;
  contact?: string | null;
  images?: CarImage[];
  feature?: Feature | null;
  brand?: Brand | null;
  rentalPlan?: RentalPlan[];
  location?: CarLocation | null;
  company?: Company | null;
  isFavorite?: boolean | null;
  featuredCars?: { id: string } | null;
  promotion?: { startDate: string; endDate: string }[] | null;
}

export interface Slider {
  id: string;
  carId?: string | null;
  companyId?: string | null;
  url?: string | null;
  image?: string | null;
  type: SlideType;
  car?: { id: string; title: string } | null;
}

export interface Support {
  id: string;
  en: string;
  ku: string;
  ar: string;
  content: string;
  image?: string | null;
  available?: boolean;
}

export interface BrandWithCars extends Brand {
  cars: Car[];
}

export interface FiltersData {
  brands: Brand[];
  types: CarType[];
  cities: (GeoCity & { id: string; towns: (Localized & { id: string })[] })[];
  plans: Plan[];
}

export interface Profile {
  userId: string;
  email: string;
  phoneNumber?: string | null;
  countryCode?: string;
  name: string;
  userName?: string | null;
  image?: string | null;
  emailVerifiedAt?: string | null;
  phoneVerifiedAt?: string | null;
  tourist?: boolean | null;
  iraqi?: boolean | null;
  company?: Company | null;
  role?: Role | null;
  permissions?: { permission: Permission }[];
}

export interface AuthResult extends Profile {
  accessToken: string;
  refreshToken: string;
}

export interface Review {
  id: string;
  reviewId?: string | null;
  desc: string;
  rate: number;
  status?: ReviewStatus;
  reviewedAt?: string;
  carId?: string | null;
  companyId?: string | null;
  profile?: Profile | null;
}

export interface Book {
  id: string;
  bookId?: string;
  status: BookStatus;
  startDate: string;
  endDate: string;
  basePrice: number | string;
  totalPrice: number | string;
  finalPrice: number | string;
  discountAmount?: number | string;
  duration?: number | null;
  contact?: string | null;
  bookedAt?: string;
  cancelReason?: string | null;
  car?: Car | null;
  company?: Company | null;
  rentalPlan?: RentalPlan | null;
  promotion?: unknown;
}

export interface Paginated<T> {
  cursor?: string | null;
  cars?: T[];
  hasMore?: boolean;
}

export interface PromotionResult {
  carId?: string | null;
  companyId?: string | null;
  planId?: string | null;
  rentalPlanId?: string | null;
  totalPrice: number;
  finalPrice: number;
  discount: number;
  periods?: number;
}
