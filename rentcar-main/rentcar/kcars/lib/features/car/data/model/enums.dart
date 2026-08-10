import 'package:dart_mappable/dart_mappable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kcars/translations/locale_keys.g.dart';
part 'enums.mapper.dart';

@MappableEnum()
enum Transmission {
  manual,
  automatic,
  amt,
  cvt,
  dct,
  sp;

  transmissionType() => switch (this) {
    manual => LocaleKeys.transmission_manual.tr(),
    automatic => LocaleKeys.transmission_automatic.tr(),
    amt => "AMT",
    cvt => "CVT",
    dct => "DCT",
    sp => "SP",
  };
}

@MappableEnum()
enum Fuel {
  diesel,
  gasoline,
  electric,
  hybird,
  lpg,
  cng;

  String getFuel() => switch (this) {
    diesel => LocaleKeys.fuel_diesel.tr(),
    gasoline => LocaleKeys.fuel_gasoline.tr(),
    electric => LocaleKeys.fuel_electric.tr(),
    hybird => LocaleKeys.fuel_hybrid.tr(),
    lpg => LocaleKeys.fuel_lpg.tr(),
    cng => LocaleKeys.fuel_cng.tr(),
  };
}

@MappableEnum()
enum RentalPeriodType {
  hourly,
  daily,
  weekly,
  monthly;

  periodType() => switch (this) {
    hourly => LocaleKeys.rentalPeriodType_hourly.tr(),
    daily => LocaleKeys.rentalPeriodType_daily.tr(),
    weekly => LocaleKeys.rentalPeriodType_weekly.tr(),
    monthly => LocaleKeys.rentalPeriodType_monthly.tr(),
  };
  periodPerType() => switch (this) {
    hourly => LocaleKeys.rentalPeriodPerType_hourly.tr(),
    daily => LocaleKeys.rentalPeriodPerType_daily.tr(),
    weekly => LocaleKeys.rentalPeriodPerType_weekly.tr(),
    monthly => LocaleKeys.rentalPeriodPerType_monthly.tr(),
  };
  periodDuration(int duration) => switch (this) {
    hourly => LocaleKeys.labels_hourP.plural(duration),
    daily => LocaleKeys.labels_dayP.plural(duration),
    monthly => LocaleKeys.labels_monthP.plural(duration),
    weekly => LocaleKeys.labels_hourP.plural(duration),
  };
}

@MappableEnum()
enum PromotionPriceType {
  percentage,
  fixed;

  pricePromotionType() => switch (this) {
    percentage => "%",
    fixed => LocaleKeys.labels_iqd.tr(),
  };
}

@MappableEnum()
enum PromotionType { car, company, plan, rentalPlan }

enum MapMarkerType { company, car }

@MappableEnum()
enum SlideType { car, company, url }

@MappableEnum()
enum Currency {
  iqd,
  usd;

  String getCurrency() => switch (this) {
    usd => LocaleKeys.currency_usd.tr(),
    iqd => LocaleKeys.currency_iqd.tr(),
  };

  String getSymboal() => switch (this) {
    usd => "\$",
    iqd => LocaleKeys.currency_iqd.tr(),
  };
}
