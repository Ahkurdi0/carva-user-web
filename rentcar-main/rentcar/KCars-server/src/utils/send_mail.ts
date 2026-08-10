import { randomInt } from 'crypto';
import { transporter } from '../config/mail';
import { prisma } from '../config/prisma';
import { Exception } from './exception';

interface EmailOptions {
  to: string;
  lang: string;
  code?: string;
  subject?: string;
  text?: string;
}

export function sendEmail({
  to,
  lang,
  code,
  text,
}: EmailOptions): Promise<boolean> {
  return new Promise(async (resolve, reject) => {
    await transporter.sendMail({
      from: '"KCars" <kcarsapp@gmail.com>',
      to: to,
      subject:
        lang === 'ku'
          ? 'پشتڕاستکردنەوەی ئیمەیڵ'
          : lang === 'ar'
            ? 'التحقق من البريد الإلكتروني'
            : 'Email Verification',
      text: text ?? 'Hello world?',
      html: template(code!, lang),
    });
    resolve(true);
  });
}

const template = (code: string, lang: string) => {
  const message = getMessage(lang);

  return `
  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<style type="text/css">
table {
border-collapse: separate;
table-layout: fixed;
mso-table-lspace: 0pt;
mso-table-rspace: 0pt
}
table td {
border-collapse: collapse
}
.ExternalClass {
width: 100%
}
.ExternalClass,
.ExternalClass p,
.ExternalClass span,
.ExternalClass font,
.ExternalClass td,
.ExternalClass div {
line-height: 100%
}
body, a, li, p, h1, h2, h3 {
-ms-text-size-adjust: 100%;
-webkit-text-size-adjust: 100%;
}
html {
-webkit-text-size-adjust: none !important
}
body {
min-width: 100%;
Margin: 0px;
padding: 0px;
}
body, #innerTable {
-webkit-font-smoothing: antialiased;
-moz-osx-font-smoothing: grayscale
}
#innerTable img+div {
display: none;
display: none !important
}
img {
Margin: 0;
padding: 0;
-ms-interpolation-mode: bicubic
}
h1, h2, h3, p, a {
line-height: inherit;
overflow-wrap: normal;
white-space: normal;
word-break: break-word
}
a {
text-decoration: none
}
h1, h2, h3, p {
min-width: 100%!important;
width: 100%!important;
max-width: 100%!important;
display: inline-block!important;
border: 0;
padding: 0;
margin: 0
}
a[x-apple-data-detectors] {
color: inherit !important;
text-decoration: none !important;
font-size: inherit !important;
font-family: inherit !important;
font-weight: inherit !important;
line-height: inherit !important
}
u + #body a {
color: inherit;
text-decoration: none;
font-size: inherit;
font-family: inherit;
font-weight: inherit;
line-height: inherit;
}
a[href^="mailto"],
a[href^="tel"],
a[href^="sms"] {
color: inherit;
text-decoration: none
}
</style>
<style type="text/css">
@media (min-width: 481px) {
.hd { display: none!important }
}
</style>
<style type="text/css">
@media (max-width: 480px) {
.hm { display: none!important }
}
</style>
<style type="text/css">
@media (max-width: 480px) {
.t41,.t46{mso-line-height-alt:0px!important;line-height:0!important;display:none!important}.t42{padding:40px!important;border-radius:0!important}.t20,.t22{max-width:398px!important}.t32{text-align:left!important}.t25{display:revert!important}.t27,.t31{vertical-align:top!important;width:auto!important;max-width:100%!important}
}
</style>
<!--[if !mso]>-->
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&amp;family=Sofia+Sans:wght@700&amp;family=Open+Sans:wght@400;500;600&amp;display=swap" rel="stylesheet" type="text/css" />

</head>
<body id="body" class="t49" style="min-width:100%;Margin:0px;padding:0px;background-color:#FFFFFF;"><div class="t48" style="background-color:#FFFFFF;"><table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" align="center"><tr><td class="t47" style="font-size:0;line-height:0;mso-line-height-rule:exactly;background-color:#FFFFFF;" valign="top" align="center">

<table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" align="center" id="innerTable"><tr><td><div class="t41" style="mso-line-height-rule:exactly;mso-line-height-alt:50px;line-height:50px;font-size:1px;display:block;">&nbsp;&nbsp;</div></td></tr><tr><td align="center">
<table class="t45" role="presentation" cellpadding="0" cellspacing="0" style="Margin-left:auto;Margin-right:auto;"><tr><td width="600" class="t44" style="width:600px;">
<table class="t43" role="presentation" cellpadding="0" cellspacing="0" width="100%" style="width:100%;"><tr><td class="t42" style="border:1px solid #EBEBEB;overflow:hidden;background-color:#FFFFFF;padding:44px 42px 32px 42px;border-radius:3px 3px 3px 3px;"><table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="width:100% !important;"><tr><td align="left">
<table class="t4" role="presentation" cellpadding="0" cellspacing="0" style="Margin-right:auto;"><tr><td width="42" class="t3" style="width:42px;">
<table class="t2" role="presentation" cellpadding="0" cellspacing="0" width="100%" style="width:100%;"><tr><td class="t1"><div style="font-size:0px;"><img class="t0" style="display:block;border:0;height:auto;width:100%;Margin:0;max-width:100%;" width="42" height="42" alt="" src="https://94397881-32de-4ef5-88fa-bdf4ff8ecb25.b-cdn.net/e/b3d5ce16-392f-4e27-9a2c-369a487689fe/a26edb1e-19f4-4be1-9903-44f62bcc5322.png"/></div></td></tr></table>
</td></tr></table>
</td></tr><tr><td><div class="t5" style="mso-line-height-rule:exactly;mso-line-height-alt:42px;line-height:42px;font-size:1px;display:block;">&nbsp;&nbsp;</div></td></tr><tr><td align="center">
<table class="t10" role="presentation" cellpadding="0" cellspacing="0" style="Margin-left:auto;Margin-right:auto;"><tr><td width="514" class="t9" style="width:600px;">
<table class="t8" role="presentation" cellpadding="0" cellspacing="0" width="100%" style="width:100%;"><tr><td class="t7" style="border-bottom:1px solid #EFF1F4;padding:0 0 18px 0;"><h1 class="t6" style="margin:0;Margin:0;font-family:Montserrat,BlinkMacSystemFont,Segoe UI,Helvetica Neue,Arial,sans-serif;line-height:28px;font-weight:700;font-style:normal;font-size:24px;text-decoration:none;text-transform:none;letter-spacing:-1px;direction:ltr;color:#141414;text-align:left;mso-line-height-rule:exactly;mso-text-raise:1px;">${message.title}</h1></td></tr></table>
</td></tr></table>
</td></tr><tr><td><div class="t11" style="mso-line-height-rule:exactly;mso-line-height-alt:18px;line-height:18px;font-size:1px;display:block;">&nbsp;&nbsp;</div></td></tr><tr><td align="center">
<table class="t16" role="presentation" cellpadding="0" cellspacing="0" style="Margin-left:auto;Margin-right:auto;"><tr><td width="514" class="t15" style="width:600px;">
<table class="t14" role="presentation" cellpadding="0" cellspacing="0" width="100%" style="width:100%;"><tr><td class="t13"><p class="t12" style="margin:0;Margin:0;font-family:Open Sans,BlinkMacSystemFont,Segoe UI,Helvetica Neue,Arial,sans-serif;line-height:25px;font-weight:400;font-style:normal;font-size:15px;text-decoration:none;text-transform:none;letter-spacing:-0.1px;direction:ltr;color:#141414;text-align:left;mso-line-height-rule:exactly;mso-text-raise:3px;">${message.message}</p></td></tr></table>
</td></tr></table>
</td></tr><tr><td><div class="t18" style="mso-line-height-rule:exactly;mso-line-height-alt:24px;line-height:24px;font-size:1px;display:block;">&nbsp;&nbsp;</div></td></tr><tr><td align="left">
<table class="t22" role="presentation" cellpadding="0" cellspacing="0" style="Margin-right:auto;max-width:514px;"><tr><td class="t21" style="width:auto;">
<table class="t20" role="presentation" cellpadding="0" cellspacing="0" style="width:auto;max-width:514px;"><tr><td class="t19" style="overflow:hidden;background-color:#F7F7F7;text-align:center;line-height:34px;mso-line-height-rule:exactly;mso-text-raise:5px;padding:0 23px 0 23px;border-radius:4px 4px 4px 4px;"><span class="t17" style="display:block;margin:0;Margin:0;font-family:Sofia Sans,BlinkMacSystemFont,Segoe UI,Helvetica Neue,Arial,sans-serif;line-height:34px;font-weight:700;font-style:normal;font-size:20px;text-decoration:none;text-transform:none;letter-spacing:1px;direction:ltr;color:#222222;text-align:center;mso-line-height-rule:exactly;mso-text-raise:5px;">${code}</span></td></tr></table>
</td></tr></table>
</td></tr><tr><td><div class="t36" style="mso-line-height-rule:exactly;mso-line-height-alt:40px;line-height:40px;font-size:1px;display:block;">&nbsp;&nbsp;</div></td></tr><tr><td align="center">
<table class="t40" role="presentation" cellpadding="0" cellspacing="0" style="Margin-left:auto;Margin-right:auto;"><tr><td width="514" class="t39" style="width:600px;">
<table class="t38" role="presentation" cellpadding="0" cellspacing="0" width="100%" style="width:100%;"><tr><td class="t37" style="border-top:1px solid #DFE1E4;padding:24px 0 0 0;"><div class="t35" style="width:100%;text-align:left;"><div class="t34" style="display:inline-block;"><table class="t33" role="presentation" cellpadding="0" cellspacing="0" align="left" valign="top">
<tr class="t32"><td></td><td class="t27" valign="top">
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" class="t26" style="width:auto;"><tr><td class="t24" style="background-color:#FFFFFF;text-align:center;line-height:20px;mso-line-height-rule:exactly;mso-text-raise:2px;"><span class="t23" style="display:block;margin:0;Margin:0;font-family:Open Sans,BlinkMacSystemFont,Segoe UI,Helvetica Neue,Arial,sans-serif;line-height:20px;font-weight:600;font-style:normal;font-size:14px;text-decoration:none;direction:ltr;color:#222222;text-align:center;mso-line-height-rule:exactly;mso-text-raise:2px;">KCars</span></td><td class="t25" style="width:20px;" width="20"></td></tr></table>
</td><td class="t31" valign="top">
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" class="t30" style="width:auto;"><tr><td class="t29" style="background-color:#FFFFFF;text-align:center;line-height:20px;mso-line-height-rule:exactly;mso-text-raise:2px;"><span class="t28" style="display:block;margin:0;Margin:0;font-family:Open Sans,BlinkMacSystemFont,Segoe UI,Helvetica Neue,Arial,sans-serif;line-height:20px;font-weight:500;font-style:normal;font-size:14px;text-decoration:none;direction:ltr;color:#B4BECC;text-align:center;mso-line-height-rule:exactly;mso-text-raise:2px;">https://kcars.com</span></td></tr></table>
</td>
<td></td></tr>
</table></div></div></td></tr></table>
</td></tr></table>
</td></tr></table></td></tr></table>
</td></tr></table>
</td></tr><tr><td><div class="t46" style="mso-line-height-rule:exactly;mso-line-height-alt:50px;line-height:50px;font-size:1px;display:block;">&nbsp;&nbsp;</div></td></tr></table></td></tr></table></div><div class="gmail-fix" style="display: none; white-space: nowrap; font: 15px courier; line-height: 0;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</div></body>
</html>
  `;
};

function getMessage(lang: string): {
  title: string;
  message: string;
  warning: string;
} {
  switch (lang) {
    case 'en':
      return {
        title: 'Email Verification',
        message:
          'To complete your registration, please use the following verification code:',
        warning: 'If you did not request this, please ignore this email.',
      };
      break;
    case 'ku':
      return {
        title: 'پشتڕاستکردنەوەی ئیمەیڵ',
        message:
          'بۆ پشتڕاستکردنەوەی ئیمەیڵەکەت ئەم کۆدە بەەکار بهێنە بۆ ماوەی ١٠ خولەک چالاکە',
        warning:
          'ئەگەر تۆ داوای ئەم کۆدەت نەکردووە، تکایە ئەم ئیمەیڵە پشتگوێ بخە',
      };
      break;
    case 'ar':
      return {
        title: 'التحقق من البريد الإلكتروني',
        message: 'لتمامة التسجيل ، يرجى استخدام الكود التالي لاكمال التسجيل:',
        warning: 'اذا لم تطلب هذا الكود ، يرجى تجاهل هذا البريد الإلكتروني.',
      };
      break;
    default:
      return {
        title: '',
        warning: '',
        message: '',
      };
  }
}

function generateVerificationCode(): number {
  return randomInt(100000, 1000000);
}

function getExpirationTime(): Date {
  const expirationTime = new Date();
  expirationTime.setMinutes(expirationTime.getMinutes() + 10);
  return expirationTime;
}

export const sendEmailVerificationCode = async (
  email: string,
  lang: string,
  ip: string | undefined,
) => {
  try {
    const verificationCode = generateVerificationCode();
    const expirationTime = getExpirationTime();
    await prisma.resetPassword.create({
      data: {
        code: `${verificationCode}`,
        email,
        expireAt: expirationTime,
        verifyStatus: 'pending',
        type: 'email',
        ip,
      },
    });
    await sendEmail({ to: email, code: verificationCode.toString(), lang });
  } catch (error) {
    throw new Exception(400, 'send_otp_failed');
  }
};
