export const ImageDirs = {
  profile: 'profile',
  company: 'company',
  companyProfile: 'companyProfile',
  companyCover: 'companyCover',
  car: 'car',
  contact: 'contact',
  slider: 'slider',
} as const;

export type ImageKeys = (typeof ImageDirs)[keyof typeof ImageDirs];
