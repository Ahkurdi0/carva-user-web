import { z } from 'zod';
import * as Schema from '../../src/generated/zod/';
import {
  booleanPreprocessing,
  stringPreprocessing,
  uuid7Preporcess,
  uuidV7,
} from './common';

export const CreateCompanySchemas = Schema.CompanySchema.partial()
  .extend({
    id: uuidV7.nullable().optional(),
    userId: z.string().cuid2().nullable().optional(),
    name: z.string().min(3).max(100).nullable().optional(),
    activeDate: z.coerce.date().nullable().optional(),
    expiresAt: z.coerce.date().nullable().optional(),
    available: z.boolean().nullish().optional(),
    international: z.boolean().nullish().optional(),
    contact: stringPreprocessing({ max: 50 }).nullable().optional(),
    location: Schema.LocationSchema.pick({
      lat: true,
      long: true,
      townId: true,
      cityId: true,
    })
      .extend({
        id: uuidV7.nullable().optional(),
        townId: uuidV7.nullable().optional(),
        cityId: uuidV7.nullable().optional(),
        lat: z.number().nullable().optional(),
        long: z.number().nullable().optional(),
      })
      .nullable()
      .optional(),
  })
  .omit({
    rate: true,
    review: true,
    image: true,
  });

export type CreateCompanyPayload = z.infer<typeof CreateCompanySchemas>;

export const CompaniesSchema = z.object({
  cursor: uuidV7.nullable().optional(),
  expired: z.boolean().default(true).optional(),
});

export type CompaniesPayload = z.infer<typeof CompaniesSchema>;

export const AllBooksSchema = z.object({
  cursor: uuidV7.nullable().optional(),
  status: Schema.BookStausSchema.optional(),
  id: uuidV7.nullable().optional(),
  userId: z.string().cuid2().nullable().optional(),
});

export type AllBooksPayload = z.infer<typeof AllBooksSchema>;

export const CompanyStatusSchema = z.object({
  id: uuidV7.optional(),
  status: Schema.CompanyStatusesSchema,
  reason: z.string().optional(),
  companyId: uuidV7,
});

export type CompanyStatusPayload = z.infer<typeof CompanyStatusSchema>;

export const BanUserSchema = Schema.AccountStatusSchema.partial()
  .omit({
    bannedAt: true,
  })
  .extend({ bannedUntil: z.coerce.date() })
  .superRefine((val, ctx) => {
    if (!val.id) {
      const requiredFields = [
        'bannedUntil',
        'title',
        'description',
        'userId',
      ] as const;

      for (const field of requiredFields) {
        if (val[field] === undefined || val[field] === null) {
          ctx.addIssue({
            code: z.ZodIssueCode.custom,
            message: `${field} is required`,
            path: [field],
          });
        }
      }
    }
  });

export type BanUserPayload = z.infer<typeof BanUserSchema>;

export const AccountStatusSchema = z.object({
  id: uuidV7.optional(),
  cursor: uuidV7.optional(),
  userId: z.string().cuid2(),
});

export type AccountStatusPayload = z.infer<typeof AccountStatusSchema>;

export const AllReviewSchema = z.object({
  cursor: uuidV7.nullable().optional(),
  userId: z.string().cuid2().nullable().optional(),
  status: Schema.ReviewStatusSchema.nullable().optional(),
});

export type AllReviewPayload = z.infer<typeof AllReviewSchema>;

export const UpdateUserRoleSchema = z.object({
  userId: z.string().cuid2(),
  role: z.enum(['admin', 'user']),
  permissions: z.array(z.string().cuid2()).nullish(),
});

export type UpdateUserRolePayload = z.infer<typeof UpdateUserRoleSchema>;

export const UserCursor = z.object({
  cursor: uuidV7.nullable().optional(),
  roleName: z.enum(['admin', 'user']).nullable().optional(),
  search: z.string().trim().nullable().optional(),
});

export type UserCursorPayload = z.infer<typeof UserCursor>;

export const UpdatePasswordSchema = z.object({
  password: z.string().min(8).max(100),
  userId: z.string().cuid2(),
});

export type UpdatePasswordPayload = z.infer<typeof UpdatePasswordSchema>;

export const UpdateReviewSchema = z.object({
  id: uuidV7,
  status: z.enum(['accepted', 'deleted']),
});

export type UpdateReviewPayload = z.infer<typeof UpdateReviewSchema>;

export const newSupportSchema = z.object({
  id: uuid7Preporcess.nullable().optional(),
  en: stringPreprocessing({ max: 100 }).nullable().optional(),
  ku: stringPreprocessing({ max: 100 }).nullable().optional(),
  ar: stringPreprocessing({ max: 100 }).nullable().optional(),
  content: stringPreprocessing({ max: 500 }).nullable().optional(),
});

export type NewSupportPayload = z.infer<typeof newSupportSchema>;

export const newSliderSchema = Schema.SliderSchema.partial().extend({
  carId: uuid7Preporcess.nullable().optional(),
  companyId: uuid7Preporcess.nullable().optional(),
  available: booleanPreprocessing.nullable().optional(),
  url: stringPreprocessing({ max: 200 }).nullable().optional(),
});

export type NewSliderPayload = z.infer<typeof newSliderSchema>;

export const newNotificationSchema = Schema.NotificationSchema.omit({
  id: true,
  postedAt: true,
});

export type NewNotificationPayload = z.infer<typeof newNotificationSchema>;

export const NewCitySchema = Schema.CitySchema.partial()
  .extend({ id: uuidV7.nullable().optional() })
  .omit({ deletedAt: true });

export type NewCityPayload = z.infer<typeof NewCitySchema>;

export const NewCarTypeSchema = Schema.CarTypeSchema.partial()
  .extend({ id: uuidV7.nullable().optional() })
  .omit({ deletedAt: true, sort: true });

export type NewCarTypePayload = z.infer<typeof NewCarTypeSchema>;

export const NewBrandSchema = Schema.BrandSchema.partial()
  .extend({
    id: uuidV7.nullable().optional(),
    ku: stringPreprocessing({ min: 1, max: 200 }).nullable().optional(),
    en: stringPreprocessing({ min: 1, max: 200 }).nullable().optional(),
    ar: stringPreprocessing({ min: 1, max: 200 }).nullable().optional(),
    available: booleanPreprocessing.nullable().optional(),
  })
  .omit({
    deletedAt: true,
    image: true,
  });

export type NewBrandPayload = z.infer<typeof NewBrandSchema>;

export const FeaturedCarsScehma = Schema.FeaturedCarsSchema.partial()
  .extend({
    id: uuidV7.nullable().optional(),
    carId: uuidV7,
    companyId: uuidV7.nullable().optional(),
    startAt: z.coerce.date().nullable().optional(),
    until: z.coerce.date().nullable().optional(),
  })
  .pick({
    id: true,
    carId: true,
    companyId: true,
    startAt: true,
    until: true,
  });

export type FeaturedCarsPayload = z.infer<typeof FeaturedCarsScehma>;

export const NewTownSchema = Schema.TownSchema.partial()
  .extend({
    id: uuidV7.nullable().optional(),
    cityId: uuidV7.nullable().optional(),
    en: z.string().nullable().optional(),
  })
  .omit({
    deletedAt: true,
  });

export type NewTownPayload = z.infer<typeof NewTownSchema>;

export const SortSchema = z.array(
  z.object({
    id: uuidV7,
    sort: z.number(),
  }),
);
export type SortPayload = z.infer<typeof SortSchema>;
