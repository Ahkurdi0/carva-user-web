-- DropIndex
DROP INDEX "location"."location_cityId_key";

-- CreateIndex
CREATE INDEX "location_cityId_idx" ON "location"."location"("cityId");
