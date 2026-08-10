import { RedisStore } from 'connect-redis';
import Redis from 'ioredis';

export const redisClient = new Redis({ enableOfflineQueue: false });

redisClient.on('error', (err) => {});

export let redisStore = new RedisStore({
  client: redisClient,
  ttl: 90 * 24 * 60 * 60 * 1000,
});

export const setData = async <T>(type: string, data: T, expire?: number) => {
  if (expire) {
    await redisClient.set(type, JSON.stringify(data), 'EX', expire);
  } else {
    await redisClient.set(type, JSON.stringify(data));
  }
};

export const getData = async <T>(type: string): Promise<T | null> => {
  const res = await redisClient.get(type);

  if (res !== null) {
    const data: T = JSON.parse(res);
    return data;
  }
  return null;
};
