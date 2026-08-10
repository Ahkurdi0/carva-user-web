import app from './app';
import config from './config/config';
process.env.AWS_SDK_JS_SUPPRESS_MAINTENANCE_MODE_MESSAGE = '1';

export const server = app.listen(config.port, () => {
  console.log(`Server running on port ${config.port}`);
});
