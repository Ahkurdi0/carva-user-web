import { Request, Response } from 'express';
import { prisma } from '../config/prisma';
import { carInclude } from '../utils/extracted_types';
import * as Payload from '../validation/admin';
import { redisClient, setData } from '../config/redis';
import { asyncWrap } from '../utils/async_wrap';
import { Exception } from '../utils/exception';
import { AdminPermissions } from '../constants/permissions';
import { hashingPassword } from '../utils/utils';
import { deleteImageS3, uploadImageS3 } from '../utils/upload_image';
import { ImageDirs } from '../constants/images_keys';
import { sendLocalizedNotificationToAllUsers } from '../utils/notification';
import { redisKeys } from '../constants/redis_keys';
import { Prisma } from '@prisma/client';

export const users = async (req: Request, res: Response) => {
  const { cursor, roleName, search } = req.body;

  const data = await prisma.profile.findMany({
    cursor: cursor ? { id: cursor } : undefined,
    skip: cursor ? 1 : undefined,
    take: 15,
    where: {
      role: roleName ? { roleName } : undefined,
      ...(search
        ? {
            OR: [
              { name: { contains: search, mode: 'insensitive' } },
              { email: { contains: search, mode: 'insensitive' } },
              { phoneNumber: { contains: search, mode: 'insensitive' } },
            ],
          }
        : undefined),
    },
    orderBy: { id: 'desc' },
    include: {
      role: true,
      permissions: { include: { permission: true } },
      company: {
        select: {
          id: true,
          image: true,
          contact: true,
          international: true,
          name: true,
          desc: true,
          available: true,
          ...locationQueyry,
          ...contactsQuery,
          activeDate: true,
          expiresAt: true,
          rate: true,
          review: true,
          location: {
            include: {
              city: true,
              town: true,
            },
          },
        },
      },
    },
  });
  res.status(200).json(data);
};

export const permissions = async (req: Request, res: Response) => {
  const data = await prisma.permission.findMany({});
  res.status(200).json(data);
};
export const updateUserRole = async (req: Request, res: Response) => {
  const { userId, role, permissions }: Payload.UpdateUserRolePayload = req.body;

  var neRole: AdminPermissions;

  if (role === 'admin') {
    const updateRole = await prisma.$transaction(async (tx) => {
      const adminRole = await tx.role.findFirst({
        where: { roleName: 'admin' },
      });
      const currentUser = await tx.profile.findFirst({ where: { userId } });
      if (!currentUser) {
        throw new Exception(404, 'user_not_found');
      }
      const allPermissions = await tx.permission.findMany({
        where: { permissionId: { in: permissions! } },
      });

      const newRole = await tx.profile.update({
        where: { userId },
        data: {
          role: { connect: { roleId: adminRole?.roleId } },
          permissions: {
            deleteMany: { userId },
            upsert: allPermissions.map((perm) => ({
              where: {
                userId_permissionId: {
                  userId: userId,
                  permissionId: perm.permissionId,
                },
              },
              update: { permissionId: perm.permissionId },
              create: { permissionId: perm.permissionId },
            })),
          },
        },
        select: { role: true, permissions: { select: { permission: true } } },
      });

      neRole = newRole;
    });
  } else {
    await prisma.$transaction(async (tx) => {
      const currentUser = await tx.profile.findFirst({ where: { userId } });
      if (!currentUser) {
        throw new Exception(404, 'user_not_found');
      }
      const userRole = await tx.role.findFirst({ where: { roleName: 'user' } });

      if (!userRole) {
        throw new Exception(404, 'user_not_found');
      }
      const newRole = await tx.profile.update({
        where: { userId },
        data: {
          permissions: { deleteMany: { userId } },
          role: { connect: { roleId: userRole.roleId } },
        },
        select: { role: true, permissions: { select: { permission: true } } },
      });
      neRole = newRole;
    });
  }

  res.status(200).end();

  Promise.all([
    asyncWrap(() => redisClient.del(`role_${userId}`)),
    asyncWrap(() => setData(`role_${userId}`, neRole)),
  ]);
};

export const companies = async (req: Request, res: Response) => {
  const { cursor, expired }: Payload.CompaniesPayload = req.body;
  const data = await prisma.company.findMany({
    cursor: cursor ? { id: cursor } : undefined,
    skip: cursor ? 1 : undefined,
    take: 15,
    orderBy: { id: 'desc' },
    where: expired === true ? { expiresAt: { lte: new Date() } } : undefined,
    include: {
      ...profileQuery,
      ...contactsQuery,
      location: {
        include: {
          city: true,
          town: true,
        },
      },
    },
  });
  res.status(200).json(data);
};

export const allBooks = async (req: Request, res: Response) => {
  const { cursor, status, id, userId }: Payload.AllBooksPayload = req.body;

  const data = await prisma.book.findMany({
    cursor: cursor ? { id: cursor } : undefined,
    skip: cursor ? 1 : undefined,
    take: 15,
    orderBy: { id: 'desc' },
    where: { status: status ?? undefined, userId: userId ?? undefined },
    include: {
      rentalPlan: {
        select: { id: true, plan: true, price: true, periodType: true },
      },
      ...profileQuery,
      car: {
        include: carInclude({ withPromotion: false, withFeatured: false }),
      },
      company: {
        include: {
          ...locationQueyry,
          ...contactsQuery,
        },
      },
    },
  });
  res.status(200).json(data);
};

export const allCarReviews = async (req: Request, res: Response) => {
  const { userId, status, cursor } = req.body;
  const data = await prisma.carReview.findMany({
    cursor: cursor ? { id: cursor } : undefined,
    skip: cursor ? 1 : undefined,
    orderBy: { id: 'desc' },
    where: {
      userId: userId ?? undefined,
      status: status ?? undefined,
      deletedAt: null,
    },
    include: {
      company: true,
      ...profileQuery,
      car: { include: carInclude({ withPromotion: false }) },
    },
  });
  return res.status(200).json(data);
};

export const carReviewFlags = async (req: Request, res: Response) => {
  const { status, cursor } = req.body;
  const data = await prisma.carReviewFlag.findMany({
    cursor: cursor ? { id: cursor } : undefined,
    skip: cursor ? 1 : undefined,
    orderBy: { id: 'desc' },
    where: { status: 'flagged', deletedAt: null },
    include: {
      review: {
        include: {
          ...profileQuery,
        },
      },
      company: true,
      car: { include: carInclude({ withPromotion: false }) },
    },
  });
  return res.status(200).json(data);
};

export const allCompanyReviews = async (req: Request, res: Response) => {
  const { userId, status, cursor } = req.body;
  const data = await prisma.companyReview.findMany({
    cursor: cursor ? { id: cursor } : undefined,
    skip: cursor ? 1 : undefined,
    orderBy: { id: 'desc' },
    where: {
      userId: userId ?? undefined,
      status: status ?? undefined,
      deletedAt: null,
    },
    include: {
      ...profileQuery,
      company: {
        include: {
          ...profileQuery,
        },
      },
    },
  });
  return res.status(200).json(data);
};

export const companyReviewFlags = async (req: Request, res: Response) => {
  const { status, cursor } = req.body;
  const data = await prisma.companyReviewFlag.findMany({
    cursor: cursor ? { id: cursor } : undefined,
    skip: cursor ? 1 : undefined,
    orderBy: { id: 'desc' },
    where: { status: 'flagged', deletedAt: null },
    include: {
      company: true,
      review: {
        include: {
          ...profileQuery,
        },
      },
    },
  });
  return res.status(200).json(data);
};

export const allCars = async (req: Request, res: Response) => {
  const { cursor, id } = req.body;
  const data = await prisma.car.findMany({
    cursor: cursor ? { id: cursor } : undefined,
    skip: cursor ? 1 : undefined,
    take: 15,
    orderBy: { id: 'desc' },
    where: { carId: { contains: id, mode: 'insensitive' }, deletedAt: null },
    include: {
      ...carInclude({ withFeatured: false }),
      type: true,
      featuredCars: {
        where: {
          deletedAt: null,
          OR: [
            { until: { gte: new Date() } },
            { until: null },
            { startAt: { gte: new Date() } },
          ],
        },
      },
      location: {
        include: {
          city: true,
          town: true,
        },
      },
    },
  });
  const cars = data.map(({ featuredCars, ...car }) => ({
    ...car,
    featuredCars: featuredCars ?? null,
  }));
  res.status(200).json(cars);
};

export const companyStatuses = async (req: Request, res: Response) => {
  const { cursor, id } = req.body;
  const data = await prisma.companyStatus.findMany({
    cursor: cursor ? { id: cursor } : undefined,
    skip: cursor ? 1 : undefined,
    take: 15,
    orderBy: { id: 'desc' },
    where: { comanyId: id },
  });
  res.status(200).json(data);
};

export const newCompany = async (req: Request, res: Response) => {
  const { location, ...data }: Payload.CreateCompanyPayload = req.body;

  const updateLocation = async (
    tx: Prisma.TransactionClient,
    locationId: string,
  ) => {
    if (!location) return;

    await tx.$executeRaw`
      UPDATE "location"."location"
      SET "pglocation" = ST_SetSRID(ST_MakePoint(${location.long}, ${location.lat}), 4326)::geography
      WHERE "id" = ${locationId}
    `;
  };

  const companyPlans =
    data.activeDate && data.expiresAt
      ? {
          create: {
            activeDate: data.activeDate,
            expiresAt: data.expiresAt,
          },
        }
      : undefined;

  if (!data.id) {
    if (!data.userId || !data.name || !data.activeDate || !data.expiresAt) {
      throw new Exception(400, 'GE');
    }
  }

  const newTRX = await prisma.$transaction(async (tx) => {
    const company = data.id
      ? await tx.company.update({
          where: { id: data.id },
          data: {
            name: data.name ?? undefined,
            desc: data.desc ?? undefined,
            activeDate: data.activeDate ?? undefined,
            expiresAt: data.expiresAt ?? undefined,
            companyPlans,
            available: data.available ?? undefined,
            international: data.international ?? undefined,
            delivery: data.delivery ?? undefined,
            contact: data.contact ?? undefined,
            location: location
              ? {
                  update: {
                    lat: location.lat ?? undefined,
                    long: location.long ?? undefined,
                    townId: location.townId ?? null,
                    cityId: location.cityId ?? undefined,
                  },
                }
              : undefined,
          },
          include: {
            location: true,
            profile: {
              select: {
                name: true,
                prefLang: true,
                sessions: { select: { sessionId: true } },
              },
            },
          },
        })
      : await tx.company.create({
          data: {
            userId: data.userId!,
            name: data.name!,
            desc: data.desc,
            activeDate: new Date(),
            expiresAt: data.expiresAt!,
            companyPlans: companyPlans!,
            available: data.available ?? undefined,
            international: data.international ?? undefined,
            location: location
              ? {
                  create: {
                    lat: location.lat!,
                    long: location.long!,
                    townId: location.townId ?? undefined,
                    cityId: location.cityId ?? undefined,
                  },
                }
              : undefined,
          },
          include: {
            location: true,
            profile: {
              select: {
                name: true,
                prefLang: true,
                sessions: {
                  select: { sessionId: true },
                  orderBy: { id: 'desc' },
                  take: 1,
                },
              },
            },
          },
        });

    if (company.location && location) {
      await updateLocation(tx, company.location.id);
    }
    return company;
  });

  if (newTRX.profile?.sessions) {
    newTRX.profile.sessions.map(async (session) => {
      await asyncWrap(() =>
        redisClient.del(`${redisKeys.user}_${session.sessionId}`),
      );
    });
  }

  res.status(200).end(newTRX.id);
};

export const updateCompnayStatus = async (req: Request, res: Response) => {
  const { id, companyId, status, reason } = req.body;
  const data = await prisma.$transaction(async (tx) => {
    const company = await tx.companyStatus.findUnique({ where: { id } });
    if (!company) throw new Error('company_not_found');
    if (company.status === status) {
      throw new Error('same_status');
    }

    await tx.company.update({
      where: { id: companyId },
      data: { available: status === 'live' ? true : false },
    });

    const result = await tx.companyStatus.upsert({
      where: { id },
      create: { status, reason },
      update: { status, reason: reason ?? undefined },
      select: { id: true },
    });

    return result.id;
  });
  res.status(200).json(data);
};

export const banUser = async (req: Request, res: Response) => {
  const {
    id,
    userId,
    title,
    description,
    bannedUntil,
  }: Payload.BanUserPayload = req.body;

  const data = await prisma.accountStatus.upsert({
    where: { id: id ?? '' },
    create: {
      userId: userId!,
      description: description!,
      bannedUntil: bannedUntil!,
      title: title!,
    },
    update: { description, bannedUntil, title },
  });
  res.status(200).json(data.id);
};

export const deleleteBan = async (req: Request, res: Response) => {
  const { id } = req.body;
  const data = await prisma.accountStatus.delete({ where: { id } });
  res.status(200).json(data.id);
};

export const bannedUsers = async (req: Request, res: Response) => {
  const { cursor, userId } = req.body;
  const data = await prisma.accountStatus.findMany({
    cursor: cursor ? { id: cursor } : undefined,
    skip: cursor ? 1 : undefined,
    take: 15,
    orderBy: { id: 'desc' },
    where: { userId },
    include: {
      profile: {
        include: {
          role: true,
          permissions: { select: { permission: true } },
          company: true,
        },
      },
    },
  });
  const users = data.map((user) => user.profile);
  res.status(200).json(users);
};
export const accountStatuses = async (req: Request, res: Response) => {
  const { cursor, userId } = req.body;
  const data = await prisma.accountStatus.findMany({
    cursor: cursor ? { id: cursor } : undefined,
    skip: cursor ? 1 : undefined,
    take: 15,
    orderBy: { id: 'desc' },
    where: { userId },
  });
  res.status(200).json(data);
};

export const updateCarReview = async (req: Request, res: Response) => {
  const { id, status }: Payload.UpdateReviewPayload = req.body;
  const trx = await prisma.$transaction(async (tx) => {
    const previousReview = await tx.carReview.findFirst({
      where: { id },
    });
    if (!previousReview) {
      throw new Exception(400, 'car_review_not_exist');
    }
    if (previousReview.status === status) {
      throw new Exception(400, 'same_status');
    }

    if (status === 'accepted') {
      await tx.carReview.update({
        where: { id },
        data: {
          status,
          CarReviewFlag: { update: { status: status } },
        },
      });
    }
    if (status === 'deleted') {
      await tx.carReview.update({
        where: { id },
        data: { status: 'deleted', deletedAt: new Date() },
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
    }
  });
  res.status(200).end();
};

export const updateCompanyReview = async (req: Request, res: Response) => {
  const { id, status }: Payload.UpdateReviewPayload = req.body;

  const trx = await prisma.$transaction(async (tx) => {
    const previousReview = await tx.companyReview.findFirst({
      where: { id },
    });

    if (!previousReview) {
      throw new Exception(400, 'car_review_not_exist');
    }
    if (previousReview.status === status) {
      throw new Exception(400, 'same_status');
    }

    if (status === 'accepted') {
      await tx.companyReview.update({
        where: { id },
        data: { status },
      });
    }
    if (status === 'deleted') {
      await tx.companyReview.update({
        where: { id },
        data: { status: 'deleted', deletedAt: new Date() },
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
    }
  });
  res.status(200).end();
};

export const brands = async (req: Request, res: Response) => {
  const data = await prisma.brand.findMany({
    orderBy: { sort: 'asc' },
    where: { deletedAt: null },
  });
  res.status(200).json(data);
};

export const newBrand = async (req: Request, res: Response) => {
  const { id, ...data }: Payload.NewBrandPayload = req.body;

  const file = req.file;
  var newImage;

  if (file) {
    const [err, images] = await asyncWrap(() =>
      uploadImageS3(file, ImageDirs.contact),
    );
    newImage = images;
  }

  const image = newImage ? newImage : undefined;
  var oldImage;
  const trx = await prisma.$transaction(async (tx) => {
    if (id) {
      const brand = await tx.brand.findFirst({ where: { id } });
      if (!brand) {
        throw new Exception(404, 'GE');
      }
      const updated = await tx.brand.update({
        where: { id },
        data: {
          en: data.en ?? undefined,
          ar: data.ar ?? undefined,
          ku: data.ku ?? undefined,
          available: data.available ?? undefined,
          image,
        },
      });
      oldImage = brand.image;
      return updated;
    }
    const maxId = await tx.brand.aggregate({
      _max: { sort: true },
      where: { deletedAt: null },
    });
    const sort = maxId._max.sort ? maxId._max.sort + 1 : 1;
    const ct = await prisma.brand.create({
      data: {
        en: data.en!,
        ar: data.ar!,
        ku: data.ku!,
        sort,
        available: data.available ?? true,
      },
    });
    return ct;
  });
  res.status(200).json({ id: trx.id, image });
  if (file && oldImage) {
    await asyncWrap(() => deleteImageS3(oldImage!));
  }
};

export const deleteBrand = async (req: Request, res: Response) => {
  const { id } = req.body;
  const brand = await prisma.brand.update({
    where: { id },
    data: { deletedAt: new Date() },
  });
  return res.status(200).end();
};

export const sortBrands = async (req: Request, res: Response) => {
  const data: Payload.SortPayload = req.body;

  await prisma.$transaction(
    data.map((c) =>
      prisma.brand.update({
        where: { id: c.id },
        data: { sort: c.sort },
      }),
    ),
  );

  return res.status(200).end();
};

export const cities = async (req: Request, res: Response) => {
  const data = await prisma.city.findMany({
    orderBy: { sort: 'asc' },
    where: { deletedAt: null },
    include: {
      towns: {
        where: { deletedAt: null },
        orderBy: { sort: 'asc' },
        select: {
          available: true,
          id: true,
          en: true,
          ar: true,
          ku: true,
          lat: true,
          long: true,
          sort: true,
          cityId: true,
        },
      },
    },
  });
  res.status(200).json(data);
};

export const newCity = async (req: Request, res: Response) => {
  const { id, ...data }: Payload.NewCityPayload = req.body;

  const updateLocation = async (tx: Prisma.TransactionClient, id: string) => {
    if (!data.lat || !data.long) return;
    await tx.$executeRaw`
      UPDATE "location"."city"
      SET "pglocation" = ST_SetSRID(ST_MakePoint(${data.long}, ${data.lat}), 4326)::geography
      WHERE "id" = ${id}
    `;
  };

  const trx = await prisma.$transaction(async (tx) => {
    if (id) {
      const updated = await tx.city.update({
        where: { id },
        data: {
          en: data.en ?? undefined,
          ar: data.ar ?? undefined,
          ku: data.ku ?? undefined,
          available: data.available ?? undefined,
          lat: data.lat ?? undefined,
          long: data.long ?? undefined,
        },
      });
      if (data.lat && data.long) {
        await updateLocation(tx, updated.id);
      }
      return updated;
    }
    const maxId = await tx.city.aggregate({
      _max: { sort: true },
      where: { deletedAt: null },
    });
    const sort = maxId._max.sort ? maxId._max.sort + 1 : 1;
    const ct = await prisma.city.create({
      data: {
        en: data.en!,
        ar: data.ar!,
        ku: data.ku!,
        available: data.available ?? true,
        sort,
        lat: data.lat ?? undefined,
        long: data.long ?? undefined,
      },
    });
    if (data.lat && data.long) {
      await updateLocation(tx, ct.id);
    }
    return ct;
  });

  return res.status(200).end(trx.id);
};

export const deleteCity = async (req: Request, res: Response) => {
  const { id } = req.body;
  await prisma.city.update({
    where: { id },
    data: { deletedAt: new Date() },
  });
  return res.status(200).end();
};

export const sortCity = async (req: Request, res: Response) => {
  const data: Payload.SortPayload = req.body;

  await prisma.$transaction(
    data.map((c) =>
      prisma.city.update({
        where: { id: c.id },
        data: { sort: c.sort },
      }),
    ),
  );

  return res.status(200).end();
};

export const newTown = async (req: Request, res: Response) => {
  const { id, ...data }: Payload.NewTownPayload = req.body;

  const updateLocation = async (tx: Prisma.TransactionClient, id: string) => {
    if (!data.lat || !data.long) return;
    await tx.$executeRaw`
      UPDATE "location"."town"
      SET "pglocation" = ST_SetSRID(ST_MakePoint(${data.long}, ${data.lat}), 4326)::geography
      WHERE "id" = ${id}
    `;
  };

  const trx = await prisma.$transaction(async (tx) => {
    if (id) {
      const updated = await tx.town.update({
        where: { id },
        data: {
          en: data.en ?? undefined,
          ar: data.ar ?? undefined,
          ku: data.ku ?? undefined,
          available: data.available ?? undefined,
        },
      });
      if (data.lat && data.long) {
        await updateLocation(tx, updated.id);
      }
      return updated;
    }
    const maxId = await tx.town.aggregate({
      _max: { sort: true },
      where: { deletedAt: null },
    });
    const sort = maxId._max.sort ? maxId._max.sort + 1 : 1;
    const ct = await prisma.town.create({
      data: {
        en: data.en!,
        ar: data.ar!,
        ku: data.ku!,
        available: data.available ?? true,
        cityId: data.cityId!,
        sort,
        lat: data.lat ?? undefined,
        long: data.long ?? undefined,
      },
    });
    if (data.lat && data.long) {
      await updateLocation(tx, ct.id);
    }
    return ct;
  });
  return res.status(200).end(trx.id);
};

export const deleteTown = async (req: Request, res: Response) => {
  const { id } = req.body;
  await prisma.town.update({
    where: { id },
    data: { deletedAt: new Date() },
  });
  return res.status(200).end();
};

export const sortTown = async (req: Request, res: Response) => {
  const data: Payload.SortPayload = req.body;

  await prisma.$transaction(
    data.map((c) =>
      prisma.town.update({
        where: { id: c.id },
        data: { sort: c.sort },
      }),
    ),
  );

  return res.status(200).end();
};

export const carTypes = async (req: Request, res: Response) => {
  const data = await prisma.carType.findMany({
    orderBy: { sort: 'asc' },
    where: { deletedAt: null },
  });
  res.status(200).json(data);
};

export const newCarType = async (req: Request, res: Response) => {
  const { id, ...data }: Payload.NewCarTypePayload = req.body;
  const newCarType = await prisma.$transaction(async (tx) => {
    if (id) {
      const updated = await tx.carType.update({
        where: { id },
        data: {
          en: data.en ?? undefined,
          ar: data.ar ?? undefined,
          ku: data.ku ?? undefined,
          available: data.available ?? undefined,
        },
      });
      return updated;
    }
    const maxId = await tx.carType.aggregate({
      _max: { sort: true },
      where: { deletedAt: null },
    });
    const sort = maxId._max.sort ? maxId._max.sort + 1 : 1;
    const ct = await prisma.carType.create({
      data: {
        en: data.en!,
        ar: data.ar!,
        ku: data.ku!,
        available: data.available ?? true,
        sort,
      },
    });
    return ct;
  });
  return res.status(200).end(newCarType.id);
};

export const deleteCarType = async (req: Request, res: Response) => {
  const { id } = req.body;
  await prisma.carType.update({
    where: { id },
    data: { deletedAt: new Date() },
  });
  return res.status(200).end();
};

export const sortCarType = async (req: Request, res: Response) => {
  const data: Payload.SortPayload = req.body;

  await prisma.$transaction(
    data.map((c) =>
      prisma.carType.update({
        where: { id: c.id },
        data: { sort: c.sort },
      }),
    ),
  );

  return res.status(200).end();
};

export const supports = async (req: Request, res: Response) => {
  const data = await prisma.support.findMany({
    orderBy: { sort: 'asc' },
  });
  res.status(200).json(data);
};

export const newSupport = async (req: Request, res: Response) => {
  const { id, ...data }: Payload.NewSupportPayload = req.body;

  const file = req.file;
  var newImage;

  if (file) {
    const [err, images] = await asyncWrap(() =>
      uploadImageS3(file, ImageDirs.contact),
    );
    newImage = images;
  }

  const image = newImage ? newImage : undefined;
  var oldImage;

  if (id) {
    const contact = await prisma.support.findFirst({ where: { id } });
    if (!contact) {
      throw new Exception(404, 'GE');
    }
    const update = await prisma.support.update({
      where: { id },
      data: {
        ku: data.ku ?? undefined,
        ar: data.ar ?? undefined,
        en: data.en ?? undefined,
        content: data.content ?? undefined,
        image,
      },
    });
    oldImage = contact.image;
    res.status(200).json({ image });

    return;
  }

  const sort = await prisma.support.aggregate({ _max: { sort: true } });
  const contact = await prisma.support.create({
    data: {
      en: data.en!,
      ku: data.ku!,
      ar: data.ar!,
      content: data.content!,
      image,
      sort: sort._max.sort ? sort._max.sort + 1 : 1,
    },
  });

  res.status(200).json({ id: contact.id, image });
  if (file && oldImage) {
    await asyncWrap(() => deleteImageS3(oldImage!));
  }
};

export const deleteSupport = async (req: Request, res: Response) => {
  const { id } = req.body;
  const contact = await prisma.support.update({
    where: { id },
    data: { deletedAt: new Date() },
  });

  return res.status(200).end();
};

export const sortSupport = async (req: Request, res: Response) => {
  const data: Payload.SortPayload = req.body;

  await prisma.$transaction(
    data.map((c) =>
      prisma.support.update({
        where: { id: c.id },
        data: { sort: c.sort },
      }),
    ),
  );

  return res.status(200).end();
};

export const featuredCars = async (req: Request, res: Response) => {
  const data = await prisma.featuredCars.findMany({
    orderBy: { sort: 'asc' },
    where: { deletedAt: null },
    include: {
      car: {
        include: {
          ...carInclude({
            withLocation: false,
            withBrand: false,
            withCompany: false,
            withFeatured: false,
          }),
          feature: true,
        },
      },
      company: { select: { id: true, name: true } },
    },
  });

  const shaped = data.map((f) => {
    if (!f.car) return null;
    return {
      ...f.car,
      company: f.company,
      featuredCars: f,
    };
  });

  res.status(200).json(shaped);
};

export const newFeatureCar = async (req: Request, res: Response) => {
  const { id, ...data }: Payload.FeaturedCarsPayload = req.body;

  const trx = await prisma.$transaction(async (tx) => {
    if (id) {
      const car = await tx.featuredCars.findFirst({ where: { id } });
      if (!car) {
        throw new Exception(404, 'GE');
      }
      const updated = await tx.featuredCars.update({
        where: { id },
        data: {
          startAt: data.startAt ?? undefined,
          until: data.until ?? undefined,
        },
      });
      return updated;
    }
    const maxId = await tx.featuredCars.aggregate({
      _max: { sort: true },
      where: { deletedAt: null },
    });
    const sort = maxId._max.sort ? maxId._max.sort + 1 : 1;
    const ct = await prisma.featuredCars.create({
      data: {
        carId: data.carId!,
        companyId: data.companyId!,
        startAt: data.startAt ?? undefined,
        until: data.until ?? undefined,
        sort,
      },
    });
    await tx.car.update({
      where: { id: data.carId! },
      data: { pinned: true, pinnedSort: sort },
    });
    return ct;
  });

  res.status(200).json(trx.id);
};

export const deleteFeaturedCars = async (req: Request, res: Response) => {
  const { id } = req.body;

  await prisma.$transaction(async (tx) => {
    const car = await prisma.featuredCars.delete({
      where: { id },
      select: { car: { select: { id: true } } },
    });

    await tx.car.update({
      where: { id: car.car?.id },
      data: { pinned: false, pinnedSort: null },
    });
  });
  return res.status(200).end();
};

export const sortFeaturedCars = async (req: Request, res: Response) => {
  const data: Payload.SortPayload = req.body;

  await prisma.$transaction(
    data.map((c) =>
      prisma.featuredCars.update({
        where: { id: c.id },
        data: { sort: c.sort, car: { update: { pinnedSort: c.sort } } },
      }),
    ),
  );
  return res.status(200).end();
};

export const sliders = async (req: Request, res: Response) => {
  const data = await prisma.slider.findMany({
    orderBy: { sort: 'asc' },
  });
  res.status(200).json(data);
};

export const newSlider = async (req: Request, res: Response) => {
  const { id, ...data }: Payload.NewSliderPayload = req.body;

  const file = req.file;
  var newImage;

  if (file) {
    const [err, images] = await asyncWrap(() =>
      uploadImageS3(file, ImageDirs.slider),
    );
    newImage = images;
  }

  const image = newImage ? newImage : undefined;
  var oldImage;

  if (id) {
    const contact = await prisma.slider.findFirst({ where: { id } });
    if (!contact) {
      throw new Exception(404, 'GE');
    }
    const update = await prisma.slider.update({
      where: { id },
      data: {
        available: data.available ?? undefined,
        carId: data.carId ?? undefined,
        url: data.url ?? undefined,
        companyId: data.companyId ?? undefined,
        image,
      },
    });
    oldImage = contact.image;
    res.status(200).end();
  } else {
    const sort = await prisma.slider.aggregate({ _max: { sort: true } });
    const slider = await prisma.slider.create({
      data: {
        available: data.available ?? true,
        carId: data.carId ?? undefined,
        companyId: data.companyId ?? undefined,
        url: data.url ?? undefined,
        type: data.type,
        image,
        sort: sort._max.sort ? sort._max.sort + 1 : 1,
      },
    });

    res.status(200).end();
  }
  if (file && oldImage) {
    await asyncWrap(() => deleteImageS3(oldImage!));
  }
};

export const deleteSlider = async (req: Request, res: Response) => {
  const { id } = req.body;
  await prisma.slider.update({
    where: { id },
    data: { deletedAt: new Date() },
  });

  return res.status(200).end();
};

export const sortSlider = async (req: Request, res: Response) => {
  const data: Payload.SortPayload = req.body;

  await prisma.$transaction(
    data.map((c) =>
      prisma.slider.update({
        where: { id: c.id },
        data: { sort: c.sort },
      }),
    ),
  );

  return res.status(200).end();
};

export const newNotification = async (req: Request, res: Response) => {
  const { id, notify, ...notification } = req.body;
  const data = await prisma.notification.create({ data: notification });
  await asyncWrap(() => sendLocalizedNotificationToAllUsers(notification));
  res.status(200).json(data.id);
};

export const deleteNotification = async (req: Request, res: Response) => {
  const { id } = req.body;
  await prisma.notification.delete({ where: { id } });
  return res.status(200).end();
};

export const updateUserPassword = async (req: Request, res: Response) => {
  const { userId, password } = req.body;

  const user = await prisma.user.findFirst({ where: { userId } });

  if (!user) {
    throw new Exception(404, 'GE');
  }

  const [hashedPasswordError, hashedPassword] = await asyncWrap(() =>
    hashingPassword(password),
  );

  if (hashedPasswordError || !hashedPassword) {
    throw new Exception(403, 'GE');
  }

  const usr = await prisma.user.update({
    where: { userId },
    data: { password: hashedPassword },
    select: { id: true },
  });

  await prisma.$transaction(async (tx) => {
    const allSessions = await tx.session.findMany({
      where: { userId },
    });
    if (allSessions) {
      const sessions = allSessions.map((sessions) => sessions.sessionId);
      if (sessions)
        sessions.forEach((sessionId) => {
          if (sessionId != null) {
            redisClient.del(`sess:${sessionId}`);
          }
        });
    }
    await tx.session.updateMany({
      where: { userId: userId },
      data: { deletedAt: new Date() },
    });
  });

  return res.status(200).end();
};

export const recoverAccount = async (req: Request, res: Response) => {
  const { userId } = req.body;
  await prisma.user.update({
    where: { userId },
    data: { deletedAt: null },
    select: { id: true },
  });
  res.status(200).end();
};

export const statistics = async (req: Request, res: Response) => {
  const { date } = req.body;

  const now = date ? new Date(date) : new Date();
  const currentYear = date ? new Date(date).getFullYear() : now.getFullYear();

  const totalUserPerMonth = prisma.$queryRaw`
      SELECT EXTRACT(MONTH FROM "user"."profile"."joinedAt") AS month,
        COUNT("user"."profile"."userId")::int AS total
      FROM "user"."profile"
      WHERE EXTRACT(YEAR FROM "user"."profile"."joinedAt") = ${currentYear}

      GROUP BY EXTRACT(MONTH FROM "user"."profile"."joinedAt")
      ORDER BY month DESC;
      `;

  const totalUserPerYear = prisma.$queryRaw`select EXTRACT(YEAR FROM "user"."profile"."joinedAt") as year,COUNT("user"."profile"."userId")::int as total FROM "user"."profile" GROUP BY EXTRACT(YEAR FROM "user"."profile"."joinedAt") order by "year" desc`;

  const totalCompaniesPerMonth = prisma.$queryRaw`
      SELECT EXTRACT(MONTH FROM "company"."company"."joinedAt") AS month,
        COUNT("company"."company"."serial")::int AS total
      FROM "company"."company"
      WHERE EXTRACT(YEAR FROM "company"."company"."joinedAt") = ${currentYear}

      GROUP BY EXTRACT(MONTH FROM "company"."company"."joinedAt")
      ORDER BY month DESC;
      `;

  const totallCompaniesPerYear = prisma.$queryRaw`select EXTRACT(YEAR FROM "company"."company"."joinedAt") as year,COUNT("company"."company"."serial")::int as total FROM "company"."company" GROUP BY EXTRACT(YEAR FROM "company"."company"."joinedAt") order by "year" desc`;

  const totalCarsPerMonth = prisma.$queryRaw`
      SELECT EXTRACT(MONTH FROM "car"."car"."listedAt") AS month,
        COUNT("car"."car"."id")::int AS total
      FROM "car"."car"
      WHERE EXTRACT(YEAR FROM "car"."car"."listedAt") = ${currentYear}
      AND "car"."car"."deletedAt" IS  NULL

      GROUP BY EXTRACT(MONTH FROM "car"."car"."listedAt")
      ORDER BY month DESC;
      `;

  const totallCarsPerYear = prisma.$queryRaw`select EXTRACT(YEAR FROM "car"."car"."listedAt") as year,
    COUNT("car"."car"."listedAt")::int as total
    FROM "car"."car"
    WHERE "car"."car"."deletedAt" IS NULL
    GROUP BY EXTRACT(YEAR FROM "car"."car"."listedAt") order by "year" desc`;

  const totalcar = prisma.car.aggregate({
    _count: { id: true },
    where: { deletedAt: null },
  });

  const totalReservation = prisma.book.aggregate({
    _count: { id: true },
  });

  const totalPendingReservation = prisma.book.aggregate({
    _count: { id: true },
    where: { status: 'pending' },
  });
  const totalOngoinReservation = prisma.book.aggregate({
    _count: { id: true },
    where: { status: 'ongoing' },
  });

  const totalCompletedReservation = prisma.book.aggregate({
    _count: { id: true },
    where: { status: 'completed' },
  });

  const totalCanceledReservation = prisma.book.aggregate({
    _count: { id: true },
    where: { status: 'completed' },
  });

  const [
    totalUserPerMonths,
    totalUserPerYears,
    totalCompaniesPerMonths,
    totallCompaniesPerYears,
    totalReservations,
    totalPendingReservations,
    totalOngoinReservations,
    totalCompletedReservations,
    totalCanceledReservations,
    totalCarsPerMonths,
    totallCarsPerYears,
    totalcars,
  ] = await Promise.all([
    totalUserPerMonth,
    totalUserPerYear,
    totalCompaniesPerMonth,
    totallCompaniesPerYear,
    totalReservation,
    totalPendingReservation,
    totalOngoinReservation,
    totalCompletedReservation,
    totalCanceledReservation,
    totalCarsPerMonth,
    totallCarsPerYear,
    totalcar,
  ]);

  const data = {
    totalUserPerMonths,
    totalUserPerYears,
    totalCompaniesPerMonths,
    totallCompaniesPerYears,
    totalReservations: totalReservations._count.id ?? 0,
    totalPendingReservations: totalPendingReservations._count.id ?? 0,
    totalOngoinReservations: totalOngoinReservations._count.id ?? 0,
    totalCompletedReservations: totalCompletedReservations._count.id ?? 0,
    totalCanceledReservations: totalCanceledReservations._count.id ?? 0,
    totalCarsPerMonths,
    totallCarsPerYears,
    totalcars: totalcars._count.id ?? 0,
  };

  res.status(200).json(data);
};

export const companyStatistics = async (req: Request, res: Response) => {
  const { date } = req.body;
  const now = new Date();
  const currentYear = date ? new Date(date).getFullYear() : now.getFullYear();

  if (date && isNaN(new Date(date).getTime())) {
    return res.status(400).json('Invalid date format');
  }

  const stats = await prisma.$queryRaw<
    {
      company: {
        id: string;
        name: string;
        image: string | null;
        total: number;
      };
      types: {
        type: string;
        data: { month: number; count: number }[];
        total: number;
      }[];
    }[]
  >`
      WITH monthly_stats AS (
        SELECT
          cs."companyId",
          cs."type",
          EXTRACT(MONTH FROM cs."createdAt")::int AS month,
          COUNT(*) AS count
        FROM "company"."contactStatistic" cs
        WHERE cs."createdAt" >= ${new Date(currentYear, 0, 1)}
          AND cs."createdAt" < ${new Date(currentYear + 1, 0, 1)}
        GROUP BY cs."companyId", cs."type", EXTRACT(MONTH FROM cs."createdAt")
      ),
      type_stats AS (
        SELECT
          ms."companyId",
          ms."type",
          json_build_object(
            'type', ms."type",
            'data', json_agg(
              json_build_object(
                'month', ms.month,
                'count', ms.count
              ) ORDER BY ms.month
            ),
            'total', SUM(ms.count)
          ) AS type_data
        FROM monthly_stats ms
        GROUP BY ms."companyId", ms."type"
      ),
      company_stats AS (
        SELECT
          ts."companyId",
          json_agg(ts.type_data) AS types,
          SUM((ts.type_data->>'total')::bigint) AS company_total
        FROM type_stats ts
        GROUP BY ts."companyId"
      )
      SELECT
        json_build_object(
          'id', c.id,
          'name', c.name,
          'image', c.image,
          'total', COALESCE(cs.company_total, 0)
        ) AS company,
        COALESCE(cs.types, '[]'::json) AS types
      FROM "company"."company" c
      LEFT JOIN company_stats cs ON cs."companyId" = c.id
      ORDER BY c.name;
    `;

  res.status(200).json(stats);
};
const locationQueyry = {
  location: {
    select: {
      lat: true,
      long: true,
      city: { select: { en: true, ar: true, ku: true } },
      town: { select: { en: true, ar: true, ku: true } },
    },
  },
};

const contactsQuery = {
  contacts: {
    select: { value: true, countrCode: true },
    where: { deletedAt: null },
  },
};

const profileQuery = {
  profile: {
    select: {
      userId: true,
      name: true,
      serial: true,
      phoneNumber: true,
      email: true,
      image: true,
      role: true,
      permissions: { select: { permission: true } },
    },
  },
};
