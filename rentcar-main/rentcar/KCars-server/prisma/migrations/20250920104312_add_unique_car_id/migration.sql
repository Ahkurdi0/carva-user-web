/*
  Warnings:

  - A unique constraint covering the columns `[carId]` on the table `car` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "car_carId_key" ON "car"."car"("carId");
