import { z } from 'zod';

const password = z.string().min(8).max(100);
const countryCode = z.string().trim().min(2).max(10).default('+964');
const name = z.string().min(3).max(30);
const otp = z.string().min(6).max(6);
const email = z.string().trim().email();
const phoneNumber = z.string().trim().min(10).max(20);
const nullString = z.string().nullish();

const session = z.object({
  systemName: nullString,
  isPhysicalDevice: nullString,
  model: nullString,
  localizedModel: nullString,
  systemVersion: nullString,
  name: nullString,
  identifierForVendor: nullString,
  platform: nullString,
});

export const signInSchema = z.object({
  password,
  email,
  session,
  platform: nullString,
});

export const signUpSchema = signInSchema.extend({
  name,
  phoneNumber: phoneNumber.nullish(),
  countryCode: countryCode.nullish(),
  session,
});

export const logOutSchema = z.object({
  allDevices: z.boolean(),
});

export const updateNameSchema = z.object({
  name,
});

export const updatePasswordSchema = z.object({
  oldPassword: password,
  newPassword: password,
});

export const emailSchema = z.object({
  email: z.string().email(),
});

export const verifyEmailSchema = z.object({
  email: z.string().email(),
  code: otp,
});

export const resetEmailPasswordSchema = verifyEmailSchema.extend({
  password,
});

export const otpCodeSchema = z.object({
  code: z.string().min(6).max(6),
});

export const signedResetPasswordSchema = otpCodeSchema.extend({
  password,
});

export const updatePhoneNumberSchema = z.object({
  phoneNumber,
  countryCode,
});

export const prefLangSchema = z.object({
  prefLang: z.enum(['en', 'ar', 'ku']),
});
