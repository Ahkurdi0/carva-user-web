-- AlterTable
ALTER TABLE "user"."profile" ALTER COLUMN "phoneNumber" DROP NOT NULL;

-- AlterTable
ALTER TABLE "user"."user" ALTER COLUMN "phoneNumber" DROP NOT NULL;
