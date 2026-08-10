import { NextFunction, Request, Response } from 'express';
import { z } from 'zod';
import { Exception } from '../utils/exception';

export const validateSchema = (schema: z.ZodType<any>) => {
  return (req: Request, res: Response, next: NextFunction) => {
    try {
      const parsedData = schema.parse(req.body);
      req.body = parsedData;
      next();
    } catch (error: any) {
      return next(new Exception(400, `Incorrect info`, true));
    }
  };
};

export const validateParamSchema = (schema: z.ZodType<any>) => {
  return (req: Request, res: Response, next: NextFunction) => {
    try {
      const parsedData = schema.parse(req.params);
      req.params = parsedData;
      next();
    } catch (error: any) {
      return next(new Exception(400, `Incorrect info`, true));
    }
  };
};
