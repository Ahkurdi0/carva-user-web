// Typed wrappers around the backend endpoints, grouped by area.
import { api, ApiError, tokens } from "./api";
import type { AnalyticsSummary } from "./analytics-store";
import type {
  AuthResult,
  Book,
  BookStatus,
  Brand,
  BrandWithCars,
  Car,
  CarType,
  Company,
  FiltersData,
  GeoCity,
  Paginated,
  Plan,
  Profile,
  PromotionResult,
  Review,
  Slider,
  Support,
} from "./types";

/* ----------------------------- Auth ----------------------------- */
export const authApi = {
  login: (email: string, password: string) =>
    api.json<AuthResult>("/auth/login", { email, password, session: {} }),
  signup: (data: {
    name: string;
    email: string;
    password: string;
    phoneNumber?: string;
    countryCode?: string;
    userName?: string;
  }) => api.json<AuthResult>("/auth/signup", { ...data, session: {} }),
  updateName: (name: string) => api.json("/auth/updateName", { name }),
  updatePhoneNumber: (countryCode: string, phoneNumber: string) =>
    api.json("/auth/updatePhoneNumber", { countryCode, phoneNumber }),
  updatePassword: (oldPassword: string, newPassword: string) =>
    api.json("/auth/updatePassword", { oldPassword, newPassword }),
  updateProfilePicture: (file: File) => {
    const fd = new FormData();
    fd.append("image", file);
    return api.form<{ imageUrl: string }>("/auth/updateProfilePicture", fd);
  },
  updatePrefLang: (prefLang: string) =>
    api.json("/auth/updatePrefLang", { prefLang }),
  deleteAccount: () => api.json("/auth/deleteAccount"),
};

/* -------- Password reset / email verification (OTP) -------- */
export const otpApi = {
  resetSend: (email: string) => api.json("/auth/email/r/send", { email }),
  resetVerify: (email: string, code: string) =>
    api.json("/auth/email/r/verify", { email, code }),
  resetPassword: (email: string, code: string, password: string) =>
    api.json("/auth/email/r/resetPassword", { email, code, password }),
  verifyEmailSend: () => api.json("/auth/email/v/send"),
  verifyEmail: (code: string) => api.json("/auth/email/v/verify", { code }),
  updateEmailSend: (email: string) => api.json("/auth/email/u/send", { email }),
  updateEmailVerify: (email: string, code: string) =>
    api.json("/auth/email/u/verify", { email, code }),
};

/* ----------------------------- Customer ----------------------------- */
export const userApi = {
  suggestedCars: () => api.json<Car[]>("/user/suggestedCars"),
  brands: () => api.json<BrandWithCars[]>("/user/brands"),
  sliders: () => api.json<Slider[]>("/user/sliders"),
  slider: (id: string) => api.json("/user/slider", { id }),
  recentlyViewed: () => api.json<Car[]>("/user/recentlyViewed"),
  nearByCars: (lat: number, long: number) =>
    api.json<Car[]>("/user/nearBayCars", { lat, long }),
  allCars: (cursor?: string) =>
    api.json<Paginated<Car>>("/user/cars", { cursor }),
  filterCars: (params: Record<string, unknown>) =>
    api.json<Car[]>("/user/filterCars", params),
  filters: () => api.json<FiltersData>("/user/filters"),
  carDetails: (id: string) => api.json<Car>("/user/carDetails", { id }),
  getCars: (companyId: string, cursor?: string, type?: string, brand?: string) =>
    // The backend's schema requires these keys to be present (explicit null),
    // not omitted — otherwise it rejects with "Incorrect info".
    api.json<Car[]>("/user/getCars", {
      companyId,
      cursor: cursor ?? null,
      type: type ?? null,
      brand: brand ?? null,
    }),
  company: (id: string) => api.json<Company>("/user/company", { id }),
  companies: (cursor?: string, inl?: boolean, delivery?: boolean) =>
    api.json<Company[]>("/user/companies", { cursor, inl, delivery }),
  supports: () => api.json<Support[]>("/user/supports"),
  carReviews: (id: string, cursor?: string) =>
    api.json<Review[]>("/user/carReviews", { id, cursor }),
  companyReviews: (id: string, cursor?: string) =>
    api.json<Review[]>("/user/companyReviews", { id, cursor }),

  favoriteCars: (cursor?: string) =>
    api.json<Car[]>("/user/favoriteCars", { cursor }),
  toggleFavorite: (id: string) => api.json<string>("/user/favoriteCar", { id }),

  booked: (cursor?: string, status?: BookStatus) =>
    api.json<Book[]>("/user/booked", { cursor, status }),
  bookCar: (data: {
    carId: string;
    rentalPlanId: string;
    planId?: string;
    startDate: string;
    endDate: string;
    contact?: string;
    code?: string;
  }) => api.json<string>("/user/bookCar", data),
  cancelBook: (id: string) => api.json("/user/cancelBook", { id }),
  applyPromo: (data: {
    code: string;
    carId: string;
    rentalPlanId: string;
    planId?: string;
    startDate: string;
    endDate: string;
  }) => api.json<PromotionResult>("/user/applyPromoCode", data),

  reviewCar: (carId: string, rate: number, desc: string) =>
    api.json<string>("/user/reviewCar", { carId, rate, desc }),
  deleteCarReview: (id: string) => api.json("/user/deleteCarReview", { id }),
  reviewCompany: (companyId: string, rate: number, desc: string) =>
    api.json<string>("/user/reviewCompany", { companyId, rate, desc }),
  deleteCompanyReview: (id: string) =>
    api.json("/user/deleteCompanyReview", { id }),

  contact: (data: {
    type: string;
    companyId: string;
    contactId?: string;
    carId?: string;
    value?: string;
  }) => api.json<string>("/user/contact", data),

  explorerMap: (b: { west: number; east: number; north: number; south: number }) =>
    api.json<Car[]>("/user/explorerMap", b),
};

/* ----------------------------- Company dashboard ----------------------------- */
export const companyApi = {
  company: () => api.json<Company>("/company/company", {}),
  getCars: (cursor?: string, type?: string, brand?: string) =>
    api.json<Car[]>("/company/getCars", {
      cursor: cursor ?? null,
      type: type ?? null,
      brand: brand ?? null,
    }),
  booked: (cursor?: string, status?: string, search?: string) =>
    api.json<Book[]>("/company/booked", { cursor, status, search }),
  updateBook: (bookId: string, status: string, cancelReason?: string) =>
    api.json("/company/updateBook", { bookId, status, cancelReason }),
  promotions: (cursor?: string) =>
    api.json<Record<string, unknown>[]>("/company/promotions/", { cursor }),
  newPromotion: (data: Record<string, unknown>) =>
    api.json("/company/promotion/new", data),
  deletePromotion: (id: string) => api.json("/company/promotion/delete", { id }),
  carReviews: (cursor?: string) =>
    api.json<Review[]>("/company/companyCarsReviews", { cursor }),
  companyReviews: () => api.json<Review[]>("/company/companiesReviews", {}),
  brands: () => api.json<Brand[]>("/company/brands", {}),
  carTypes: () => api.json<CarType[]>("/company/carTypes", {}),
  plans: () => api.json<Plan[]>("/company/plans", {}),
  cities: () => api.json<(GeoCity & { towns: GeoCity[] })[]>("/company/cities", {}),
  deleteCar: (id: string) => api.json("/company/car/delete", { id }),
  newCar: (form: FormData) => api.form("/company/car/new", form),
  updateCar: (form: FormData) => api.form("/company/car/update", form),
  updateCompany: (form: FormData) => api.form("/company/updateCompany", form),
};

/* ----------------------------- Admin panel ----------------------------- */
export const adminApi = {
  statistics: (date?: string) =>
    api.json<Record<string, unknown>>("/admin/statistics", { date }),
  users: (cursor?: string, roleName?: "admin" | "user", search?: string) =>
    api.json<Profile[]>("/admin/users", { cursor, roleName, search }),
  permissions: () => api.json<{ permissionId: string; permissionName: string }[]>("/admin/permissions", {}),
  updateRole: (userId: string, role: "admin" | "user", permissions?: string[]) =>
    api.json("/admin/updateRole", { userId, role, permissions }),
  companies: (cursor?: string, expired?: boolean) =>
    api.json<Company[]>("/admin/companies", { cursor, expired }),
  allBooks: (cursor?: string, status?: string) =>
    api.json<Book[]>("/admin/allBooks", { cursor, status }),
  allCars: (cursor?: string, id?: string) =>
    api.json<Car[]>("/admin/allCars", { cursor, id }),
  allCarReviews: (cursor?: string, status?: string) =>
    api.json<Review[]>("/admin/allCarReviews", { cursor, status }),
  allCompanyReviews: (cursor?: string, status?: string) =>
    api.json<Review[]>("/admin/allCompanyReviews", { cursor, status }),
  carReviewFlags: (cursor?: string) =>
    api.json<Record<string, unknown>[]>("/admin/carReviewFlags", { cursor }),
  companyReviewFlags: (cursor?: string) =>
    api.json<Record<string, unknown>[]>("/admin/companyReviewFlags", { cursor }),
  updateCarReview: (id: string, status: "accepted" | "deleted") =>
    api.json("/admin/updateCarReview", { id, status }),
  updateCompanyReview: (id: string, status: "accepted" | "deleted") =>
    api.json("/admin/updateCompanyReview", { id, status }),
  banUser: (userId: string, title: string, description: string, bannedUntil: string) =>
    api.json("/admin/updateAccountStatus", { userId, title, description, bannedUntil }),
  bannedUsers: (cursor?: string) => api.json<Profile[]>("/admin/bannedUsers", { cursor }),
  recoverAccount: (userId: string) => api.json("/admin/recoverAccount", { userId }),
  updateUserPassword: (userId: string, password: string) =>
    api.json("/admin/updateUserPassword", { userId, password }),
  // content
  brands: () => api.json<Brand[]>("/admin/brands", {}).catch(() => userApi.filters().then((f) => f.brands)),
  newBrand: (form: FormData) => api.form<{ id: string; image: string }>("/admin/newBrand", form),
  deleteBrand: (id: string) => api.json("/admin/deleteBrand", { id }),
  carTypes: () => api.json<CarType[]>("/admin/carTypes", {}),
  newCarType: (data: { id?: string; en?: string; ar?: string; ku?: string }) =>
    api.json("/admin/newCarType", data),
  deleteCarType: (id: string) => api.json("/admin/deleteCarType", { id }),
  cities: () => api.json<(GeoCity & { towns?: GeoCity[] })[]>("/admin/cities", {}),
  newCity: (data: Record<string, unknown>) => api.json("/admin/newCity", data),
  deleteCity: (id: string) => api.json("/admin/deleteCity", { id }),
  newTown: (data: Record<string, unknown>) => api.json("/admin/newTown", data),
  deleteTown: (id: string) => api.json("/admin/deleteTown", { id }),
  supports: () => api.json<Support[]>("/admin/supports", {}).catch(() => userApi.supports()),
  newSupport: (form: FormData) => api.form("/admin/newSupport", form),
  deleteSupport: (id: string) => api.json("/admin/deleteSupport", { id }),
  sliders: () => api.json<Slider[]>("/admin/sliders", {}).catch(() => userApi.sliders()),
  newSlider: (form: FormData) => api.form("/admin/newSlider", form),
  deleteSlider: (id: string) => api.json("/admin/deleteSlider", { id }),
  // The backend's schema requires every key to be present — the app sends a
  // placeholder `id` and an explicit `postedAt: null` via Notifications.toMap(),
  // so omitting them here makes the request fail with "Incorrect info".
  newNotification: (data: Record<string, unknown>) =>
    api.json("/admin/newNotification", { id: "id", postedAt: null, ...data }),
  // Admin creates/edits a company on behalf of a user (mirrors the app's
  // NewEditCompanyScreen). `id` is null for a new company, otherwise the
  // existing company id; `userId` is the owner the company is attached to.
  newCompany: (data: {
    id?: string | null;
    userId: string;
    name: string;
    desc?: string | null;
    international: boolean;
    delivery?: boolean;
    contact?: string | null;
    activeDate: string;
    expiresAt: string;
    location: { lat: number; long: number; townId?: string | null; cityId?: string | null } | null;
    available: boolean;
  }) => api.json<string>("/admin/newCompany", { id: null, ...data }),
  featuredCars: () => api.json<Record<string, unknown>[]>("/admin/featuredCars", {}),
  newFeaturedCar: (carId: string) => api.json("/admin/newFeaturedCar", { carId }),
  deleteFeaturedCar: (id: string) => api.json("/admin/deleteFeaturedCar", { id }),
};

/* ----------------------------- Visitor analytics ----------------------------- */
// These live on the local Next.js server (not the remote backend). The read is
// admin-gated server-side, so we just forward the access token.
export const analyticsApi = {
  summary: async (): Promise<AnalyticsSummary> => {
    const res = await fetch("/api/analytics", {
      headers: tokens.access ? { Authorization: `Bearer ${tokens.access}` } : {},
      cache: "no-store",
    });
    if (!res.ok) throw new ApiError(res.status, `Failed to load analytics (${res.status})`);
    return (await res.json()) as AnalyticsSummary;
  },
};
