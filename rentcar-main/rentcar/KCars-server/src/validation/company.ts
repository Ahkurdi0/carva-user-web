import * as Schema from '../../src/generated/zod/';
import { z } from 'zod';
import {
  booleanPreprocessing,
  stringPreprocessing,
  uuid7Preporcess,
  uuidV7,
} from './common';

const parseJson = <T extends z.ZodTypeAny>(schema: T) =>
  z.preprocess((val) => {
    if (typeof val === 'string') {
      try {
        return JSON.parse(val);
      } catch (e) {
        return val;
      }
    }
    return val;
  }, schema);

export const updateCarSchema = Schema.CarSchema.partial()
  .extend({
    id: uuid7Preporcess,
    title: stringPreprocessing({ min: 3, max: 100 }).optional(),
    desc: stringPreprocessing({ max: 1000 }).optional(),
    deletedImages: parseJson(
      z
        .array(
          Schema.ImageSchema.extend({ id: uuidV7 }).pick({
            id: true,
            image: true,
          }),
        )
        .optional(),
    ),
    deletedRentalPlans: parseJson(
      z
        .array(
          Schema.RentalPlanSchema.extend({ id: uuidV7 }).pick({ id: true }),
        )
        .optional(),
    ),
    brandId: uuid7Preporcess.optional(),
    typeId: uuid7Preporcess.optional(),
    available: booleanPreprocessing.optional(),
    displayPlan: parseJson(Schema.RentalPeriodTypeSchema).nullable().optional(),
    rentalPlan: parseJson(
      z
        .array(
          Schema.RentalPlanSchema.extend({
            price: z.number(),
            planId: uuidV7,
          }).omit({
            companyId: true,
            deletedAt: true,
            id: true,
          }),
        )
        .max(3),
    ).optional(),

    location: parseJson(
      Schema.LocationSchema.extend({
        id: uuid7Preporcess.optional(),
        cityId: uuid7Preporcess.optional(),
        lat: z.number().optional(),
        long: z.number().optional(),
        townId: uuid7Preporcess.nullable().optional(),
      })
        .omit({ createdAt: true, companyId: true })
        .optional(),
    ),

    feature: parseJson(
      Schema.FeatureSchema.partial()
        .omit({
          id: true,
          deletedAt: true,
          carId: true,
        })
        .nullish()
        .optional(),
    ),
  })
  .strict();

export type updateCarPayload = z.infer<typeof updateCarSchema>;

export const ListCarSchema = Schema.CarSchema.extend({
  title: z.string().min(3).max(100),
  companyId: uuid7Preporcess.nullable().optional(),
  brandId: uuid7Preporcess,
  typeId: uuid7Preporcess.nullable().optional(),
  location: parseJson(
    Schema.CarLocationSchema.extend({
      cityId: uuidV7,
      townId: uuidV7.optional(),
      lat: z.number(),
      long: z.number(),
    })
      .pick({ lat: true, long: true, cityId: true, townId: true })
      .optional(),
  ),
  available: booleanPreprocessing,
  rentalPlan: parseJson(
    z
      .array(
        Schema.RentalPlanSchema.omit({
          carId: true,
          id: true,
          available: true,
        }).extend({ planId: uuidV7, price: z.number() }),
      )
      .max(3),
  ),
  feature: parseJson(
    Schema.FeatureSchema.omit({
      id: true,
      carId: true,
      deletedAt: true,
    }),
  ),
})
  .omit({
    id: true,
    rate: true,
    review: true,
    trips: true,
    deletedAt: true,
    listedAt: true,
    serial: true,
    carId: true,
    viewed: true,
    pinned: true,
    pinnedSort: true,
  })
  .strict();

export type ListCarPayload = z.infer<typeof ListCarSchema>;

export const SortCarImagesSchema = z.array(
  Schema.ImageSchema.extend({
    companyId: uuidV7.optional(),
    sort: z.number(),
    carId: uuidV7,
    id: uuidV7,
  })
    .omit({
      deletedAt: true,
    })
    .strict(),
);

export type SortCarImagesPayload = z.infer<typeof SortCarImagesSchema>;

export const PromotionSchema = Schema.PromotionSchema.extend({
  id: uuidV7.optional(),
  companyId: uuidV7.nullable().optional(),
  code: z.string().min(8).max(15),
  startDate: z.coerce.date(),
  endDate: z.coerce.date(),
  maxUses: z.number(),
  maxAmount: z.number().nullable().optional(),
  maxDiscountAmount: z.number().nullable().optional(),
  minOrderValue: z.number().nullable().optional(),
  type: z.enum(['car', 'company']).default('car'),
  value: z.coerce.number(),
  maxUsePerUser: z.number(),
  priceType: z.enum(['percentage', 'fixed']),
  available: z.boolean().default(true),
}).omit({
  deletedAt: true,
  usesCount: true,
  promotedAt: true,
});

export type PromotionPayload = z.infer<typeof PromotionSchema>;

export const PromotionUpdateSchema = Schema.PromotionSchema.pick({
  id: true,
  carId: true,
  available: true,
  companyId: true,
}).extend({
  id: uuidV7,
  companyId: uuidV7.nullable().optional(),
  carId: uuidV7,
});

export type PromotionUpdatePayload = z.infer<typeof PromotionUpdateSchema>;

export const CompanySchema = Schema.CompanySchema.extend({
  name: z.string().min(3).max(100).optional(),
  desc: z.string().max(1000).optional(),
  companyId: uuidV7.optional(),
  newContacts: z
    .array(
      Schema.ContactSchema.omit({
        deletedAt: true,
        companyId: true,
      }),
    )
    .optional()
    .nullable()
    .default([]),
  deletedContacts: z
    .array(
      Schema.ContactSchema.pick({
        id: true,
      }).extend({ id: uuidV7 }),
    )
    .optional()
    .nullable()
    .default([]),

  location: Schema.LocationSchema.pick({
    id: true,
    lat: true,
    long: true,
    townId: true,
    cityId: true,
  })
    .extend({ id: uuidV7.optional() })
    .optional(),
}).strict();

export type CompanyPayload = z.infer<typeof CompanySchema>;

export const UpdateCompanySchema = Schema.CompanySchema.extend({
  name: stringPreprocessing({ max: 200 }).optional(),
  desc: stringPreprocessing({ max: 600 }).optional(),
  contact: stringPreprocessing({ max: 50 }).nullable().optional(),
  companyId: uuid7Preporcess.optional(),
  newContacts: parseJson(
    z
      .array(
        Schema.ContactSchema.pick({
          value: true,
        }),
      )
      .max(5)
      .nullable()
      .optional(),
  )
    .nullable()
    .optional(),
  deletedContacts: parseJson(
    z
      .array(
        Schema.ContactSchema.pick({
          id: true,
        }).extend({ id: uuidV7 }),
      )
      .nullable()
      .optional(),
  ),
  location: parseJson(
    Schema.LocationSchema.partial()
      .extend({
        lat: z.number().nullable().optional(),
        long: z.number().nullable().optional(),
      })
      .pick({
        lat: true,
        long: true,
        townId: true,
        cityId: true,
      })
      .nullable()
      .optional(),
  ),
}).partial();

export type UpdateCompanyPayload = z.infer<typeof UpdateCompanySchema>;

export const SortContactsSchema = z.array(
  Schema.ContactSchema.extend({
    id: uuidV7,
    companyId: uuidV7.optional(),
  }).pick({
    id: true,
    sort: true,
    companyId: true,
  }),
);

export type SortContactsPayload = z.infer<typeof SortContactsSchema>;

export const CarCompanySchema = z.object({
  cursor: uuidV7.nullable().optional(),
  companyId: uuidV7.nullable().optional(),
  type: uuidV7.nullable().optional(),
  brand: uuidV7.nullable().optional(),
  status: Schema.BookStausSchema.optional(),
});

export type CarCompanyPayload = z.infer<typeof CarCompanySchema>;

export const CompanyBookedSchema = z.object({
  cursor: uuidV7.nullable().optional(),
  status: Schema.BookStausSchema.optional(),
  companyId: uuidV7.optional(),
  search: z.string().trim().min(2).nullable().optional(),
});

export type CompanyBookedPayload = z.infer<typeof CompanyBookedSchema>;

export const updateBook = z.object({
  bookId: uuidV7,
  status: Schema.BookStausSchema,
  cancelReason: z.string().optional(),
});

export type updateBookPayload = z.infer<typeof updateBook>;

export const PromotionsSchema = z.object({
  cursor: uuidV7.nullable().optional(),
  carId: uuidV7.nullable().optional(),
  companyId: uuidV7.nullable().optional(),
});

export type PromotionsPayload = z.infer<typeof PromotionsSchema>;

export const FlagReviewScham = z.object({
  reviewId: uuidV7,
  carId: uuidV7.nullable().optional(),
  companyId: uuidV7.nullable().optional(),
});

export type FlagReviewPayload = z.infer<typeof FlagReviewScham>;
