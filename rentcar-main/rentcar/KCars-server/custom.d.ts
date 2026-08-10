import { IFile, IUSER } from './src/types/interfaces';

declare global {
  namespace NodeJS {
    export interface ProcessEnv {
      NODE_ENV: 'development' | 'production' | 'test';
      DOMAIN: string;
      PORT: string;
      DATABASE_URL: string;
      ANDROID_CHANELL_ID: string;
      ONESIGNAL_APPID: String;
      ONESIGNAL_USER_KEY: string;
      ONESIGNAL_APPKEY: string;
      ONESIGNAL_REST_API_KEY: string;
      ONESIGNAL_ORGANIZATION_API_KEY: string;

      MY_NUMBER: string;
      REDIS_KEY: string;
      DOMAIN: string;

      ENCRYPTION_KEY: string;
      ALGORITHM: string;

      APPLE_KEY_ID: string;
      APPLE_CLIENT_ID: string;
      APPLE_CLIENT_ID_ANDROID: string;
      APPLE_TEAM_ID: string;
      APPLE_PRIVATE_KEY: string;

      GOOGLE_CLIENT_ID_ANDROID: string;
      GOOGLE_CLIENT_ID_APPLE: string;

      ESIMKEY: string;
      BASE_URL: string;

      AWS_ACCESS_KEY: string;
      AWS_SECRET_KEY: string;
      AWS_BUCKET: string;
      BASE_IMAGE: string;
      UPLOADS: string;
      LOGGER: string;

      TWILIO_ACCOUNT_SID: string;
      TWILIO_AUTH_TOKEN: string;
      TWILIO_VERIFY_SERVICES: string;

      GMAIL_USER: string;
      GMAIL_PASSWORD: string;
      SMTP: string;

      DOWNLOAD: string;
      ACCESS_TOKEN_SECRET: string;
      REFRESH_TOKEN_SECRET: string;

      NODE_ENV: 'development' | 'production' | 'test';
    }
  }

  namespace Express {
    export interface Request {
      userId?: string;
      role?: string;
      email?: string;
      phoneNumber?: string;
      countryCode?: string;
      file?: IFile;
      files: {
        [fieldname: string]: IFile[];
      };
      emailVerifiedAt?: Date | null;
      phoneVerifiedAt?: Date | null;
      REDIS_KEY: string;
      platform?: string;
      user: IUSER | null;
      companyId: string | undefined;
      ip: string;
      prefLang: string;
      rateLimit?: {
        resetTime: number;
      };
    }
    export interface IncomingHttpHeaders {
      devicelang?: string;
    }
  }
}
