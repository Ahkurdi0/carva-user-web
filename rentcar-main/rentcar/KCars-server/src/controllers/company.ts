import { prisma } from '../config/prisma';
import { ImageDirs } from '../constants/images_keys';
import { IFile } from '../types/interfaces';
import { asyncWrap } from '../utils/async_wrap';
import { Exception } from '../utils/exception';
import { carInclude } from '../utils/extracted_types';
import {
  sendNotificationToAdmin,
  sendNotificationToUsers,
} from '../utils/notification';
import {
  getBookStatus,
  getNotificationMessage,
  PrefLangs,
} from '../utils/notifications_messages';
import * as S3Image from '../utils/upload_image';
import {
  CarCompanyPayload,
  CompanyBookedPayload,
  ListCarPayload,
  PromotionPayload,
  PromotionsPayload,
  PromotionUpdatePayload,
  SortCarImagesPayload,
  SortContactsPayload,
  updateBookPayload,
  updateCarPayload,
  UpdateCompanyPayload,
} from '../validation/company';
import { Request, Response } from 'express';

export const updateCar = async (req: Request, res: Response) => {
  const {
    location,
    rentalPlan,
    deletedImages,
    deletedRentalPlans,
    displayPlan,
    feature,
    ...newCar
  }: updateCarPayload = req.body;

  var companyId = req.user?.companyId;
  const files = req.files;
  let newImageData: {
    image: string;
    companyId: string;
    sort: number;
  }[] = [];
  const isAdmin = req.user?.role === 'admin';
  if (!companyId && isAdmin) {
    const currentCar = await prisma.car.findUnique({
      where: { id: newCar.id! },
    });
    companyId = currentCar?.companyId;
  }
  if (files?.images && (files.images as IFile[]).length > 0) {
    const [uploadError, urls] = await asyncWrap(() =>
      S3Image.uploadImagesToS3(files.images as IFile[], ImageDirs.car),
    );

    if (uploadError || !urls) {
      throw new Exception(400, 'image_upload_failed');
    }

    newImageData = urls.map((url, idx) => ({
      image: url,
      companyId: companyId!,
      sort: idx,
    }));
  }

  await prisma.$transaction(async (tx) => {
    const car = await tx.car.findUnique({
      where: { id: newCar.id!, companyId: isAdmin ? undefined : companyId! },
    });

    if (!car) {
      throw new Exception(400, 'unauthorized');
    }

    if (deletedImages?.length) {
      await tx.image.updateMany({
        where: {
          carId: newCar.id!,
          id: { in: deletedImages.map((image) => image.id) },
        },
        data: { deletedAt: new Date() },
      });
    }

    if (newImageData.length) {
      const currentImags = await tx.image.findMany({
        where: { carId: newCar.id!, deletedAt: null },
      });

      if (
        currentImags.length +
          newImageData.length -
          (deletedImages?.length ?? 0) >
        5
      ) {
        throw new Exception(400, 'GE');
      }

      const maxSort = await tx.image.aggregate({
        where: { carId: newCar.id! },
        _max: { sort: true },
      });

      const baseSort = maxSort._max.sort ?? 0;
      newImageData = newImageData.map((img, idx) => ({
        ...img,
        sort: baseSort + idx + 1,
      }));
    }

    if (deletedRentalPlans?.length) {
      await tx.rentalPlan.updateMany({
        where: {
          carId: newCar.id,
          id: { in: deletedRentalPlans.map((p) => p.id) },
        },
        data: { available: false, deletedAt: new Date() },
      });
    }
    if (rentalPlan) {
      const currentPlans = await tx.rentalPlan.findMany({
        where: { carId: newCar.id, deletedAt: null },
      });

      if (
        currentPlans.length +
          rentalPlan.length -
          (deletedRentalPlans?.length ?? 0) >
        3
      ) {
        throw new Exception(400, 'GE');
      }
    }

    const createdCar = await tx.car.update({
      where: { id: newCar.id! },
      data: {
        brandId: newCar.brandId ?? undefined,
        typeId: newCar.typeId ?? undefined,
        title: newCar.title ?? undefined,
        available: newCar.available ?? undefined,
        companyId: newCar.companyId ?? undefined,
        displayPlan: displayPlan ?? undefined,
        ...(rentalPlan?.length
          ? { rentalPlan: { createMany: { data: rentalPlan } } }
          : {}),
        ...(newImageData?.length
          ? { images: { createMany: { data: newImageData } } }
          : {}),
        feature: feature
          ? {
              update: {
                data: {
                  seat: feature.seat ?? undefined,
                  carTypeId: newCar.typeId ?? undefined,
                  brandId: feature.brandId ?? undefined,
                  hp: feature.hp ?? undefined,
                  speed: feature.speed ?? undefined,
                  fuel: feature.fuel ?? undefined,
                  transmission: feature.transmission ?? undefined,
                  year: feature.year ?? undefined,
                  cylinders: feature.cylinders ?? undefined,
                  engCC: feature.engCC ?? undefined,
                  odometer: feature.odometer ?? undefined,
                },
              },
            }
          : newCar.typeId
            ? { update: { carTypeId: newCar.typeId } }
            : undefined,
        location: location
          ? {
              update: {
                long: location.long ?? undefined,
                lat: location.lat ?? undefined,
                cityId: location.cityId ?? undefined,
                townId: location.townId,
              },
            }
          : undefined,
      },
      include: { location: true },
    });
    if (createdCar.location && location) {
      await tx.$executeRaw`
        UPDATE "location"."carLocation"
        SET "location" = ST_SetSRID(ST_MakePoint(${location.long}, ${location.lat}), 4326)::geography
        WHERE "id" = ${createdCar.location.id}
      `;
    }
  });

  return res.status(200).end();
};

export const listCar = async (req: Request, res: Response) => {
  const {
    location,
    rentalPlan,
    companyId,
    displayPlan,
    feature,
    ...data
  }: ListCarPayload = req.body;

  const cid = req.user!.companyId!;
  if (!cid) throw new Exception(400, 'company_not_found');
  const files = req.files;

  let newImageData: {
    image: string;
    companyId: string;
    sort: number;
  }[] = [];

  if (files?.images && (files.images as IFile[]).length > 0) {
    const [uploadError, urls] = await asyncWrap(() =>
      S3Image.uploadImagesToS3(files.images as IFile[], ImageDirs.car),
    );

    if (uploadError || !urls) {
      throw new Exception(400, 'image_upload_failed');
    }
    newImageData = urls.map((url, idx) => ({
      image: url,
      companyId: cid,
      sort: idx,
    }));
  }

  await prisma.$transaction(async (tx) => {
    const createdCar = await tx.car.create({
      data: {
        ...data,
        companyId: cid,
        available: data.available ?? true,
        displayPlan: displayPlan!,
        rentalPlan: { createMany: { data: rentalPlan } },
        location: location
          ? {
              create: {
                long: location!.long!,
                lat: location!.lat!,
                cityId: location.cityId!,
                townId: location.townId ?? undefined,
                companyId: cid!,
              },
            }
          : undefined,
        feature: feature ? { create: feature } : undefined,
        images: { createMany: { data: newImageData } },
      },
      include: { location: true },
    });
    if (createdCar.location && location) {
      await tx.$executeRaw`
        UPDATE "location"."carLocation"
        SET "location" = ST_SetSRID(ST_MakePoint(${location.long}, ${location.lat}), 4326)::geography
        WHERE "id" = ${createdCar.location.id}
      `;
    }
  });
  return res.status(200).end();
};

export const deleteCar = async (req: Request, res: Response) => {
  const { id } = req.body;
  const deletedAt = new Date();

  await prisma.$transaction(async (tx) => {
    const car = await tx.car.findUnique({
      where: { id },
      include: {
        location: true,
        feature: true,
      },
    });

    await tx.car.update({
      where: { id },
      data: { deletedAt },
    });
  });

  return res.status(200).end();
};

export const sortCarImages = async (req: Request, res: Response) => {
  const images: SortCarImagesPayload = req.body;
  const companyId = req.user?.companyId;
  const isAdmin = req.user?.role == 'admin';
  await prisma.$transaction(
    images.map((image) =>
      prisma.image.update({
        where: {
          id: image.id,
          carId: image.carId,
          companyId: isAdmin ? undefined : companyId!,
        },
        data: { sort: image.sort },
      }),
    ),
  );
  return res.status(200).end();
};

export const promotions = async (req: Request, res: Response) => {
  const { cursor, companyId, carId }: PromotionsPayload = req.body;
  const cid = req.user?.companyId ?? companyId;
  const data = await prisma.promotion.findMany({
    orderBy: { id: 'desc' },
    where: { companyId: cid, deletedAt: null, carId: carId },
  });
  res.status(200).json(data);
};

export const promotion = async (req: Request, res: Response) => {
  const promot: PromotionPayload = req.body;

  const { id, companyId, code, ...data } = promot;

  const cid = req.user?.companyId;
  const isAdmin = req.user?.role == 'admin';

  const promo = await prisma.$transaction(async (tx) => {
    const car = await tx.car.findUnique({
      where: { id: data.carId!, companyId: isAdmin ? undefined : cid! },
    });
    if (!car) throw new Exception(400, 'car_not_found');

    const exist = await tx.promotion.findUnique({
      where: { code: code! },
    });
    if (exist) throw new Exception(400, 'used_promot_code');
    const newPromotion = await tx.promotion.create({
      data: {
        ...data,
        code: code.toLocaleLowerCase(),
        companyId: cid!,
      },
    });
    return newPromotion.id;
  });

  return res.status(200).json(promo);
};

export const updatePromotion = async (req: Request, res: Response) => {
  const promot: PromotionUpdatePayload = req.body;
  const { id, available, companyId, carId, ...data } = promot;
  const cid = req.user?.companyId;
  const isAdmin = req.user?.role == 'admin';
  const promo = await prisma.$transaction(async (tx) => {
    const car = await tx.car.findUnique({
      where: { id: carId, companyId: isAdmin ? undefined : cid! },
    });
    if (!car) throw new Exception(400, 'car_not_found');
    if (id) {
      const update = await tx.promotion.update({
        where: { id, companyId: cid, carId },
        data: { available },
      });
      return update.id;
    }
  });

  return res.status(200).end();
};

export const deletePromotion = async (req: Request, res: Response) => {
  const { id } = req.body;
  const companyId = req.user?.companyId;
  const isAdmin = req.user?.role == 'admin';
  const deleted = await prisma.promotion.update({
    where: { id, companyId: isAdmin ? undefined : companyId! },
    data: { deletedAt: new Date() },
  });

  return res.status(200).end();
};

export const getBooks = async (req: Request, res: Response) => {
  const { cursor, status, companyId, search }: CompanyBookedPayload = req.body;

  const cid = req.user?.companyId ?? companyId;

  const data = await prisma.book.findMany({
    cursor: cursor ? { id: cursor } : undefined,
    skip: cursor ? 1 : undefined,
    take: 5,
    orderBy: { id: 'desc' },
    where: {
      companyId: cid,
      status: status ?? undefined,
      ...(search
        ? { bookId: { contains: search, mode: 'insensitive' } }
        : undefined),
    },
    include: {
      rentalPlan: { include: { plan: true } },
      profile: {
        include: { role: true, permissions: { select: { permission: true } } },
      },
      car: {
        include: carInclude({ withPromotion: false }),
      },
      promotion: { include: { rentalPlan: { include: { plan: true } } } },
    },
  });
  return res.status(200).json(data);
};

export const getCars = async (req: Request, res: Response) => {
  const { cursor, companyId, type, brand }: CarCompanyPayload = req.body;

  const cid = req?.companyId;

  const cars = await prisma.car.findMany({
    cursor: cursor ? { id: cursor } : undefined,
    skip: cursor ? 1 : undefined,
    take: 15,
    orderBy: { id: 'desc' },
    where: {
      companyId: cid!,
      typeId: type ?? undefined,
      brandId: brand ?? undefined,
      deletedAt: null,
    },
    include: {
      brand: true,
      feature: {
        include: {
          type: {
            select: {
              id: true,
              en: true,
              ku: true,
              ar: true,
            },
          },
        },
      },
      type: true,
      images: { where: { deletedAt: null } },
      location: {
        include: {
          city: {
            omit: { deletedAt: true, sort: true, available: true },
          },
          town: {
            omit: { deletedAt: true, sort: true, available: true },
          },
        },
      },
      rentalPlan: { include: { plan: true }, where: { deletedAt: null } },
    },
  });

  return res.status(200).json(cars);
};

export const updateBook = async (req: Request, res: Response) => {
  const { bookId, status, cancelReason }: updateBookPayload = req.body;
  const companyId = req.user?.companyId;

  const updated = await prisma.$transaction(async (tx) => {
    const book = await tx.book.findUnique({
      where: { id: bookId, companyId },
      include: {
        profile: { select: { prefLang: true } },
        car: { select: { title: true } },
      },
    });
    if (!book) {
      throw new Exception(400, 'book_not_found');
    }
    if (book && book.status === status) {
      throw new Exception(400, 'same_status');
    }

    const data = await tx.book.update({
      where: { id: bookId },
      data: { cancelReason, status },
    });

    if (status === 'completed' && !book.isCompleted) {
      await tx.book.update({
        where: { id: bookId },
        data: { isCompleted: true },
      });
      await tx.car.update({
        where: { id: book.carId! },
        data: { trips: { increment: 1 } },
      });
    }
    return book;
  });

  res.status(200).end();
  const lang = (updated.profile?.prefLang as PrefLangs) ?? 'en';
  const message = getNotificationMessage({
    notificationType: 'reservation_status',
    language: lang,
    title: getBookStatus(status, lang),
    content: updated.car?.title ?? '',
  });

  await asyncWrap(() =>
    sendNotificationToUsers({ userId: updated.userId, content: message }),
  );
};

export const updateCompnay = async (req: Request, res: Response) => {
  const {
    name,
    desc,
    location,
    deletedContacts,
    newContacts,
    companyId,
    delivery,
    international,
    contact,
  }: UpdateCompanyPayload = req.body;

  const cid = req.user?.companyId;
  let newImage: string | undefined = undefined;
  let newCoverImage: string | undefined = undefined;

  const image = req.files['image'] ? req.files['image'][0] : null;
  const coverImage = req.files['coverImage']
    ? req.files['coverImage'][0]
    : null;

  if (image) {
    const [err, url] = await asyncWrap(() =>
      S3Image.uploadImageS3(image, ImageDirs.companyProfile),
    );
    if (err || !url) {
      throw new Exception(400, 'image_upload_failed');
    }
    newImage = url;
    const data = await prisma.company.findUnique({
      where: { id: cid },
    });

    if (data?.image) {
      const [errDelete, _] = await asyncWrap(() =>
        S3Image.deleteImageS3(data.image!),
      );
      if (errDelete) {
        throw new Exception(400, 'image_upload_failed');
      }
    }
  }
  if (coverImage) {
    const [err, url] = await asyncWrap(() =>
      S3Image.uploadImageS3(coverImage, ImageDirs.companyCover),
    );
    if (err || !url) {
      throw new Exception(400, 'image_upload_failed');
    }
    newCoverImage = url;
    const data = await prisma.company.findUnique({
      where: { id: cid },
    });

    if (data?.coverImage) {
      const [errDelete, _] = await asyncWrap(() =>
        S3Image.deleteImageS3(data.coverImage!),
      );
      if (errDelete) {
        throw new Exception(400, 'image_upload_failed');
      }
    }
  }
  await prisma.$transaction(async (tx) => {
    let maxSort = 0;

    if (newContacts?.length) {
      const currentContacts = await tx.contact.findMany({
        where: { companyId: cid },
      });

      if (
        currentContacts.length +
          newContacts.length -
          (deletedContacts?.length ?? 0) >
        5
      ) {
        throw new Exception(400, 'GE');
      }

      const maxOrder = await tx.contact.aggregate({
        where: { companyId: cid ?? undefined },
        _max: { sort: true },
      });
      maxSort = maxOrder._max.sort ?? 0;
    }

    const createManyData = newContacts?.length
      ? newContacts.map((c, index) => ({
          ...c,
          sort: maxSort + index + 1,
        }))
      : undefined;

    const company = await tx.company.update({
      where: { id: cid ?? undefined },
      data: {
        name: name ?? undefined,
        desc: desc ?? undefined,
        image: newImage ?? undefined,
        coverImage: newCoverImage ?? undefined,
        delivery: delivery,
        contact: contact ?? undefined,
        contacts: {
          ...(createManyData && {
            createMany: {
              data: createManyData,
            },
          }),
          ...(deletedContacts?.length && {
            updateMany: {
              where: {
                id: { in: deletedContacts.map((c) => c.id) },
              },
              data: { deletedAt: new Date() },
            },
          }),
        },
        location: location
          ? {
              update: {
                long: location.long ?? undefined,
                lat: location.lat ?? undefined,
                cityId: location.cityId ?? undefined,
                townId: location.townId,
              },
            }
          : undefined,
      },
      include: { location: { select: { id: true } } },
    });

    if (location && company.location) {
      await tx.$executeRaw`
        UPDATE "location"."location"
        SET "pglocation" = ST_SetSRID(ST_MakePoint(${location.long}, ${location.lat}), 4326)::geography
        WHERE "id" = ${company.location.id}
      `;
    }
  });

  return res.status(200).end();
};

export const sortContacts = async (req: Request, res: Response) => {
  const contacts: SortContactsPayload = req.body;

  await prisma.$transaction(
    contacts.map((c) =>
      prisma.contact.update({
        where: { id: c.id, companyId: c.companyId },
        data: { sort: c.sort },
      }),
    ),
  );

  res.status(200).json({});
};

export const carReviews = async (req: Request, res: Response) => {
  const { cursor, id } = req.body;
  const companyId = req.user?.companyId ?? id;

  const data = await prisma.carReview.findMany({
    cursor: cursor ? { id: cursor } : undefined,
    skip: cursor ? 1 : undefined,
    take: 15,
    orderBy: { id: 'desc' },
    omit: {
      userId: true,
      carId: true,
      deletedAt: true,
      bookId: true,
    },
    where: { deletedAt: null, companyId: companyId },
    include: {
      CarReviewFlag: { select: { flaggedAt: true } },
      car: true,
      profile: {
        include: { role: true, permissions: { select: { permission: true } } },
      },
    },
  });
  const reviews = data.map((r) => {
    return {
      ...r,
      flaggedAt: r.CarReviewFlag?.flaggedAt,
    };
  });
  res.status(200).json(reviews);
};

export const brands = async (req: Request, res: Response) => {
  const isAdmin = req.user?.role === 'admin';
  const data = await prisma.brand.findMany({
    orderBy: { sort: 'asc' },
    where: { deletedAt: null, available: isAdmin ? undefined : true },
    omit: {
      sort: isAdmin ? undefined : true,
      available: true,
      deletedAt: true,
    },
  });
  res.status(200).json(data);
};

export const carTypes = async (req: Request, res: Response) => {
  const isAdmin = req.user?.role === 'admin';
  const data = await prisma.carType.findMany({
    orderBy: { sort: 'asc' },
    where: { deletedAt: null, available: isAdmin ? undefined : true },
    omit: {
      sort: isAdmin ? undefined : true,
      available: isAdmin ? undefined : true,
      deletedAt: true,
    },
  });
  res.status(200).json(data);
};

export const plans = async (req: Request, res: Response) => {
  const data = await prisma.plan.findMany({ orderBy: { id: 'desc' } });
  res.status(200).json(data);
};

export const cities = async (req: Request, res: Response) => {
  const isAdmin = req.user?.role === 'admin';
  const data = await prisma.city.findMany({
    orderBy: { id: 'desc' },
    where: {
      deletedAt: null,
      available: isAdmin ? undefined : true,
    },
    include: {
      towns: {
        select: { id: true, en: true, ar: true, ku: true },
        where: {
          available: isAdmin ? undefined : true,
        },
      },
    },
  });
  res.status(200).json(data);
};
export const companyReviews = async (req: Request, res: Response) => {
  const { cursor } = req.body;
  const companyId = req.user?.companyId;

  const data = await prisma.companyReview.findMany({
    cursor: cursor ? { id: cursor } : undefined,
    skip: cursor ? 1 : undefined,
    take: 15,
    where: { companyId, deletedAt: null },
    include: {
      companyReviewFlag: { select: { flaggedAt: true } },
      profile: {
        include: {
          role: true,
          permissions: { select: { permission: true } },
        },
      },
    },
  });
  const reviews = data.map((r) => {
    return {
      ...r,
      flaggedAt: r.companyReviewFlag?.flaggedAt,
    };
  });
  res.status(200).json(reviews);
};

export const flagCompnayReview = async (req: Request, res: Response) => {
  const { reviewId } = req.body;

  const companyId = req.user?.companyId;
  if (!companyId) throw new Exception(400, 'company_not_found');

  const flag = await prisma.$transaction(async (tx) => {
    const prev = await tx.companyReviewFlag.findFirst({
      where: { reviewId },
    });
    if (prev) {
      throw new Exception(400, 'review_flag_exist');
    }
    const data = await tx.companyReviewFlag.create({
      data: { companyId, reviewId },
      select: { id: true },
    });
    const user = await tx.companyReview.update({
      where: { id: reviewId },
      data: { status: 'flagged' },
      select: {
        id: true,
        profile: { select: { name: true } },
        company: { select: { name: true } },
      },
    });
    return { ...data, ...user };
  });
  res.status(200).json(flag.id);
  await asyncWrap(() =>
    sendNotificationToAdmin({
      content: {
        title: flag.company?.name ?? '',
        content: `Reported a company review by ( ${flag.profile?.name} )`,
      },
      adminAccess: 'access_company_reviews_flag',
    }),
  );
};

export const flagCarReview = async (req: Request, res: Response) => {
  const companyId = req.user!.companyId!;
  const { reviewId, carId } = req.body;

  if (!companyId) throw new Exception(400, 'company_not_found');

  const flag = await prisma.$transaction(async (tx) => {
    const prev = await tx.carReviewFlag.findFirst({
      where: { reviewId, companyId, carId },
      include: { company: { select: { name: true } } },
    });
    if (prev) {
      throw new Exception(400, 'review_flag_exist');
    }
    const data = await tx.carReviewFlag.create({
      data: { companyId, reviewId, carId },
      select: { id: true, company: { select: { name: true } } },
    });
    const user = await tx.carReview.update({
      where: { id: reviewId },
      data: { status: 'flagged' },
      select: { profile: { select: { name: true } } },
    });
    return { ...data, ...user };
  });
  res.status(200).json(flag.id);
  await asyncWrap(() =>
    sendNotificationToAdmin({
      content: {
        title: flag.company.name,
        content: `Reported a car review by ( $${flag.profile?.name} )`,
      },
      adminAccess: 'access_car_reviews_flag',
    }),
  );
};

export const company = async (req: Request, res: Response) => {
  const { id } = req.body;
  const companyId = req.user?.companyId;

  const userId = req.userId;
  const data = await prisma.$transaction(async (tx) => {
    const company = await tx.company.findUnique({
      where: { id: companyId },
      include: {
        contacts: {
          where: { deletedAt: null },
          select: { id: true, value: true, countrCode: true, type: true },
        },
        location: {
          include: {
            city: {
              select: { id: true, en: true, ar: true, ku: true },
            },
            town: { select: { id: true, en: true, ar: true, ku: true } },
          },
        },
      },
    });
    if (!company) {
      throw new Exception(400, 'company_not_found');
    }
    const cars = await tx.car.aggregate({
      _count: { id: true },
      where: { companyId, deletedAt: null },
    });
    return {
      ...company,
      cars: cars._count.id,
    };
  });
  res.status(200).json(data);
};
