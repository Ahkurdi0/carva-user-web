// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'promo_code.dart';

class PromoCodeMapper extends ClassMapperBase<PromoCode> {
  PromoCodeMapper._();

  static PromoCodeMapper? _instance;
  static PromoCodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PromoCodeMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PromoCode';

  static String _$code(PromoCode v) => v.code;
  static const Field<PromoCode, String> _f$code = Field('code', _$code);
  static String _$carId(PromoCode v) => v.carId;
  static const Field<PromoCode, String> _f$carId = Field('carId', _$carId);
  static String _$companyId(PromoCode v) => v.companyId;
  static const Field<PromoCode, String> _f$companyId =
      Field('companyId', _$companyId);
  static String _$rentalPlanId(PromoCode v) => v.rentalPlanId;
  static const Field<PromoCode, String> _f$rentalPlanId =
      Field('rentalPlanId', _$rentalPlanId);
  static String _$planId(PromoCode v) => v.planId;
  static const Field<PromoCode, String> _f$planId = Field('planId', _$planId);
  static DateTime _$startDate(PromoCode v) => v.startDate;
  static const Field<PromoCode, DateTime> _f$startDate =
      Field('startDate', _$startDate);
  static DateTime _$endDate(PromoCode v) => v.endDate;
  static const Field<PromoCode, DateTime> _f$endDate =
      Field('endDate', _$endDate);

  @override
  final MappableFields<PromoCode> fields = const {
    #code: _f$code,
    #carId: _f$carId,
    #companyId: _f$companyId,
    #rentalPlanId: _f$rentalPlanId,
    #planId: _f$planId,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
  };

  static PromoCode _instantiate(DecodingData data) {
    return PromoCode(
        code: data.dec(_f$code),
        carId: data.dec(_f$carId),
        companyId: data.dec(_f$companyId),
        rentalPlanId: data.dec(_f$rentalPlanId),
        planId: data.dec(_f$planId),
        startDate: data.dec(_f$startDate),
        endDate: data.dec(_f$endDate));
  }

  @override
  final Function instantiate = _instantiate;

  static PromoCode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PromoCode>(map);
  }

  static PromoCode fromJson(String json) {
    return ensureInitialized().decodeJson<PromoCode>(json);
  }
}

mixin PromoCodeMappable {
  String toJson() {
    return PromoCodeMapper.ensureInitialized()
        .encodeJson<PromoCode>(this as PromoCode);
  }

  Map<String, dynamic> toMap() {
    return PromoCodeMapper.ensureInitialized()
        .encodeMap<PromoCode>(this as PromoCode);
  }

  PromoCodeCopyWith<PromoCode, PromoCode, PromoCode> get copyWith =>
      _PromoCodeCopyWithImpl<PromoCode, PromoCode>(
          this as PromoCode, $identity, $identity);
  @override
  String toString() {
    return PromoCodeMapper.ensureInitialized()
        .stringifyValue(this as PromoCode);
  }

  @override
  bool operator ==(Object other) {
    return PromoCodeMapper.ensureInitialized()
        .equalsValue(this as PromoCode, other);
  }

  @override
  int get hashCode {
    return PromoCodeMapper.ensureInitialized().hashValue(this as PromoCode);
  }
}

extension PromoCodeValueCopy<$R, $Out> on ObjectCopyWith<$R, PromoCode, $Out> {
  PromoCodeCopyWith<$R, PromoCode, $Out> get $asPromoCode =>
      $base.as((v, t, t2) => _PromoCodeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PromoCodeCopyWith<$R, $In extends PromoCode, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? code,
      String? carId,
      String? companyId,
      String? rentalPlanId,
      String? planId,
      DateTime? startDate,
      DateTime? endDate});
  PromoCodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PromoCodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PromoCode, $Out>
    implements PromoCodeCopyWith<$R, PromoCode, $Out> {
  _PromoCodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PromoCode> $mapper =
      PromoCodeMapper.ensureInitialized();
  @override
  $R call(
          {String? code,
          String? carId,
          String? companyId,
          String? rentalPlanId,
          String? planId,
          DateTime? startDate,
          DateTime? endDate}) =>
      $apply(FieldCopyWithData({
        if (code != null) #code: code,
        if (carId != null) #carId: carId,
        if (companyId != null) #companyId: companyId,
        if (rentalPlanId != null) #rentalPlanId: rentalPlanId,
        if (planId != null) #planId: planId,
        if (startDate != null) #startDate: startDate,
        if (endDate != null) #endDate: endDate
      }));
  @override
  PromoCode $make(CopyWithData data) => PromoCode(
      code: data.get(#code, or: $value.code),
      carId: data.get(#carId, or: $value.carId),
      companyId: data.get(#companyId, or: $value.companyId),
      rentalPlanId: data.get(#rentalPlanId, or: $value.rentalPlanId),
      planId: data.get(#planId, or: $value.planId),
      startDate: data.get(#startDate, or: $value.startDate),
      endDate: data.get(#endDate, or: $value.endDate));

  @override
  PromoCodeCopyWith<$R2, PromoCode, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PromoCodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
