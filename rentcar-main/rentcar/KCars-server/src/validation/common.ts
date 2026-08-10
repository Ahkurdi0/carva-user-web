import z from 'zod';

export const uuidV7Regex =
  /^[0-9a-f]{8}-[0-9a-f]{4}-7[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;

export const uuidV7 = z.string().regex(uuidV7Regex, 'Invalid UUID v7 format');

export const IDV7schema = z.object({ id: uuidV7 });
export const UserIdSchmea = z.object({ userId: z.string().cuid2() });

export const IDV7schemaOptiona = z
  .object({ id: uuidV7.nullable().optional() })
  .nullable()
  .optional();

export const CursorSchema = z.object({
  cursor: uuidV7.nullable().optional(),
  id: z.string().nullable().optional(),
});

export const uuidShcemaNullable = z
  .string()
  .regex(uuidV7Regex, {
    message: 'Invalid ULID format',
  })
  .nullable();

export const uuid7Preporcess = z.preprocess(
  (value) => {
    if (
      (typeof value === 'string' && value.trim() === '') ||
      value === 'null'
    ) {
      return null;
    }
    return value;
  },
  z.union([uuidV7, z.null()]),
);

export const stringPreprocessing = ({
  min = 3,
  max = 200,
}: {
  min?: number;
  max?: number;
}) =>
  z.preprocess((value) => {
    if (typeof value === 'string') {
      if (value === 'null') return null;
    }
    return value;
  }, z.string().min(min).max(max).nullish());

export const booleanPreprocessing = z.preprocess((value) => {
  if (typeof value === 'string') {
    if (value === 'true') return true;
    if (value === 'false') return false;
    if (value === 'null') return null;
  }

  return value;
}, z.boolean().nullable());

export const numberPreprocessingNullable = z.preprocess((value) => {
  if (typeof value === 'string') {
    const parsed = parseFloat(value);
    return isNaN(parsed) ? null : parsed;
  }
  return value;
}, z.number().nullable());

export const numberPreprocessing = z.preprocess((value) => {
  if (typeof value === 'string') {
    const parsed = parseFloat(value);
    return isNaN(parsed) ? null : parsed;
  }
  return value;
}, z.number().default(0));

export const CUID2 = z.object({ id: z.string().cuid2() });
