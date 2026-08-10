import * as OneSignal from '@onesignal/node-onesignal';
import 'dotenv/config';
import { getData, setData } from '../config/redis';
import { asyncWrap } from './async_wrap';
import { prisma } from '../config/prisma';
import { Notification } from 'prisma/prisma-client';
import { PermissionKeys } from '../constants/permissions';
const configuration = OneSignal.createConfiguration({
  authMethods: {
    rest_api_key: {
      tokenProvider: {
        getToken(): Promise<string> | string {
          return process.env.ONESIGNAL_USER_KEY;
        },
      },
    },
    organization_api_key: {
      tokenProvider: {
        getToken(): Promise<string> | string {
          return process.env.ONESIGNAL_ORGANIZATIONKEY!;
        },
      },
    },
  },
});

const client = new OneSignal.DefaultApi(configuration);

function createNotification(): OneSignal.Notification {
  const notification = new OneSignal.Notification();
  notification.app_id = process.env.ONESIGNAL_APPID as string;
  notification.android_channel_id = process.env.ANDROID_CHANELL_ID;
  notification.priority = 10;
  notification.content_available = true;
  notification.target_channel = 'push';
  return notification;
}

const enNotification = createNotification();
const arNotification = createNotification();
const kuNotification = createNotification();

const notification = createNotification();

type ContentType = {
  title: string;
  content: string;
};
type AdminNotificationParams = {
  content: ContentType;
  adminAccess?: PermissionKeys;
};
export const sendNotificationToUsers = async ({
  userId,
  content,
}: {
  userId?: string | null;
  content: ContentType;
}) => {
  if (userId == null) return;

  notification.headings = { en: content.title };
  notification.contents = { en: content.content };
  notification.included_segments = ['included_external_id'];
  notification.include_aliases = { external_id: [userId] };
  notification.content_available = true;
  try {
    const notifications = await client.createNotification(notification);

    return notifications;
  } catch (error) {
    return error;
  }
};

const adnotification = new OneSignal.Notification();

export const sendNotificationToAdmin = async ({
  content,
  adminAccess,
}: AdminNotificationParams) => {
  adnotification.app_id = process.env.ONESIGNAL_APPID as string;
  adnotification.android_channel_id = process.env.ANDROID_CHANELL_ID;
  adnotification.priority = 10;
  adnotification.content_available = true;
  adnotification.target_channel = 'push';
  adnotification.headings = { en: content.title };
  adnotification.contents = { en: content.content };

  var admins = await getData<string[] | null>(`kcarsAdmins_${adminAccess}`);

  if (!admins || admins.length === 0) {
    const fromDb = await prisma.profile.findMany({
      where: {
        role: { roleName: 'admin' },
      },
      select: {
        userId: true,
        permissions: {
          select: { permission: true },
          where: {
            permission: { permissionName: adminAccess },
          },
        },
      },
    });

    admins = fromDb
      .map((admin) => admin.userId)
      .flat()
      .filter((userId) => userId !== null) as string[];

    await asyncWrap(() => setData(`kcarsAdmins_${adminAccess}`, admins, 600));
  }

  adnotification.included_segments = ['included_external_id'];
  adnotification.include_aliases = { external_id: [...admins] };

  try {
    const notificationssssss = await client.createNotification(adnotification);

    return notificationssssss;
  } catch (error) {
    return error;
  }
};

export const sendNotificationToAllUsers = async (
  title: string,
  content: string,
) => {
  const notification = createNotification();

  const notificationss = await client.createNotification(notification);

  return notificationss;
};

export const sendLocalizedNotificationToAllUsers = async (
  content: Notification,
) => {
  enNotification.headings = { en: content.enTitle };
  enNotification.contents = { en: content.enDescription };

  arNotification.headings = { en: content.arTitle };
  arNotification.contents = { en: content.arDescription };

  kuNotification.headings = { en: content.kuTitle };
  kuNotification.contents = { en: content.kuDescription };

  enNotification.filters = [
    { field: 'tag', key: 'appLang', relation: '=', value: 'en' },
  ];

  arNotification.filters = [
    { field: 'tag', key: 'appLang', relation: '=', value: 'ar' },
  ];

  kuNotification.filters = [
    { field: 'tag', key: 'appLang', relation: '=', value: 'ku' },
  ];

  try {
    const ennotificationss = await client.createNotification(enNotification);
    const arnotificationss = await client.createNotification(arNotification);
    const kuNotificationss = await client.createNotification(kuNotification);
  } catch (error) {
    return error;
  }
};
