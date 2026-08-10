import { NextFunction, Request, Response } from 'express';
import { getData, setData } from '../config/redis';
import { AdminPermissions, PermissionKeys } from '../constants/permissions';
import { prisma } from '../config/prisma';
import { asyncWrap } from '../utils/async_wrap';

export const checkPermission = async (
  userId: string,
  permission: PermissionKeys,
): Promise<boolean> => {
  let myData = await getData<AdminPermissions | null>(`role_${userId}`);

  if (!myData) {
    myData = await prisma.profile.findFirst({
      where: {
        userId,
        role: { roleName: 'admin' },
      },
      include: {
        role: true,
        permissions: {
          select: { permission: true },
        },
      },
    });
    if (myData) {
      await setData(`role_${userId}`, myData, 3 * 24 * 60 * 60);
    }
  }

  const hasPerm =
    myData?.role?.roleName === 'admin' &&
    myData.permissions.some((p) => p.permission.permissionName === permission);

  return hasPerm;
};

export const hasPermissions = (permission: PermissionKeys) => {
  return async (req: Request, res: Response, next: NextFunction) => {
    if (!req.userId) {
      return res.status(403).json('Unauthorized');
    }

    const [error, allowed] = await asyncWrap(() =>
      checkPermission(req.userId!, permission),
    );

    if (allowed) {
      return next();
    }

    return res.status(403).json('Permission denied');
  };
};
