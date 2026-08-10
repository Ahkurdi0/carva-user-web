CREATE EXTENSION IF NOT EXISTS postgis;

-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "appSetting";

-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "book";

-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "car";

-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "company";

-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "enums";

-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "location";

-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "user";

-- CreateEnum
CREATE TYPE "enums"."ResetPasswordType" AS ENUM ('email', 'phone');

-- CreateEnum
CREATE TYPE "enums"."VerifyStatus" AS ENUM ('pending', 'verified', 'expired', 'failed');

-- CreateEnum
CREATE TYPE "enums"."ContactTypes" AS ENUM ('phone', 'email');

-- CreateEnum
CREATE TYPE "enums"."ReviewStatus" AS ENUM ('pending', 'accepted', 'canceled', 'flagged', 'deleted');

-- CreateEnum
CREATE TYPE "enums"."BookStaus" AS ENUM ('pending', 'ongoing', 'canceled', 'refunded', 'rejected', 'completed');

-- CreateEnum
CREATE TYPE "enums"."RentalPeriodType" AS ENUM ('hourly', 'daily', 'weekly', 'monthly');

-- CreateEnum
CREATE TYPE "enums"."PromotionPriceType" AS ENUM ('percentage', 'fixed');

-- CreateEnum
CREATE TYPE "enums"."PromotionType" AS ENUM ('car', 'company', 'plan', 'rentalPlan');

-- CreateEnum
CREATE TYPE "enums"."Fuel" AS ENUM ('diesel', 'gasoline', 'electric', 'hybird', 'lpg', 'cng');

-- CreateEnum
CREATE TYPE "enums"."Transmission" AS ENUM ('manual', 'automatic', 'amt', 'cvt', 'dct', 'sp');

-- CreateEnum
CREATE TYPE "enums"."CompanyStatuses" AS ENUM ('suspended', 'loacked', 'live');

-- CreateTable
CREATE TABLE "appSetting"."support" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "image" TEXT,
    "sort" INTEGER,
    "deletedAt" TIMESTAMP(3),
    "available" BOOLEAN NOT NULL DEFAULT true,
    "postedAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "support_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "appSetting"."notification" (
    "id" VARCHAR(50) NOT NULL,
    "kuTitle" TEXT NOT NULL,
    "arTitle" TEXT NOT NULL,
    "enTitle" TEXT NOT NULL,
    "kuDescription" TEXT NOT NULL,
    "arDescription" TEXT NOT NULL,
    "enDescription" TEXT NOT NULL,
    "postedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "notification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "book"."book" (
    "id" TEXT NOT NULL,
    "bookId" TEXT NOT NULL,
    "userId" TEXT,
    "carId" TEXT,
    "companyId" TEXT,
    "status" "enums"."BookStaus" NOT NULL DEFAULT 'pending',
    "isCompleted" BOOLEAN,
    "cancelReason" TEXT,
    "rentalPlanId" TEXT,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "basePrice" DECIMAL(18,3) NOT NULL,
    "totalPrice" DECIMAL(18,3) NOT NULL,
    "finalPrice" DECIMAL(18,3) NOT NULL,
    "discountAmount" DECIMAL(18,3) NOT NULL DEFAULT 0,
    "duration" INTEGER,
    "promotionId" TEXT,
    "promtionType" "enums"."PromotionType",
    "planId" TEXT,
    "contact" TEXT,
    "bookedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "book_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "book"."rental_plan" (
    "id" TEXT NOT NULL,
    "carId" TEXT,
    "price" DECIMAL(18,3) NOT NULL,
    "max" INTEGER,
    "min" INTEGER,
    "planId" TEXT NOT NULL,
    "periodType" "enums"."RentalPeriodType" NOT NULL DEFAULT 'hourly',
    "available" BOOLEAN NOT NULL DEFAULT true,
    "companyId" TEXT,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "rental_plan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "book"."Plan" (
    "id" TEXT NOT NULL,
    "en" TEXT NOT NULL,
    "ku" TEXT,
    "ar" TEXT,
    "periodType" "enums"."RentalPeriodType" NOT NULL DEFAULT 'hourly',
    "sort" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "Plan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "book"."promotion" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "name" VARCHAR(200),
    "description" TEXT,
    "priceType" "enums"."PromotionPriceType" NOT NULL DEFAULT 'fixed',
    "type" "enums"."PromotionType" NOT NULL DEFAULT 'car',
    "value" DECIMAL(18,3) NOT NULL,
    "minOrderValue" DECIMAL(18,3),
    "maxDiscountAmount" DECIMAL(18,3),
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "maxUses" INTEGER,
    "usesCount" INTEGER NOT NULL DEFAULT 0,
    "maxUsePerUser" INTEGER NOT NULL DEFAULT 1,
    "companyId" TEXT,
    "carId" TEXT,
    "rentalPlanId" TEXT,
    "available" BOOLEAN NOT NULL DEFAULT true,
    "planId" TEXT,
    "deletedAt" TIMESTAMP(3),
    "promotedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "promotion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "book"."usedPromotion" (
    "id" TEXT NOT NULL,
    "promotionId" TEXT,
    "userId" TEXT,
    "carId" TEXT,
    "companyId" TEXT,
    "rentalPlanId" TEXT,
    "planId" TEXT,
    "used" INTEGER NOT NULL DEFAULT 1,
    "bookId" TEXT,
    "postedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "usedPromotion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "book"."promotionRedemption" (
    "id" TEXT NOT NULL,
    "promotionId" TEXT,
    "userId" TEXT,
    "carId" TEXT,
    "rentalPlanId" TEXT,
    "planId" TEXT,
    "companyId" TEXT,
    "usedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "bookId" TEXT,

    CONSTRAINT "promotionRedemption_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "car"."car" (
    "id" TEXT NOT NULL,
    "serial" SERIAL NOT NULL,
    "carId" TEXT NOT NULL,
    "title" VARCHAR(200) NOT NULL,
    "companyId" TEXT NOT NULL,
    "rate" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "review" INTEGER NOT NULL DEFAULT 0,
    "trips" INTEGER NOT NULL DEFAULT 0,
    "available" BOOLEAN NOT NULL DEFAULT true,
    "brandId" TEXT,
    "typeId" TEXT,
    "listedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "car_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "car"."feature" (
    "id" TEXT NOT NULL,
    "seat" INTEGER NOT NULL,
    "hp" INTEGER NOT NULL,
    "speed" INTEGER NOT NULL,
    "year" INTEGER,
    "brandId" TEXT,
    "transmission" "enums"."Transmission" NOT NULL DEFAULT 'automatic',
    "fuel" "enums"."Fuel" NOT NULL DEFAULT 'diesel',
    "carTypeId" TEXT,
    "carId" TEXT NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "feature_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "car"."image" (
    "id" TEXT NOT NULL,
    "image" TEXT NOT NULL,
    "sort" INTEGER NOT NULL,
    "companyId" TEXT NOT NULL,
    "carId" TEXT NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "image_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "car"."carType" (
    "id" TEXT NOT NULL,
    "en" TEXT NOT NULL,
    "ar" TEXT,
    "ku" TEXT,
    "sort" INTEGER NOT NULL,
    "available" BOOLEAN NOT NULL DEFAULT true,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "carType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "car"."carReview" (
    "id" TEXT NOT NULL,
    "serial" SERIAL NOT NULL,
    "reviewId" TEXT,
    "userId" TEXT,
    "desc" TEXT NOT NULL,
    "rate" INTEGER NOT NULL,
    "carId" TEXT,
    "status" "enums"."ReviewStatus" NOT NULL DEFAULT 'pending',
    "deletedAt" TIMESTAMP(3),
    "canceledAt" TIMESTAMP(3),
    "companyId" TEXT,
    "bookId" TEXT,
    "reviewedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "carReview_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "car"."Brand" (
    "id" TEXT NOT NULL,
    "en" TEXT NOT NULL,
    "ar" TEXT,
    "ku" TEXT,
    "image" TEXT,
    "sort" INTEGER NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "available" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Brand_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "car"."favoriteCars" (
    "id" TEXT NOT NULL,
    "userId" TEXT,
    "carId" TEXT,
    "postedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "favoriteCars_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "car"."recentlyViewedCar" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "carId" TEXT NOT NULL,
    "viewedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "recentlyViewedCar_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "car"."carReviewFlag" (
    "id" TEXT NOT NULL,
    "serial" SERIAL NOT NULL,
    "companyId" TEXT NOT NULL,
    "reviewId" TEXT NOT NULL,
    "flaggedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" "enums"."ReviewStatus" NOT NULL DEFAULT 'flagged',
    "carId" TEXT,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "carReviewFlag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "company"."company" (
    "id" TEXT NOT NULL,
    "serial" SERIAL NOT NULL,
    "companyId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "desc" TEXT,
    "image" VARCHAR(1000),
    "userId" TEXT NOT NULL,
    "activeDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "rate" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "review" INTEGER NOT NULL DEFAULT 0,
    "available" BOOLEAN NOT NULL DEFAULT true,
    "joinedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "company_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "company"."contact" (
    "id" TEXT NOT NULL,
    "countrCode" TEXT,
    "value" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "type" "enums"."ContactTypes" NOT NULL DEFAULT 'phone',
    "available" BOOLEAN NOT NULL DEFAULT true,
    "sort" INTEGER,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "contact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "company"."companyReview" (
    "id" TEXT NOT NULL,
    "serial" SERIAL NOT NULL,
    "reviewId" TEXT,
    "desc" TEXT NOT NULL,
    "rate" INTEGER NOT NULL,
    "companyId" TEXT,
    "userId" TEXT,
    "status" "enums"."ReviewStatus" NOT NULL DEFAULT 'pending',
    "canceledAt" TIMESTAMP(3),
    "reviewedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "companyReview_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "company"."companyReviewFlag" (
    "id" TEXT NOT NULL,
    "reviewId" TEXT NOT NULL,
    "serial" SERIAL NOT NULL,
    "status" "enums"."ReviewStatus" NOT NULL DEFAULT 'flagged',
    "deletedAt" TIMESTAMP(3),
    "flaggedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "companyId" TEXT NOT NULL,

    CONSTRAINT "companyReviewFlag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "company"."companyStatus" (
    "id" TEXT NOT NULL,
    "comanyId" TEXT,
    "status" "enums"."CompanyStatuses" NOT NULL DEFAULT 'live',
    "reason" TEXT,
    "postedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "companyStatus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "company"."CompanyPlans" (
    "id" TEXT NOT NULL,
    "companyId" TEXT,
    "activeDate" TIMESTAMP(3) NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "postedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CompanyPlans_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "location"."location" (
    "id" TEXT NOT NULL,
    "lat" DOUBLE PRECISION NOT NULL,
    "long" DOUBLE PRECISION NOT NULL,
    "companyId" TEXT NOT NULL,
    "townId" TEXT,
    "radiusKm" INTEGER,
    "cityId" TEXT,
    "pglocation" geography(Point, 4326),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "location_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "location"."carLocation" (
    "id" TEXT NOT NULL,
    "lat" DOUBLE PRECISION NOT NULL,
    "long" DOUBLE PRECISION NOT NULL,
    "companyId" TEXT NOT NULL,
    "townId" TEXT,
    "carId" TEXT,
    "radiusKm" INTEGER,
    "cityId" TEXT,
    "location" geography(Point, 4326),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "carLocation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "location"."city" (
    "id" TEXT NOT NULL,
    "en" TEXT NOT NULL,
    "ku" TEXT NOT NULL,
    "ar" TEXT NOT NULL,
    "lat" DOUBLE PRECISION,
    "long" DOUBLE PRECISION,
    "radiusKm" INTEGER,
    "sort" INTEGER,
    "pglocation" geography(Point, 4326),
    "available" BOOLEAN NOT NULL DEFAULT true,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "city_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "location"."town" (
    "id" TEXT NOT NULL,
    "en" TEXT NOT NULL,
    "ku" TEXT NOT NULL,
    "ar" TEXT NOT NULL,
    "lat" DOUBLE PRECISION,
    "long" DOUBLE PRECISION,
    "radiusKm" INTEGER,
    "cityId" TEXT NOT NULL,
    "sort" INTEGER,
    "pglocation" geography(Point, 4326),
    "available" BOOLEAN NOT NULL DEFAULT true,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "town_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user"."user" (
    "id" TEXT NOT NULL,
    "serial" SERIAL NOT NULL,
    "userId" VARCHAR(50) NOT NULL,
    "email" VARCHAR(200) NOT NULL,
    "password" VARCHAR(500) NOT NULL,
    "userName" TEXT,
    "joinedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),
    "countryCode" TEXT NOT NULL DEFAULT '+964',
    "phoneNumber" VARCHAR(50) NOT NULL,
    "platform" TEXT,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user"."profile" (
    "id" VARCHAR(50) NOT NULL,
    "serial" SERIAL NOT NULL,
    "userId" VARCHAR(50) NOT NULL,
    "email" VARCHAR(200) NOT NULL,
    "phoneNumber" VARCHAR(50) NOT NULL,
    "image" VARCHAR(1000),
    "name" VARCHAR(100) NOT NULL,
    "userName" VARCHAR(100),
    "countryCode" TEXT NOT NULL DEFAULT '+964',
    "platform" TEXT,
    "joinedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "emailVerifiedAt" TIMESTAMP(3),
    "phoneVerifiedAt" TIMESTAMP(3),
    "deletedAt" TIMESTAMP(3),
    "roleId" TEXT NOT NULL,
    "prefLang" TEXT,

    CONSTRAINT "profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user"."accountStatus" (
    "id" VARCHAR(50) NOT NULL,
    "userId" VARCHAR(50) NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "bannedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "bannedUntil" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "accountStatus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user"."session" (
    "id" VARCHAR(50) NOT NULL,
    "sessionId" TEXT NOT NULL,
    "userId" VARCHAR(50) NOT NULL,
    "systemName" TEXT,
    "isPhysicalDevice" TEXT,
    "model" TEXT,
    "localizedModel" TEXT,
    "systemVersion" TEXT,
    "name" TEXT,
    "identifierForVendor" TEXT,
    "ip" TEXT,
    "platform" TEXT,
    "lastLogin" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "token" TEXT,
    "revoked" BOOLEAN,
    "expiresAt" TIMESTAMP(3),
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "session_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user"."userActivityLog" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "details" JSONB,
    "ip" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "userActivityLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user"."role" (
    "roleId" VARCHAR(50) NOT NULL,
    "roleName" TEXT NOT NULL,
    "description" TEXT,

    CONSTRAINT "role_pkey" PRIMARY KEY ("roleId")
);

-- CreateTable
CREATE TABLE "user"."permission" (
    "permissionId" VARCHAR(50) NOT NULL,
    "permissionName" TEXT NOT NULL,
    "description" TEXT,

    CONSTRAINT "permission_pkey" PRIMARY KEY ("permissionId")
);

-- CreateTable
CREATE TABLE "user"."UserPermissions" (
    "id" VARCHAR(50) NOT NULL,
    "userId" VARCHAR(50) NOT NULL,
    "permissionId" VARCHAR(50) NOT NULL,

    CONSTRAINT "UserPermissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user"."rolePermission" (
    "id" VARCHAR(50) NOT NULL,
    "roleId" VARCHAR(50) NOT NULL,
    "permissionId" VARCHAR(50) NOT NULL,
    "assignedBy" VARCHAR(50),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "rolePermission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user"."resetPassword" (
    "id" TEXT NOT NULL,
    "email" TEXT,
    "countryCode" TEXT DEFAULT '+964',
    "phoneNumber" TEXT,
    "code" TEXT NOT NULL,
    "verifyStatus" "enums"."VerifyStatus" NOT NULL DEFAULT 'pending',
    "type" "enums"."ResetPasswordType" NOT NULL DEFAULT 'phone',
    "ip" TEXT,
    "attempts" INTEGER NOT NULL DEFAULT 0,
    "expireAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "postedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "resetPassword_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user"."AccountInfo" (
    "id" TEXT NOT NULL,
    "lat" DOUBLE PRECISION,
    "long" DOUBLE PRECISION,
    "userId" TEXT,

    CONSTRAINT "AccountInfo_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "notification_id_key" ON "appSetting"."notification"("id");

-- CreateIndex
CREATE INDEX "notification_postedAt_idx" ON "appSetting"."notification"("postedAt");

-- CreateIndex
CREATE UNIQUE INDEX "book_id_key" ON "book"."book"("id");

-- CreateIndex
CREATE INDEX "book_userId_idx" ON "book"."book"("userId");

-- CreateIndex
CREATE INDEX "book_carId_idx" ON "book"."book"("carId");

-- CreateIndex
CREATE INDEX "book_companyId_idx" ON "book"."book"("companyId");

-- CreateIndex
CREATE INDEX "book_startDate_idx" ON "book"."book"("startDate");

-- CreateIndex
CREATE INDEX "book_endDate_idx" ON "book"."book"("endDate");

-- CreateIndex
CREATE INDEX "book_bookedAt_idx" ON "book"."book"("bookedAt");

-- CreateIndex
CREATE INDEX "book_totalPrice_idx" ON "book"."book"("totalPrice");

-- CreateIndex
CREATE INDEX "book_basePrice_idx" ON "book"."book"("basePrice");

-- CreateIndex
CREATE UNIQUE INDEX "rental_plan_id_key" ON "book"."rental_plan"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Plan_id_key" ON "book"."Plan"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Plan_periodType_key" ON "book"."Plan"("periodType");

-- CreateIndex
CREATE UNIQUE INDEX "promotion_id_key" ON "book"."promotion"("id");

-- CreateIndex
CREATE UNIQUE INDEX "promotion_code_key" ON "book"."promotion"("code");

-- CreateIndex
CREATE INDEX "promotion_code_idx" ON "book"."promotion"("code");

-- CreateIndex
CREATE INDEX "promotion_usesCount_idx" ON "book"."promotion"("usesCount");

-- CreateIndex
CREATE INDEX "promotion_maxUses_idx" ON "book"."promotion"("maxUses");

-- CreateIndex
CREATE INDEX "promotion_carId_idx" ON "book"."promotion"("carId");

-- CreateIndex
CREATE INDEX "promotion_companyId_idx" ON "book"."promotion"("companyId");

-- CreateIndex
CREATE UNIQUE INDEX "usedPromotion_bookId_key" ON "book"."usedPromotion"("bookId");

-- CreateIndex
CREATE INDEX "usedPromotion_userId_idx" ON "book"."usedPromotion"("userId");

-- CreateIndex
CREATE INDEX "usedPromotion_promotionId_idx" ON "book"."usedPromotion"("promotionId");

-- CreateIndex
CREATE INDEX "usedPromotion_planId_idx" ON "book"."usedPromotion"("planId");

-- CreateIndex
CREATE INDEX "usedPromotion_rentalPlanId_idx" ON "book"."usedPromotion"("rentalPlanId");

-- CreateIndex
CREATE INDEX "usedPromotion_companyId_idx" ON "book"."usedPromotion"("companyId");

-- CreateIndex
CREATE UNIQUE INDEX "usedPromotion_userId_promotionId_carId_key" ON "book"."usedPromotion"("userId", "promotionId", "carId");

-- CreateIndex
CREATE UNIQUE INDEX "usedPromotion_userId_promotionId_companyId_key" ON "book"."usedPromotion"("userId", "promotionId", "companyId");

-- CreateIndex
CREATE UNIQUE INDEX "usedPromotion_userId_promotionId_planId_key" ON "book"."usedPromotion"("userId", "promotionId", "planId");

-- CreateIndex
CREATE UNIQUE INDEX "usedPromotion_userId_promotionId_rentalPlanId_key" ON "book"."usedPromotion"("userId", "promotionId", "rentalPlanId");

-- CreateIndex
CREATE UNIQUE INDEX "usedPromotion_userId_promotionId_key" ON "book"."usedPromotion"("userId", "promotionId");

-- CreateIndex
CREATE INDEX "promotionRedemption_promotionId_idx" ON "book"."promotionRedemption"("promotionId");

-- CreateIndex
CREATE INDEX "promotionRedemption_userId_idx" ON "book"."promotionRedemption"("userId");

-- CreateIndex
CREATE INDEX "promotionRedemption_carId_idx" ON "book"."promotionRedemption"("carId");

-- CreateIndex
CREATE INDEX "promotionRedemption_rentalPlanId_idx" ON "book"."promotionRedemption"("rentalPlanId");

-- CreateIndex
CREATE INDEX "promotionRedemption_planId_idx" ON "book"."promotionRedemption"("planId");

-- CreateIndex
CREATE UNIQUE INDEX "car_id_key" ON "car"."car"("id");

-- CreateIndex
CREATE INDEX "car_companyId_idx" ON "car"."car"("companyId");

-- CreateIndex
CREATE UNIQUE INDEX "feature_id_key" ON "car"."feature"("id");

-- CreateIndex
CREATE UNIQUE INDEX "feature_carId_key" ON "car"."feature"("carId");

-- CreateIndex
CREATE INDEX "feature_carId_idx" ON "car"."feature"("carId");

-- CreateIndex
CREATE INDEX "feature_carTypeId_idx" ON "car"."feature"("carTypeId");

-- CreateIndex
CREATE UNIQUE INDEX "image_id_key" ON "car"."image"("id");

-- CreateIndex
CREATE UNIQUE INDEX "carReview_id_key" ON "car"."carReview"("id");

-- CreateIndex
CREATE INDEX "carReview_userId_idx" ON "car"."carReview"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Brand_id_key" ON "car"."Brand"("id");

-- CreateIndex
CREATE UNIQUE INDEX "favoriteCars_id_key" ON "car"."favoriteCars"("id");

-- CreateIndex
CREATE INDEX "favoriteCars_userId_idx" ON "car"."favoriteCars"("userId");

-- CreateIndex
CREATE INDEX "favoriteCars_carId_idx" ON "car"."favoriteCars"("carId");

-- CreateIndex
CREATE UNIQUE INDEX "favoriteCars_carId_userId_key" ON "car"."favoriteCars"("carId", "userId");

-- CreateIndex
CREATE UNIQUE INDEX "recentlyViewedCar_id_key" ON "car"."recentlyViewedCar"("id");

-- CreateIndex
CREATE INDEX "recentlyViewedCar_userId_idx" ON "car"."recentlyViewedCar"("userId");

-- CreateIndex
CREATE INDEX "recentlyViewedCar_userId_carId_idx" ON "car"."recentlyViewedCar"("userId", "carId");

-- CreateIndex
CREATE INDEX "recentlyViewedCar_userId_viewedAt_idx" ON "car"."recentlyViewedCar"("userId", "viewedAt");

-- CreateIndex
CREATE UNIQUE INDEX "recentlyViewedCar_userId_carId_key" ON "car"."recentlyViewedCar"("userId", "carId");

-- CreateIndex
CREATE UNIQUE INDEX "carReviewFlag_reviewId_key" ON "car"."carReviewFlag"("reviewId");

-- CreateIndex
CREATE UNIQUE INDEX "carReviewFlag_companyId_reviewId_key" ON "car"."carReviewFlag"("companyId", "reviewId");

-- CreateIndex
CREATE UNIQUE INDEX "company_id_key" ON "company"."company"("id");

-- CreateIndex
CREATE UNIQUE INDEX "company_userId_key" ON "company"."company"("userId");

-- CreateIndex
CREATE INDEX "company_userId_idx" ON "company"."company"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "contact_id_key" ON "company"."contact"("id");

-- CreateIndex
CREATE INDEX "contact_companyId_idx" ON "company"."contact"("companyId");

-- CreateIndex
CREATE UNIQUE INDEX "companyReview_id_key" ON "company"."companyReview"("id");

-- CreateIndex
CREATE INDEX "companyReview_companyId_idx" ON "company"."companyReview"("companyId");

-- CreateIndex
CREATE INDEX "companyReview_userId_idx" ON "company"."companyReview"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "companyReviewFlag_reviewId_key" ON "company"."companyReviewFlag"("reviewId");

-- CreateIndex
CREATE INDEX "companyReviewFlag_reviewId_idx" ON "company"."companyReviewFlag"("reviewId");

-- CreateIndex
CREATE UNIQUE INDEX "companyReviewFlag_companyId_reviewId_key" ON "company"."companyReviewFlag"("companyId", "reviewId");

-- CreateIndex
CREATE UNIQUE INDEX "companyStatus_id_key" ON "company"."companyStatus"("id");

-- CreateIndex
CREATE INDEX "companyStatus_comanyId_idx" ON "company"."companyStatus"("comanyId");

-- CreateIndex
CREATE INDEX "companyStatus_status_idx" ON "company"."companyStatus"("status");

-- CreateIndex
CREATE UNIQUE INDEX "CompanyPlans_id_key" ON "company"."CompanyPlans"("id");

-- CreateIndex
CREATE UNIQUE INDEX "CompanyPlans_companyId_key" ON "company"."CompanyPlans"("companyId");

-- CreateIndex
CREATE INDEX "CompanyPlans_companyId_idx" ON "company"."CompanyPlans"("companyId");

-- CreateIndex
CREATE UNIQUE INDEX "location_id_key" ON "location"."location"("id");

-- CreateIndex
CREATE UNIQUE INDEX "location_companyId_key" ON "location"."location"("companyId");

-- CreateIndex
CREATE INDEX "location_radiusKm_idx" ON "location"."location"("radiusKm");

-- CreateIndex
CREATE INDEX "location_lat_idx" ON "location"."location"("lat");

-- CreateIndex
CREATE INDEX "location_long_idx" ON "location"."location"("long");

-- CreateIndex
CREATE UNIQUE INDEX "location_id_companyId_key" ON "location"."location"("id", "companyId");

-- CreateIndex
CREATE UNIQUE INDEX "location_cityId_key" ON "location"."location"("cityId");

-- CreateIndex
CREATE UNIQUE INDEX "carLocation_id_key" ON "location"."carLocation"("id");

-- CreateIndex
CREATE UNIQUE INDEX "carLocation_carId_key" ON "location"."carLocation"("carId");

-- CreateIndex
CREATE INDEX "carLocation_radiusKm_idx" ON "location"."carLocation"("radiusKm");

-- CreateIndex
CREATE INDEX "carLocation_lat_idx" ON "location"."carLocation"("lat");

-- CreateIndex
CREATE INDEX "carLocation_long_idx" ON "location"."carLocation"("long");

-- CreateIndex
CREATE INDEX "carLocation_carId_idx" ON "location"."carLocation"("carId");

-- CreateIndex
CREATE INDEX "carLocation_townId_idx" ON "location"."carLocation"("townId");

-- CreateIndex
CREATE INDEX "carLocation_cityId_idx" ON "location"."carLocation"("cityId");

-- CreateIndex
CREATE UNIQUE INDEX "city_id_key" ON "location"."city"("id");

-- CreateIndex
CREATE INDEX "city_radiusKm_idx" ON "location"."city"("radiusKm");

-- CreateIndex
CREATE INDEX "city_lat_idx" ON "location"."city"("lat");

-- CreateIndex
CREATE INDEX "city_long_idx" ON "location"."city"("long");

-- CreateIndex
CREATE UNIQUE INDEX "town_id_key" ON "location"."town"("id");

-- CreateIndex
CREATE INDEX "town_radiusKm_idx" ON "location"."town"("radiusKm");

-- CreateIndex
CREATE INDEX "town_lat_idx" ON "location"."town"("lat");

-- CreateIndex
CREATE INDEX "town_long_idx" ON "location"."town"("long");

-- CreateIndex
CREATE INDEX "town_cityId_idx" ON "location"."town"("cityId");

-- CreateIndex
CREATE UNIQUE INDEX "user_id_key" ON "user"."user"("id");

-- CreateIndex
CREATE UNIQUE INDEX "user_userId_key" ON "user"."user"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "user_email_key" ON "user"."user"("email");

-- CreateIndex
CREATE UNIQUE INDEX "user_userName_key" ON "user"."user"("userName");

-- CreateIndex
CREATE INDEX "user_userId_idx" ON "user"."user"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "user_countryCode_phoneNumber_key" ON "user"."user"("countryCode", "phoneNumber");

-- CreateIndex
CREATE UNIQUE INDEX "profile_id_key" ON "user"."profile"("id");

-- CreateIndex
CREATE UNIQUE INDEX "profile_serial_key" ON "user"."profile"("serial");

-- CreateIndex
CREATE UNIQUE INDEX "profile_userId_key" ON "user"."profile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "profile_email_key" ON "user"."profile"("email");

-- CreateIndex
CREATE UNIQUE INDEX "profile_phoneNumber_key" ON "user"."profile"("phoneNumber");

-- CreateIndex
CREATE UNIQUE INDEX "profile_userName_key" ON "user"."profile"("userName");

-- CreateIndex
CREATE INDEX "profile_userId_idx" ON "user"."profile"("userId");

-- CreateIndex
CREATE INDEX "profile_phoneNumber_idx" ON "user"."profile"("phoneNumber");

-- CreateIndex
CREATE INDEX "profile_name_idx" ON "user"."profile"("name");

-- CreateIndex
CREATE INDEX "profile_email_idx" ON "user"."profile"("email");

-- CreateIndex
CREATE INDEX "profile_roleId_idx" ON "user"."profile"("roleId");

-- CreateIndex
CREATE UNIQUE INDEX "profile_countryCode_phoneNumber_key" ON "user"."profile"("countryCode", "phoneNumber");

-- CreateIndex
CREATE UNIQUE INDEX "accountStatus_id_key" ON "user"."accountStatus"("id");

-- CreateIndex
CREATE INDEX "accountStatus_userId_idx" ON "user"."accountStatus"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "session_sessionId_key" ON "user"."session"("sessionId");

-- CreateIndex
CREATE INDEX "session_sessionId_idx" ON "user"."session"("sessionId");

-- CreateIndex
CREATE INDEX "session_userId_idx" ON "user"."session"("userId");

-- CreateIndex
CREATE INDEX "userActivityLog_userId_idx" ON "user"."userActivityLog"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "role_roleId_key" ON "user"."role"("roleId");

-- CreateIndex
CREATE INDEX "role_roleName_idx" ON "user"."role"("roleName");

-- CreateIndex
CREATE UNIQUE INDEX "permission_permissionId_key" ON "user"."permission"("permissionId");

-- CreateIndex
CREATE INDEX "permission_permissionName_idx" ON "user"."permission"("permissionName");

-- CreateIndex
CREATE UNIQUE INDEX "UserPermissions_id_key" ON "user"."UserPermissions"("id");

-- CreateIndex
CREATE UNIQUE INDEX "UserPermissions_userId_permissionId_key" ON "user"."UserPermissions"("userId", "permissionId");

-- CreateIndex
CREATE INDEX "rolePermission_roleId_idx" ON "user"."rolePermission"("roleId");

-- CreateIndex
CREATE UNIQUE INDEX "rolePermission_roleId_permissionId_key" ON "user"."rolePermission"("roleId", "permissionId");

-- CreateIndex
CREATE UNIQUE INDEX "resetPassword_code_key" ON "user"."resetPassword"("code");

-- CreateIndex
CREATE INDEX "resetPassword_phoneNumber_idx" ON "user"."resetPassword"("phoneNumber");

-- CreateIndex
CREATE INDEX "resetPassword_email_idx" ON "user"."resetPassword"("email");

-- CreateIndex
CREATE INDEX "resetPassword_code_idx" ON "user"."resetPassword"("code");

-- CreateIndex
CREATE INDEX "resetPassword_postedAt_idx" ON "user"."resetPassword"("postedAt");

-- CreateIndex
CREATE INDEX "resetPassword_expireAt_idx" ON "user"."resetPassword"("expireAt");

-- CreateIndex
CREATE UNIQUE INDEX "AccountInfo_id_key" ON "user"."AccountInfo"("id");

-- CreateIndex
CREATE UNIQUE INDEX "AccountInfo_userId_key" ON "user"."AccountInfo"("userId");

-- CreateIndex
CREATE INDEX "AccountInfo_userId_idx" ON "user"."AccountInfo"("userId");

-- AddForeignKey
ALTER TABLE "book"."book" ADD CONSTRAINT "book_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"."profile"("userId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."book" ADD CONSTRAINT "book_carId_fkey" FOREIGN KEY ("carId") REFERENCES "car"."car"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."book" ADD CONSTRAINT "book_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"."company"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."book" ADD CONSTRAINT "book_rentalPlanId_fkey" FOREIGN KEY ("rentalPlanId") REFERENCES "book"."rental_plan"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."book" ADD CONSTRAINT "book_promotionId_fkey" FOREIGN KEY ("promotionId") REFERENCES "book"."promotion"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."book" ADD CONSTRAINT "book_planId_fkey" FOREIGN KEY ("planId") REFERENCES "book"."Plan"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."rental_plan" ADD CONSTRAINT "rental_plan_carId_fkey" FOREIGN KEY ("carId") REFERENCES "car"."car"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."rental_plan" ADD CONSTRAINT "rental_plan_planId_fkey" FOREIGN KEY ("planId") REFERENCES "book"."Plan"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."rental_plan" ADD CONSTRAINT "rental_plan_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"."company"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."promotion" ADD CONSTRAINT "promotion_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"."company"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."promotion" ADD CONSTRAINT "promotion_carId_fkey" FOREIGN KEY ("carId") REFERENCES "car"."car"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."promotion" ADD CONSTRAINT "promotion_rentalPlanId_fkey" FOREIGN KEY ("rentalPlanId") REFERENCES "book"."rental_plan"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."promotion" ADD CONSTRAINT "promotion_planId_fkey" FOREIGN KEY ("planId") REFERENCES "book"."Plan"("id") ON DELETE SET DEFAULT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."usedPromotion" ADD CONSTRAINT "usedPromotion_promotionId_fkey" FOREIGN KEY ("promotionId") REFERENCES "book"."promotion"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."usedPromotion" ADD CONSTRAINT "usedPromotion_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"."profile"("userId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."usedPromotion" ADD CONSTRAINT "usedPromotion_carId_fkey" FOREIGN KEY ("carId") REFERENCES "car"."car"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."usedPromotion" ADD CONSTRAINT "usedPromotion_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"."company"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."usedPromotion" ADD CONSTRAINT "usedPromotion_rentalPlanId_fkey" FOREIGN KEY ("rentalPlanId") REFERENCES "book"."rental_plan"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."usedPromotion" ADD CONSTRAINT "usedPromotion_planId_fkey" FOREIGN KEY ("planId") REFERENCES "book"."Plan"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."usedPromotion" ADD CONSTRAINT "usedPromotion_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "book"."book"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."promotionRedemption" ADD CONSTRAINT "promotionRedemption_promotionId_fkey" FOREIGN KEY ("promotionId") REFERENCES "book"."promotion"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."promotionRedemption" ADD CONSTRAINT "promotionRedemption_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"."profile"("userId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."promotionRedemption" ADD CONSTRAINT "promotionRedemption_carId_fkey" FOREIGN KEY ("carId") REFERENCES "car"."car"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."promotionRedemption" ADD CONSTRAINT "promotionRedemption_rentalPlanId_fkey" FOREIGN KEY ("rentalPlanId") REFERENCES "book"."rental_plan"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."promotionRedemption" ADD CONSTRAINT "promotionRedemption_planId_fkey" FOREIGN KEY ("planId") REFERENCES "book"."Plan"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."promotionRedemption" ADD CONSTRAINT "promotionRedemption_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"."company"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book"."promotionRedemption" ADD CONSTRAINT "promotionRedemption_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "book"."book"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."car" ADD CONSTRAINT "car_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"."company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."car" ADD CONSTRAINT "car_brandId_fkey" FOREIGN KEY ("brandId") REFERENCES "car"."Brand"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."car" ADD CONSTRAINT "car_typeId_fkey" FOREIGN KEY ("typeId") REFERENCES "car"."carType"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."feature" ADD CONSTRAINT "feature_brandId_fkey" FOREIGN KEY ("brandId") REFERENCES "car"."Brand"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."feature" ADD CONSTRAINT "feature_carTypeId_fkey" FOREIGN KEY ("carTypeId") REFERENCES "car"."carType"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."feature" ADD CONSTRAINT "feature_carId_fkey" FOREIGN KEY ("carId") REFERENCES "car"."car"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."image" ADD CONSTRAINT "image_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"."company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."image" ADD CONSTRAINT "image_carId_fkey" FOREIGN KEY ("carId") REFERENCES "car"."car"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."carReview" ADD CONSTRAINT "carReview_carId_fkey" FOREIGN KEY ("carId") REFERENCES "car"."car"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."carReview" ADD CONSTRAINT "carReview_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"."profile"("userId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."carReview" ADD CONSTRAINT "carReview_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "book"."book"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."carReview" ADD CONSTRAINT "carReview_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"."company"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."favoriteCars" ADD CONSTRAINT "favoriteCars_carId_fkey" FOREIGN KEY ("carId") REFERENCES "car"."car"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."favoriteCars" ADD CONSTRAINT "favoriteCars_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"."profile"("userId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."recentlyViewedCar" ADD CONSTRAINT "recentlyViewedCar_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"."profile"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."recentlyViewedCar" ADD CONSTRAINT "recentlyViewedCar_carId_fkey" FOREIGN KEY ("carId") REFERENCES "car"."car"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."carReviewFlag" ADD CONSTRAINT "carReviewFlag_carId_fkey" FOREIGN KEY ("carId") REFERENCES "car"."car"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."carReviewFlag" ADD CONSTRAINT "carReviewFlag_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"."company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "car"."carReviewFlag" ADD CONSTRAINT "carReviewFlag_reviewId_fkey" FOREIGN KEY ("reviewId") REFERENCES "car"."carReview"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company"."company" ADD CONSTRAINT "company_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"."profile"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company"."contact" ADD CONSTRAINT "contact_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"."company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company"."companyReview" ADD CONSTRAINT "companyReview_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"."company"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company"."companyReview" ADD CONSTRAINT "companyReview_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"."profile"("userId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company"."companyReviewFlag" ADD CONSTRAINT "companyReviewFlag_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"."company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company"."companyReviewFlag" ADD CONSTRAINT "companyReviewFlag_reviewId_fkey" FOREIGN KEY ("reviewId") REFERENCES "company"."companyReview"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company"."companyStatus" ADD CONSTRAINT "companyStatus_comanyId_fkey" FOREIGN KEY ("comanyId") REFERENCES "company"."company"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company"."CompanyPlans" ADD CONSTRAINT "CompanyPlans_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"."company"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "location"."location" ADD CONSTRAINT "location_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"."company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "location"."location" ADD CONSTRAINT "location_townId_fkey" FOREIGN KEY ("townId") REFERENCES "location"."town"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "location"."location" ADD CONSTRAINT "location_cityId_fkey" FOREIGN KEY ("cityId") REFERENCES "location"."city"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "location"."carLocation" ADD CONSTRAINT "carLocation_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"."company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "location"."carLocation" ADD CONSTRAINT "carLocation_townId_fkey" FOREIGN KEY ("townId") REFERENCES "location"."town"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "location"."carLocation" ADD CONSTRAINT "carLocation_carId_fkey" FOREIGN KEY ("carId") REFERENCES "car"."car"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "location"."carLocation" ADD CONSTRAINT "carLocation_cityId_fkey" FOREIGN KEY ("cityId") REFERENCES "location"."city"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "location"."town" ADD CONSTRAINT "town_cityId_fkey" FOREIGN KEY ("cityId") REFERENCES "location"."city"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user"."profile" ADD CONSTRAINT "profile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"."user"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user"."profile" ADD CONSTRAINT "profile_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "user"."role"("roleId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user"."accountStatus" ADD CONSTRAINT "accountStatus_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"."profile"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user"."session" ADD CONSTRAINT "session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"."profile"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user"."userActivityLog" ADD CONSTRAINT "userActivityLog_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"."profile"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user"."UserPermissions" ADD CONSTRAINT "UserPermissions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"."profile"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user"."UserPermissions" ADD CONSTRAINT "UserPermissions_permissionId_fkey" FOREIGN KEY ("permissionId") REFERENCES "user"."permission"("permissionId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user"."rolePermission" ADD CONSTRAINT "rolePermission_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "user"."role"("roleId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user"."rolePermission" ADD CONSTRAINT "rolePermission_permissionId_fkey" FOREIGN KEY ("permissionId") REFERENCES "user"."permission"("permissionId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user"."rolePermission" ADD CONSTRAINT "rolePermission_assignedBy_fkey" FOREIGN KEY ("assignedBy") REFERENCES "user"."profile"("userId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user"."AccountInfo" ADD CONSTRAINT "AccountInfo_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"."profile"("userId") ON DELETE SET NULL ON UPDATE CASCADE;
