import { Decimal } from '@prisma/client/runtime/library';
import { Promotion, RentalPeriodType } from 'prisma/prisma-client';
import { Exception } from './exception';
import { ApplyPromoCodePayload } from '../validation/user';
import { prisma } from '../config/prisma';

type BookingDetails = {
  code: string;
  carId: string;
  companyId: string;
  rentalPlanId: string;
  planId: string;
  startDate: Date;
  endDate: Date;
};

export type PromotionResult = {
  promotion: Promotion | null;
  finalPrice: Decimal;
  discount: Decimal;
  totalPrice: Decimal;
  basePrice: Decimal;
  periods: number;
  carId?: string | null;
  companyId?: string | null;
  planId?: string | null;
  rentalPlanId?: string | null;
};

export async function validateAndCalculatePromotion(
  booking: BookingDetails,
  userId: string,
): Promise<PromotionResult> {
  const promotion = await prisma.promotion.findUnique({
    where: { code: booking.code.toLowerCase(), deletedAt: null },
    include: {
      car: true,
      company: true,
      plan: true,
      rentalPlan: { include: { plan: true } },
    },
  });

  if (!promotion) throw new Exception(400, 'promotion_not_found');

  const now = new Date();

  if (
    !promotion.available ||
    now < promotion.startDate ||
    now > promotion.endDate
  ) {
    throw new Exception(400, 'promotion_unvailable');
  }

  if (!matchesPromotion(booking, promotion)) {
    throw new Exception(400, 'invalid_promotion');
  }

  // Check usage limits
  const userUsage = await prisma.usedPromotion.findUnique({
    where: {
      userId_promotionId: {
        userId,
        promotionId: promotion.id,
      },
    },
  });

  const maxPerUser = promotion.maxUsePerUser ?? 1;
  if (userUsage && userUsage.used >= maxPerUser) {
    throw new Exception(400, 'maximum_usage_promotion');
  }

  const globalMax = promotion.maxUses;
  if (globalMax !== null && promotion.usesCount >= globalMax) {
    throw new Exception(400, 'expired_promotion');
  }

  if (booking.endDate <= booking.startDate) {
    throw new Exception(400, 'Invalid rental duration', true);
  }

  const rentalPlan =
    promotion.rentalPlan ??
    (await prisma.rentalPlan.findUnique({
      where: { id: booking.rentalPlanId },
      include: { plan: true },
    }));

  if (!rentalPlan) {
    throw new Exception(400, 'Rental plan not found', true);
  }

  // Calculate number of periods based on rentalPlan.periodType
  let periods = calculatePeriods(
    rentalPlan.plan.periodType,
    booking.startDate,
    booking.endDate,
  );

  periods = Math.ceil(periods); // Round up partial periods

  const min = rentalPlan.min ?? 1;
  const max = rentalPlan.max ?? Infinity;

  if (periods < min || periods > max) {
    throw new Exception(
      400,
      `Rental duration must be between ${min} and ${isFinite(max) ? max : 'unlimited'} ${rentalPlan.periodType}`,
      true,
    );
  }

  // Calculate total price = price per period * number of periods
  const totalPrice = rentalPlan.price.mul(periods);

  // Calculate discount
  let discount = new Decimal(0);
  if (promotion.priceType === 'fixed') {
    discount = promotion.value;
  } else if (promotion.priceType === 'percentage') {
    discount = totalPrice.mul(promotion.value).div(100);
  }

  const zero = new Decimal(0);
  const difference = totalPrice.minus(discount);
  const finalPrice = difference.lt(zero) ? zero : difference;
  if (
    promotion.maxDiscountAmount !== null &&
    finalPrice.gt(promotion.maxDiscountAmount)
  ) {
    throw new Exception(400, 'min_maximum_discount_amount');
  }
  if (
    promotion.minOrderValue !== null &&
    finalPrice.lt(promotion.minOrderValue)
  ) {
    throw new Exception(400, 'min_maximum_discount_amount');
  }

  return {
    promotion,
    finalPrice,
    discount,
    totalPrice,
    periods,
    companyId: rentalPlan.companyId,
    carId: rentalPlan.carId,
    planId: rentalPlan.planId,
    rentalPlanId: rentalPlan.id,
    basePrice: rentalPlan.price,
  };
}

// Calculates rental duration in periods (hours, days, etc.)
export function calculatePeriods(
  rentalPlanType: RentalPeriodType,
  startDate: Date,
  endDate: Date,
): number {
  const durationMs = endDate.getTime() - startDate.getTime();
  if (durationMs <= 0) throw new Error('Invalid rental duration.');

  switch (rentalPlanType) {
    case 'hourly':
      return durationMs / (1000 * 60 * 60);
    case 'daily':
      return durationMs / (1000 * 60 * 60 * 24);

    default:
      throw new Exception(400, 'Unsupported rental plan type', true);
  }
}

// Calculates price info without promotion
export function calculatePriceWithoutPromotion(
  rentalPlanPrice: Decimal,
  periods: number,
) {
  const basePrice = rentalPlanPrice;
  const totalPrice = basePrice.mul(periods);
  const finalPrice = totalPrice;

  return {
    basePrice,
    totalPrice,
    finalPrice,
    periods,
    discount: new Decimal(0),
  };
}

export function getPromotionWhereCondition(
  promotion: any,
  data: ApplyPromoCodePayload,
  userId: string,
) {
  switch (promotion?.type) {
    case 'company':
      return {
        userId_promotionId_companyId: {
          userId,
          promotionId: promotion.id,
          companyId: data.companyId,
        },
      };
    case 'plan':
      return {
        userId_promotionId_planId: {
          userId,
          promotionId: promotion.id,
          planId: data.planId,
        },
      };
    case 'car':
      return {
        userId_promotionId_carId: {
          userId,
          promotionId: promotion.id,
          carId: data.carId,
        },
      };
    case 'rentalPlan':
      return {
        userId_promotionId_rentalPlanId: {
          userId,
          promotionId: promotion.id,
          rentalPlanId: data.rentalPlanId,
        },
      };
    default:
      return {
        userId_promotionId: {
          userId,
          promotionId: promotion.id,
        },
      };
  }
}

function matchesPromotion(
  booking: BookingDetails,
  promotion: Promotion,
): boolean {
  // Always check company if set
  if (promotion.companyId && promotion.companyId !== booking.companyId)
    return false;

  switch (promotion.type) {
    case 'company':
      if (booking.companyId !== promotion.companyId) return false;
      if (
        promotion.rentalPlanId &&
        booking.rentalPlanId !== promotion.rentalPlanId
      )
        return false;
      if (promotion.planId && booking.planId !== promotion.planId) return false;
      if (promotion.carId && booking.carId !== promotion.carId) return false;
      return true;

    case 'plan':
      if (booking.planId !== promotion.planId) return false;
      if (
        promotion.rentalPlanId &&
        booking.rentalPlanId !== promotion.rentalPlanId
      )
        return false;
      if (promotion.carId && booking.carId !== promotion.carId) return false;
      return true;

    case 'rentalPlan':
      if (booking.rentalPlanId !== promotion.rentalPlanId) return false;
      if (promotion.carId && booking.carId !== promotion.carId) return false;
      return true;

    case 'car':
      if (booking.carId !== promotion.carId) return false;
      if (
        promotion.rentalPlanId &&
        booking.rentalPlanId !== promotion.rentalPlanId
      )
        return false;
      if (promotion.planId && booking.planId !== promotion.planId) return false;
      return true;

    default:
      return false;
  }
}
