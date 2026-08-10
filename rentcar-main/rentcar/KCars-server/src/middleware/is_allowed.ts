import { Request, Response, NextFunction } from 'express';
import { checkPermission } from './has_permission';
import { asyncWrap } from '../utils/async_wrap';
import { PermissionKeys } from '../constants/permissions';
import { Exception } from '../utils/exception';
import { currentUser } from '../utils/current_user';

export const isAllowed =
  (permission: PermissionKeys) =>
  async (req: Request, res: Response, next: NextFunction) => {
    const user = req.user;

    if (!user) {
      throw new Exception(403, 'unauthorized');
    }
    if (user.role === 'admin') {
      const [err, allowed] = await asyncWrap(() =>
        checkPermission(user.userId, permission),
      );

      if (err || !allowed) {
        throw new Exception(403, 'unauthorized');
      }

      return next();
    }

    if (user.companyId && user.company?.companyOwnerId == user.userId) {
      if (user.company.expired) {
        throw new Exception(403, 'company_expired');
      }
      return next();
    }
    if (user.company?.available === false) {
      throw new Exception(403, 'company_unavailable');
    }

    throw new Exception(403, 'unauthorized');
  };
