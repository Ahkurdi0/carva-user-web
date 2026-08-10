import { Router } from 'express';
import { asyncErrorHandler } from '../utils/async_wrap';
import * as Controller from '../controllers/admin';
import { validateSchema } from '../middleware/valiadation';
import { CursorSchema, IDV7schema, UserIdSchmea } from '../validation/common';
import { hasPermissions } from '../middleware/has_permission';
import { Permissions } from '../constants/permissions';
import * as Schema from '../validation/admin';
import { Multerr } from '../config/multer';
export default (router: Router) => {
  const api = '/api/v1/admin';

  router.post(
    `${api}/users`,
    validateSchema(Schema.UserCursor),
    asyncErrorHandler(hasPermissions(Permissions.users)),
    asyncErrorHandler(Controller.users),
  );

  router.post(
    `${api}/permissions`,
    asyncErrorHandler(hasPermissions(Permissions.user_roles)),
    asyncErrorHandler(Controller.permissions),
  );

  router.post(
    `${api}/updateRole`,
    validateSchema(Schema.UpdateUserRoleSchema),
    asyncErrorHandler(hasPermissions(Permissions.user_roles)),
    asyncErrorHandler(Controller.updateUserRole),
  );

  router.post(
    `${api}/newCompany`,
    validateSchema(Schema.CreateCompanySchemas),
    asyncErrorHandler(hasPermissions(Permissions.createCompany)),
    asyncErrorHandler(Controller.newCompany),
  );

  router.post(
    `${api}/updateCompnayStatus`,
    validateSchema(Schema.CompanyStatusSchema),
    asyncErrorHandler(hasPermissions(Permissions.companyStatuses)),
    asyncErrorHandler(Controller.updateCompnayStatus),
  );

  router.post(
    `${api}/companies`,
    validateSchema(Schema.CompaniesSchema),
    asyncErrorHandler(hasPermissions(Permissions.company)),
    asyncErrorHandler(Controller.companies),
  );

  router.post(
    `${api}/allBooks`,
    validateSchema(Schema.AllBooksSchema),
    asyncErrorHandler(hasPermissions(Permissions.books)),
    asyncErrorHandler(Controller.allBooks),
  );

  router.post(
    `${api}/allCars`,
    validateSchema(CursorSchema),
    asyncErrorHandler(hasPermissions(Permissions.companyCars)),
    asyncErrorHandler(Controller.allCars),
  );

  router.post(
    `${api}/allCarReviews`,
    validateSchema(Schema.AllReviewSchema),
    asyncErrorHandler(hasPermissions(Permissions.carReviews)),
    asyncErrorHandler(Controller.allCarReviews),
  );

  router.post(
    `${api}/carReviewFlags`,
    validateSchema(Schema.AllReviewSchema),
    asyncErrorHandler(hasPermissions(Permissions.carReviewsFlag)),
    asyncErrorHandler(Controller.carReviewFlags),
  );

  router.post(
    `${api}/allCompanyReviews`,
    validateSchema(Schema.AllReviewSchema),
    asyncErrorHandler(hasPermissions(Permissions.companyReviews)),
    asyncErrorHandler(Controller.allCompanyReviews),
  );

  router.post(
    `${api}/companyReviewFlags`,
    validateSchema(Schema.AllReviewSchema),
    asyncErrorHandler(hasPermissions(Permissions.carReviewsFlag)),
    asyncErrorHandler(Controller.companyReviewFlags),
  );

  router.post(
    `${api}/companyStatuses`,
    validateSchema(CursorSchema),
    asyncErrorHandler(hasPermissions(Permissions.companyStatuses)),
    asyncErrorHandler(Controller.companyStatuses),
  );

  router.post(
    `${api}/updateAccountStatus`,
    validateSchema(Schema.BanUserSchema),
    asyncErrorHandler(hasPermissions(Permissions.account_status)),
    asyncErrorHandler(Controller.banUser),
  );

  router.post(
    `${api}/bannedUsers`,
    validateSchema(CursorSchema),
    asyncErrorHandler(hasPermissions(Permissions.account_status)),
    asyncErrorHandler(Controller.bannedUsers),
  );

  router.post(
    `${api}/accountStatuses`,
    validateSchema(Schema.AccountStatusSchema),
    asyncErrorHandler(hasPermissions(Permissions.account_status)),
    asyncErrorHandler(Controller.accountStatuses),
  );

  router.post(
    `${api}/deleteBan`,
    validateSchema(IDV7schema),
    asyncErrorHandler(hasPermissions(Permissions.account_status)),
    asyncErrorHandler(Controller.deleleteBan),
  );

  router.post(
    `${api}/updateUserPassword`,
    validateSchema(Schema.UpdatePasswordSchema),
    asyncErrorHandler(hasPermissions(Permissions.updateUserPassword)),
    asyncErrorHandler(Controller.updateUserPassword),
  );

  router.post(
    `${api}/recoverAccount`,
    validateSchema(UserIdSchmea),
    asyncErrorHandler(hasPermissions(Permissions.recoverAccount)),
    asyncErrorHandler(Controller.recoverAccount),
  );

  router.post(
    `${api}/updateCarReview`,
    validateSchema(Schema.UpdateReviewSchema),
    asyncErrorHandler(hasPermissions(Permissions.carReviews)),
    asyncErrorHandler(Controller.updateCarReview),
  );
  router.post(
    `${api}/updateCompanyReview`,
    validateSchema(Schema.UpdateReviewSchema),
    asyncErrorHandler(hasPermissions(Permissions.companyReviews)),
    asyncErrorHandler(Controller.updateCompanyReview),
  );

  router.post(
    `${api}/newBrand`,
    Multerr.single('image'),
    validateSchema(Schema.NewBrandSchema),
    asyncErrorHandler(hasPermissions(Permissions.brands)),
    asyncErrorHandler(Controller.newBrand),
  );

  router.post(
    `${api}/sortBrand`,
    validateSchema(Schema.SortSchema),
    asyncErrorHandler(hasPermissions(Permissions.brands)),
    asyncErrorHandler(Controller.sortBrands),
  );

  router.post(
    `${api}/deleteBrand`,
    validateSchema(IDV7schema),
    asyncErrorHandler(hasPermissions(Permissions.brands)),
    asyncErrorHandler(Controller.deleteBrand),
  );

  router.post(
    `${api}/newCarType`,
    validateSchema(Schema.NewCarTypeSchema),
    asyncErrorHandler(hasPermissions(Permissions.carTypes)),
    asyncErrorHandler(Controller.newCarType),
  );

  router.post(
    `${api}/sortCarType`,
    validateSchema(Schema.SortSchema),
    asyncErrorHandler(hasPermissions(Permissions.carTypes)),
    asyncErrorHandler(Controller.sortCarType),
  );

  router.post(
    `${api}/deleteCarType`,
    validateSchema(IDV7schema),
    asyncErrorHandler(hasPermissions(Permissions.carTypes)),
    asyncErrorHandler(Controller.deleteCarType),
  );

  router.post(
    `${api}/cities`,
    asyncErrorHandler(hasPermissions(Permissions.cities)),
    asyncErrorHandler(Controller.cities),
  );

  router.post(
    `${api}/newCity`,
    validateSchema(Schema.NewCitySchema),
    asyncErrorHandler(hasPermissions(Permissions.cities)),
    asyncErrorHandler(Controller.newCity),
  );

  router.post(
    `${api}/sortCity`,
    validateSchema(Schema.SortSchema),
    asyncErrorHandler(hasPermissions(Permissions.cities)),
    asyncErrorHandler(Controller.sortCity),
  );

  router.post(
    `${api}/deleteCity`,
    validateSchema(IDV7schema),
    asyncErrorHandler(hasPermissions(Permissions.cities)),
    asyncErrorHandler(Controller.deleteCity),
  );

  router.post(
    `${api}/newTown`,
    validateSchema(Schema.NewTownSchema),
    asyncErrorHandler(hasPermissions(Permissions.towns)),
    asyncErrorHandler(Controller.newTown),
  );

  router.post(
    `${api}/sortTown`,
    validateSchema(Schema.SortSchema),
    asyncErrorHandler(hasPermissions(Permissions.towns)),
    asyncErrorHandler(Controller.sortTown),
  );

  router.post(
    `${api}/deleteTown`,
    validateSchema(IDV7schema),
    asyncErrorHandler(hasPermissions(Permissions.towns)),
    asyncErrorHandler(Controller.deleteTown),
  );

  router.post(
    `${api}/newSupport`,
    Multerr.single('image'),
    asyncErrorHandler(hasPermissions(Permissions.support)),
    validateSchema(Schema.newSupportSchema),
    asyncErrorHandler(Controller.newSupport),
  );
  router.post(
    `${api}/sortSupport`,
    asyncErrorHandler(hasPermissions(Permissions.support)),
    validateSchema(Schema.SortSchema),
    asyncErrorHandler(Controller.sortSupport),
  );

  router.post(
    `${api}/deleteSupport`,
    asyncErrorHandler(hasPermissions(Permissions.support)),
    validateSchema(IDV7schema),
    asyncErrorHandler(Controller.deleteSupport),
  );

  router.post(
    `${api}/featuredCars`,
    asyncErrorHandler(hasPermissions(Permissions.companyCars)),
    asyncErrorHandler(Controller.featuredCars),
  );
  router.post(
    `${api}/newFeaturedCar`,
    asyncErrorHandler(hasPermissions(Permissions.companyCars)),
    validateSchema(Schema.FeaturedCarsScehma),
    asyncErrorHandler(Controller.newFeatureCar),
  );
  router.post(
    `${api}/sortFeaturedCar`,
    asyncErrorHandler(hasPermissions(Permissions.companyCars)),
    validateSchema(Schema.SortSchema),
    asyncErrorHandler(Controller.sortFeaturedCars),
  );

  router.post(
    `${api}/deleteFeaturedCar`,
    asyncErrorHandler(hasPermissions(Permissions.companyCars)),
    validateSchema(IDV7schema),
    asyncErrorHandler(Controller.deleteFeaturedCars),
  );

  router.post(
    `${api}/newSlider`,
    Multerr.single('image'),
    asyncErrorHandler(hasPermissions(Permissions.sliders)),
    validateSchema(Schema.newSliderSchema),
    asyncErrorHandler(Controller.newSlider),
  );
  router.post(
    `${api}/sortSlider`,
    asyncErrorHandler(hasPermissions(Permissions.sliders)),
    validateSchema(Schema.SortSchema),
    asyncErrorHandler(Controller.sortSlider),
  );

  router.post(
    `${api}/deleteSlider`,
    asyncErrorHandler(hasPermissions(Permissions.sliders)),
    validateSchema(IDV7schema),
    asyncErrorHandler(Controller.deleteSlider),
  );

  router.post(
    `${api}/newNotification`,
    asyncErrorHandler(hasPermissions(Permissions.notification)),
    validateSchema(Schema.newNotificationSchema),
    asyncErrorHandler(Controller.newNotification),
  );
  router.post(
    `${api}/deleteNotification`,
    asyncErrorHandler(hasPermissions(Permissions.notification)),
    validateSchema(IDV7schema),
    asyncErrorHandler(Controller.deleteNotification),
  );

  router.post(
    `${api}/companyStatistics`,
    asyncErrorHandler(hasPermissions(Permissions.admin_statistics)),
    asyncErrorHandler(Controller.companyStatistics),
  );

  router.post(
    `${api}/statistics`,
    asyncErrorHandler(hasPermissions(Permissions.admin_statistics)),
    asyncErrorHandler(Controller.statistics),
  );
};
