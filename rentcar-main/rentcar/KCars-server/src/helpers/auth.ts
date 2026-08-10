import { prisma } from '../config/prisma';
import { Auth, Session } from '../types/interfaces';
import { asyncWrap } from '../utils/async_wrap';
import { Request, Response, NextFunction } from 'express';
import { Exception } from '../utils/exception';

import {
  comparePassword,
  generateAccessToken,
  generateRefreshToken,
  hashingPassword,
  hashToken,
} from '../utils/utils';
import { generateUniqueId } from '../utils/uniuqe_id';

export const handleLogin = async (req: Request, res: Response) => {
  const user: Auth = req.body;

  const [findUserError, profile] = await asyncWrap(() =>
    findUserData(user.email),
  );

  if (findUserError || !profile) {
    throw new Exception(403, 'email_not_exist');
  }

  if (profile.deletedAt !== null) {
    throw new Exception(403, 'account_locked');
  }

  const [pswdError, hashedPassword] = await asyncWrap(() =>
    comparePassword(user.password!, profile.password),
  );

  if (pswdError || !hashedPassword) {
    throw new Exception(403, 'email_not_exist');
  }
  const sessionId = generateUniqueId();
  const accessToken = generateAccessToken({ sessionId });
  const refreshToken = generateRefreshToken({ sessionId });
  const hashedToken = hashToken(refreshToken);

  const newSesssion = {
    ...user.session,
    ip: req.ip,
    token: hashedToken,
    sessionId,
  };
  const [setSessionError, userSession] = await asyncWrap(() =>
    setSession(profile.userId, newSesssion),
  );

  if (setSessionError || !userSession) {
    throw new Exception(403, 'GE');
  }

  return res
    .status(201)
    .json({ ...profile.profile, accessToken, refreshToken });
};

export const handleSignUp = async (req: Request, res: Response) => {
  const devicelang = req.headers.devicelang as 'en' | 'ku' | 'ar' | null;

  const authData: Auth = req.body;

  const [error, emilExist] = await asyncWrap(() =>
    chekForUserEmail(authData.email),
  );

  if (error || emilExist) {
    throw new Exception(403, 'email_exist');
  }

  const phone = authData.phoneNumber;
  if (phone) {
    const [phoneErr, phoneExist] = await asyncWrap(() =>
      chekForUserPhone(phone, authData.countryCode ?? '+964'),
    );

    if (phoneErr || phoneExist) {
      throw new Exception(403, 'phone_number_used');
    }
  }

  const [hashedPasswordError, hashedPassword] = await asyncWrap(() =>
    hashingPassword(authData.password!),
  );

  if (hashedPasswordError || !hashedPassword) {
    throw new Exception(403, 'GE');
  }

  const newAuth: Auth = {
    name: authData.name,
    email: authData.email,
    password: hashedPassword,
    phoneNumber: authData.phoneNumber,
    countryCode: authData.countryCode,
    platForm: authData.platForm,
    prefLang: devicelang ?? 'en',
    userName: authData.userName,
  };

  const [userError, newUser] = await asyncWrap(() => createUser(newAuth));

  if (userError || !newUser || !newUser?.profile) {
    throw new Exception(400, 'accountt_creation_failed');
  }

  const sessionId = generateUniqueId();
  const accessToken = generateAccessToken({ sessionId });
  const refreshToken = generateRefreshToken({ sessionId });
  const hashedToken = hashToken(refreshToken);

  const newSesssion = {
    ...newAuth.session,
    ip: req.ip,
    token: hashedToken,
    sessionId,
  };

  const [setSessionError, userSession] = await asyncWrap(() =>
    setSession(newUser.userId, newSesssion),
  );

  if (setSessionError || !userSession) {
    throw new Exception(403, 'user cant be creaate', true);
  }

  return res
    .status(201)
    .json({ ...newUser.profile, accessToken, refreshToken });
};
export const findUserData = async (email: string) => {
  const user = await prisma.user.findFirst({
    omit: { serial: true },
    where: { email: email.toLocaleLowerCase() },
    include: {
      profile: {
        omit: {
          prefLang: true,
          deletedAt: true,
          roleId: true,
          serial: true,
          id: true,
        },
        include: {
          company: true,
          role: { select: { roleName: true } },
          permissions: { select: { permission: true } },
        },
      },
    },
  });

  return user;
};

export const createUser = async (auth: Auth) => {
  const { name, email, prefLang } = auth;

  const newUser = await prisma.$transaction(async (tx) => {
    const role = await tx.role.findFirst({ where: { roleName: 'user' } });

    const user = await tx.user.create({
      omit: { serial: true },
      data: {
        email: email.toLowerCase(),
        password: auth.password!,
        phoneNumber: auth.phoneNumber ?? undefined,
        userName: auth.userName,
        countryCode: auth.countryCode,
        platform: auth.session?.platform,
        profile: {
          create: {
            roleId: role!.roleId!,
            name,
            email,
            userName: auth.userName,
            countryCode: auth.countryCode,
            phoneNumber: auth.phoneNumber ?? undefined,
            prefLang,
            platform: auth.session?.platform,
          },
        },
      },
      include: {
        profile: {
          omit: {
            prefLang: true,
            deletedAt: true,
            roleId: true,
            serial: true,
          },
          include: {
            role: { select: { roleName: true } },
            permissions: { select: { permission: true } },
          },
        },
      },
    });

    return user;
  });

  return newUser;
};

export const chekForUserEmail = async (
  email: string,
): Promise<string | undefined> => {
  const existing = await prisma.user.findFirst({
    where: { email },
    select: { email: true },
  });
  return existing?.email;
};

export const chekForUserPhone = async (
  phoneNumber: string,
  countryCode: string,
): Promise<string | null> => {
  const existing = await prisma.user.findFirst({
    where: { phoneNumber, countryCode },
    select: { phoneNumber: true },
  });
  return existing?.phoneNumber ?? null;
};

export const setSession = async (userId: string, deviceInfo?: Session) => {
  const { isPhysicalDevice, ...devices } = deviceInfo!;

  const setToken = await prisma.session.upsert({
    where: { sessionId: userId },
    create: {
      isPhysicalDevice: `${isPhysicalDevice}`,
      sessionId: deviceInfo!.sessionId!,
      profile: { connect: { userId } },
      identifierForVendor: `${devices.identifierForVendor}`,
      localizedModel: `${devices.localizedModel}`,
      model: `${devices.model}`,
      name: `${devices.model}`,
      systemName: `${devices.systemName}`,
      systemVersion: `${devices.systemVersion}`,
      ip: deviceInfo?.ip,
      platform: deviceInfo?.platform,
      token: deviceInfo?.token,
    },
    update: {
      isPhysicalDevice: `${isPhysicalDevice}`,
      identifierForVendor: `${devices.identifierForVendor}`,
      localizedModel: `${devices.localizedModel}`,
      model: `${devices.model}`,
      name: `${devices.model}`,
      systemName: `${devices.systemName}`,
      systemVersion: `${devices.systemVersion}`,
      ip: deviceInfo?.ip,
      platform: deviceInfo?.platform,
      token: deviceInfo?.token,
    },
  });
  return true;
};
