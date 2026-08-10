// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'enums.dart';

class TransmissionMapper extends EnumMapper<Transmission> {
  TransmissionMapper._();

  static TransmissionMapper? _instance;
  static TransmissionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TransmissionMapper._());
    }
    return _instance!;
  }

  static Transmission fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Transmission decode(dynamic value) {
    switch (value) {
      case r'manual':
        return Transmission.manual;
      case r'automatic':
        return Transmission.automatic;
      case r'amt':
        return Transmission.amt;
      case r'cvt':
        return Transmission.cvt;
      case r'dct':
        return Transmission.dct;
      case r'sp':
        return Transmission.sp;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Transmission self) {
    switch (self) {
      case Transmission.manual:
        return r'manual';
      case Transmission.automatic:
        return r'automatic';
      case Transmission.amt:
        return r'amt';
      case Transmission.cvt:
        return r'cvt';
      case Transmission.dct:
        return r'dct';
      case Transmission.sp:
        return r'sp';
    }
  }
}

extension TransmissionMapperExtension on Transmission {
  String toValue() {
    TransmissionMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Transmission>(this) as String;
  }
}

class FuelMapper extends EnumMapper<Fuel> {
  FuelMapper._();

  static FuelMapper? _instance;
  static FuelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FuelMapper._());
    }
    return _instance!;
  }

  static Fuel fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Fuel decode(dynamic value) {
    switch (value) {
      case r'diesel':
        return Fuel.diesel;
      case r'gasoline':
        return Fuel.gasoline;
      case r'electric':
        return Fuel.electric;
      case r'hybird':
        return Fuel.hybird;
      case r'lpg':
        return Fuel.lpg;
      case r'cng':
        return Fuel.cng;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Fuel self) {
    switch (self) {
      case Fuel.diesel:
        return r'diesel';
      case Fuel.gasoline:
        return r'gasoline';
      case Fuel.electric:
        return r'electric';
      case Fuel.hybird:
        return r'hybird';
      case Fuel.lpg:
        return r'lpg';
      case Fuel.cng:
        return r'cng';
    }
  }
}

extension FuelMapperExtension on Fuel {
  String toValue() {
    FuelMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Fuel>(this) as String;
  }
}

class RentalPeriodTypeMapper extends EnumMapper<RentalPeriodType> {
  RentalPeriodTypeMapper._();

  static RentalPeriodTypeMapper? _instance;
  static RentalPeriodTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RentalPeriodTypeMapper._());
    }
    return _instance!;
  }

  static RentalPeriodType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  RentalPeriodType decode(dynamic value) {
    switch (value) {
      case r'hourly':
        return RentalPeriodType.hourly;
      case r'daily':
        return RentalPeriodType.daily;
      case r'weekly':
        return RentalPeriodType.weekly;
      case r'monthly':
        return RentalPeriodType.monthly;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(RentalPeriodType self) {
    switch (self) {
      case RentalPeriodType.hourly:
        return r'hourly';
      case RentalPeriodType.daily:
        return r'daily';
      case RentalPeriodType.weekly:
        return r'weekly';
      case RentalPeriodType.monthly:
        return r'monthly';
    }
  }
}

extension RentalPeriodTypeMapperExtension on RentalPeriodType {
  String toValue() {
    RentalPeriodTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<RentalPeriodType>(this) as String;
  }
}

class PromotionPriceTypeMapper extends EnumMapper<PromotionPriceType> {
  PromotionPriceTypeMapper._();

  static PromotionPriceTypeMapper? _instance;
  static PromotionPriceTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PromotionPriceTypeMapper._());
    }
    return _instance!;
  }

  static PromotionPriceType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  PromotionPriceType decode(dynamic value) {
    switch (value) {
      case r'percentage':
        return PromotionPriceType.percentage;
      case r'fixed':
        return PromotionPriceType.fixed;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(PromotionPriceType self) {
    switch (self) {
      case PromotionPriceType.percentage:
        return r'percentage';
      case PromotionPriceType.fixed:
        return r'fixed';
    }
  }
}

extension PromotionPriceTypeMapperExtension on PromotionPriceType {
  String toValue() {
    PromotionPriceTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<PromotionPriceType>(this) as String;
  }
}

class PromotionTypeMapper extends EnumMapper<PromotionType> {
  PromotionTypeMapper._();

  static PromotionTypeMapper? _instance;
  static PromotionTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PromotionTypeMapper._());
    }
    return _instance!;
  }

  static PromotionType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  PromotionType decode(dynamic value) {
    switch (value) {
      case r'car':
        return PromotionType.car;
      case r'company':
        return PromotionType.company;
      case r'plan':
        return PromotionType.plan;
      case r'rentalPlan':
        return PromotionType.rentalPlan;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(PromotionType self) {
    switch (self) {
      case PromotionType.car:
        return r'car';
      case PromotionType.company:
        return r'company';
      case PromotionType.plan:
        return r'plan';
      case PromotionType.rentalPlan:
        return r'rentalPlan';
    }
  }
}

extension PromotionTypeMapperExtension on PromotionType {
  String toValue() {
    PromotionTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<PromotionType>(this) as String;
  }
}

class SlideTypeMapper extends EnumMapper<SlideType> {
  SlideTypeMapper._();

  static SlideTypeMapper? _instance;
  static SlideTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideTypeMapper._());
    }
    return _instance!;
  }

  static SlideType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SlideType decode(dynamic value) {
    switch (value) {
      case r'car':
        return SlideType.car;
      case r'company':
        return SlideType.company;
      case r'url':
        return SlideType.url;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SlideType self) {
    switch (self) {
      case SlideType.car:
        return r'car';
      case SlideType.company:
        return r'company';
      case SlideType.url:
        return r'url';
    }
  }
}

extension SlideTypeMapperExtension on SlideType {
  String toValue() {
    SlideTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SlideType>(this) as String;
  }
}

class CurrencyMapper extends EnumMapper<Currency> {
  CurrencyMapper._();

  static CurrencyMapper? _instance;
  static CurrencyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CurrencyMapper._());
    }
    return _instance!;
  }

  static Currency fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Currency decode(dynamic value) {
    switch (value) {
      case r'iqd':
        return Currency.iqd;
      case r'usd':
        return Currency.usd;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Currency self) {
    switch (self) {
      case Currency.iqd:
        return r'iqd';
      case Currency.usd:
        return r'usd';
    }
  }
}

extension CurrencyMapperExtension on Currency {
  String toValue() {
    CurrencyMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Currency>(this) as String;
  }
}
