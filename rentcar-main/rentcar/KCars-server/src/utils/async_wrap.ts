import { NextFunction, Request, Response } from 'express';
type AsyncFunction<T> = (...args: any[]) => Promise<T>;

export async function asyncWrap<T>(
  asyncFunction: AsyncFunction<T>,
): Promise<[Error | undefined, T | undefined]> {
  try {
    const result = await asyncFunction();
    return [undefined, result];
  } catch (error) {
    return [error as Error, undefined];
  }
}

export const asyncErrorHandler = (handler: AsyncFunction<any>) => {
  return async (req: Request, res: Response, next: NextFunction) => {
    try {
      await handler(req, res, next);
    } catch (error) {
      next(error);
    }
  };
};
