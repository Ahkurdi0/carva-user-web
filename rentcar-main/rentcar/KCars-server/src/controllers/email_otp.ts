import { Request, Response } from 'express';
import { Exception } from '../utils/exception';
import { prisma } from '../config/prisma';
import { sendEmailVerificationCode } from '../utils/send_mail';
import { asyncWrap } from '../utils/async_wrap';
import { chekForUserEmail } from '../helpers/auth';
import { hashingPassword } from '../utils/utils';

const MAX_ATTEMP = 5;
export const resendEmailVerificationCode = async (
  req: Request,
  res: Response,
) => {
  const email = req.email;

  if (!email) {
    throw new Exception(404, 'email_not_exist');
  }

  const lastCode = await prisma.resetPassword.findFirst({
    where: { email },
    orderBy: { id: 'desc' },
  });

  const [error, emailExist] = await asyncWrap(() =>
    sendEmailVerificationCode(email, req.prefLang ?? 'en', req.ip),
  );
  if (error) {
    throw new Exception(400, 'send_otp_failed');
  }

  res.status(200).end();
};

export const verifyEmailAddress = async (req: Request, res: Response) => {
  const { email, code } = req.body;

  const userId = req.userId;
  const currentUserEmail = req.email;
  if (currentUserEmail !== email) {
    throw new Exception(400, 'incorrect_email');
  }
  const now = new Date();

  const update = await prisma.$transaction(async (tx) => {
    const findCode = await tx.resetPassword.findFirst({
      where: { email, type: 'email', verifyStatus: 'pending' },
      orderBy: { postedAt: 'desc' },
    });

    if (!findCode) {
      throw new Exception(403, 'email_code_invalid');
    }

    if (findCode.expireAt <= now || findCode.attempts >= MAX_ATTEMP) {
      throw new Exception(403, 'code_expired');
    }

    if (findCode.code !== code) {
      await tx.resetPassword.update({
        where: { id: findCode.id },
        data: { attempts: { increment: 1 } },
      });
      throw new Exception(403, 'email_code_invalid');
    }

    await tx.profile.update({
      where: { userId, email },
      data: { emailVerifiedAt: new Date() },
    });

    await tx.resetPassword.deleteMany({ where: { email } });
  });

  res.status(200).end();
};

export const sendEmailOtpCode = async (req: Request, res: Response) => {
  const { email } = req.body;

  const [err, emailExists] = await asyncWrap(() => chekForUserEmail(email));

  if (err || !emailExists) {
    throw new Exception(404, 'incorrect_email');
  }

  const devicelang = req.headers.devicelang as 'en' | 'ku' | 'ar' | null;

  const [otpError, otp] = await asyncWrap(() =>
    sendEmailVerificationCode(email, devicelang ?? 'en', req.ip),
  );

  if (otpError) {
    throw new Exception(403, 'send_otp_failed');
  }
  res.status(200).end();
};

export const verifyEmailOtpCode = async (req: Request, res: Response) => {
  const { email, code } = req.body;

  const now = new Date();
  const update = await prisma.$transaction(async (tx) => {
    const findCode = await tx.resetPassword.findFirst({
      where: { email, type: 'email', verifyStatus: 'pending' },
      orderBy: { id: 'desc' },
    });

    if (!findCode) {
      throw new Exception(403, 'email_code_invalid');
    }
    if (findCode.expireAt <= now || findCode.attempts >= MAX_ATTEMP) {
      throw new Exception(403, 'code_expired');
    }

    if (findCode.code !== code) {
      await tx.resetPassword.update({
        where: { id: findCode.id },
        data: { attempts: { increment: 1 } },
      });
      throw new Exception(403, 'email_code_invalid');
    }

    await tx.resetPassword.update({
      where: { id: findCode.id },
      data: { verifyStatus: 'verified' },
    });

    await tx.resetPassword.updateMany({
      where: {
        email,
        id: { not: findCode.id },
        verifyStatus: 'pending',
      },
      data: { verifyStatus: 'expired' },
    });
  });

  res.status(200).end();
};

export const emailResetPassword = async (req: Request, res: Response) => {
  const { email, password, code } = req.body;

  const [pswdError, hashedPassword] = await asyncWrap(() =>
    hashingPassword(password),
  );
  if (pswdError || !hashedPassword) {
    throw new Exception(403, 'GE');
  }

  const now = new Date();

  const reset = await prisma.$transaction(async (tx) => {
    const findCode = await tx.resetPassword.findFirst({
      where: { verifyStatus: 'verified', email },
      orderBy: { id: 'desc' },
    });

    if (!findCode || !findCode.email) {
      throw new Exception(403, 'code_expired');
    }

    if (findCode.expireAt <= now || findCode.attempts >= MAX_ATTEMP) {
      throw new Exception(403, 'code_expired');
    }

    if (findCode.code !== code) {
      await tx.resetPassword.update({
        where: { id: findCode.id },
        data: { attempts: { increment: 1 } },
      });
      throw new Exception(403, 'email_code_invalid');
    }

    const user = await tx.user.update({
      where: { email: findCode.email },
      data: { password: hashedPassword },
    });

    await tx.userActivityLog.create({
      data: {
        userId: user.userId,
        action: 'reset_password',
        details: user!.password,
        ip: req.ip,
      },
    });
    await tx.resetPassword.deleteMany({
      where: { email: findCode.email },
    });
  });

  res.status(200).end();
};

export const sendNewEmailOtpCode = async (req: Request, res: Response) => {
  const { email } = req.body;

  const [err, emailExist] = await asyncWrap(() => chekForUserEmail(email));

  if (err || emailExist) {
    throw new Exception(404, 'email_exist');
  }

  const [otpError, otp] = await asyncWrap(() =>
    sendEmailVerificationCode(email, req.prefLang ?? 'en', req.ip),
  );

  if (otpError) {
    throw new Exception(403, 'GE');
  }
  res.status(200).end();
};

export const updateEmailAddress = async (req: Request, res: Response) => {
  const { email, code } = req.body;

  const userId = req.userId;

  const now = new Date();

  const update = await prisma.$transaction(async (tx) => {
    const isExist = await tx.user.findFirst({ where: { email } });

    if (isExist) {
      throw new Exception(403, 'email_exist');
    }
    const findCode = await tx.resetPassword.findFirst({
      where: { email, type: 'email', verifyStatus: 'pending' },
      orderBy: { id: 'desc' },
    });

    if (!findCode || !findCode.email) {
      throw new Exception(403, 'email_code_invalid');
    }
    if (findCode.expireAt <= now || findCode.attempts >= MAX_ATTEMP) {
      throw new Exception(403, 'code_expired');
    }

    if (findCode.code !== code) {
      await tx.resetPassword.update({
        where: { id: findCode.id },
        data: { attempts: { increment: 1 } },
      });
      throw new Exception(403, 'email_code_invalid');
    }

    const user = await tx.user.update({
      where: { userId },
      data: {
        email,
        profile: {
          update: {
            email,
            activiyLog: {
              create: {
                action: 'change_email',
                details: email,
                ip: req.ip,
              },
            },
          },
        },
      },
    });

    await tx.resetPassword.deleteMany({ where: { email } });
  });

  res.status(200).end();
};

export const singedVerifyOtpCode = async (req: Request, res: Response) => {
  const { code } = req.body;
  const email = req.email;

  const now = new Date();
  const update = await prisma.$transaction(async (tx) => {
    const findCode = await tx.resetPassword.findFirst({
      where: { email, type: 'email', verifyStatus: 'pending' },
      orderBy: { id: 'desc' },
    });

    if (!findCode || !findCode.email) {
      throw new Exception(403, 'code_invalid');
    }
    if (findCode.expireAt <= now || findCode.attempts >= MAX_ATTEMP) {
      throw new Exception(403, 'code_expired');
    }

    if (findCode.code !== code) {
      await tx.resetPassword.update({
        where: { id: findCode.id },
        data: { attempts: { increment: 1 } },
      });
      throw new Exception(403, 'email_code_invalid');
    }

    await tx.resetPassword.updateMany({
      where: { email },
      data: { verifyStatus: 'verified' },
    });

    await tx.resetPassword.updateMany({
      where: {
        email,
        id: { not: findCode.id },
        verifyStatus: 'pending',
      },
      data: { verifyStatus: 'expired' },
    });
  });

  res.status(200).end();
};

export const singedResetPassword = async (req: Request, res: Response) => {
  const { password, code } = req.body;
  const email = req.email;

  const [pswdError, hashedPassword] = await asyncWrap(() =>
    hashingPassword(password),
  );

  if (pswdError || !hashedPassword) {
    throw new Exception(403, 'GE');
  }

  const now = new Date();

  const reset = await prisma.$transaction(async (tx) => {
    const findCode = await tx.resetPassword.findFirst({
      where: { email, type: 'email', verifyStatus: 'pending' },
      orderBy: { id: 'desc' },
    });

    if (!findCode || !findCode.email) {
      throw new Exception(403, 'code_expired');
    }

    if (findCode.expireAt <= now || findCode.attempts >= MAX_ATTEMP) {
      throw new Exception(403, 'code_expired');
    }

    if (findCode.code !== code) {
      await tx.resetPassword.update({
        where: { id: findCode.id },
        data: { attempts: { increment: 1 } },
      });
      throw new Exception(403, 'email_code_invalid');
    }

    const user = await prisma.user.update({
      where: { email: findCode.email },
      data: { password: hashedPassword },
    });

    await tx.userActivityLog.create({
      data: {
        userId: user.userId,
        action: 'reset_password',
        details: hashedPassword,
        ip: req.ip,
      },
    });

    await prisma.resetPassword.deleteMany({
      where: { email: findCode.email },
    });
  });

  res.status(200).end();
};
