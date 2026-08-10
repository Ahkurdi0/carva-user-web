-- AlterTable
ALTER TABLE "car"."car" ADD COLUMN     "contact" TEXT,
ADD COLUMN     "displayPlan" "enums"."RentalPeriodType" NOT NULL DEFAULT 'hourly';
