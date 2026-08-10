import { Router } from 'express';
import { botSafeRateLimiter } from '../middleware/preview_rate';
import { asyncErrorHandler } from '../utils/async_wrap';
import { isAuthenticated } from '../middleware/is_authenticated';
import { validateParamSchema } from '../middleware/valiadation';
import { CUID2 } from '../validation/common';
import { requestedCar } from '../controllers/user';

export default (router: Router) => {
  router.get(
    `/car/:id`,
    asyncErrorHandler(isAuthenticated({ required: false })),
    asyncErrorHandler(botSafeRateLimiter),
    validateParamSchema(CUID2),
    asyncErrorHandler(requestedCar),
  );
};
