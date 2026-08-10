import { prisma } from '../config/prisma';
import { getData, setData } from '../config/redis';
import { redisKeys } from '../constants/redis_keys';
import { IUSER } from '../types/interfaces';
import { generateUniqueId } from './uniuqe_id';
import { generateAccessToken, generateRefreshToken, hashToken } from './utils';

export const currentUser = async (sessionId: string): Promise<IUSER | null> => {
  const user = await getData<IUSER>(`${redisKeys.user}_${sessionId}`);

  if (user) {
    return user;
  }
  const session = await prisma.session.findUnique({
    where: { sessionId },
    include: {
      profile: {
        include: {
          company: {
            select: {
              id: true,
              userId: true,
              activeDate: true,
              expiresAt: true,
              available: true,
            },
          },
          role: true,
          accountInfo: true,
        },
      },
    },
  });
  if (!session) {
    return null;
  }
  if (session.profile) {
    const userDB = session.profile;
    const cuser: IUSER = {
      companyId: userDB?.company?.id ?? undefined,
      userId: userDB.userId,
      name: userDB.name,
      role: userDB.role.roleName,
      email: userDB.email,
      emailVerifiedAt: userDB.emailVerifiedAt,
      phoneVerifiedAt: userDB.phoneVerifiedAt,
      phoneNumber: userDB.phoneNumber,
      countryCode: userDB.countryCode,
      sessionId: sessionId,
      company: {
        companyOwnerId: userDB.company?.userId,
        companyId: userDB.company?.id ?? undefined,
        activeDate: userDB.company?.activeDate,
        expiresAt: userDB.company?.expiresAt,
        available: userDB.company?.available,
        expired:
          (userDB.company?.expiresAt &&
            userDB.company?.expiresAt < new Date()) ??
          true,
      },
      location: userDB.accountInfo
        ? {
            long: userDB?.accountInfo?.long ?? null,
            lat: userDB?.accountInfo?.lat ?? null,
          }
        : null,
    };
    await setData(`${redisKeys.user}_${sessionId}`, cuser, 604800);

    return cuser;
  }
  return null;
};

export const refreshingToken = async (
  sessionId: string,
  token: string,
): Promise<{ accessToken: string; refreshToken: string } | null> => {
  const session = await prisma.session.findUnique({
    where: { sessionId },
    include: {
      profile: {
        include: {
          role: true,
          company: {
            select: {
              id: true,
              userId: true,
              activeDate: true,
              expiresAt: true,
              available: true,
            },
          },
          accountInfo: true,
        },
      },
    },
  });

  if (!session) {
    return null;
  }

  if (session.token !== hashToken(token)) {
    return null;
  }
  const newSessionId = generateUniqueId();
  const accessToken = generateAccessToken({ sessionId: newSessionId });
  const refreshToken = generateRefreshToken({ sessionId: newSessionId });
  const newHashedToken = hashToken(refreshToken);

  const updating = await prisma.session.update({
    where: { sessionId: session.sessionId },
    data: {
      token: newHashedToken,
      sessionId: newSessionId,
      expiresAt: new Date(Date.now() + 1000 * 60 * 60 * 24 * 7),
    },
  });
  const userDB = session.profile;
  const cuser: IUSER = {
    companyId: userDB?.company?.id ?? undefined,
    userId: userDB.userId,
    name: userDB.name,
    role: userDB.role.roleName,
    email: userDB.email,
    emailVerifiedAt: userDB.emailVerifiedAt,
    phoneVerifiedAt: userDB.phoneVerifiedAt,
    phoneNumber: userDB.phoneNumber,
    countryCode: userDB.countryCode,
    sessionId: newSessionId,
    company: {
      companyOwnerId: userDB.company?.userId,
      companyId: userDB.company?.id ?? undefined,
      activeDate: userDB.company?.activeDate,
      expiresAt: userDB.company?.expiresAt,
      available: userDB.company?.available,
      expired:
        (userDB.company?.expiresAt && userDB.company?.expiresAt < new Date()) ??
        true,
    },
    location: userDB.accountInfo
      ? {
          long: userDB?.accountInfo?.long ?? null,
          lat: userDB?.accountInfo?.lat ?? null,
        }
      : null,
  };
  await setData(`${redisKeys.user}_${newSessionId}`, cuser, 604800);
  return { accessToken, refreshToken };
};
