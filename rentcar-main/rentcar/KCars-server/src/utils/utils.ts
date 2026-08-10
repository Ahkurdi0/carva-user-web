import { compare, genSalt, hash } from 'bcrypt';
import crypto from 'crypto';
import jwt from 'jsonwebtoken';

export const hashingPassword = async (password: string): Promise<string> => {
  const salt = await genSalt(10);
  const hashing = await hash(password, salt);
  return hashing;
};

export const comparePassword = async (
  password: string,
  hashedPassword: string,
): Promise<Boolean> => {
  const compared = await compare(password, hashedPassword);
  return compared;
};

export const generateOTP = () => {
  return Math.floor(Math.random() * 9000 + 100000);
};

export const hashToken = (token: string): string => {
  return crypto.createHash('sha256').update(token).digest('hex');
};

const ACCESS_SECRET = process.env.ACCESS_TOKEN_SECRET!;
const REFRESH_SECRET = process.env.REFRESH_TOKEN_SECRET!;

export function generateAccessToken(payload: { sessionId: string }): string {
  return jwt.sign(payload, ACCESS_SECRET, { expiresIn: '15m' });
}

export function generateRefreshToken(payload: { sessionId: string }): string {
  return jwt.sign(payload, REFRESH_SECRET, { expiresIn: '60d' });
}
