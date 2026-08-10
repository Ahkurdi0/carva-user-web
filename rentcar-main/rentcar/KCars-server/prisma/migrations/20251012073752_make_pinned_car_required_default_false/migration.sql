/*
  Warnings:

  - Made the column `pinned` on table `car` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "car"."car" ADD COLUMN     "pinnedSort" INTEGER,
ALTER COLUMN "pinned" SET NOT NULL,
ALTER COLUMN "pinned" SET DEFAULT false;

-- CreateIndex
CREATE INDEX "car_companyId_carId_idx" ON "car"."car"("companyId", "carId");

-- CreateIndex
CREATE INDEX "car_id_pinned_idx" ON "car"."car"("id", "pinned");

-- CreateIndex
CREATE INDEX "car_carId_pinned_idx" ON "car"."car"("carId", "pinned");

-- CreateIndex
CREATE INDEX "car_id_available_pinned_idx" ON "car"."car"("id", "available", "pinned");
