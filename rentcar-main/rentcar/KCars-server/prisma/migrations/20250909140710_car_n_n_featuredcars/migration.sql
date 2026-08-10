/*
  Warnings:

  - A unique constraint covering the columns `[carId]` on the table `featuredCar` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "featuredCar_carId_key" ON "car"."featuredCar"("carId");
