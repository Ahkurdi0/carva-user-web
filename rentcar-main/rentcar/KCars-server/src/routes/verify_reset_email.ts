import { Router } from 'express';
import { asyncErrorHandler } from '../utils/async_wrap';
import { isAuthenticated } from '../middleware/is_authenticated';
import * as EmailController from '../controllers/email_otp';
import * as Schema from '../validation/auth';
import { validateSchema } from '../middleware/valiadation';
import { RateLimitters } from '../middleware/rate_limiter';

export default (router: Router) => {
  const api = '/api/v1/auth';
  router.post(
    `${api}/email/v/send`,
    asyncErrorHandler(isAuthenticated()),
    asyncErrorHandler(RateLimitters.vSendOtp()),
    asyncErrorHandler(EmailController.resendEmailVerificationCode),
  );

  router.post(
    `${api}/email/v/verify`,
    validateSchema(Schema.verifyEmailSchema),
    asyncErrorHandler(isAuthenticated()),
    asyncErrorHandler(RateLimitters.vVerifyOtp()),
    asyncErrorHandler(EmailController.verifyEmailAddress),
  );

  router.post(
    `${api}/email/r/send`,
    validateSchema(Schema.emailSchema),
    asyncErrorHandler(RateLimitters.rSendOtp()),
    asyncErrorHandler(EmailController.sendEmailOtpCode),
  );

  router.post(
    `${api}/email/r/verify`,
    validateSchema(Schema.verifyEmailSchema),
    asyncErrorHandler(RateLimitters.rVerifyOtp()),
    asyncErrorHandler(EmailController.verifyEmailOtpCode),
  );

  router.post(
    `${api}/email/r/resetPassword`,
    validateSchema(Schema.resetEmailPasswordSchema),
    asyncErrorHandler(RateLimitters.rResetPassword()),
    asyncErrorHandler(EmailController.emailResetPassword),
  );

  router.post(
    `${api}/email/u/send`,
    validateSchema(Schema.emailSchema),
    asyncErrorHandler(isAuthenticated()),
    asyncErrorHandler(RateLimitters.uSendOtp()),
    asyncErrorHandler(EmailController.sendNewEmailOtpCode),
  );

  router.post(
    `${api}/email/u/verify`,
    validateSchema(Schema.verifyEmailSchema),
    asyncErrorHandler(RateLimitters.uVerifyOtp()),
    asyncErrorHandler(isAuthenticated()),
    asyncErrorHandler(EmailController.updateEmailAddress),
  );

  router.post(
    `${api}/email/r/s/send`,
    asyncErrorHandler(isAuthenticated()),
    asyncErrorHandler(RateLimitters.sSendOtp()),
    asyncErrorHandler(EmailController.resendEmailVerificationCode),
  );

  router.post(
    `${api}/email/r/s/verify`,
    validateSchema(Schema.otpCodeSchema),
    asyncErrorHandler(isAuthenticated()),
    asyncErrorHandler(RateLimitters.sVerifyOtp()),
    asyncErrorHandler(EmailController.singedVerifyOtpCode),
  );

  router.post(
    `${api}/email/r/s/resetPassword`,
    validateSchema(Schema.signedResetPasswordSchema),
    asyncErrorHandler(isAuthenticated()),
    asyncErrorHandler(RateLimitters.sResetPassword()),
    asyncErrorHandler(EmailController.singedResetPassword),
  );
};
