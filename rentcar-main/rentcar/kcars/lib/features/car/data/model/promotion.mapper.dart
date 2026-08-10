// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'promotion.dart';

class PromotionMapper extends ClassMapperBase<Promotion> {
  PromotionMapper._();

  static PromotionMapper? _instance;
  static PromotionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PromotionMapper._());
      PromotionPriceTypeMapper.ensureInitialized();
      PromotionTypeMapper.ensureInitialized();
      CarMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Promotion';

  static String _$id(Promotion v) => v.id;
  static const Field<Promotion, String> _f$id = Field('id', _$id);
  static String? _$code(Promotion v) => v.code;
  static const Field<Promotion, String> _f$code =
      Field('code', _$code, opt: true);
  static String? _$name(Promotion v) => v.name;
  static const Field<Promotion, String> _f$name =
      Field('name', _$name, opt: true);
  static String? _$description(Promotion v) => v.description;
  static const Field<Promotion, String> _f$description =
      Field('description', _$description, opt: true);
  static PromotionPriceType _$priceType(Promotion v) => v.priceType;
  static const Field<Promotion, PromotionPriceType> _f$priceType =
      Field('priceType', _$priceType);
  static PromotionType _$type(Promotion v) => v.type;
  static const Field<Promotion, PromotionType> _f$type = Field('type', _$type);
  static double? _$value(Promotion v) => v.value;
  static const Field<Promotion, double> _f$value =
      Field('value', _$value, opt: true);
  static double? _$minOrderValue(Promotion v) => v.minOrderValue;
  static const Field<Promotion, double> _f$minOrderValue =
      Field('minOrderValue', _$minOrderValue, opt: true);
  static double? _$maxDiscountAmount(Promotion v) => v.maxDiscountAmount;
  static const Field<Promotion, double> _f$maxDiscountAmount =
      Field('maxDiscountAmount', _$maxDiscountAmount, opt: true);
  static DateTime _$startDate(Promotion v) => v.startDate;
  static const Field<Promotion, DateTime> _f$startDate =
      Field('startDate', _$startDate);
  static DateTime _$endDate(Promotion v) => v.endDate;
  static const Field<Promotion, DateTime> _f$endDate =
      Field('endDate', _$endDate);
  static int? _$maxUses(Promotion v) => v.maxUses;
  static const Field<Promotion, int> _f$maxUses =
      Field('maxUses', _$maxUses, opt: true);
  static int? _$usesCount(Promotion v) => v.usesCount;
  static const Field<Promotion, int> _f$usesCount =
      Field('usesCount', _$usesCount, opt: true);
  static int? _$maxUsePerUser(Promotion v) => v.maxUsePerUser;
  static const Field<Promotion, int> _f$maxUsePerUser =
      Field('maxUsePerUser', _$maxUsePerUser, opt: true);
  static String? _$companyId(Promotion v) => v.companyId;
  static const Field<Promotion, String> _f$companyId =
      Field('companyId', _$companyId, opt: true);
  static String? _$carId(Promotion v) => v.carId;
  static const Field<Promotion, String> _f$carId =
      Field('carId', _$carId, opt: true);
  static String? _$rentalPlanId(Promotion v) => v.rentalPlanId;
  static const Field<Promotion, String> _f$rentalPlanId =
      Field('rentalPlanId', _$rentalPlanId, opt: true);
  static bool? _$available(Promotion v) => v.available;
  static const Field<Promotion, bool> _f$available =
      Field('available', _$available, opt: true);
  static String? _$planId(Promotion v) => v.planId;
  static const Field<Promotion, String> _f$planId =
      Field('planId', _$planId, opt: true);
  static Car? _$car(Promotion v) => v.car;
  static const Field<Promotion, Car> _f$car = Field('car', _$car, opt: true);

  @override
  final MappableFields<Promotion> fields = const {
    #id: _f$id,
    #code: _f$code,
    #name: _f$name,
    #description: _f$description,
    #priceType: _f$priceType,
    #type: _f$type,
    #value: _f$value,
    #minOrderValue: _f$minOrderValue,
    #maxDiscountAmount: _f$maxDiscountAmount,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
    #maxUses: _f$maxUses,
    #usesCount: _f$usesCount,
    #maxUsePerUser: _f$maxUsePerUser,
    #companyId: _f$companyId,
    #carId: _f$carId,
    #rentalPlanId: _f$rentalPlanId,
    #available: _f$available,
    #planId: _f$planId,
    #car: _f$car,
  };

  static Promotion _instantiate(DecodingData data) {
    return Promotion(
        id: data.dec(_f$id),
        code: data.dec(_f$code),
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        priceType: data.dec(_f$priceType),
        type: data.dec(_f$type),
        value: data.dec(_f$value),
        minOrderValue: data.dec(_f$minOrderValue),
        maxDiscountAmount: data.dec(_f$maxDiscountAmount),
        startDate: data.dec(_f$startDate),
        endDate: data.dec(_f$endDate),
        maxUses: data.dec(_f$maxUses),
        usesCount: data.dec(_f$usesCount),
        maxUsePerUser: data.dec(_f$maxUsePerUser),
        companyId: data.dec(_f$companyId),
        carId: data.dec(_f$carId),
        rentalPlanId: data.dec(_f$rentalPlanId),
        available: data.dec(_f$available),
        planId: data.dec(_f$planId),
        car: data.dec(_f$car));
  }

  @override
  final Function instantiate = _instantiate;

  static Promotion fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Promotion>(map);
  }

  static Promotion fromJson(String json) {
    return ensureInitialized().decodeJson<Promotion>(json);
  }
}

mixin PromotionMappable {
  String toJson() {
    return PromotionMapper.ensureInitialized()
        .encodeJson<Promotion>(this as Promotion);
  }

  Map<String, dynamic> toMap() {
    return PromotionMapper.ensureInitialized()
        .encodeMap<Promotion>(this as Promotion);
  }

  PromotionCopyWith<Promotion, Promotion, Promotion> get copyWith =>
      _PromotionCopyWithImpl<Promotion, Promotion>(
          this as Promotion, $identity, $identity);
  @override
  String toString() {
    return PromotionMapper.ensureInitialized()
        .stringifyValue(this as Promotion);
  }

  @override
  bool operator ==(Object other) {
    return PromotionMapper.ensureInitialized()
        .equalsValue(this as Promotion, other);
  }

  @override
  int get hashCode {
    return PromotionMapper.ensureInitialized().hashValue(this as Promotion);
  }
}

extension PromotionValueCopy<$R, $Out> on ObjectCopyWith<$R, Promotion, $Out> {
  PromotionCopyWith<$R, Promotion, $Out> get $asPromotion =>
      $base.as((v, t, t2) => _PromotionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PromotionCopyWith<$R, $In extends Promotion, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CarCopyWith<$R, Car, Car>? get car;
  $R call(
      {String? id,
      String? code,
      String? name,
      String? description,
      PromotionPriceType? priceType,
      PromotionType? type,
      double? value,
      double? minOrderValue,
      double? maxDiscountAmount,
      DateTime? startDate,
      DateTime? endDate,
      int? maxUses,
      int? usesCount,
      int? maxUsePerUser,
      String? companyId,
      String? carId,
      String? rentalPlanId,
      bool? available,
      String? planId,
      Car? car});
  PromotionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PromotionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Promotion, $Out>
    implements PromotionCopyWith<$R, Promotion, $Out> {
  _PromotionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Promotion> $mapper =
      PromotionMapper.ensureInitialized();
  @override
  CarCopyWith<$R, Car, Car>? get car =>
      $value.car?.copyWith.$chain((v) => call(car: v));
  @override
  $R call(
          {String? id,
          Object? code = $none,
          Object? name = $none,
          Object? description = $none,
          PromotionPriceType? priceType,
          PromotionType? type,
          Object? value = $none,
          Object? minOrderValue = $none,
          Object? maxDiscountAmount = $none,
          DateTime? startDate,
          DateTime? endDate,
          Object? maxUses = $none,
          Object? usesCount = $none,
          Object? maxUsePerUser = $none,
          Object? companyId = $none,
          Object? carId = $none,
          Object? rentalPlanId = $none,
          Object? available = $none,
          Object? planId = $none,
          Object? car = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (code != $none) #code: code,
        if (name != $none) #name: name,
        if (description != $none) #description: description,
        if (priceType != null) #priceType: priceType,
        if (type != null) #type: type,
        if (value != $none) #value: value,
        if (minOrderValue != $none) #minOrderValue: minOrderValue,
        if (maxDiscountAmount != $none) #maxDiscountAmount: maxDiscountAmount,
        if (startDate != null) #startDate: startDate,
        if (endDate != null) #endDate: endDate,
        if (maxUses != $none) #maxUses: maxUses,
        if (usesCount != $none) #usesCount: usesCount,
        if (maxUsePerUser != $none) #maxUsePerUser: maxUsePerUser,
        if (companyId != $none) #companyId: companyId,
        if (carId != $none) #carId: carId,
        if (rentalPlanId != $none) #rentalPlanId: rentalPlanId,
        if (available != $none) #available: available,
        if (planId != $none) #planId: planId,
        if (car != $none) #car: car
      }));
  @override
  Promotion $make(CopyWithData data) => Promotion(
      id: data.get(#id, or: $value.id),
      code: data.get(#code, or: $value.code),
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      priceType: data.get(#priceType, or: $value.priceType),
      type: data.get(#type, or: $value.type),
      value: data.get(#value, or: $value.value),
      minOrderValue: data.get(#minOrderValue, or: $value.minOrderValue),
      maxDiscountAmount:
          data.get(#maxDiscountAmount, or: $value.maxDiscountAmount),
      startDate: data.get(#startDate, or: $value.startDate),
      endDate: data.get(#endDate, or: $value.endDate),
      maxUses: data.get(#maxUses, or: $value.maxUses),
      usesCount: data.get(#usesCount, or: $value.usesCount),
      maxUsePerUser: data.get(#maxUsePerUser, or: $value.maxUsePerUser),
      companyId: data.get(#companyId, or: $value.companyId),
      carId: data.get(#carId, or: $value.carId),
      rentalPlanId: data.get(#rentalPlanId, or: $value.rentalPlanId),
      available: data.get(#available, or: $value.available),
      planId: data.get(#planId, or: $value.planId),
      car: data.get(#car, or: $value.car));

  @override
  PromotionCopyWith<$R2, Promotion, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PromotionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PromotionUpdateMapper extends ClassMapperBase<PromotionUpdate> {
  PromotionUpdateMapper._();

  static PromotionUpdateMapper? _instance;
  static PromotionUpdateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PromotionUpdateMapper._());
      PromotionPriceTypeMapper.ensureInitialized();
      PromotionTypeMapper.ensureInitialized();
      CarMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PromotionUpdate';

  static String? _$id(PromotionUpdate v) => v.id;
  static const Field<PromotionUpdate, String> _f$id =
      Field('id', _$id, opt: true);
  static String? _$code(PromotionUpdate v) => v.code;
  static const Field<PromotionUpdate, String> _f$code =
      Field('code', _$code, opt: true);
  static String? _$name(PromotionUpdate v) => v.name;
  static const Field<PromotionUpdate, String> _f$name =
      Field('name', _$name, opt: true);
  static String? _$description(PromotionUpdate v) => v.description;
  static const Field<PromotionUpdate, String> _f$description =
      Field('description', _$description, opt: true);
  static PromotionPriceType? _$priceType(PromotionUpdate v) => v.priceType;
  static const Field<PromotionUpdate, PromotionPriceType> _f$priceType =
      Field('priceType', _$priceType, opt: true);
  static PromotionType? _$type(PromotionUpdate v) => v.type;
  static const Field<PromotionUpdate, PromotionType> _f$type =
      Field('type', _$type, opt: true);
  static double? _$value(PromotionUpdate v) => v.value;
  static const Field<PromotionUpdate, double> _f$value =
      Field('value', _$value, opt: true);
  static double? _$minOrderValue(PromotionUpdate v) => v.minOrderValue;
  static const Field<PromotionUpdate, double> _f$minOrderValue =
      Field('minOrderValue', _$minOrderValue, opt: true);
  static double? _$maxDiscountAmount(PromotionUpdate v) => v.maxDiscountAmount;
  static const Field<PromotionUpdate, double> _f$maxDiscountAmount =
      Field('maxDiscountAmount', _$maxDiscountAmount, opt: true);
  static DateTime? _$startDate(PromotionUpdate v) => v.startDate;
  static const Field<PromotionUpdate, DateTime> _f$startDate =
      Field('startDate', _$startDate, opt: true);
  static DateTime? _$endDate(PromotionUpdate v) => v.endDate;
  static const Field<PromotionUpdate, DateTime> _f$endDate =
      Field('endDate', _$endDate, opt: true);
  static int? _$maxUses(PromotionUpdate v) => v.maxUses;
  static const Field<PromotionUpdate, int> _f$maxUses =
      Field('maxUses', _$maxUses, opt: true);
  static int? _$usesCount(PromotionUpdate v) => v.usesCount;
  static const Field<PromotionUpdate, int> _f$usesCount =
      Field('usesCount', _$usesCount, opt: true);
  static int? _$maxUsePerUser(PromotionUpdate v) => v.maxUsePerUser;
  static const Field<PromotionUpdate, int> _f$maxUsePerUser =
      Field('maxUsePerUser', _$maxUsePerUser, opt: true);
  static String? _$companyId(PromotionUpdate v) => v.companyId;
  static const Field<PromotionUpdate, String> _f$companyId =
      Field('companyId', _$companyId, opt: true);
  static String _$carId(PromotionUpdate v) => v.carId;
  static const Field<PromotionUpdate, String> _f$carId =
      Field('carId', _$carId);
  static String? _$rentalPlanId(PromotionUpdate v) => v.rentalPlanId;
  static const Field<PromotionUpdate, String> _f$rentalPlanId =
      Field('rentalPlanId', _$rentalPlanId, opt: true);
  static bool? _$available(PromotionUpdate v) => v.available;
  static const Field<PromotionUpdate, bool> _f$available =
      Field('available', _$available, opt: true);
  static String? _$planId(PromotionUpdate v) => v.planId;
  static const Field<PromotionUpdate, String> _f$planId =
      Field('planId', _$planId, opt: true);
  static Car? _$car(PromotionUpdate v) => v.car;
  static const Field<PromotionUpdate, Car> _f$car =
      Field('car', _$car, opt: true);

  @override
  final MappableFields<PromotionUpdate> fields = const {
    #id: _f$id,
    #code: _f$code,
    #name: _f$name,
    #description: _f$description,
    #priceType: _f$priceType,
    #type: _f$type,
    #value: _f$value,
    #minOrderValue: _f$minOrderValue,
    #maxDiscountAmount: _f$maxDiscountAmount,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
    #maxUses: _f$maxUses,
    #usesCount: _f$usesCount,
    #maxUsePerUser: _f$maxUsePerUser,
    #companyId: _f$companyId,
    #carId: _f$carId,
    #rentalPlanId: _f$rentalPlanId,
    #available: _f$available,
    #planId: _f$planId,
    #car: _f$car,
  };

  static PromotionUpdate _instantiate(DecodingData data) {
    return PromotionUpdate(
        id: data.dec(_f$id),
        code: data.dec(_f$code),
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        priceType: data.dec(_f$priceType),
        type: data.dec(_f$type),
        value: data.dec(_f$value),
        minOrderValue: data.dec(_f$minOrderValue),
        maxDiscountAmount: data.dec(_f$maxDiscountAmount),
        startDate: data.dec(_f$startDate),
        endDate: data.dec(_f$endDate),
        maxUses: data.dec(_f$maxUses),
        usesCount: data.dec(_f$usesCount),
        maxUsePerUser: data.dec(_f$maxUsePerUser),
        companyId: data.dec(_f$companyId),
        carId: data.dec(_f$carId),
        rentalPlanId: data.dec(_f$rentalPlanId),
        available: data.dec(_f$available),
        planId: data.dec(_f$planId),
        car: data.dec(_f$car));
  }

  @override
  final Function instantiate = _instantiate;

  static PromotionUpdate fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PromotionUpdate>(map);
  }

  static PromotionUpdate fromJson(String json) {
    return ensureInitialized().decodeJson<PromotionUpdate>(json);
  }
}

mixin PromotionUpdateMappable {
  String toJson() {
    return PromotionUpdateMapper.ensureInitialized()
        .encodeJson<PromotionUpdate>(this as PromotionUpdate);
  }

  Map<String, dynamic> toMap() {
    return PromotionUpdateMapper.ensureInitialized()
        .encodeMap<PromotionUpdate>(this as PromotionUpdate);
  }

  PromotionUpdateCopyWith<PromotionUpdate, PromotionUpdate, PromotionUpdate>
      get copyWith =>
          _PromotionUpdateCopyWithImpl<PromotionUpdate, PromotionUpdate>(
              this as PromotionUpdate, $identity, $identity);
  @override
  String toString() {
    return PromotionUpdateMapper.ensureInitialized()
        .stringifyValue(this as PromotionUpdate);
  }

  @override
  bool operator ==(Object other) {
    return PromotionUpdateMapper.ensureInitialized()
        .equalsValue(this as PromotionUpdate, other);
  }

  @override
  int get hashCode {
    return PromotionUpdateMapper.ensureInitialized()
        .hashValue(this as PromotionUpdate);
  }
}

extension PromotionUpdateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PromotionUpdate, $Out> {
  PromotionUpdateCopyWith<$R, PromotionUpdate, $Out> get $asPromotionUpdate =>
      $base.as((v, t, t2) => _PromotionUpdateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PromotionUpdateCopyWith<$R, $In extends PromotionUpdate, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CarCopyWith<$R, Car, Car>? get car;
  $R call(
      {String? id,
      String? code,
      String? name,
      String? description,
      PromotionPriceType? priceType,
      PromotionType? type,
      double? value,
      double? minOrderValue,
      double? maxDiscountAmount,
      DateTime? startDate,
      DateTime? endDate,
      int? maxUses,
      int? usesCount,
      int? maxUsePerUser,
      String? companyId,
      String? carId,
      String? rentalPlanId,
      bool? available,
      String? planId,
      Car? car});
  PromotionUpdateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PromotionUpdateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PromotionUpdate, $Out>
    implements PromotionUpdateCopyWith<$R, PromotionUpdate, $Out> {
  _PromotionUpdateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PromotionUpdate> $mapper =
      PromotionUpdateMapper.ensureInitialized();
  @override
  CarCopyWith<$R, Car, Car>? get car =>
      $value.car?.copyWith.$chain((v) => call(car: v));
  @override
  $R call(
          {Object? id = $none,
          Object? code = $none,
          Object? name = $none,
          Object? description = $none,
          Object? priceType = $none,
          Object? type = $none,
          Object? value = $none,
          Object? minOrderValue = $none,
          Object? maxDiscountAmount = $none,
          Object? startDate = $none,
          Object? endDate = $none,
          Object? maxUses = $none,
          Object? usesCount = $none,
          Object? maxUsePerUser = $none,
          Object? companyId = $none,
          String? carId,
          Object? rentalPlanId = $none,
          Object? available = $none,
          Object? planId = $none,
          Object? car = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (code != $none) #code: code,
        if (name != $none) #name: name,
        if (description != $none) #description: description,
        if (priceType != $none) #priceType: priceType,
        if (type != $none) #type: type,
        if (value != $none) #value: value,
        if (minOrderValue != $none) #minOrderValue: minOrderValue,
        if (maxDiscountAmount != $none) #maxDiscountAmount: maxDiscountAmount,
        if (startDate != $none) #startDate: startDate,
        if (endDate != $none) #endDate: endDate,
        if (maxUses != $none) #maxUses: maxUses,
        if (usesCount != $none) #usesCount: usesCount,
        if (maxUsePerUser != $none) #maxUsePerUser: maxUsePerUser,
        if (companyId != $none) #companyId: companyId,
        if (carId != null) #carId: carId,
        if (rentalPlanId != $none) #rentalPlanId: rentalPlanId,
        if (available != $none) #available: available,
        if (planId != $none) #planId: planId,
        if (car != $none) #car: car
      }));
  @override
  PromotionUpdate $make(CopyWithData data) => PromotionUpdate(
      id: data.get(#id, or: $value.id),
      code: data.get(#code, or: $value.code),
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      priceType: data.get(#priceType, or: $value.priceType),
      type: data.get(#type, or: $value.type),
      value: data.get(#value, or: $value.value),
      minOrderValue: data.get(#minOrderValue, or: $value.minOrderValue),
      maxDiscountAmount:
          data.get(#maxDiscountAmount, or: $value.maxDiscountAmount),
      startDate: data.get(#startDate, or: $value.startDate),
      endDate: data.get(#endDate, or: $value.endDate),
      maxUses: data.get(#maxUses, or: $value.maxUses),
      usesCount: data.get(#usesCount, or: $value.usesCount),
      maxUsePerUser: data.get(#maxUsePerUser, or: $value.maxUsePerUser),
      companyId: data.get(#companyId, or: $value.companyId),
      carId: data.get(#carId, or: $value.carId),
      rentalPlanId: data.get(#rentalPlanId, or: $value.rentalPlanId),
      available: data.get(#available, or: $value.available),
      planId: data.get(#planId, or: $value.planId),
      car: data.get(#car, or: $value.car));

  @override
  PromotionUpdateCopyWith<$R2, PromotionUpdate, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PromotionUpdateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PromotionPostMapper extends ClassMapperBase<PromotionPost> {
  PromotionPostMapper._();

  static PromotionPostMapper? _instance;
  static PromotionPostMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PromotionPostMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PromotionPost';

  static String? _$cursor(PromotionPost v) => v.cursor;
  static const Field<PromotionPost, String> _f$cursor =
      Field('cursor', _$cursor, opt: true);
  static String? _$companyId(PromotionPost v) => v.companyId;
  static const Field<PromotionPost, String> _f$companyId =
      Field('companyId', _$companyId, opt: true);
  static String? _$carId(PromotionPost v) => v.carId;
  static const Field<PromotionPost, String> _f$carId =
      Field('carId', _$carId, opt: true);

  @override
  final MappableFields<PromotionPost> fields = const {
    #cursor: _f$cursor,
    #companyId: _f$companyId,
    #carId: _f$carId,
  };

  static PromotionPost _instantiate(DecodingData data) {
    return PromotionPost(
        cursor: data.dec(_f$cursor),
        companyId: data.dec(_f$companyId),
        carId: data.dec(_f$carId));
  }

  @override
  final Function instantiate = _instantiate;

  static PromotionPost fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PromotionPost>(map);
  }

  static PromotionPost fromJson(String json) {
    return ensureInitialized().decodeJson<PromotionPost>(json);
  }
}

mixin PromotionPostMappable {
  String toJson() {
    return PromotionPostMapper.ensureInitialized()
        .encodeJson<PromotionPost>(this as PromotionPost);
  }

  Map<String, dynamic> toMap() {
    return PromotionPostMapper.ensureInitialized()
        .encodeMap<PromotionPost>(this as PromotionPost);
  }

  PromotionPostCopyWith<PromotionPost, PromotionPost, PromotionPost>
      get copyWith => _PromotionPostCopyWithImpl<PromotionPost, PromotionPost>(
          this as PromotionPost, $identity, $identity);
  @override
  String toString() {
    return PromotionPostMapper.ensureInitialized()
        .stringifyValue(this as PromotionPost);
  }

  @override
  bool operator ==(Object other) {
    return PromotionPostMapper.ensureInitialized()
        .equalsValue(this as PromotionPost, other);
  }

  @override
  int get hashCode {
    return PromotionPostMapper.ensureInitialized()
        .hashValue(this as PromotionPost);
  }
}

extension PromotionPostValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PromotionPost, $Out> {
  PromotionPostCopyWith<$R, PromotionPost, $Out> get $asPromotionPost =>
      $base.as((v, t, t2) => _PromotionPostCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PromotionPostCopyWith<$R, $In extends PromotionPost, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? cursor, String? companyId, String? carId});
  PromotionPostCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PromotionPostCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PromotionPost, $Out>
    implements PromotionPostCopyWith<$R, PromotionPost, $Out> {
  _PromotionPostCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PromotionPost> $mapper =
      PromotionPostMapper.ensureInitialized();
  @override
  $R call(
          {Object? cursor = $none,
          Object? companyId = $none,
          Object? carId = $none}) =>
      $apply(FieldCopyWithData({
        if (cursor != $none) #cursor: cursor,
        if (companyId != $none) #companyId: companyId,
        if (carId != $none) #carId: carId
      }));
  @override
  PromotionPost $make(CopyWithData data) => PromotionPost(
      cursor: data.get(#cursor, or: $value.cursor),
      companyId: data.get(#companyId, or: $value.companyId),
      carId: data.get(#carId, or: $value.carId));

  @override
  PromotionPostCopyWith<$R2, PromotionPost, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PromotionPostCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
