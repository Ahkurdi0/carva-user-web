import { Router } from 'express';

import * as AuthController from '../controllers/auth';
import * as authValidation from '../validation/auth';
import { validateSchema } from '../middleware/valiadation';
import { asyncErrorHandler } from '../utils/async_wrap';
import { isAuthenticated } from '../middleware/is_authenticated';
import { Multerr } from '../config/multer';
import { RateLimitters } from '../middleware/rate_limiter';
export default (router: Router) => {
  const api = '/api/v1/auth';

  router.post(
    `${api}/login`,
    validateSchema(authValidation.signInSchema),
    asyncErrorHandler(RateLimitters.auth()),
    asyncErrorHandler(AuthController.login),
  );

  router.post(
    `${api}/signup`,
    validateSchema(authValidation.signUpSchema),
    asyncErrorHandler(RateLimitters.signUp()),
    asyncErrorHandler(AuthController.signup),
  );

  router.post(
    `${api}/refreshToken`,
    asyncErrorHandler(RateLimitters.general()),
    asyncErrorHandler(AuthController.refreshingTokens),
  );

  router.post(
    `${api}/refresh`,
    asyncErrorHandler(isAuthenticated()),
    asyncErrorHandler(RateLimitters.general()),
    asyncErrorHandler(AuthController.refresh),
  );

  router.post(
    `${api}/logout`,
    asyncErrorHandler(isAuthenticated()),
    validateSchema(authValidation.logOutSchema),
    asyncErrorHandler(AuthController.logout),
  );

  router.post(
    `${api}/updateName`,
    validateSchema(authValidation.updateNameSchema),
    asyncErrorHandler(isAuthenticated()),
    asyncErrorHandler(RateLimitters.update()),
    asyncErrorHandler(AuthController.updateName),
  );

  router.post(
    `${api}/updatePhoneNumber`,
    validateSchema(authValidation.updatePhoneNumberSchema),
    asyncErrorHandler(isAuthenticated()),
    asyncErrorHandler(RateLimitters.update()),
    asyncErrorHandler(AuthController.updatePhoneNumber),
  );

  router.post(
    `${api}/updatePassword`,
    validateSchema(authValidation.updatePasswordSchema),
    asyncErrorHandler(isAuthenticated()),
    asyncErrorHandler(RateLimitters.update()),
    asyncErrorHandler(AuthController.updatePassword),
  );

  router.post(
    `${api}/updateProfilePicture`,
    asyncErrorHandler(isAuthenticated()),
    Multerr.single('image'),
    asyncErrorHandler(RateLimitters.update()),
    asyncErrorHandler(AuthController.updateProfilePicture),
  );

  router.post(
    `${api}/deleteAccount`,
    asyncErrorHandler(isAuthenticated()),
    asyncErrorHandler(RateLimitters.general()),
    asyncErrorHandler(AuthController.deleteAccount),
  );
  router.post(
    `${api}/updatePrefLang`,
    asyncErrorHandler(isAuthenticated()),
    asyncErrorHandler(RateLimitters.general()),
    validateSchema(authValidation.prefLangSchema),
    asyncErrorHandler(AuthController.updatePrefLang),
  );
};
