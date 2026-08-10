import { Router } from 'express';
import admin from './admin';
import auth from './auth';
import company from './company';
import user from './user';
import publicRoute from './public';
import verifyReset from './verify_reset_email';
const router = Router();

export default (): Router => {
  auth(router);
  admin(router);
  user(router);
  company(router);
  verifyReset(router);
  publicRoute(router);

  return router;
};
