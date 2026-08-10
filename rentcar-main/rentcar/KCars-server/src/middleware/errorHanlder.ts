import { NextFunction, Request, Response } from 'express';
import { Exception } from '../utils/exception';
import { logger } from '../config/logger';

export const errorHandler = (
  err: Error,
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  const devicelang = req.headers.devicelang as 'en' | 'ku' | 'ar' | null;

  if (err instanceof Exception) {
    if (err.isCustom) {
      res.status(err.statusCode).json(err.message);
      return;
    }
    const curr = err.actualError![devicelang ?? 'en'];
    res.status(err.statusCode).json(curr ?? 'something went wrong');
    return;
  }
  logger.log('error', err.message);

  return res.status(400).json('Something went wrong GE');
};
