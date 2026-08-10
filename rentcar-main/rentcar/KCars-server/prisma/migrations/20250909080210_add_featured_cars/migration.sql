-- AlterTable
ALTER TABLE "car"."car" ADD COLUMN     "pinned" BOOLEAN;

-- CreateTable
CREATE TABLE "car"."featuredCar" (
    "id" TEXT NOT NULL,
    "carId" TEXT,
    "sort" INTEGER NOT NULL DEFAULT 0,
    "companyId" TEXT,
    "startAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "until" TIMESTAMP(3),
    "deletedAt" TIMESTAMP(3),
    "available" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "featuredCar_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "featuredCar_carId_idx" ON "car"."featuredCar"("carId");

-- CreateIndex
CREATE INDEX "featuredCar_companyId_idx" ON "car"."featuredCar"("companyId");

-- CreateIndex
CREATE INDEX "featuredCar_companyId_carId_idx" ON "car"."featuredCar"("companyId", "carId");

-- CreateIndex
CREATE INDEX "featuredCar_until_idx" ON "car"."featuredCar"("until");

-- CreateIndex
CREATE INDEX "featuredCar_startAt_idx" ON "car"."featuredCar"("startAt");

-- CreateIndex
CREATE INDEX "featuredCar_startAt_until_idx" ON "car"."featuredCar"("startAt", "until");

-- CreateIndex
CREATE INDEX "featuredCar_deletedAt_available_sort_startAt_until_idx" ON "car"."featuredCar"("deletedAt", "available", "sort", "startAt", "until");

-- CreateIndex
CREATE INDEX "featuredCar_deletedAt_available_idx" ON "car"."featuredCar"("deletedAt", "available");

-- CreateIndex
CREATE INDEX "featuredCar_available_idx" ON "car"."featuredCar"("available");

-- AddForeignKey
ALTER TABLE "car"."featuredCar" ADD CONSTRAINT "featuredCar_carId_fkey" FOREIGN KEY ("carId") REFERENCES "car"."car"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."featuredCar" ADD CONSTRAINT "featuredCar_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"."company"("id") ON DELETE SET NULL ON UPDATE CASCADE;
