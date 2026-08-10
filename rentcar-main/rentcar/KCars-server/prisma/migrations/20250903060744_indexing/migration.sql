-- AlterTable
ALTER TABLE "appSetting"."Slider" ALTER COLUMN "deletedAt" DROP DEFAULT;

-- CreateIndex
CREATE INDEX "Slider_carId_idx" ON "appSetting"."Slider"("carId");

-- CreateIndex
CREATE INDEX "Slider_companyId_idx" ON "appSetting"."Slider"("companyId");

-- CreateIndex
CREATE INDEX "Slider_sort_idx" ON "appSetting"."Slider"("sort");

-- CreateIndex
CREATE INDEX "Slider_deletedAt_idx" ON "appSetting"."Slider"("deletedAt");

-- CreateIndex
CREATE INDEX "support_sort_idx" ON "appSetting"."support"("sort");

-- CreateIndex
CREATE INDEX "Brand_deletedAt_idx" ON "car"."Brand"("deletedAt");

-- CreateIndex
CREATE INDEX "car_carId_idx" ON "car"."car"("carId");

-- CreateIndex
CREATE INDEX "car_brandId_idx" ON "car"."car"("brandId");

-- CreateIndex
CREATE INDEX "car_typeId_idx" ON "car"."car"("typeId");

-- CreateIndex
CREATE INDEX "car_serial_idx" ON "car"."car"("serial");

-- CreateIndex
CREATE INDEX "car_rate_idx" ON "car"."car"("rate");

-- CreateIndex
CREATE INDEX "car_review_idx" ON "car"."car"("review");

-- CreateIndex
CREATE INDEX "car_review_rate_idx" ON "car"."car"("review", "rate");

-- CreateIndex
CREATE INDEX "car_listedAt_idx" ON "car"."car"("listedAt");

-- CreateIndex
CREATE INDEX "carReview_reviewId_idx" ON "car"."carReview"("reviewId");

-- CreateIndex
CREATE INDEX "carReview_carId_idx" ON "car"."carReview"("carId");

-- CreateIndex
CREATE INDEX "carReview_companyId_idx" ON "car"."carReview"("companyId");

-- CreateIndex
CREATE INDEX "carReview_companyId_carId_idx" ON "car"."carReview"("companyId", "carId");

-- CreateIndex
CREATE INDEX "carReview_bookId_idx" ON "car"."carReview"("bookId");

-- CreateIndex
CREATE INDEX "image_carId_idx" ON "car"."image"("carId");

-- CreateIndex
CREATE INDEX "image_companyId_idx" ON "car"."image"("companyId");

-- CreateIndex
CREATE INDEX "image_carId_companyId_idx" ON "car"."image"("carId", "companyId");

-- CreateIndex
CREATE INDEX "company_companyId_idx" ON "company"."company"("companyId");

-- CreateIndex
CREATE INDEX "company_serial_idx" ON "company"."company"("serial");

-- CreateIndex
CREATE INDEX "company_userId_companyId_idx" ON "company"."company"("userId", "companyId");

-- CreateIndex
CREATE INDEX "company_rate_review_idx" ON "company"."company"("rate", "review");

-- CreateIndex
CREATE INDEX "company_review_idx" ON "company"."company"("review");

-- CreateIndex
CREATE INDEX "company_rate_idx" ON "company"."company"("rate");

-- CreateIndex
CREATE INDEX "company_expiresAt_idx" ON "company"."company"("expiresAt");

-- CreateIndex
CREATE INDEX "company_activeDate_idx" ON "company"."company"("activeDate");

-- CreateIndex
CREATE INDEX "companyReview_reviewId_idx" ON "company"."companyReview"("reviewId");

-- CreateIndex
CREATE INDEX "companyReview_reviewId_userId_idx" ON "company"."companyReview"("reviewId", "userId");

-- CreateIndex
CREATE INDEX "companyReview_reviewId_companyId_idx" ON "company"."companyReview"("reviewId", "companyId");

-- CreateIndex
CREATE INDEX "companyReviewFlag_status_idx" ON "company"."companyReviewFlag"("status");

-- CreateIndex
CREATE INDEX "contact_type_idx" ON "company"."contact"("type");

-- CreateIndex
CREATE INDEX "user_email_idx" ON "user"."user"("email");

-- CreateIndex
CREATE INDEX "user_email_phoneNumber_idx" ON "user"."user"("email", "phoneNumber");
