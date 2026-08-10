// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'paln.dart';

class PlanMapper extends ClassMapperBase<Plan> {
  PlanMapper._();

  static PlanMapper? _instance;
  static PlanMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PlanMapper._());
      RentalPeriodTypeMapper.ensureInitialized();
      RentalPlanMapper.ensureInitialized();
      PromotionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Plan';

  static String? _$id(Plan v) => v.id;
  static const Field<Plan, String> _f$id = Field('id', _$id, opt: true);
  static String? _$en(Plan v) => v.en;
  static const Field<Plan, String> _f$en = Field('en', _$en, opt: true);
  static String? _$ku(Plan v) => v.ku;
  static const Field<Plan, String> _f$ku = Field('ku', _$ku, opt: true);
  static String? _$ar(Plan v) => v.ar;
  static const Field<Plan, String> _f$ar = Field('ar', _$ar, opt: true);
  static RentalPeriodType? _$periodType(Plan v) => v.periodType;
  static const Field<Plan, RentalPeriodType> _f$periodType =
      Field('periodType', _$periodType, opt: true);
  static int? _$sort(Plan v) => v.sort;
  static const Field<Plan, int> _f$sort = Field('sort', _$sort, opt: true);
  static List<RentalPlan>? _$rentalPlan(Plan v) => v.rentalPlan;
  static const Field<Plan, List<RentalPlan>> _f$rentalPlan =
      Field('rentalPlan', _$rentalPlan, opt: true);
  static List<Promotion>? _$promotions(Plan v) => v.promotions;
  static const Field<Plan, List<Promotion>> _f$promotions =
      Field('promotions', _$promotions, opt: true);

  @override
  final MappableFields<Plan> fields = const {
    #id: _f$id,
    #en: _f$en,
    #ku: _f$ku,
    #ar: _f$ar,
    #periodType: _f$periodType,
    #sort: _f$sort,
    #rentalPlan: _f$rentalPlan,
    #promotions: _f$promotions,
  };

  static Plan _instantiate(DecodingData data) {
    return Plan(
        id: data.dec(_f$id),
        en: data.dec(_f$en),
        ku: data.dec(_f$ku),
        ar: data.dec(_f$ar),
        periodType: data.dec(_f$periodType),
        sort: data.dec(_f$sort),
        rentalPlan: data.dec(_f$rentalPlan),
        promotions: data.dec(_f$promotions));
  }

  @override
  final Function instantiate = _instantiate;

  static Plan fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Plan>(map);
  }

  static Plan fromJson(String json) {
    return ensureInitialized().decodeJson<Plan>(json);
  }
}

mixin PlanMappable {
  String toJson() {
    return PlanMapper.ensureInitialized().encodeJson<Plan>(this as Plan);
  }

  Map<String, dynamic> toMap() {
    return PlanMapper.ensureInitialized().encodeMap<Plan>(this as Plan);
  }

  PlanCopyWith<Plan, Plan, Plan> get copyWith =>
      _PlanCopyWithImpl<Plan, Plan>(this as Plan, $identity, $identity);
  @override
  String toString() {
    return PlanMapper.ensureInitialized().stringifyValue(this as Plan);
  }

  @override
  bool operator ==(Object other) {
    return PlanMapper.ensureInitialized().equalsValue(this as Plan, other);
  }

  @override
  int get hashCode {
    return PlanMapper.ensureInitialized().hashValue(this as Plan);
  }
}

extension PlanValueCopy<$R, $Out> on ObjectCopyWith<$R, Plan, $Out> {
  PlanCopyWith<$R, Plan, $Out> get $asPlan =>
      $base.as((v, t, t2) => _PlanCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PlanCopyWith<$R, $In extends Plan, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, RentalPlan, RentalPlanCopyWith<$R, RentalPlan, RentalPlan>>?
      get rentalPlan;
  ListCopyWith<$R, Promotion, PromotionCopyWith<$R, Promotion, Promotion>>?
      get promotions;
  $R call(
      {String? id,
      String? en,
      String? ku,
      String? ar,
      RentalPeriodType? periodType,
      int? sort,
      List<RentalPlan>? rentalPlan,
      List<Promotion>? promotions});
  PlanCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PlanCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Plan, $Out>
    implements PlanCopyWith<$R, Plan, $Out> {
  _PlanCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Plan> $mapper = PlanMapper.ensureInitialized();
  @override
  ListCopyWith<$R, RentalPlan, RentalPlanCopyWith<$R, RentalPlan, RentalPlan>>?
      get rentalPlan => $value.rentalPlan != null
          ? ListCopyWith($value.rentalPlan!, (v, t) => v.copyWith.$chain(t),
              (v) => call(rentalPlan: v))
          : null;
  @override
  ListCopyWith<$R, Promotion, PromotionCopyWith<$R, Promotion, Promotion>>?
      get promotions => $value.promotions != null
          ? ListCopyWith($value.promotions!, (v, t) => v.copyWith.$chain(t),
              (v) => call(promotions: v))
          : null;
  @override
  $R call(
          {Object? id = $none,
          Object? en = $none,
          Object? ku = $none,
          Object? ar = $none,
          Object? periodType = $none,
          Object? sort = $none,
          Object? rentalPlan = $none,
          Object? promotions = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (en != $none) #en: en,
        if (ku != $none) #ku: ku,
        if (ar != $none) #ar: ar,
        if (periodType != $none) #periodType: periodType,
        if (sort != $none) #sort: sort,
        if (rentalPlan != $none) #rentalPlan: rentalPlan,
        if (promotions != $none) #promotions: promotions
      }));
  @override
  Plan $make(CopyWithData data) => Plan(
      id: data.get(#id, or: $value.id),
      en: data.get(#en, or: $value.en),
      ku: data.get(#ku, or: $value.ku),
      ar: data.get(#ar, or: $value.ar),
      periodType: data.get(#periodType, or: $value.periodType),
      sort: data.get(#sort, or: $value.sort),
      rentalPlan: data.get(#rentalPlan, or: $value.rentalPlan),
      promotions: data.get(#promotions, or: $value.promotions));

  @override
  PlanCopyWith<$R2, Plan, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PlanCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
