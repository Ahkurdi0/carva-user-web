-- CreateEnum
CREATE TYPE "enums"."Currency" AS ENUM ('usd', 'iqd');

-- AlterTable
ALTER TABLE "book"."rental_plan" ADD COLUMN     "currency" "enums"."Currency" NOT NULL DEFAULT 'iqd';
