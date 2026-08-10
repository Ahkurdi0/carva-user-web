import { Router } from 'express';
import { asyncErrorHandler } from '../utils/async_wrap';
import * as Controller from '../controllers/user';
import * as Schema from '../validation/user';
import { isAuthenticated } from '../middleware/is_authenticated';
import { validateSchema } from '../middleware/valiadation';
import { CUID2, CursorSchema, IDV7schema } from '../validation/common';
import { accountStatuses } from '../middleware/account_status';
import { RateLimitters } from '../middleware/rate_limiter';

export default (router: Router) => {
  const api = '/api/v1/user';

  router.post(
    `${api}/suggestedCars`,
    asyncErrorHandler(isAuthenticated({ required: false })),
    asyncErrorHandler(Controller.suggestedCars),
  );

  router.post(
    `${api}/nearBayCars`,
    asyncErrorHandler(isAuthenticated({ required: false })),
    validateSchema(Schema.LocationSchema),
    asyncErrorHandler(Controller.nearBayCars),
  );

  router.post(
    `${api}/explorerMap`,
    asyncErrorHandler(isAuthenticated({ required: false })),
    asyncErrorHandler(RateLimitters.explorerMap()),
    validateSchema(Schema.ExplorerMapSchema),
    asyncErrorHandler(Controller.explorerMap),
  );

  router.post(
    `${api}/brands`,
    asyncErrorHandler(isAuthenticated({ required: false })),
    asyncErrorHandler(Controller.brandCars),
  );

  router.post(
    `${api}/recentlyViewed`,
    asyncErrorHandler(isAuthenticated()),
    asyncErrorHandler(Controller.recentlyViewed),
  );

  router.post(
    `${api}/filterCars`,
    asyncErrorHandler(isAuthenticated({ required: false })),
    validateSchema(Schema.CarFilterSchema),
    asyncErrorHandler(Controller.filteredCars),
  );

  router.post(
    `${api}/applyPromoCode`,
    asyncErrorHandler(isAuthenticated()),
    validateSchema(Schema.ApplyPromoCodeSchema),
    asyncErrorHandler(accountStatuses),
    asyncErrorHandler(RateLimitters.promoCode()),
    asyncErrorHandler(Controller.applyPromotionCode),
  );

  router.post(
    `${api}/bookCar`,
    asyncErrorHandler(isAuthenticated()),
    validateSchema(Schema.BookCarSchema),
    asyncErrorHandler(accountStatuses),
    asyncErrorHandler(Controller.bookAcar),
  );

  router.post(
    `${api}/cancelBook`,
    asyncErrorHandler(isAuthenticated()),
    validateSchema(CUID2),
    asyncErrorHandler(accountStatuses),
    asyncErrorHandler(Controller.cancelBook),
  );

  router.post(
    `${api}/booked`,
    asyncErrorHandler(isAuthenticated()),
    validateSchema(CursorSchema),
    asyncErrorHandler(Controller.bookedCars),
  );

  router.post(
    `${api}/favoriteCar`,
    asyncErrorHandler(isAuthenticated()),
    validateSchema(CursorSchema),
    asyncErrorHandler(Controller.fovoriteCar),
  );

  router.post(
    `${api}/favoriteCars`,
    asyncErrorHandler(isAuthenticated()),
    validateSchema(CursorSchema),
    asyncErrorHandler(Controller.fovoriteCars),
  );

  router.post(
    `${api}/reviewCompany`,
    asyncErrorHandler(isAuthenticated()),
    validateSchema(Schema.CompanyReviewSchema),
    asyncErrorHandler(accountStatuses),
    asyncErrorHandler(Controller.reviewCompany),
  );

  router.post(
    `${api}/deleteCompanyReview`,
    asyncErrorHandler(isAuthenticated()),
    validateSchema(IDV7schema),
    asyncErrorHandler(accountStatuses),
    asyncErrorHandler(Controller.deleteCompanyReview),
  );

  router.post(
    `${api}/reviewCar`,
    asyncErrorHandler(isAuthenticated()),
    validateSchema(Schema.CarReviewSchema),
    asyncErrorHandler(accountStatuses),
    asyncErrorHandler(Controller.reviewCar),
  );

  router.post(
    `${api}/deleteCarReview`,
    asyncErrorHandler(isAuthenticated()),
    validateSchema(IDV7schema),
    asyncErrorHandler(accountStatuses),
    asyncErrorHandler(Controller.deleteCarReview),
  );

  router.post(
    `${api}/carReviews`,
    asyncErrorHandler(isAuthenticated({ required: false })),
    validateSchema(Schema.ReviewCurosrSchema),
    asyncErrorHandler(Controller.carReviews),
  );

  router.post(
    `${api}/company`,
    asyncErrorHandler(isAuthenticated({ required: false })),
    validateSchema(IDV7schema),
    asyncErrorHandler(Controller.company),
  );
  router.post(
    `${api}/companyReviews`,
    asyncErrorHandler(isAuthenticated({ required: false })),
    validateSchema(Schema.ReviewCurosrSchema),
    asyncErrorHandler(Controller.companyReviews),
  );

  router.post(
    `${api}/carDetails`,
    asyncErrorHandler(isAuthenticated({ required: false })),
    validateSchema(CUID2),
    asyncErrorHandler(Controller.detailsCar),
  );

  router.post(
    `${api}/getCars`,
    asyncErrorHandler(isAuthenticated({ required: false })),
    validateSchema(Schema.CarCompanySchema),
    asyncErrorHandler(Controller.getCars),
  );

  router.post(
    `${api}/filters`,
    asyncErrorHandler(isAuthenticated({ required: false })),
    asyncErrorHandler(Controller.filtersData),
  );

  router.post(
    `${api}/cars`,
    asyncErrorHandler(isAuthenticated({ required: false })),
    asyncErrorHandler(Controller.allCars),
  );

  router.post(
    `${api}/supports`,
    asyncErrorHandler(isAuthenticated({ required: false })),
    asyncErrorHandler(Controller.support),
  );

  router.post(
    `${api}/companies`,
    asyncErrorHandler(isAuthenticated({ required: false })),
    asyncErrorHandler(Controller.companies),
  );

  router.post(
    `${api}/contact`,
    validateSchema(Schema.contactCompanySchema),
    asyncErrorHandler(isAuthenticated({ required: false })),
    asyncErrorHandler(Controller.contact),
  );

  router.post(
    `${api}/sliders`,
    asyncErrorHandler(isAuthenticated({ required: false })),
    asyncErrorHandler(Controller.sliders),
  );
  router.post(
    `${api}/slider`,
    asyncErrorHandler(isAuthenticated({ required: false })),
    asyncErrorHandler(Controller.slider),
  );
};
