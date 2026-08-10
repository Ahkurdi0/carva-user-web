import { BookStaus } from 'prisma/prisma-client';

export const allNotifications = ({
  title = '',
  content = '',
}: {
  title?: string;
  content?: string;
}) => {
  const sTitle = title ?? '';
  const sContent = content ?? '';
  return {
    reservation_status: {
      en: {
        title: `Your reservation status is ${sTitle}`,
        content: sContent,
      },
      ar: {
        title: `حالة الحجز الخاصة بك هي ${sTitle}`,
        content: sContent ?? '',
      },
      ku: {
        title: `حجزکردنەکەت ${sTitle}`,
        content: sContent,
      },
    },
    new_reservation: {
      en: {
        title: 'You have new reservation',
        content: `${sTitle} reserved ${sContent}`,
      },
      ar: {
        title: 'لديك حجز جديد',
        content: `${sContent} قام بالحجز ${sTitle}`,
      },
      ku: {
        title: `حجزکردنی نوێت هەیە (${sTitle})`,
        content: `${sContent}`,
      },
    },
    new_car_review: {
      en: {
        title: 'New Car Review',
        content: `${sTitle} Reviewed ${sContent}`,
      },
      ar: {
        title: 'مراجعة سيارة جديدة',
        content: `${sContent} تمت المراجعة ${sTitle}`,
      },
      ku: {
        title: 'پێداچوونەوەی ئۆتۆمبێل',
        content: `${sContent} پێداچوونەوەی کرد بۆ ${sTitle}`,
      },
    },
    new_company_review: {
      en: {
        title: 'New Copmany Review',
        content: `${sTitle} reviwed company`,
      },
      ar: {
        title: 'مراجعة سيارة جديدة',
        content: `لقد قمت بمراجعة شركتك ${sTitle}`,
      },
      ku: {
        title: 'پێداچوونەوەی کۆمپانیا',
        content: `پێداچوونەوەی کرد بۆ کۆمپانیا ${sTitle}`,
      },
    },
  };
};

export type PrefLangs = 'ku' | 'en' | 'ar';

export const getNotificationMessage = <
  T extends keyof ReturnType<typeof allNotifications>,
>({
  notificationType,
  language,
  title,
  content,
}: {
  notificationType: T;
  language: keyof ReturnType<typeof allNotifications>[T];
  title?: string;
  content?: string;
}) => {
  const notifications = allNotifications({ title, content });
  return notifications[notificationType][language];
};

export const getBookStatus = (status: BookStaus, lang: PrefLangs) => {
  switch (status) {
    case 'pending':
      return lang === 'ku'
        ? 'لە چاوەڕوانیدایە'
        : lang == 'ar'
          ? 'في الانتظار'
          : 'Pending';

    case 'completed':
      return lang === 'ku'
        ? 'کۆتایی هات'
        : lang == 'ar'
          ? 'تمكتم'
          : 'Completed';

    case 'canceled':
      return lang === 'ku'
        ? 'هەڵوەشایەوە'
        : lang == 'ar'
          ? 'تم الإلغاء'
          : 'Canceled';

    case 'ongoing':
      return lang === 'ku'
        ? 'لەجێبەجێکردندایە'
        : lang == 'ar'
          ? 'في طور التنفيذ'
          : 'In Process';

    default:
      return '';
  }
};
