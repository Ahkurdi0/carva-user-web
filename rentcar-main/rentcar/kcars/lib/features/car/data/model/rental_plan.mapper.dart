// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'rental_plan.dart';

class RentalPlanMapper extends ClassMapperBase<RentalPlan> {
  RentalPlanMapper._();

  static RentalPlanMapper? _instance;
  static RentalPlanMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RentalPlanMapper._());
      CarMapper.ensureInitialized();
      PlanMapper.ensureInitialized();
      RentalPeriodTypeMapper.ensureInitialized();
      PromotionMapper.ensureInitialized();
      CurrencyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RentalPlan';

  static String _$id(RentalPlan v) => v.id;
  static const Field<RentalPlan, String> _f$id = Field('id', _$id);
  static String? _$carId(RentalPlan v) => v.carId;
  static const Field<RentalPlan, String> _f$carId =
      Field('carId', _$carId, opt: true);
  static Car? _$car(RentalPlan v) => v.car;
  static const Field<RentalPlan, Car> _f$car = Field('car', _$car, opt: true);
  static double _$price(RentalPlan v) => v.price;
  static const Field<RentalPlan, double> _f$price = Field('price', _$price);
  static int? _$max(RentalPlan v) => v.max;
  static const Field<RentalPlan, int> _f$max = Field('max', _$max, opt: true);
  static int? _$min(RentalPlan v) => v.min;
  static const Field<RentalPlan, int> _f$min = Field('min', _$min, opt: true);
  static Plan? _$plan(RentalPlan v) => v.plan;
  static const Field<RentalPlan, Plan> _f$plan =
      Field('plan', _$plan, opt: true);
  static RentalPeriodType _$periodType(RentalPlan v) => v.periodType;
  static const Field<RentalPlan, RentalPeriodType> _f$periodType = Field(
      'periodType', _$periodType,
      opt: true, def: RentalPeriodType.hourly);
  static bool _$available(RentalPlan v) => v.available;
  static const Field<RentalPlan, bool> _f$available =
      Field('available', _$available, opt: true, def: true);
  static List<Promotion>? _$promotions(RentalPlan v) => v.promotions;
  static const Field<RentalPlan, List<Promotion>> _f$promotions =
      Field('promotions', _$promotions, opt: true);
  static String? _$planId(RentalPlan v) => v.planId;
  static const Field<RentalPlan, String> _f$planId =
      Field('planId', _$planId, opt: true);
  static Currency? _$currency(RentalPlan v) => v.currency;
  static const Field<RentalPlan, Currency> _f$currency =
      Field('currency', _$currency, opt: true);

  @override
  final MappableFields<RentalPlan> fields = const {
    #id: _f$id,
    #carId: _f$carId,
    #car: _f$car,
    #price: _f$price,
    #max: _f$max,
    #min: _f$min,
    #plan: _f$plan,
    #periodType: _f$periodType,
    #available: _f$available,
    #promotions: _f$promotions,
    #planId: _f$planId,
    #currency: _f$currency,
  };

  static RentalPlan _instantiate(DecodingData data) {
    return RentalPlan(
        id: data.dec(_f$id),
        carId: data.dec(_f$carId),
        car: data.dec(_f$car),
        price: data.dec(_f$price),
        max: data.dec(_f$max),
        min: data.dec(_f$min),
        plan: data.dec(_f$plan),
        periodType: data.dec(_f$periodType),
        available: data.dec(_f$available),
        promotions: data.dec(_f$promotions),
        planId: data.dec(_f$planId),
        currency: data.dec(_f$currency));
  }

  @override
  final Function instantiate = _instantiate;

  static RentalPlan fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RentalPlan>(map);
  }

  static RentalPlan fromJson(String json) {
    return ensureInitialized().decodeJson<RentalPlan>(json);
  }
}

mixin RentalPlanMappable {
  String toJson() {
    return RentalPlanMapper.ensureInitialized()
        .encodeJson<RentalPlan>(this as RentalPlan);
  }

  Map<String, dynamic> toMap() {
    return RentalPlanMapper.ensureInitialized()
        .encodeMap<RentalPlan>(this as RentalPlan);
  }

  RentalPlanCopyWith<RentalPlan, RentalPlan, RentalPlan> get copyWith =>
      _RentalPlanCopyWithImpl<RentalPlan, RentalPlan>(
          this as RentalPlan, $identity, $identity);
  @override
  String toString() {
    return RentalPlanMapper.ensureInitialized()
        .stringifyValue(this as RentalPlan);
  }

  @override
  bool operator ==(Object other) {
    return RentalPlanMapper.ensureInitialized()
        .equalsValue(this as RentalPlan, other);
  }

  @override
  int get hashCode {
    return RentalPlanMapper.ensureInitialized().hashValue(this as RentalPlan);
  }
}

extension RentalPlanValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RentalPlan, $Out> {
  RentalPlanCopyWith<$R, RentalPlan, $Out> get $asRentalPlan =>
      $base.as((v, t, t2) => _RentalPlanCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class RentalPlanCopyWith<$R, $In extends RentalPlan, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CarCopyWith<$R, Car, Car>? get car;
  PlanCopyWith<$R, Plan, Plan>? get plan;
  ListCopyWith<$R, Promotion, PromotionCopyWith<$R, Promotion, Promotion>>?
      get promotions;
  $R call(
      {String? id,
      String? carId,
      Car? car,
      double? price,
      int? max,
      int? min,
      Plan? plan,
      RentalPeriodType? periodType,
      bool? available,
      List<Promotion>? promotions,
      String? planId,
      Currency? currency});
  RentalPlanCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _RentalPlanCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RentalPlan, $Out>
    implements RentalPlanCopyWith<$R, RentalPlan, $Out> {
  _RentalPlanCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RentalPlan> $mapper =
      RentalPlanMapper.ensureInitialized();
  @override
  CarCopyWith<$R, Car, Car>? get car =>
      $value.car?.copyWith.$chain((v) => call(car: v));
  @override
  PlanCopyWith<$R, Plan, Plan>? get plan =>
      $value.plan?.copyWith.$chain((v) => call(plan: v));
  @override
  ListCopyWith<$R, Promotion, PromotionCopyWith<$R, Promotion, Promotion>>?
      get promotions => $value.promotions != null
          ? ListCopyWith($value.promotions!, (v, t) => v.copyWith.$chain(t),
              (v) => call(promotions: v))
          : null;
  @override
  $R call(
          {String? id,
          Object? carId = $none,
          Object? car = $none,
          double? price,
          Object? max = $none,
          Object? min = $none,
          Object? plan = $none,
          RentalPeriodType? periodType,
          bool? available,
          Object? promotions = $none,
          Object? planId = $none,
          Object? currency = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (carId != $none) #carId: carId,
        if (car != $none) #car: car,
        if (price != null) #price: price,
        if (max != $none) #max: max,
        if (min != $none) #min: min,
        if (plan != $none) #plan: plan,
        if (periodType != null) #periodType: periodType,
        if (available != null) #available: available,
        if (promotions != $none) #promotions: promotions,
        if (planId != $none) #planId: planId,
        if (currency != $none) #currency: currency
      }));
  @override
  RentalPlan $make(CopyWithData data) => RentalPlan(
      id: data.get(#id, or: $value.id),
      carId: data.get(#carId, or: $value.carId),
      car: data.get(#car, or: $value.car),
      price: data.get(#price, or: $value.price),
      max: data.get(#max, or: $value.max),
      min: data.get(#min, or: $value.min),
      plan: data.get(#plan, or: $value.plan),
      periodType: data.get(#periodType, or: $value.periodType),
      available: data.get(#available, or: $value.available),
      promotions: data.get(#promotions, or: $value.promotions),
      planId: data.get(#planId, or: $value.planId),
      currency: data.get(#currency, or: $value.currency));

  @override
  RentalPlanCopyWith<$R2, RentalPlan, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _RentalPlanCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class FilterRentalPlanMapper extends ClassMapperBase<FilterRentalPlan> {
  FilterRentalPlanMapper._();

  static FilterRentalPlanMapper? _instance;
  static FilterRentalPlanMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FilterRentalPlanMapper._());
      PlanMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FilterRentalPlan';

  static String? _$id(FilterRentalPlan v) => v.id;
  static const Field<FilterRentalPlan, String> _f$id =
      Field('id', _$id, opt: true);
  static int? _$maxPrice(FilterRentalPlan v) => v.maxPrice;
  static const Field<FilterRentalPlan, int> _f$maxPrice =
      Field('maxPrice', _$maxPrice, opt: true);
  static int? _$minPrice(FilterRentalPlan v) => v.minPrice;
  static const Field<FilterRentalPlan, int> _f$minPrice =
      Field('minPrice', _$minPrice, opt: true);
  static Plan? _$plan(FilterRentalPlan v) => v.plan;
  static const Field<FilterRentalPlan, Plan> _f$plan =
      Field('plan', _$plan, opt: true);
  static String? _$planId(FilterRentalPlan v) => v.planId;
  static const Field<FilterRentalPlan, String> _f$planId =
      Field('planId', _$planId, opt: true);

  @override
  final MappableFields<FilterRentalPlan> fields = const {
    #id: _f$id,
    #maxPrice: _f$maxPrice,
    #minPrice: _f$minPrice,
    #plan: _f$plan,
    #planId: _f$planId,
  };

  static FilterRentalPlan _instantiate(DecodingData data) {
    return FilterRentalPlan(
        id: data.dec(_f$id),
        maxPrice: data.dec(_f$maxPrice),
        minPrice: data.dec(_f$minPrice),
        plan: data.dec(_f$plan),
        planId: data.dec(_f$planId));
  }

  @override
  final Function instantiate = _instantiate;

  static FilterRentalPlan fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FilterRentalPlan>(map);
  }

  static FilterRentalPlan fromJson(String json) {
    return ensureInitialized().decodeJson<FilterRentalPlan>(json);
  }
}

mixin FilterRentalPlanMappable {
  String toJson() {
    return FilterRentalPlanMapper.ensureInitialized()
        .encodeJson<FilterRentalPlan>(this as FilterRentalPlan);
  }

  Map<String, dynamic> toMap() {
    return FilterRentalPlanMapper.ensureInitialized()
        .encodeMap<FilterRentalPlan>(this as FilterRentalPlan);
  }

  FilterRentalPlanCopyWith<FilterRentalPlan, FilterRentalPlan, FilterRentalPlan>
      get copyWith =>
          _FilterRentalPlanCopyWithImpl<FilterRentalPlan, FilterRentalPlan>(
              this as FilterRentalPlan, $identity, $identity);
  @override
  String toString() {
    return FilterRentalPlanMapper.ensureInitialized()
        .stringifyValue(this as FilterRentalPlan);
  }

  @override
  bool operator ==(Object other) {
    return FilterRentalPlanMapper.ensureInitialized()
        .equalsValue(this as FilterRentalPlan, other);
  }

  @override
  int get hashCode {
    return FilterRentalPlanMapper.ensureInitialized()
        .hashValue(this as FilterRentalPlan);
  }
}

extension FilterRentalPlanValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FilterRentalPlan, $Out> {
  FilterRentalPlanCopyWith<$R, FilterRentalPlan, $Out>
      get $asFilterRentalPlan => $base
          .as((v, t, t2) => _FilterRentalPlanCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FilterRentalPlanCopyWith<$R, $In extends FilterRentalPlan, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PlanCopyWith<$R, Plan, Plan>? get plan;
  $R call(
      {String? id, int? maxPrice, int? minPrice, Plan? plan, String? planId});
  FilterRentalPlanCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _FilterRentalPlanCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FilterRentalPlan, $Out>
    implements FilterRentalPlanCopyWith<$R, FilterRentalPlan, $Out> {
  _FilterRentalPlanCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FilterRentalPlan> $mapper =
      FilterRentalPlanMapper.ensureInitialized();
  @override
  PlanCopyWith<$R, Plan, Plan>? get plan =>
      $value.plan?.copyWith.$chain((v) => call(plan: v));
  @override
  $R call(
          {Object? id = $none,
          Object? maxPrice = $none,
          Object? minPrice = $none,
          Object? plan = $none,
          Object? planId = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (maxPrice != $none) #maxPrice: maxPrice,
        if (minPrice != $none) #minPrice: minPrice,
        if (plan != $none) #plan: plan,
        if (planId != $none) #planId: planId
      }));
  @override
  FilterRentalPlan $make(CopyWithData data) => FilterRentalPlan(
      id: data.get(#id, or: $value.id),
      maxPrice: data.get(#maxPrice, or: $value.maxPrice),
      minPrice: data.get(#minPrice, or: $value.minPrice),
      plan: data.get(#plan, or: $value.plan),
      planId: data.get(#planId, or: $value.planId));

  @override
  FilterRentalPlanCopyWith<$R2, FilterRentalPlan, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _FilterRentalPlanCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
