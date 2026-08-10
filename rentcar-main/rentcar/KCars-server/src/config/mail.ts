import nodemailer from 'nodemailer';

const isProduction = process.env.NODE_ENV === 'production';

export const transporter = nodemailer.createTransport({
  host: process.env.SMTP,
  port: isProduction ? 465 : 587, // true for 465, false for other ports
  secure: isProduction,
  auth: {
    user: process.env.GMAIL_USER,
    pass: process.env.GMAIL_PASSWORD,
  },
});
