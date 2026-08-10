import { PrefLangs } from './notifications_messages';

type WhatsAppPayload = {
  phoneNumber: string;
  subject: string;
  carId: string | undefined;
  language: PrefLangs;
};

export function openChat({
  phoneNumber,
  subject,
  carId,
  language,
}: WhatsAppPayload): string {
  const localizedMessage = getLocalizedMessage(language, carId);
  const message = `${subject}\n${localizedMessage}`;
  const encodedMessage = encodeURIComponent(message);

  return `https://wa.me/${phoneNumber}?text=${encodedMessage}`;
}

function getLocalizedMessage(lang: PrefLangs, carId: string | undefined) {
  switch (lang) {
    case 'ku':
      return carId
        ? `پێویستم بە زانیاریی زیاترە دەربارەی ئەم ئۆتۆمبێلە\n https://carvarent.com/car/${carId}`
        : 'هەژمارەکەتمان لە ئەپەکە بینی پێویستمان بە کەمێک زانیاریی زیاترە';
    case 'ar':
      return carId
        ? `نحتاج إلى مزيد من المعلومات حول هذه السيارة للإيجار، هل يمكننا مساعدتي؟\n https://carvarent.com/car/${carId}`
        : 'لقد رأينا حسابك على السيارات ونحتاج إلى مزيد من المعلومات حول هذه السيارة للإيجار، هل يمكننا مساعدتنا؟';
    default:
      return carId
        ? `We need more information about this car to rent. Can you help me?\n https://carvarent.com/car/${carId}`
        : 'We saw your account on Cars and we need more information about this car to rent. Can you help us?';
  }
}
