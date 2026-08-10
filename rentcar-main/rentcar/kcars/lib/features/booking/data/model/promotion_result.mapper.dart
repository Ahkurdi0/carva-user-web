// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'promotion_result.dart';

class PromotionResultMapper extends ClassMapperBase<PromotionResult> {
  PromotionResultMapper._();

  static PromotionResultMapper? _instance;
  static PromotionResultMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PromotionResultMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PromotionResult';

  static double _$finalPrice(PromotionResult v) => v.finalPrice;
  static const Field<PromotionResult, double> _f$finalPrice =
      Field('finalPrice', _$finalPrice);
  static double _$discount(PromotionResult v) => v.discount;
  static const Field<PromotionResult, double> _f$discount =
      Field('discount', _$discount);
  static double _$totalPrice(PromotionResult v) => v.totalPrice;
  static const Field<PromotionResult, double> _f$totalPrice =
      Field('totalPrice', _$totalPrice);
  static double? _$basePrice(PromotionResult v) => v.basePrice;
  static const Field<PromotionResult, double> _f$basePrice =
      Field('basePrice', _$basePrice, opt: true);
  static double? _$periods(PromotionResult v) => v.periods;
  static const Field<PromotionResult, double> _f$periods =
      Field('periods', _$periods, opt: true);

  @override
  final MappableFields<PromotionResult> fields = const {
    #finalPrice: _f$finalPrice,
    #discount: _f$discount,
    #totalPrice: _f$totalPrice,
    #basePrice: _f$basePrice,
    #periods: _f$periods,
  };

  static PromotionResult _instantiate(DecodingData data) {
    return PromotionResult(
        finalPrice: data.dec(_f$finalPrice),
        discount: data.dec(_f$discount),
        totalPrice: data.dec(_f$totalPrice),
        basePrice: data.dec(_f$basePrice),
        periods: data.dec(_f$periods));
  }

  @override
  final Function instantiate = _instantiate;

  static PromotionResult fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PromotionResult>(map);
  }

  static PromotionResult fromJson(String json) {
    return ensureInitialized().decodeJson<PromotionResult>(json);
  }
}

mixin PromotionResultMappable {
  String toJson() {
    return PromotionResultMapper.ensureInitialized()
        .encodeJson<PromotionResult>(this as PromotionResult);
  }

  Map<String, dynamic> toMap() {
    return PromotionResultMapper.ensureInitialized()
        .encodeMap<PromotionResult>(this as PromotionResult);
  }

  PromotionResultCopyWith<PromotionResult, PromotionResult, PromotionResult>
      get copyWith =>
          _PromotionResultCopyWithImpl<PromotionResult, PromotionResult>(
              this as PromotionResult, $identity, $identity);
  @override
  String toString() {
    return PromotionResultMapper.ensureInitialized()
        .stringifyValue(this as PromotionResult);
  }

  @override
  bool operator ==(Object other) {
    return PromotionResultMapper.ensureInitialized()
        .equalsValue(this as PromotionResult, other);
  }

  @override
  int get hashCode {
    return PromotionResultMapper.ensureInitialized()
        .hashValue(this as PromotionResult);
  }
}

extension PromotionResultValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PromotionResult, $Out> {
  PromotionResultCopyWith<$R, PromotionResult, $Out> get $asPromotionResult =>
      $base.as((v, t, t2) => _PromotionResultCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PromotionResultCopyWith<$R, $In extends PromotionResult, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {double? finalPrice,
      double? discount,
      double? totalPrice,
      double? basePrice,
      double? periods});
  PromotionResultCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PromotionResultCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PromotionResult, $Out>
    implements PromotionResultCopyWith<$R, PromotionResult, $Out> {
  _PromotionResultCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PromotionResult> $mapper =
      PromotionResultMapper.ensureInitialized();
  @override
  $R call(
          {double? finalPrice,
          double? discount,
          double? totalPrice,
          Object? basePrice = $none,
          Object? periods = $none}) =>
      $apply(FieldCopyWithData({
        if (finalPrice != null) #finalPrice: finalPrice,
        if (discount != null) #discount: discount,
        if (totalPrice != null) #totalPrice: totalPrice,
        if (basePrice != $none) #basePrice: basePrice,
        if (periods != $none) #periods: periods
      }));
  @override
  PromotionResult $make(CopyWithData data) => PromotionResult(
      finalPrice: data.get(#finalPrice, or: $value.finalPrice),
      discount: data.get(#discount, or: $value.discount),
      totalPrice: data.get(#totalPrice, or: $value.totalPrice),
      basePrice: data.get(#basePrice, or: $value.basePrice),
      periods: data.get(#periods, or: $value.periods));

  @override
  PromotionResultCopyWith<$R2, PromotionResult, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PromotionResultCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
