import { JwtPayload } from 'jsonwebtoken';

export interface Auth {
  email: string;
  name: string;
  phoneNumber?: string | undefined | null;
  token?: string;
  userId?: string;
  countryCode?: string;
  platForm?: string;
  session?: Session;
  prefLang?: string;
  password?: string;
  userName?: string;
  platform?: string;
  emailVerifiedAt?: Date | null;
  phoneVerifiedAt?: Date | null;
}

export interface Session {
  id?: Number;
  systemName?: any;
  isPhysicalDevice?: any;
  model?: any;
  localizedModel?: any;
  systemVersion?: any;
  name?: any;
  identifierForVendor?: any;
  ip?: string;
  lastLogin?: Date;
  token: string | null;
  platform?: string;
  sessionId: string | null;
}

export interface IFile {
  fieldname: string;
  originalname: string;
  encoding: string;
  mimetype: string;
  buffer: Buffer;
  size: number;
}

export interface IUSER {
  userId: string;
  name: string;
  role: string;
  email: string;
  emailVerifiedAt?: Date | null;
  phoneVerifiedAt?: Date | null;
  phoneNumber?: string | null | undefined;
  countryCode?: string;
  platform?: string;
  sessionId: string | undefined;
  companyId: string | undefined;
  company:
    | {
        companyOwnerId: string | undefined;
        companyId: string | undefined;
        activeDate: Date | undefined;
        expiresAt: Date | undefined;
        expired: Boolean | undefined;
        available: Boolean | undefined;
      }
    | undefined;
  location: {
    long: number | null;
    lat: number | null;
  } | null;
}

export interface CustomPayload extends JwtPayload {
  sessionId: string;
}
