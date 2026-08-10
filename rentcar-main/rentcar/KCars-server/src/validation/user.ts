import { z } from 'zod';
import { CursorSchema, uuidShcemaNullable, uuidV7 } from './common';
import {
  FuelSchema,
  RentalPlanSchema,
  TransmissionSchema,
} from '../../src/generated/zod';

import * as Schema from '../../src/generated/zod';

export const CarFilterSchema = z.object({
  brandId: uuidV7.optional(),
  companyId: uuidV7.optional(),
  minPrice: z.number().optional(),
  maxPrice: z.number().optional(),
  minYear: z.number().optional(),
  maxYear: z.number().optional(),
  typeId: uuidV7.nullable().optional(),
  cursor: uuidV7.nullable().optional(),
  rentalPlan: RentalPlanSchema.extend({
    maxPrice: z.number().optional(),
    minPrice: z.number().optional(),
    planId: uuidV7.optional(),
  })
    .pick({
      minPrice: true,
      maxPrice: true,
      planId: true,
    })
    .optional(),
  location: z
    .object({
      cityid: uuidV7.optional().optional(),
      townId: uuidV7.optional().optional(),
      city: uuidV7.optional().optional(),
      town: uuidV7.optional().optional(),
    })
    .optional(),
  feature: z
    .object({
      fuel: FuelSchema.optional(),
      type: uuidV7.optional(),
      typeId: uuidV7.optional(),
      year: z.number().optional(),
      maxYear: z.number().optional(),
      transmission: TransmissionSchema.optional(),
    })
    .optional(),
});

export type CarFilterPayload = z.infer<typeof CarFilterSchema>;

export const ApplyPromoCodeSchema = z.object({
  code: z.string().min(8).max(15),
  carId: uuidV7,
  companyId: uuidV7,
  rentalPlanId: uuidV7,
  planId: uuidV7,
  startDate: z.coerce.date(),
  endDate: z.coerce.date(),
  contact: z.string().min(10).max(20),
});

export type ApplyPromoCodePayload = z.infer<typeof ApplyPromoCodeSchema>;

export const BookCarSchema = z.object({
  code: z.string().min(8).max(15).nullable().optional(),
  carId: uuidV7,
  companyId: uuidV7,
  rentalPlanId: uuidV7,
  planId: uuidV7,
  startDate: z.coerce.date(),
  endDate: z.coerce.date(),
  contact: z.string().min(10).max(20),
});

export type BookCarPayload = z.infer<typeof BookCarSchema>;

export const CarReviewSchema = Schema.CarReviewSchema.pick({
  carId: true,
  rate: true,
  desc: true,
}).extend({
  carId: uuidV7,
  desc: z.string().trim().min(3).max(1000),
  rate: z.number().min(1).max(5),
});

export type CarReviewPayload = z.infer<typeof CarReviewSchema>;

export const CompanyReviewSchema = Schema.CompanyReviewSchema.pick({
  desc: true,
  rate: true,
  companyId: true,
}).extend({
  companyId: uuidV7,
  desc: z.string().min(3).max(1000),
});

export type CompanyReviewPayload = z.infer<typeof CompanyReviewSchema>;

export const ReviewCurosrSchema = CursorSchema.extend({
  id: uuidV7,
});

export type ReviewCurosrPayload = z.infer<typeof ReviewCurosrSchema>;

export const CarCompanySchema = z.object({
  cursor: uuidV7.nullable(),
  companyId: uuidV7,
  type: uuidV7.nullable(),
  brand: uuidV7.nullable(),
});

export type CarCompanyPayload = z.infer<typeof CarCompanySchema>;

export const LocationSchema = z.object({
  lat: z.number().min(-90).max(90),
  long: z.number().min(-180).max(180),
});

export type LocationPayload = z.infer<typeof LocationSchema>;

export const ExplorerMapSchema = z.object({
  north: z.number(),
  south: z.number(),
  west: z.number(),
  east: z.number(),
});

export type ExplorerMapPayload = z.infer<typeof ExplorerMapSchema>;

export const contactCompanySchema =
  Schema.ContactStatisticSchema.partial().extend({
    companyId: uuidV7,
    contactId: uuidShcemaNullable.optional(),
    carId: uuidShcemaNullable.optional(),
    value: z.string().min(10).max(20).nullable().optional(),
    type: z.enum(['whatsapp', 'phone']),
  });

export type ContactCompanyPayload = z.infer<typeof contactCompanySchema>;
