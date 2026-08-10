import { Brand, Car, FeaturedCars } from '../../src/generated/zod';
import { CarFilterPayload } from '../validation/user';

export const filters = (params: CarFilterPayload) => {
  const {
    brandId,
    feature,
    location,
    rentalPlan,
    companyId,
    typeId,
  }: CarFilterPayload = params;

  return {
    ...(companyId && { companyId }),
    ...(brandId && { brandId: brandId }),
    ...(typeId && { typeId: typeId }),
    ...(feature && {
      feature: {
        ...(feature.fuel && { fuel: feature.fuel }),
        ...(feature.transmission && { transmission: feature.transmission }),
        ...(feature.typeId && { carTypeId: feature.typeId }),
        ...(feature.year && {
          OR: [{ year: { gte: params.feature?.year, lte: params.maxYear } }],
        }),
      },
    }),
    ...(location && {
      location: {
        ...(location.cityid && { cityid: location.cityid }),
        ...(location.townId && { townId: location.townId }),
      },
    }),
    ...(rentalPlan && {
      rentalPlan: {
        some: {
          ...(rentalPlan?.planId !== undefined
            ? { planId: rentalPlan?.planId }
            : undefined),
          ...(rentalPlan.minPrice !== undefined &&
            rentalPlan.maxPrice !== undefined && {
              price: {
                gte: rentalPlan.minPrice,
                lte: rentalPlan.maxPrice,
              },
            }),
        },
      },
    }),
  };
};

type CarIncludeOptions = {
  userId?: string;
  withCompany?: boolean;
  withPromotion?: boolean;
  withLocation?: boolean;
  withBrand?: boolean;
  withFeatured?: boolean;
};

export const carInclude = ({
  userId,
  withCompany = true,
  withPromotion = true,
  withLocation = true,
  withBrand = true,
  withFeatured = true,
}: CarIncludeOptions = {}) => ({
  images: { where: { deletedAt: null } },
  location: withLocation && {
    select: {
      lat: true,
      long: true,
      radiusKm: true,
      city: { select: { en: true, ar: true, ku: true } },
      town: { select: { en: true, ar: true, ku: true } },
    },
  },
  rentalPlan: {
    where: { deletedAt: null },
    select: {
      price: true,
      currency: true,
      id: true,
      periodType: true,
      plan: { select: { en: true, ku: true, ar: true } },
    },
  },
  company: withCompany
    ? {
        omit: { contact: true, contacted: true },
        include: {
          contacts: { where: { deletedAt: null } },
          location: {
            select: {
              lat: true,
              long: true,
              radiusKm: true,
              city: { select: { en: true, ar: true, ku: true } },
              town: { select: { en: true, ar: true, ku: true } },
            },
          },
        },
      }
    : undefined,
  brand: withBrand,
  feature: {
    select: {
      fuel: true,
      transmission: true,
      seat: true,
      hp: true,
      speed: true,
      year: true,
      odometer: true,
      cylinders: true,
      engCC: true,
      type: { select: { id: true, en: true, ar: true, ku: true } },
    },
  },
  favorite: userId ? { where: { userId }, take: 1 } : undefined,
  featuredCars: withFeatured
    ? {
        where: {
          deletedAt: null,
          OR: [
            { until: { gte: new Date() } },
            { until: null },
            { startAt: { gte: new Date() } },
          ],
        },
      }
    : undefined,
});

export const nestedCarInclude = (userId?: string) => ({
  car: {
    include: carInclude(),
  },
});

type CarKeys = keyof Car;

function pickCarKeys<K extends CarKeys>(...keys: K[]) {
  return keys;
}
export const expiredCompanies = {
  company: { expiresAt: { gte: new Date() }, available: true },
};

// Usage:
const keys = pickCarKeys(
  'id',
  'title',
  'brandId',
  'companyId',
  'rate',
  'available',
  'listedAt',
  'rate',
  'title',
  'trips',
); //

type CarSelectedFields = Pick<Car, (typeof keys)[number]>;
type PromotionType = {
  startDate: Date;
  endDate: Date;
};
interface CarWithExtraFields extends CarSelectedFields {
  promotion?: PromotionType[] | null | undefined;
  favorite?: any;
  recentlyViewed?: any;
  isViewed?: boolean | null;
  isFavorite?: boolean | null;
  brand?: Brand | null;
  featuredCars?: FeaturedCars | null | undefined;
}

export function enrichCarsWithFlags(cars: CarWithExtraFields[]) {
  return cars.map(({ favorite, brand, featuredCars, ...car }) => ({
    ...car,
    isFavorite: favorite === undefined ? null : !!favorite.length,
    featuredCars: featuredCars ?? null,
    brand,
  }));
}
