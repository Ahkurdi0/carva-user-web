import { allErrors } from './all_errors';

export type ErrorLanguage = {
  en: string;
  ku: string;
  ar: string;
};

export class Exception<T extends boolean = false> extends Error {
  statusCode: number;
  isCustom: T;
  actualError?: ErrorLanguage;
  constructor(
    statusCode: number,
    messageKey: T extends true ? string : keyof typeof allErrors,
    isCustom?: T,
  ) {
    const finalIsCustom = isCustom ?? (false as T);

    super(messageKey);
    this.statusCode = statusCode;
    this.isCustom = finalIsCustom;
    this.actualError = allErrors[messageKey as keyof typeof allErrors];

    Object.setPrototypeOf(this, Exception.prototype);
  }
}
