import { RateLimiterRedis } from 'rate-limiter-flexible';
import { redisClient } from './redis';

// General limiter
export const generalLimiter = new RateLimiterRedis({
  storeClient: redisClient,
  keyPrefix: 'rl_ip',
  points: 200,
  duration: 30,
});

// Update info Ratelimiter
export const updatingLimitter = new RateLimiterRedis({
  storeClient: redisClient,
  keyPrefix: 'rl_ip_email',
  points: 10,
  duration: 100,
});

// Auth and signup Ratelimiter
export const auth = new RateLimiterRedis({
  storeClient: redisClient,
  keyPrefix: 'rl_ip_auth',
  points: 20,
  duration: 60,
});

export const signup = new RateLimiterRedis({
  storeClient: redisClient,
  keyPrefix: 'rl_ip_signup',
  points: 5,
  duration: 60,
});

// Reset Send OTP
export const rSendOtpLimiter = new RateLimiterRedis({
  storeClient: redisClient,
  keyPrefix: 'rSendOtp',
  points: 5,
  duration: 600,
});

// Reset Verify OTP
export const rVerifyOtpLimiter = new RateLimiterRedis({
  storeClient: redisClient,
  keyPrefix: 'rVerifyOtp',
  points: 5,
  duration: 900,
});

// Reset password
export const rResetPasswordLimiter = new RateLimiterRedis({
  storeClient: redisClient,
  keyPrefix: 'rResetPassword',
  points: 3,
  duration: 300,
});

// Update Send OTP
export const uSendOtpLimiter = new RateLimiterRedis({
  storeClient: redisClient,
  keyPrefix: 'uSendOtp',
  points: 5,
  duration: 600,
});

// Update Verify OTP
export const uVerifyOtpLimiter = new RateLimiterRedis({
  storeClient: redisClient,
  keyPrefix: 'uVerifyOtp',
  points: 5,
  duration: 900,
});

// Update  Reset password
export const uResetPasswordLimiter = new RateLimiterRedis({
  storeClient: redisClient,
  keyPrefix: 'uResetPassword',
  points: 3,
  duration: 300,
});

// Singed Send OTP
export const sSendOtpLimiter = new RateLimiterRedis({
  storeClient: redisClient,
  keyPrefix: 'sSendOtp',
  points: 5,
  duration: 600,
});

// Singed Verify OTP
export const sVerifyOtpLimiter = new RateLimiterRedis({
  storeClient: redisClient,
  keyPrefix: 'sVerifyOtp',
  points: 5,
  duration: 900,
});

// Singed reset Password
export const sResetPasswordLimiter = new RateLimiterRedis({
  storeClient: redisClient,
  keyPrefix: 'sResetPassword',
  points: 3,
  duration: 300,
});

// Verify Send OTP
export const vSendOtpLimiter = new RateLimiterRedis({
  storeClient: redisClient,
  keyPrefix: 'vSendOtp',
  points: 5,
  duration: 600,
});

// Verify OTP
export const vVerifyOtpLimiter = new RateLimiterRedis({
  storeClient: redisClient,
  keyPrefix: 'vVerifyOtp',
  points: 5,
  duration: 900,
});

// Verify OTP
export const applyPromoCodeLimiter = new RateLimiterRedis({
  storeClient: redisClient,
  keyPrefix: 'applyPromoCode',
  points: 3,
  duration: 600,
});

export const explorerMapLimiter = new RateLimiterRedis({
  storeClient: redisClient,
  keyPrefix: 'explorerMap',
  points: 110,
  duration: 90,
});
