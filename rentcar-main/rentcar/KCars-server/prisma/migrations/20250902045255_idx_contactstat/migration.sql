/*
  Warnings:

  - You are about to drop the `ContactStatistic` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "company"."ContactStatistic" DROP CONSTRAINT "ContactStatistic_carId_fkey";

-- DropForeignKey
ALTER TABLE "company"."ContactStatistic" DROP CONSTRAINT "ContactStatistic_companyId_fkey";

-- DropForeignKey
ALTER TABLE "company"."ContactStatistic" DROP CONSTRAINT "ContactStatistic_userId_fkey";

-- DropTable
DROP TABLE "company"."ContactStatistic";

-- CreateTable
CREATE TABLE "company"."contactStatistic" (
    "id" TEXT NOT NULL,
    "contactId" TEXT,
    "userId" TEXT,
    "companyId" TEXT,
    "carId" TEXT,
    "type" "enums"."ContactTypes" NOT NULL,
    "value" TEXT,
    "ipAddress" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "contactStatistic_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "contactStatistic_id_key" ON "company"."contactStatistic"("id");

-- CreateIndex
CREATE INDEX "contactStatistic_userId_idx" ON "company"."contactStatistic"("userId");

-- CreateIndex
CREATE INDEX "contactStatistic_contactId_idx" ON "company"."contactStatistic"("contactId");

-- CreateIndex
CREATE INDEX "contactStatistic_ipAddress_idx" ON "company"."contactStatistic"("ipAddress");

-- CreateIndex
CREATE INDEX "contactStatistic_companyId_idx" ON "company"."contactStatistic"("companyId");

-- CreateIndex
CREATE INDEX "contactStatistic_type_idx" ON "company"."contactStatistic"("type");

-- CreateIndex
CREATE INDEX "contactStatistic_value_idx" ON "company"."contactStatistic"("value");

-- CreateIndex
CREATE INDEX "contactStatistic_createdAt_idx" ON "company"."contactStatistic"("createdAt");

-- AddForeignKey
ALTER TABLE "company"."contactStatistic" ADD CONSTRAINT "contactStatistic_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"."profile"("userId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company"."contactStatistic" ADD CONSTRAINT "contactStatistic_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"."company"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company"."contactStatistic" ADD CONSTRAINT "contactStatistic_carId_fkey" FOREIGN KEY ("carId") REFERENCES "car"."car"("id") ON DELETE SET NULL ON UPDATE CASCADE;
