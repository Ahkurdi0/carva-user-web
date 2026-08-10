import 'dotenv/config';
import { createLogger, format, transports } from 'winston';
const { combine, timestamp, label, printf } = format;

const myFormat = printf(({ level, message, label, timestamp }) => {
  return `${level}: ${message} ${timestamp}`;
});

export const logger = createLogger({
  level: 'error',
  format: combine(timestamp(), myFormat),
  transports: [
    new transports.File({
      filename: process.env.LOGGER,
      level: 'error',
    }),
  ],
});
