-- AlterTable
ALTER TABLE "company"."ContactStatistic" ADD COLUMN     "carId" TEXT;

-- AlterTable
ALTER TABLE "company"."contact" ADD COLUMN     "clikced" INTEGER NOT NULL DEFAULT 0;

-- AddForeignKey
ALTER TABLE "company"."ContactStatistic" ADD CONSTRAINT "ContactStatistic_carId_fkey" FOREIGN KEY ("carId") REFERENCES "car"."car"("id") ON DELETE SET NULL ON UPDATE CASCADE;
