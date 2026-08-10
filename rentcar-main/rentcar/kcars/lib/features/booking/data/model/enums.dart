import 'package:dart_mappable/dart_mappable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kcars/translations/locale_keys.g.dart';
part 'enums.mapper.dart';

@MappableEnum()
enum BookStatus {
  pending,
  ongoing,
  canceled,
  refunded,
  rejected,
  completed;

  String getStatus() => switch (this) {
    pending => LocaleKeys.bookStatus_pending.tr(),
    ongoing => LocaleKeys.bookStatus_ongoing.tr(),
    canceled => LocaleKeys.bookStatus_canceled.tr(),
    refunded => LocaleKeys.bookStatus_refunded.tr(),
    rejected => LocaleKeys.bookStatus_rejected.tr(),
    completed => LocaleKeys.bookStatus_completed.tr(),
  };
}
