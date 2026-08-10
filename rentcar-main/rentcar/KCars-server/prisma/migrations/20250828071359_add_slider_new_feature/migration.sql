/*
  Warnings:

  - You are about to drop the column `title` on the `support` table. All the data in the column will be lost.
  - Added the required column `ar` to the `support` table without a default value. This is not possible if the table is not empty.
  - Added the required column `en` to the `support` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ku` to the `support` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "enums"."SlideType" AS ENUM ('car', 'company', 'url');

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "enums"."ContactTypes" ADD VALUE 'whatsapp';
ALTER TYPE "enums"."ContactTypes" ADD VALUE 'viber';

-- AlterTable
ALTER TABLE "appSetting"."support" DROP COLUMN "title",
ADD COLUMN     "ar" TEXT NOT NULL,
ADD COLUMN     "en" TEXT NOT NULL,
ADD COLUMN     "ku" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "car"."car" ADD COLUMN     "viewed" INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE "car"."feature" ADD COLUMN     "cylinders" INTEGER,
ADD COLUMN     "engCC" DOUBLE PRECISION,
ADD COLUMN     "odometer" INTEGER,
ALTER COLUMN "hp" DROP NOT NULL,
ALTER COLUMN "speed" DROP NOT NULL;

-- AlterTable
ALTER TABLE "car"."recentlyViewedCar" ADD COLUMN     "companyId" TEXT;

-- AlterTable
ALTER TABLE "company"."company" ADD COLUMN     "contact" TEXT,
ADD COLUMN     "contacted" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "coverImage" TEXT,
ADD COLUMN     "delivery" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "international" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "user"."profile" ADD COLUMN     "iraqi" BOOLEAN DEFAULT true,
ADD COLUMN     "tourist" BOOLEAN DEFAULT false;

-- CreateTable
CREATE TABLE "appSetting"."Slider" (
    "id" TEXT NOT NULL,
    "carId" TEXT,
    "companyId" TEXT,
    "url" TEXT,
    "image" TEXT,
    "sort" INTEGER,
    "type" "enums"."SlideType" NOT NULL DEFAULT 'url',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Slider_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "car"."viewedCars" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "companyId" TEXT,
    "carId" TEXT NOT NULL,
    "viewedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "viewedCars_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "company"."ContactStatistic" (
    "id" TEXT NOT NULL,
    "contactId" TEXT,
    "userId" TEXT,
    "companyId" TEXT,
    "type" "enums"."ContactTypes" NOT NULL,
    "value" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ContactStatistic_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Slider_id_key" ON "appSetting"."Slider"("id");

-- CreateIndex
CREATE UNIQUE INDEX "viewedCars_id_key" ON "car"."viewedCars"("id");

-- CreateIndex
CREATE INDEX "viewedCars_userId_idx" ON "car"."viewedCars"("userId");

-- CreateIndex
CREATE INDEX "viewedCars_companyId_idx" ON "car"."viewedCars"("companyId");

-- CreateIndex
CREATE INDEX "viewedCars_carId_idx" ON "car"."viewedCars"("carId");

-- CreateIndex
CREATE INDEX "viewedCars_viewedAt_idx" ON "car"."viewedCars"("viewedAt");

-- CreateIndex
CREATE UNIQUE INDEX "ContactStatistic_id_key" ON "company"."ContactStatistic"("id");

-- CreateIndex
CREATE INDEX "ContactStatistic_userId_idx" ON "company"."ContactStatistic"("userId");

-- CreateIndex
CREATE INDEX "ContactStatistic_contactId_idx" ON "company"."ContactStatistic"("contactId");

-- CreateIndex
CREATE INDEX "ContactStatistic_companyId_idx" ON "company"."ContactStatistic"("companyId");

-- CreateIndex
CREATE INDEX "ContactStatistic_type_idx" ON "company"."ContactStatistic"("type");

-- CreateIndex
CREATE INDEX "ContactStatistic_value_idx" ON "company"."ContactStatistic"("value");

-- AddForeignKey
ALTER TABLE "appSetting"."Slider" ADD CONSTRAINT "Slider_carId_fkey" FOREIGN KEY ("carId") REFERENCES "car"."car"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appSetting"."Slider" ADD CONSTRAINT "Slider_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"."company"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."recentlyViewedCar" ADD CONSTRAINT "recentlyViewedCar_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"."company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."viewedCars" ADD CONSTRAINT "viewedCars_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"."profile"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."viewedCars" ADD CONSTRAINT "viewedCars_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"."company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."viewedCars" ADD CONSTRAINT "viewedCars_carId_fkey" FOREIGN KEY ("carId") REFERENCES "car"."car"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company"."ContactStatistic" ADD CONSTRAINT "ContactStatistic_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"."profile"("userId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company"."ContactStatistic" ADD CONSTRAINT "ContactStatistic_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"."company"("id") ON DELETE SET NULL ON UPDATE CASCADE;
