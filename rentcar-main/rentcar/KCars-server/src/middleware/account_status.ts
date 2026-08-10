import { NextFunction, Request, Response } from 'express';

import { getData, setData } from '../config/redis';
import { AccountStatus } from 'prisma/prisma-client';
import { asyncWrap } from '../utils/async_wrap';
import { Exception } from '../utils/exception';
import { prisma } from '../config/prisma';

export const accountStatuses = async (
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  const userId = req.userId;

  const now = new Date();
  //from redis

  const [error, userStatus] = await asyncWrap(() =>
    getData<AccountStatus>(`${userId}_accontStatus`),
  );

  if (!error && userStatus) {
    if (new Date(userStatus.bannedUntil) > now) {
      throw new Exception(
        403,
        `${userStatus.title}\n ${userStatus.description}`,
        true,
      );
    }
    next();
  } else {
    const user = await prisma.profile.findFirst({
      where: { userId },
      include: { accountStatus: { take: 1, orderBy: { id: 'desc' } } },
    });

    if (user) {
      const { accountStatus } = user;

      if (accountStatus[0]?.bannedUntil > now) {
        const userStatus = accountStatus[0];
        await asyncWrap(() =>
          setData(`${userId}_accontStatus`, userStatus, 5 * 24 * 60 * 60),
        );

        const title = userStatus.title;
        const message = userStatus.description;

        throw new Exception(403, `${title}\n ${message}`, true);
      }
      return next();
    }

    throw new Exception(403, 'GE');
  }
};
