import { RateLimiterRedis } from 'rate-limiter-flexible';
import { redisClient } from '../config/redis';
import { Request, Response, NextFunction } from 'express';
import { isbot } from 'isbot';
import { logger } from '../config/logger';

// Rate limiters
const userLimiter = new RateLimiterRedis({
  storeClient: redisClient,
  keyPrefix: 'preview_user',
  points: 50,
  duration: 60,
});

const crawlerLimiter = new RateLimiterRedis({
  storeClient: redisClient,
  keyPrefix: 'preview_crawler',
  points: 100,
  duration: 60,
});

const customCrawlerPatterns = [
  'facebookexternalhit',
  'whatsapp',
  'telegrambot',
  'twitterbot',
  'linkedinbot',
  'slackbot',
  'discordbot',
  'pinterest',
  'tiktok',
];

// Function to detect crawlers
const isCrawler = (req: Request): boolean => {
  const ua = req.headers['user-agent'] || '';
  if (isbot(ua)) return true;
  return customCrawlerPatterns.some((pattern) =>
    ua.toLowerCase().includes(pattern),
  );
};

// Middleware
export const botSafeRateLimiter = async (
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  try {
    const clientIp = req.ip || 'unknown_ip';
    const isBotRequest = isCrawler(req);
    const limiter = isBotRequest ? crawlerLimiter : userLimiter;
    const key = isBotRequest
      ? `crawler_${clientIp}_${req.headers['user-agent']}`
      : `user_${clientIp}`;

    await limiter.consume(key);
    next();
  } catch (err: any) {
    if (err instanceof Error && err.message.includes('Rate limit')) {
      return res.status(429).json({
        error: 'Too many requests, please try again later.',
      });
    }
    logger.error(`Rate limiter error: ${err.message}`);
    res.status(500).json({ error: 'Internal server error' });
  }
};
