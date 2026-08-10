import express, { ErrorRequestHandler } from 'express';

import { errorHandler } from './middleware/errorHanlder';
import routes from './routes';
import cors from 'cors';
import { isAuthenticated } from './middleware/is_authenticated';
import { asyncErrorHandler } from './utils/async_wrap';
import 'dotenv/config';

const app = express();

// Behind the web app's reverse proxy / nginx, so req.ip and the per-IP rate
// limiters read the real visitor IP from X-Forwarded-For / X-Real-IP.
app.set('trust proxy', true);

app.use(
  cors({
    origin: process.env.DOMAIN,
    methods: 'POST',
    allowedHeaders: ['Content-Type', 'Authorization'],
    credentials: true,
    optionsSuccessStatus: 200,
  }),
);
app.use(express.json());
app.use('/api/v1/company', asyncErrorHandler(isAuthenticated()));
app.use('/api/v1/admin', asyncErrorHandler(isAuthenticated()));

app.use(routes());
// Routes
// Global error handler (should be after routes)
app.use(errorHandler as ErrorRequestHandler);

export default app;
