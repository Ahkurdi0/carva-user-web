import { Router } from 'express';

import { validateSchema } from '../middleware/valiadation';
import * as Controller from '../controllers/company';
import { Multerr } from '../config/multer';
import { asyncErrorHandler } from '../utils/async_wrap';

import * as Schema1 from '../validation/company';
import * as Schema2 from '../validation/common';
import { isAllowed } from '../middleware/is_allowed';
import { Permissions } from '../constants/permissions';
const Schema = { ...Schema1, ...Schema2 };

export default (router: Router) => {
  const api = '/api/v1/company';

  router.post(
    `${api}/car/new`,
    Multerr.fields([{ name: 'images', maxCount: 5 }]),
    validateSchema(Schema.ListCarSchema),
    asyncErrorHandler(isAllowed(Permissions.companyCars)),
    asyncErrorHandler(Controller.listCar),
  );
  router.post(
    `${api}/car/update`,
    Multerr.fields([{ name: 'images', maxCount: 5 }]),
    validateSchema(Schema.updateCarSchema),
    asyncErrorHandler(isAllowed(Permissions.companyCars)),
    asyncErrorHandler(Controller.updateCar),
  );

  router.post(
    `${api}/car/delete`,
    validateSchema(Schema.IDV7schema),
    asyncErrorHandler(isAllowed(Permissions.companyCars)),
    asyncErrorHandler(Controller.deleteCar),
  );

  router.post(
    `${api}/car/sort`,
    validateSchema(Schema.SortCarImagesSchema),
    asyncErrorHandler(isAllowed(Permissions.companyCars)),
    asyncErrorHandler(Controller.sortCarImages),
  );

  router.post(
    `${api}/promotions/`,
    validateSchema(Schema.PromotionsSchema),
    asyncErrorHandler(isAllowed(Permissions.companyCars)),
    asyncErrorHandler(Controller.promotions),
  );

  router.post(
    `${api}/promotion/new`,
    validateSchema(Schema.PromotionSchema),
    asyncErrorHandler(isAllowed(Permissions.companyCars)),
    asyncErrorHandler(Controller.promotion),
  );

  router.post(
    `${api}/promotion/update`,
    validateSchema(Schema.PromotionUpdateSchema),
    asyncErrorHandler(isAllowed(Permissions.companyCars)),
    asyncErrorHandler(Controller.updatePromotion),
  );

  router.post(
    `${api}/promotion/delete`,
    validateSchema(Schema.IDV7schema),
    asyncErrorHandler(isAllowed(Permissions.companyCars)),
    asyncErrorHandler(Controller.deletePromotion),
  );

  router.post(
    `${api}/updateCompany`,
    Multerr.fields([
      { name: 'image', maxCount: 1 },
      { name: 'coverImage', maxCount: 1 },
    ]),
    validateSchema(Schema.UpdateCompanySchema),
    asyncErrorHandler(isAllowed(Permissions.company)),
    asyncErrorHandler(Controller.updateCompnay),
  );
  router.post(
    `${api}/sortContacts`,
    validateSchema(Schema.SortContactsSchema),
    asyncErrorHandler(isAllowed(Permissions.company)),
    asyncErrorHandler(Controller.sortContacts),
  );

  router.post(
    `${api}/getCars`,
    validateSchema(Schema.CarCompanySchema),
    asyncErrorHandler(isAllowed(Permissions.companyCars)),
    asyncErrorHandler(Controller.getCars),
  );

  router.post(
    `${api}/booked`,
    validateSchema(Schema.CompanyBookedSchema),
    asyncErrorHandler(isAllowed(Permissions.books)),
    asyncErrorHandler(Controller.getBooks),
  );

  router.post(
    `${api}/updateBook`,
    validateSchema(Schema.updateBook),
    asyncErrorHandler(isAllowed(Permissions.books)),
    asyncErrorHandler(Controller.updateBook),
  );

  router.post(
    `${api}/companyCarsReviews`,
    asyncErrorHandler(isAllowed(Permissions.carReviews)),
    validateSchema(Schema.CursorSchema),
    asyncErrorHandler(Controller.carReviews),
  );

  router.post(
    `${api}/companiesReviews`,
    asyncErrorHandler(isAllowed(Permissions.companyReviews)),
    asyncErrorHandler(Controller.companyReviews),
  );

  router.post(
    `${api}/brands`,
    asyncErrorHandler(isAllowed(Permissions.brands)),
    asyncErrorHandler(Controller.brands),
  );
  router.post(
    `${api}/carTypes`,
    asyncErrorHandler(isAllowed(Permissions.carTypes)),
    asyncErrorHandler(Controller.carTypes),
  );
  router.post(
    `${api}/plans`,
    asyncErrorHandler(isAllowed(Permissions.company)),
    asyncErrorHandler(Controller.plans),
  );
  router.post(
    `${api}/cities`,
    asyncErrorHandler(isAllowed(Permissions.cities)),
    asyncErrorHandler(Controller.cities),
  );

  router.post(
    `${api}/flagCarReview`,
    validateSchema(Schema.FlagReviewScham),
    asyncErrorHandler(isAllowed(Permissions.carReviewsFlag)),
    asyncErrorHandler(Controller.flagCarReview),
  );

  router.post(
    `${api}/flagCompanyReview`,
    validateSchema(Schema.FlagReviewScham),
    asyncErrorHandler(isAllowed(Permissions.companyReviewsFlag)),
    asyncErrorHandler(Controller.flagCompnayReview),
  );

  router.post(
    `${api}/company`,
    validateSchema(Schema.IDV7schemaOptiona),
    asyncErrorHandler(isAllowed(Permissions.company)),
    asyncErrorHandler(Controller.company),
  );
};
