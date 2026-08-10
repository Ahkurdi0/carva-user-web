import { Request, Response } from 'express';
import { handleLogin, handleSignUp } from '../helpers/auth';
import { refreshToken } from '../middleware/is_authenticated';
import { prisma } from '../config/prisma';
import { redisClient } from '../config/redis';
import { redisKeys } from '../constants/redis_keys';
import { Exception } from '../utils/exception';
import { comparePassword, hashingPassword } from '../utils/utils';
import { asyncWrap } from '../utils/async_wrap';
import { deleteImageS3, uploadImageS3 } from '../utils/upload_image';
import { ImageDirs } from '../constants/images_keys';

export const login = async (req: Request, res: Response) => {
  await handleLogin(req, res);
};

export const signup = async (req: Request, res: Response) => {
  await handleSignUp(req, res);
};

export const refreshingTokens = async (req: Request, res: Response) => {
  await refreshToken(req, res);
};

export const refresh = async (req: Request, res: Response) => {
  const { isCheking } = req.headers;
  const userId = req.userId;
  const sessionId = req.user?.sessionId;
  const user = await prisma.$transaction(async (tx) => {
    const user = await tx.profile.findUnique({
      where: { userId },
      omit: {
        deletedAt: true,
        id: true,
        joinedAt: true,
        platform: true,
        prefLang: true,
        roleId: true,
        serial: true,
      },
      include: {
        company: true,
        role: { select: { roleName: true } },
        permissions: { select: { permission: true } },
      },
    });
    if (isCheking && sessionId) {
      await tx.session.update({
        where: { sessionId },
        data: { lastLogin: new Date() },
      });
    }
    return user;
  });

  return res.status(200).json(user);
};

export const logout = async (req: Request, res: Response) => {
  const { allDevices } = req.body;
  const userId = req.user?.userId;
  try {
    if (allDevices) {
      const tex = prisma.$transaction(async (tx) => {
        const allSessions = await tx.session.findMany({
          where: { userId },
        });

        // Delete all Redis session caches (parallel)
        if (allSessions.length > 0) {
          await Promise.all(
            allSessions.map(async (session) => {
              await redisClient.del(`${redisKeys.user}_${session.sessionId}`);
            }),
          );
        }
        await tx.session.deleteMany({ where: { userId } });
      });

      return res.status(200).end();
    }

    // Optional: logout current session only (if all === false)
    const sessionId = req.user?.sessionId;
    if (sessionId) {
      await redisClient.del(`${redisKeys.user}_${sessionId}`);
      await prisma.session.delete({ where: { sessionId } });
    }
    return res.status(200).end();
  } catch (err) {
    throw new Exception(400, 'GE');
  }
};

export const updateName = async (req: Request, res: Response) => {
  const { name } = req.body;
  const userId = req.user?.userId;

  const oldUser = await prisma.profile.update({
    where: { userId },
    data: {
      name,
      activiyLog: {
        create: {
          action: 'change_name',
          details: name,
          ip: req.ip,
        },
      },
    },
    select: { name: true },
  });
  return res.status(200).end();
};

export const updatePassword = async (req: Request, res: Response) => {
  const { oldPassword, newPassword } = req.body;
  const userId = req.user?.userId;

  const user = await prisma.user.findUnique({
    where: { userId },
    select: { password: true },
  });

  if (!user) {
    throw new Exception(400, 'GE');
  }

  const compared = await comparePassword(oldPassword, user.password);

  if (!compared) {
    throw new Exception(400, 'incorrect_previous_password');
  }
  const newHashedPassword = await hashingPassword(newPassword);

  await prisma.$transaction(async (tx) => {
    await prisma.user.update({
      where: { userId },
      data: { password: newHashedPassword },
    });
    await tx.userActivityLog.create({
      data: {
        userId: userId!,
        action: 'change_password',
        details: newHashedPassword,
        ip: req.ip,
      },
    });
  });
  return res.status(200).end();
};

export const updatePhoneNumber = async (req: Request, res: Response) => {
  const { countryCode, phoneNumber } = req.body;

  const phonenumber = await prisma.profile.findUnique({
    where: { phoneNumber, countryCode },
  });

  if (phonenumber) {
    throw new Exception(403, 'phone_number_used');
  }
  const userId = req.userId;
  const updateProfile = await prisma.profile.update({
    where: { userId },
    data: {
      phoneNumber,
      countryCode,
      user: {
        update: {
          phoneNumber: phoneNumber,
          countryCode: countryCode,
        },
      },
      activiyLog: {
        create: {
          action: 'change_phone_number',
          details: phoneNumber,
          ip: req.ip,
        },
      },
    },
    select: { id: true },
  });
  return res.status(200).end();
};

export const updateProfilePicture = async (req: Request, res: Response) => {
  const userId = req.userId!;
  const file = req.file;

  if (!file) {
    throw new Exception(400, 'no_image_selected');
  }

  const currentUser = await prisma.profile.findUnique({
    where: { userId },
    select: { image: true },
  });

  if (!currentUser) throw new Exception(404, 'GE');

  const [uploadImageError, image] = await asyncWrap(() =>
    uploadImageS3(file, ImageDirs.profile),
  );

  if (uploadImageError || !image) {
    throw new Exception(400, 'GE');
  }

  if (currentUser.image !== null) {
    await asyncWrap(() => deleteImageS3(currentUser.image!));
  }

  await prisma.profile.update({
    where: { userId },
    select: { image: true },
    data: {
      image: image,
      activiyLog: {
        create: {
          action: 'change_profile_picture',
          details: image,
          ip: req.ip,
        },
      },
    },
  });

  return res.status(200).json({ imageUrl: image });
};

export const deleteAccount = async (req: Request, res: Response) => {
  const userId = req.user?.userId;
  const deletedAt = new Date();
  const user = await prisma.$transaction(async (tx) => {
    const user = await tx.user.update({
      where: { userId },
      data: { deletedAt, profile: { update: { deletedAt } } },
      select: { profile: true },
    });

    const allSessions = await tx.session.findMany({ where: { userId } });

    if (allSessions.length > 0) {
      await Promise.all(
        allSessions.map(async (session) => {
          await redisClient.del(`${redisKeys.user}_${session.sessionId}`);
        }),
      );
    }

    await tx.session.deleteMany({ where: { userId: userId } });
    return user.profile;
  });

  res.status(200).end();
};

export const updatePrefLang = async (req: Request, res: Response) => {
  const userId = req.userId;
  const { prefLang } = req.body;

  await prisma.profile.update({
    where: { userId },
    data: {
      prefLang,
      activiyLog: {
        create: {
          action: 'change_pref_lang',
          details: prefLang,
          ip: req.ip,
        },
      },
    },
  });
  return res.status(200).end();
};
