-- AlterTable
ALTER TABLE "appSetting"."Slider" ADD COLUMN     "clicked" INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE "car"."viewedCars" ADD COLUMN     "ipAddress" TEXT,
ALTER COLUMN "userId" DROP NOT NULL;
