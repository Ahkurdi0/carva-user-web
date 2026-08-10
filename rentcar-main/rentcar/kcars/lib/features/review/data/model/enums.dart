import 'package:dart_mappable/dart_mappable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kcars/translations/locale_keys.g.dart';

part 'enums.mapper.dart';

@MappableEnum()
enum ReviewStatus {
  pending,
  accepted,
  canceled,
  flagged,
  deleted;

  String getStatus() => switch (this) {
    pending => LocaleKeys.reviewStatus_pending.tr(),
    accepted => LocaleKeys.reviewStatus_approved.tr(),
    canceled => LocaleKeys.reviewStatus_canceled.tr(),
    flagged => LocaleKeys.reviewStatus_flagged.tr(),
    deleted => LocaleKeys.reviewStatus_deleted.tr(),
  };
}
