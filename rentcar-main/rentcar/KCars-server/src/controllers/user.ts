import { Request, Response } from 'express';
import { prisma } from '../config/prisma';
import {
  CarFilterPayload,
  CarReviewPayload,
  CompanyReviewPayload,
  ContactCompanyPayload,
  ExplorerMapPayload,
  LocationPayload,
} from '../validation/user';
import { Exception } from '../utils/exception';

import {
  calculatePeriods,
  calculatePriceWithoutPromotion,
  getPromotionWhereCondition,
  PromotionResult,
  validateAndCalculatePromotion,
} from '../utils/promotion_calculation';
import { ApplyPromoCodePayload } from '../validation/user';
import {
  carInclude,
  enrichCarsWithFlags,
  expiredCompanies,
  filters,
} from '../utils/extracted_types';
import { CarCompanyPayload } from '../validation/company';
import {
  getNotificationMessage,
  PrefLangs,
} from '../utils/notifications_messages';
import { asyncWrap } from '../utils/async_wrap';
import { sendNotificationToUsers } from '../utils/notification';
import { openChat } from '../utils/whats_app';
import { getData, setData } from '../config/redis';
import 'dotenv/config';

export const suggestedCars = async (req: Request, res: Response) => {
  const userId = req.userId;
  const cars = await prisma.car.findMany({
    take: 10,
    where: {
      ...expiredCompanies,
      deletedAt: null,
      available: true,
    },
    orderBy: [{ pinned: 'desc' }, { pinnedSort: 'asc' }, { id: 'desc' }],
    include: carInclude({ userId }),
  });

  const data = enrichCarsWithFlags(cars);

  res.status(200).json(data);
};
export const nearBayCars = async (req: Request, res: Response) => {
  const { lat, long }: LocationPayload = req.body;
  const userId = req.userId;
  const radiusInMeters = 5000;

  if (!lat && !long) {
    return res.status(400).json('Latitude and longitude must be provided');
  }
  const nearbyCarIdsResult = await prisma.$queryRaw<
    { id: string; location: any }[]
  >`
    SELECT c.id,cl.location
    FROM "car"."car" c
    JOIN "location"."carLocation" cl ON c.id = cl."carId"
    WHERE ST_DWithin(
      cl.location,
      ST_SetSRID(ST_MakePoint(${long}, ${lat}), 4326)::geography,
      ${radiusInMeters}
    )
    LIMIT 50;
  `;

  const nearbyCarIds = nearbyCarIdsResult.map((c) => c.id);

  const cars = await prisma.car.findMany({
    where: {
      id: { in: nearbyCarIds },
      deletedAt: null,
      available: true,
      ...expiredCompanies,
    },
    orderBy: [{ pinned: 'desc' }, { pinnedSort: 'asc' }, { id: 'desc' }],
    include: carInclude({ userId }),
  });

  const data = enrichCarsWithFlags(cars);

  res.status(200).json(data);
};

export const explorerMap = async (req: Request, res: Response) => {
  const { west, east, north, south }: ExplorerMapPayload = req.body;
  const userId = req.userId;

  const nearbyCarIdsResult = await prisma.$queryRaw<
    { id: string; location: any }[]
  >`
    SELECT c.id, cl.location
    FROM "car"."car" c
    JOIN "location"."carLocation" cl ON c.id = cl."carId"
    WHERE cl.location && ST_MakeEnvelope(${west}, ${south}, ${east}, ${north}, 4326)
    LIMIT 100;
  `;

  const nearbyCarIds = nearbyCarIdsResult.map((c) => c.id);

  if (nearbyCarIds.length === 0) {
    return res.status(200).json([]);
  }

  const cars = await prisma.car.findMany({
    where: {
      id: { in: nearbyCarIds },
      deletedAt: null,
      available: true,
      ...expiredCompanies,
    },
    orderBy: [{ pinned: 'desc' }, { pinnedSort: 'asc' }, { id: 'desc' }],
    include: carInclude({ userId }),
  });

  const data = enrichCarsWithFlags(cars);

  res.status(200).json(data);
};

export const brandCars = async (req: Request, res: Response) => {
  const userId = req.userId;
  const cars = await prisma.brand.findMany({
    where: { deletedAt: null },
    orderBy: { sort: 'asc' },
    include: {
      cars: {
        where: {
          deletedAt: null,
          available: true,
          company: { available: true, expiresAt: { gte: new Date() } },
        },
        take: 10,
        orderBy: [{ pinned: 'desc' }, { pinnedSort: 'asc' }, { id: 'desc' }],
        include: carInclude({ userId }),
      },
    },
  });

  const dataWithFavoriteFlag = cars.map((brand) => ({
    ...brand,
    cars: brand.cars.map(({ favorite, ...car }) => ({
      ...car,
      isFavorite: userId === undefined ? null : !!favorite?.length,
      featuredCars: car.featuredCars ?? null,
    })),
  }));

  res.status(200).json(dataWithFavoriteFlag);
};

export const filteredCars = async (req: Request, res: Response) => {
  const params: CarFilterPayload = req.body;
  const userId = req.userId;
  const whereFilters = filters(params);
  const cars = await prisma.car.findMany({
    cursor: params.cursor ? { id: params.cursor } : undefined,
    skip: params.cursor ? 1 : undefined,
    where: {
      ...whereFilters,
      ...expiredCompanies,
      available: true,
      deletedAt: null,
      companyId: params.companyId ?? undefined,
    },
    take: params.companyId ? 15 : 50,
    orderBy: [{ pinned: 'desc' }, { pinnedSort: 'asc' }, { id: 'desc' }],
    include: carInclude({ userId }),
  });
  const data = enrichCarsWithFlags(cars);
  res.status(200).json(data);
};

export const allCars = async (req: Request, res: Response) => {
  const { cursor } = req.body;
  const userId = req.userId;
  const take = 15;
  const now = new Date();

  const cars = await prisma.car.findMany({
    cursor: cursor ? { id: cursor } : undefined,
    skip: cursor ? 1 : undefined,
    where: {
      available: true,
      deletedAt: null,
      ...expiredCompanies,
    },
    take: take + 1,
    orderBy: [{ pinned: 'desc' }, { pinnedSort: 'asc' }, { id: 'desc' }],
    include: {
      ...carInclude({ userId }),
      featuredCars: {
        where: {
          available: true,
          deletedAt: null,
          startAt: { lte: now },
          OR: [{ until: null }, { until: { gte: now } }],
        },
      },
    },
  });

  const hasMore = cars.length > take;
  const data = hasMore ? cars.slice(0, take) : cars;

  res.status(200).json({
    cursor: data.at(-1)?.id,
    cars: data,
    hasMore,
  });
};

export const fovoriteCar = async (req: Request, res: Response) => {
  const { id } = req.body;
  const userId = req!.userId!;
  const trx = await prisma.$transaction(async (tx) => {
    const isExist = await tx.favoriteCars.findUnique({
      where: { carId_userId: { carId: id, userId } },
    });
    if (isExist) {
      const favorite = await tx.favoriteCars.delete({
        where: { carId_userId: { carId: id, userId } },
        select: { id: true },
      });
      return favorite.id;
    } else {
      const favorite = await tx.favoriteCars.create({
        data: { carId: id, userId: userId },
        select: { id: true },
      });
      return favorite.id;
    }
  });

  res.status(200).json(trx);
};

export const fovoriteCars = async (req: Request, res: Response) => {
  const { cursor } = req.body;

  const userId = req.userId;

  const data = await prisma.favoriteCars.findMany({
    cursor: cursor ? { id: cursor } : undefined,
    skip: cursor ? 1 : undefined,
    take: 15,
    orderBy: { id: 'desc' },
    where: { userId, car: { deletedAt: null, available: true } },
    include: {
      car: {
        include: carInclude({ userId, withCompany: true }),
        where: { ...expiredCompanies },
      },
    },
  });

  const cars = data
    ?.map((fav) => fav.car)
    .filter((car): car is Exclude<typeof car, null> => car !== null);

  const carsWithFlags = enrichCarsWithFlags(cars);

  res.status(200).json(carsWithFlags);
};

export const applyPromotionCode = async (req: Request, res: Response) => {
  const promo: ApplyPromoCodePayload = req.body;

  const userId = req.userId!;

  const applyCode: PromotionResult = await validateAndCalculatePromotion(
    promo,
    userId,
  );

  const { promotion, basePrice, ...data } = applyCode;

  res.status(200).json(data);
};

export const bookAcar = async (req: Request, res: Response) => {
  const data: ApplyPromoCodePayload = req.body;
  const userId = req.userId!;
  if (!userId) throw new Exception(400, 'user_not_found');

  let promotionResult: PromotionResult | null = null;

  if (data.code) {
    promotionResult = await validateAndCalculatePromotion(data, userId);
  }

  if (!promotionResult) {
    const rentalPlan = await prisma.rentalPlan.findUnique({
      where: { id: data.rentalPlanId },
      include: {
        car: { include: { company: true } },
        plan: true,
      },
    });
    if (!rentalPlan) throw new Exception(400, 'Rental plan not found', true);

    const periods = calculatePeriods(
      rentalPlan.periodType,
      new Date(data.startDate),
      new Date(data.endDate),
    );

    promotionResult = {
      promotion: null,
      carId: rentalPlan.carId,
      companyId: rentalPlan?.car?.companyId,
      planId: rentalPlan.planId,
      rentalPlanId: rentalPlan.id,
      ...calculatePriceWithoutPromotion(rentalPlan.price, periods),
    };
  }
  if (!promotionResult) {
    throw new Exception(500, 'GE');
  }
  const pr = promotionResult;
  const booked = await prisma.$transaction(async (tx) => {
    const book = await tx.book.create({
      data: {
        basePrice: pr.basePrice,
        carId: data.carId,
        startDate: data.startDate,
        endDate: data.endDate,
        totalPrice: pr.totalPrice,
        finalPrice: pr.finalPrice,
        companyId: pr.companyId,
        planId: pr.planId,
        promotionId: pr.promotion?.id,
        duration: pr.periods,
        rentalPlanId: pr.rentalPlanId,
        userId: userId,
        discountAmount: pr.discount,
        promtionType: pr.promotion?.type,
        contact: data.contact,
      },
      select: {
        id: true,
        company: {
          select: { userId: true, profile: { select: { prefLang: true } } },
        },
        profile: { select: { name: true } },
        car: { select: { title: true } },
      },
    });

    if (data.code) {
      const { promotion } = pr;
      await tx.promotionRedemption.create({
        data: {
          userId,
          carId: promotion?.carId,
          companyId: promotion?.companyId,
          bookId: book.id,
          planId: data.planId,
          rentalPlanId: data.rentalPlanId,
          promotionId: promotion?.id,
        },
      });
      if (promotion) {
        const whereCondition = getPromotionWhereCondition(
          promotion,
          req.body,
          userId,
        );
        await tx.promotion.update({
          where: { id: promotion.id },
          data: { usesCount: { increment: 1 } },
        });
        await tx.usedPromotion.upsert({
          where: whereCondition,
          create: {
            userId,
            promotionId: promotion!.id,
            carId: promotion.carId,
            companyId: promotion.companyId,
            planId: promotion.planId,
            rentalPlanId: promotion.rentalPlanId,
            bookId: book.id,
            used: 1,
          },
          update: { used: { increment: 1 } },
        });
      }
    }
    return book;
  });

  res.status(201).json(booked.id);
  const lang = (booked.company?.profile?.prefLang as PrefLangs) ?? 'en';
  const message = getNotificationMessage({
    notificationType: 'new_reservation',
    language: lang,
    title: booked.profile?.name,
    content: booked.car?.title,
  });
  await asyncWrap(() =>
    sendNotificationToUsers({
      userId: booked.company?.userId,
      content: message,
    }),
  );
};

export const cancelBook = async (req: Request, res: Response) => {
  const { id } = req.body;

  await prisma.$transaction(async (tx) => {
    const book = await tx.book.findUnique({ where: { id } });
    if (!book) {
      throw new Exception(400, 'book_not_found');
    }
    if (book.status !== 'pending') {
      throw new Exception(400, 'book_uncancelable');
    }

    await tx.book.update({
      where: { id },
      data: { status: 'canceled' },
    });
  });
  res.status(200).end();
};

export const bookedCars = async (req: Request, res: Response) => {
  const { cursor, status } = req.body;
  const userId = req.userId;
  const data = await prisma.book.findMany({
    cursor: cursor ? { id: cursor } : undefined,
    skip: cursor ? 1 : undefined,
    take: 15,
    where: { userId, status: status ?? undefined },
    orderBy: { id: 'desc' },
    include: {
      car: {
        include: {
          feature: {
            omit: {
              deletedAt: true,
              carTypeId: true,
              carId: true,
              brandId: true,
            },
          },
          type: { select: { en: true, ku: true, ar: true } },
          brand: { select: { ku: true, ar: true, en: true } },
          images: { select: { image: true }, where: { deletedAt: null } },
          company: {
            select: {
              name: true,
              desc: true,
              id: true,
              image: true,
              rate: true,
              review: true,
            },
          },
        },
      },
      rentalPlan: {
        select: {
          id: true,
          periodType: true,
          price: true,
          plan: { omit: { sort: true } },
        },
      },
      promotion: { include: { rentalPlan: { include: { plan: true } } } },
    },
  });

  res.status(200).json(data);
};

export const reviewCar = async (req: Request, res: Response) => {
  const { carId, desc, rate }: CarReviewPayload = req.body;
  const userId = req.userId!;
  const trx = await prisma.$transaction(async (tx) => {
    const prevBook = await tx.book.findFirst({
      where: { userId, status: 'completed', carId },
    });
    if (!prevBook) {
      throw new Exception(400, 'no_completed_booking');
    }
    const previousReview = await tx.carReview.findFirst({
      where: {
        carId,
        userId,
        deletedAt: null,
        status: { in: ['accepted', 'flagged'] },
      },
    });
    if (previousReview) {
      throw new Exception(400, 'car_review_exist');
    }
    const data = await tx.carReview.create({
      data: {
        userId,
        carId,
        desc,
        rate,
        companyId: prevBook.companyId,
        status: 'accepted',
      },
      select: { id: true, profile: { select: { name: true } } },
    });
    const avg = await tx.carReview.aggregate({
      _avg: { rate: true },
      _count: { id: true },
      where: { carId, deletedAt: null },
    });

    const car = await tx.car.update({
      where: { id: carId },
      data: { rate: avg._avg.rate ?? undefined, review: avg._count.id },
      select: {
        title: true,
        company: {
          select: { userId: true, profile: { select: { prefLang: true } } },
        },
      },
    });
    return { ...data, ...car };
  });
  res.status(200).json(trx.id);

  const lang = (trx.company?.profile?.prefLang as PrefLangs) ?? 'en';
  const message = getNotificationMessage({
    notificationType: 'new_car_review',
    language: lang,
    title: trx?.profile?.name,
    content: trx?.title,
  });
  await asyncWrap(() =>
    sendNotificationToUsers({
      userId: trx.company?.userId,
      content: message,
    }),
  );
};

export const deleteCarReview = async (req: Request, res: Response) => {
  const { id } = req.body;
  const userId = req.userId;

  const trx = await prisma.$transaction(async (tx) => {
    const previousReview = await tx.carReview.findUnique({
      where: { id, userId },
    });
    if (!previousReview) {
      throw new Exception(400, 'car_review_not_exist');
    }
    const data = await tx.carReview.update({
      where: { id },
      data: { canceledAt: new Date(), status: 'canceled' },
    });
    const avg = await tx.carReview.aggregate({
      _avg: { rate: true },
      _count: { id: true },
      where: {
        carId: previousReview.carId,
        status: { notIn: ['canceled', 'deleted'] },
      },
    });
    await tx.car.update({
      where: { id: previousReview.carId! },
      data: {
        rate: avg._avg.rate ?? 0,
        review: avg._count.id,
      },
    });
  });
  res.status(200).end();
};

export const reviewCompany = async (req: Request, res: Response) => {
  const { companyId, desc, rate }: CompanyReviewPayload = req.body;
  const userId = req.userId!;

  const trx = await prisma.$transaction(async (tx) => {
    const prevBook = await tx.book.findFirst({
      where: { userId, companyId, status: 'completed' },
    });
    if (!prevBook) {
      throw new Exception(400, 'no_completed_booking');
    }
    const previousReview = await tx.companyReview.findFirst({
      where: {
        companyId,
        userId,
        status: { in: ['accepted', 'flagged'] },
        deletedAt: null,
      },
    });
    if (previousReview) {
      throw new Exception(400, 'compnany_review_exist');
    }
    const data = await tx.companyReview.create({
      data: {
        userId,
        companyId,
        desc,
        rate,
        status: 'accepted',
      },
    });

    const avg = await tx.companyReview.aggregate({
      _avg: { rate: true },
      _count: { id: true },
      where: { companyId },
    });
    const company = await tx.company.update({
      where: { id: companyId },
      data: { rate: avg._avg.rate ?? 0, review: avg._count.id },
      select: {
        id: true,
        profile: { select: { name: true, prefLang: true, userId: true } },
      },
    });

    return { ...data, ...company };
  });
  res.status(200).json(trx.id);

  const lang = (trx?.profile?.prefLang as PrefLangs) ?? 'en';
  const message = getNotificationMessage({
    notificationType: 'new_company_review',
    language: lang,
    title: trx?.profile?.name,
  });
  await asyncWrap(() =>
    sendNotificationToUsers({
      userId: trx.profile?.userId,
      content: message,
    }),
  );
};

export const deleteCompanyReview = async (req: Request, res: Response) => {
  const { id } = req.body;
  const userId = req.userId;

  const trx = await prisma.$transaction(async (tx) => {
    const previousReview = await tx.companyReview.findFirst({
      where: { id, userId },
    });
    if (!previousReview) {
      throw new Exception(400, 'car_review_not_exist');
    }
    await tx.companyReview.update({
      where: { id, userId },
      data: { canceledAt: new Date(), status: 'canceled' },
    });
    const avg = await tx.companyReview.aggregate({
      _avg: { rate: true },
      _count: { id: true },
      where: {
        companyId: previousReview.companyId,
        status: { notIn: ['canceled', 'deleted'] },
      },
    });

    await tx.company.update({
      where: { id: previousReview.companyId! },
      data: {
        rate: avg._avg.rate ?? 0,
        review: avg._count.id,
      },
    });
  });
  res.status(200).end();
};

export const recentlyViewed = async (req: Request, res: Response) => {
  const userId = req.userId;
  const viewedCars = await prisma.recentlyViewedCar.findMany({
    orderBy: { id: 'desc' },
    take: 15,
    where: {
      userId,
      car: { available: true, deletedAt: null, ...expiredCompanies },
    },
    include: {
      car: {
        include: carInclude({ userId }),
      },
    },
  });
  const cars = viewedCars?.map((c) => c.car).filter((car) => car !== null);
  const carWithExtraFields = enrichCarsWithFlags(cars);
  res.status(200).json(carWithExtraFields);
};

export const detailsCar = async (req: Request, res: Response) => {
  const { id } = req.body;
  const userId = req.userId;

  const trx = await prisma.$transaction(async (tx) => {
    const car = await tx.car.findUnique({
      where: { carId: id, ...expiredCompanies },
      include: {
        feature: {
          select: {
            hp: true,
            fuel: true,
            speed: true,
            transmission: true,
            seat: true,
            year: true,
            odometer: true,
            engCC: true,
            cylinders: true,
            type: { select: { en: true, ar: true, ku: true } },
          },
        },
        images: { where: { deletedAt: null } },
        location: {
          select: {
            lat: true,
            long: true,
            radiusKm: true,
            city: {
              select: { en: true, ar: true, ku: true },
            },
            town: {
              select: { en: true, ar: true, ku: true },
            },
          },
        },
        rentalPlan: { include: { plan: true }, where: { deletedAt: null } },
        brand: { select: { en: true, ar: true, ku: true, image: true } },
        company: {
          omit: {
            activeDate: true,
            expiresAt: true,
            available: true,
            userId: true,
          },
          include: {
            contacts: {
              select: { id: true, value: true, type: true, countrCode: true },
            },
          },
        },
      },
    });
    if (!car) {
      throw new Exception(404, 'car_not_found');
    }
    if (userId) {
      await tx.recentlyViewedCar.upsert({
        where: { userId_carId: { userId, carId: car.id } },
        update: {},
        create: {
          userId,
          carId: car.id,
          viewedAt: new Date(),
          companyId: car.companyId,
        },
      });
    }
    await tx.viewedCars.create({
      data: { companyId: car?.companyId, carId: car.id },
    });
    return car;
  });

  res.status(200).json(trx);
};

export const carReviews = async (req: Request, res: Response) => {
  const { cursor, id } = req.body;
  const userId = req.userId;

  const data = await prisma.carReview.findMany({
    cursor: cursor ? { id: cursor } : undefined,
    skip: cursor ? 1 : undefined,
    take: cursor ? 15 : 5,
    orderBy: { id: 'desc' },
    omit: {
      userId: true,
      carId: true,
      deletedAt: true,
      bookId: true,
    },
    where: {
      carId: id,
      userId: userId ? { not: userId } : undefined,
      status: { notIn: ['flagged', 'canceled', 'deleted'] },
    },
    include: {
      profile: {
        include: { role: true, permissions: { select: { permission: true } } },
      },
    },
  });

  res.status(200).json(data);
};

export const company = async (req: Request, res: Response) => {
  const { id } = req.body;
  const userId = req.userId;
  const data = await prisma.$transaction(async (tx) => {
    const company = await tx.company.findUnique({
      where: { id },
      include: {
        contacts: {
          select: { id: true, value: true, countrCode: true, type: true },
        },
        location: { select: { lat: true, long: true } },
      },
    });
    if (!company) {
      throw new Exception(400, 'company_not_found');
    }
    let reviews = null;
    let ableToReview = null;

    const cars = await tx.car.aggregate({
      _count: { id: true },
      where: { companyId: id, deletedAt: null },
    });
    return {
      ...company,
      cars: cars._count.id,
    };
  });
  res.status(200).json(data);
};

export const companyReviews = async (req: Request, res: Response) => {
  const { cursor, id } = req.body;
  const userId = req.userId;

  const reviews = await prisma.companyReview.findMany({
    cursor: cursor ? { id: cursor } : undefined,
    skip: cursor ? 1 : undefined,
    take: 15,
    where: {
      companyId: id,
      deletedAt: null,
      NOT: { userId },
      status: { notIn: ['flagged', 'canceled', 'deleted'] },
    },
    include: {
      profile: {
        include: {
          role: true,
          permissions: { select: { permission: true } },
        },
      },
    },
  });

  res.status(200).json(reviews);
};

export const getCars = async (req: Request, res: Response) => {
  const { cursor, companyId, type, brand }: CarCompanyPayload = req.body;
  const cars = await prisma.car.findMany({
    cursor: cursor ? { id: cursor } : undefined,
    skip: cursor ? 1 : undefined,
    take: 15,
    orderBy: { id: 'desc' },
    where: {
      companyId: companyId!,
      typeId: type ?? undefined,
      brandId: brand ?? undefined,
    },
    include: carInclude({ withCompany: false }),
  });

  return res.status(200).json(cars);
};

export const support = async (req: Request, res: Response) => {
  const isAdmin = req.user?.role === 'admin';
  const data = await prisma.support.findMany({
    orderBy: { sort: 'asc' },
    where: isAdmin ? undefined : { available: true },
  });
  res.status(200).json(data);
};

export const sliders = async (req: Request, res: Response) => {
  const isAdmin = req.user?.role === 'admin';
  const data = await prisma.slider.findMany({
    orderBy: { sort: 'asc' },
    where: {
      available: isAdmin ? undefined : true,
      deletedAt: null,
    },
    include: { car: { select: { id: true, title: true, listedAt: true } } },
  });

  res.status(200).json(data);
};

export const contact = async (req: Request, res: Response) => {
  const userId = req.userId;
  const { type, value, companyId, contactId, carId }: ContactCompanyPayload =
    req.body;

  var val: string | undefined = undefined;
  const data = await prisma.$transaction(async (tx) => {
    const cc = await tx.company.findUnique({ where: { id: companyId } });
    if (!cc) throw new Exception(400, 'company_not_found');
    const company = await tx.company.update({
      data: { contacted: { increment: 1 } },
      where: { id: companyId },
    });
    if (contactId) {
      const contact = await tx.contact.findUnique({ where: { id: contactId } });
      val = contact?.value;
    }
    const updated = await prisma.contactStatistic.create({
      data: {
        userId,
        type: type ?? 'whatsapp',
        value: type === 'whatsapp' ? company.contact : val,
        companyId,
        contactId,
        carId,
        ipAddress: req.ip,
      },
      include: { car: { select: { carId: true } } },
    });
    return { company, updated };
  });

  if (type === 'whatsapp') {
    const lang = (req.headers.devicelang as PrefLangs) ?? 'en';
    const url = openChat({
      carId: data.updated?.car?.carId,
      phoneNumber: data.company.contact ?? '',
      subject: 'Carva',
      language: lang,
    });
    res.status(200).json(url);
    return;
  }
  res.status(200).end();
};

export const companies = async (req: Request, res: Response) => {
  const { cursor, inl, delivery } = req.body;

  const data = await prisma.company.findMany({
    skip: cursor ? 1 : undefined,
    take: 20,
    cursor: cursor ? { id: cursor } : undefined,
    where: {
      available: true,
      expiresAt: { gte: new Date() },
      activeDate: { lte: new Date() },
      international: inl,
      delivery: delivery ?? undefined,
    },
    orderBy: { id: 'desc' },
    omit: { contact: true, contacted: true, userId: true },
    include: { contacts: { where: { deletedAt: null } } },
  });
  res.status(200).json(data);
};

export const slider = async (req: Request, res: Response) => {
  const { id } = req.body;
  await prisma.slider.update({
    where: { id },
    data: { clicked: { increment: 1 } },
  });
  res.status(200).end();
};

export const requestedCar = async (req: Request, res: Response) => {
  const carId = req.params.id;

  const [err, cachedHtml] = await asyncWrap(() =>
    getData<string>(`${carId}_car_html`),
  );

  if (!err && cachedHtml) {
    return res.send(cachedHtml);
  }

  const car = await prisma.car.findUnique({
    where: { carId },
    include: { images: { take: 1 }, feature: true },
  });

  if (!car) {
    return res.status(404).send('Car not found');
  }

  const html = `
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>${car.title}</title>
      <meta property="og:title" content="${car.title}" />
      <meta property="og:description" content="${car.feature?.year ?? ''}" />
      <meta property="og:image" content="${car.images[0]?.image ? `${process.env.BASE_IMAGE}/` + car.images[0].image : ''}" />
      <meta property="og:url" content="https://carvarent.com/car/${carId}" />
      <meta property="og:type" content="website" />
    </head>
    <body>
      <h1>${car.title}</h1>
      <p>${car.trips}</p>
      ${car.images[0]?.image ? `<img src="${process.env.BASE_IMAGE}/${car.images[0].image}" alt="${car.title}" />` : ''}
    </body>
    </html>
  `;

  await asyncWrap(() => setData(`${carId}_car_html`, html, 900));

  res.send(html);
};

export const filtersData = async (req: Request, res: Response) => {
  const data = await prisma.$transaction(async (tx) => {
    const brands = await tx.brand.findMany({
      select: { id: true, en: true, ar: true, ku: true, image: true },
      where: { deletedAt: null, available: true },
    });
    const types = await tx.carType.findMany({
      select: { id: true, en: true, ar: true, ku: true },
      where: { deletedAt: null, available: true },
    });
    const cities = await tx.city.findMany({
      include: {
        towns: {
          select: { id: true, en: true, ar: true, ku: true },
          where: { available: true, deletedAt: null },
        },
      },
      where: { deletedAt: null, available: true },
    });
    const plans = await tx.plan.findMany({
      select: { id: true, en: true, ar: true, ku: true },
    });
    return {
      brands,
      types,
      cities,
      plans,
    };
  });

  return res.status(200).json(data);
};
