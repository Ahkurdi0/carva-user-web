import { Request, Response, NextFunction } from 'express';
import { verify } from 'jsonwebtoken';
import { CustomPayload, IUSER } from '../types/interfaces';
import { currentUser, refreshingToken } from '../utils/current_user';

import { asyncWrap } from '../utils/async_wrap';

export const isAuthenticated =
  (options: { required?: boolean } = { required: true }) =>
  async (req: Request, res: Response, next: NextFunction) => {
    const header = req.headers.authorization;

    if (!header?.startsWith('Bearer ')) {
      if (options.required) {
        return res.status(401).json('Unauthorized: Missing token');
      } else {
        return next();
      }
    }

    const token = header.split(' ')[1];

    try {
      const secret = process.env.ACCESS_TOKEN_SECRET!;
      const decoded = verify(token, secret) as CustomPayload;

      const [error, cUser] = await asyncWrap(() =>
        currentUser(decoded.sessionId),
      );

      if (error || !cUser) {
        if (options.required) {
          return res.status(401).json('Unauthorized: Invalid session');
        } else {
          return next();
        }
      }

      req.user = {
        ...cUser,
        location: cUser.location && {
          lat: cUser.location.lat,
          long: cUser.location.long,
        },
      };
      req.email = cUser.email;
      req.userId = cUser.userId;
      req.companyId = cUser.companyId;

      return next();
    } catch {
      if (options.required) {
        return res.status(401).json('Invalid or expired token');
      } else {
        return next();
      }
    }
  };

export const refreshToken = async (req: Request, res: Response) => {
  const header = req.headers.authorization;
  if (!header || !header.startsWith('Bearer ')) {
    return res
      .status(401)
      .json('Unauthorized: Missing token headers! frit line');
  }
  const token = header.split(' ')[1];

  try {
    const secret = process.env.REFRESH_TOKEN_SECRET;
    const decoded = verify(token, secret) as CustomPayload;

    const [error, data] = await asyncWrap(() =>
      refreshingToken(decoded.sessionId, token),
    );

    if (error || !data) {
      return res.status(401).json(`Missing token ${error}`);
    }
    return res.status(200).json(data);
  } catch (err) {
    return res.status(401).json('Invalid or expired token');
  }
};
