import { Request, Response, NextFunction } from 'express';
import { RateLimiterRedis } from 'rate-limiter-flexible';

import * as Limiters from '../config/rate_limiter';

type KeyExtractor = (req: Request) => string | null;

const createRateLimiterMiddleware = (
  limiter: RateLimiterRedis,
  keyExtractor: KeyExtractor,
) => {
  return async (req: Request, res: Response, next: NextFunction) => {
    const key = keyExtractor(req) ?? req.ip;

    if (!key) {
      res.status(400).json('Missing identifier for rate limiting');
      return;
    }

    try {
      const rateRes = await limiter.consume(key);
      res.setHeader(
        'X-RateLimit-Remaining',
        rateRes.remainingPoints.toString(),
      );
      next();
    } catch (rateLimiterRes: any) {
      const devicelang = (req.headers.devicelang as string | undefined) || 'en';

      const timeLeftMinutes = Math.ceil(
        rateLimiterRes.msBeforeNext / (1000 * 60),
      );
      const message =
        devicelang == 'ku'
          ? `تکایە دوای ${timeLeftMinutes} خولەک هەوڵبدەوە`
          : devicelang == 'ar'
            ? `الطلبات كثيرة جدًا، يرجى المحاولة مرة أخرى لاحقًا بعد ${timeLeftMinutes} دقيقة`
            : `Too many requests, please try again later after ${timeLeftMinutes} minute`;

      res.setHeader('Retry-After', timeLeftMinutes.toString());

      res.status(429).json(message);
    }
  };
};

const ipEmailKey = (req: Request) => {
  const email = req.email || req.body?.email;
  return email ? `${req.ip}:${email}` : null;
};

export const RateLimitters = {
  rSendOtp: () =>
    createRateLimiterMiddleware(Limiters.rSendOtpLimiter, ipEmailKey),
  rVerifyOtp: () =>
    createRateLimiterMiddleware(Limiters.rVerifyOtpLimiter, ipEmailKey),
  rResetPassword: () =>
    createRateLimiterMiddleware(Limiters.rResetPasswordLimiter, ipEmailKey),
  uSendOtp: () =>
    createRateLimiterMiddleware(Limiters.uSendOtpLimiter, ipEmailKey),
  uVerifyOtp: () =>
    createRateLimiterMiddleware(Limiters.uVerifyOtpLimiter, ipEmailKey),
  uResetPassword: () =>
    createRateLimiterMiddleware(Limiters.uResetPasswordLimiter, ipEmailKey),
  sSendOtp: () =>
    createRateLimiterMiddleware(Limiters.sSendOtpLimiter, ipEmailKey),
  sVerifyOtp: () =>
    createRateLimiterMiddleware(Limiters.sVerifyOtpLimiter, ipEmailKey),
  sResetPassword: () =>
    createRateLimiterMiddleware(Limiters.sResetPasswordLimiter, ipEmailKey),

  vSendOtp: () =>
    createRateLimiterMiddleware(Limiters.vSendOtpLimiter, ipEmailKey),
  vVerifyOtp: () =>
    createRateLimiterMiddleware(Limiters.vVerifyOtpLimiter, ipEmailKey),
  auth: () =>
    createRateLimiterMiddleware(Limiters.auth, (req) => req.ip ?? null),
  signUp: () =>
    createRateLimiterMiddleware(Limiters.signup, (req) => req.ip ?? null),
  update: () =>
    createRateLimiterMiddleware(Limiters.updatingLimitter, ipEmailKey),
  general: () =>
    createRateLimiterMiddleware(
      Limiters.generalLimiter,
      (req) => req.ip ?? null,
    ),
  promoCode: () =>
    createRateLimiterMiddleware(
      Limiters.applyPromoCodeLimiter,
      (req) => req.ip ?? null,
    ),
  explorerMap: () =>
    createRateLimiterMiddleware(
      Limiters.explorerMapLimiter,
      (req) => req.userId ?? null,
    ),
};
