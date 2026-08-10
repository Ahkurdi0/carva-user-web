import 'package:dart_mappable/dart_mappable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kcars/translations/locale_keys.g.dart';
part 'enums.mapper.dart';

@MappableEnum()
enum ContactTypes {
  phone,
  email,
  whatsapp,
  viber;

  String getTitle() => switch (this) {
    phone => LocaleKeys.inputLabels_phoneNumber.tr(),
    email => LocaleKeys.inputLabels_email.tr(),
    whatsapp => LocaleKeys.buttons_whatsapp.tr(),
    _ => name,
  };
}
