// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'featured_cars.dart';

class FeaturedCarsMapper extends ClassMapperBase<FeaturedCars> {
  FeaturedCarsMapper._();

  static FeaturedCarsMapper? _instance;
  static FeaturedCarsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FeaturedCarsMapper._());
      CarMapper.ensureInitialized();
      CompanyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FeaturedCars';

  static String? _$id(FeaturedCars v) => v.id;
  static const Field<FeaturedCars, String> _f$id = Field('id', _$id, opt: true);
  static String? _$carId(FeaturedCars v) => v.carId;
  static const Field<FeaturedCars, String> _f$carId =
      Field('carId', _$carId, opt: true);
  static Car? _$car(FeaturedCars v) => v.car;
  static const Field<FeaturedCars, Car> _f$car = Field('car', _$car, opt: true);
  static int? _$sort(FeaturedCars v) => v.sort;
  static const Field<FeaturedCars, int> _f$sort =
      Field('sort', _$sort, opt: true);
  static String? _$companyId(FeaturedCars v) => v.companyId;
  static const Field<FeaturedCars, String> _f$companyId =
      Field('companyId', _$companyId, opt: true);
  static Company? _$company(FeaturedCars v) => v.company;
  static const Field<FeaturedCars, Company> _f$company =
      Field('company', _$company, opt: true);
  static DateTime? _$startAt(FeaturedCars v) => v.startAt;
  static const Field<FeaturedCars, DateTime> _f$startAt =
      Field('startAt', _$startAt, opt: true);
  static DateTime? _$until(FeaturedCars v) => v.until;
  static const Field<FeaturedCars, DateTime> _f$until =
      Field('until', _$until, opt: true);
  static DateTime? _$deletedAt(FeaturedCars v) => v.deletedAt;
  static const Field<FeaturedCars, DateTime> _f$deletedAt =
      Field('deletedAt', _$deletedAt, opt: true);
  static bool? _$available(FeaturedCars v) => v.available;
  static const Field<FeaturedCars, bool> _f$available =
      Field('available', _$available, opt: true);
  static DateTime? _$createdAt(FeaturedCars v) => v.createdAt;
  static const Field<FeaturedCars, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, opt: true);
  static DateTime? _$updatedAt(FeaturedCars v) => v.updatedAt;
  static const Field<FeaturedCars, DateTime> _f$updatedAt =
      Field('updatedAt', _$updatedAt, opt: true);

  @override
  final MappableFields<FeaturedCars> fields = const {
    #id: _f$id,
    #carId: _f$carId,
    #car: _f$car,
    #sort: _f$sort,
    #companyId: _f$companyId,
    #company: _f$company,
    #startAt: _f$startAt,
    #until: _f$until,
    #deletedAt: _f$deletedAt,
    #available: _f$available,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static FeaturedCars _instantiate(DecodingData data) {
    return FeaturedCars(
        id: data.dec(_f$id),
        carId: data.dec(_f$carId),
        car: data.dec(_f$car),
        sort: data.dec(_f$sort),
        companyId: data.dec(_f$companyId),
        company: data.dec(_f$company),
        startAt: data.dec(_f$startAt),
        until: data.dec(_f$until),
        deletedAt: data.dec(_f$deletedAt),
        available: data.dec(_f$available),
        createdAt: data.dec(_f$createdAt),
        updatedAt: data.dec(_f$updatedAt));
  }

  @override
  final Function instantiate = _instantiate;

  static FeaturedCars fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FeaturedCars>(map);
  }

  static FeaturedCars fromJson(String json) {
    return ensureInitialized().decodeJson<FeaturedCars>(json);
  }
}

mixin FeaturedCarsMappable {
  String toJson() {
    return FeaturedCarsMapper.ensureInitialized()
        .encodeJson<FeaturedCars>(this as FeaturedCars);
  }

  Map<String, dynamic> toMap() {
    return FeaturedCarsMapper.ensureInitialized()
        .encodeMap<FeaturedCars>(this as FeaturedCars);
  }

  FeaturedCarsCopyWith<FeaturedCars, FeaturedCars, FeaturedCars> get copyWith =>
      _FeaturedCarsCopyWithImpl<FeaturedCars, FeaturedCars>(
          this as FeaturedCars, $identity, $identity);
  @override
  String toString() {
    return FeaturedCarsMapper.ensureInitialized()
        .stringifyValue(this as FeaturedCars);
  }

  @override
  bool operator ==(Object other) {
    return FeaturedCarsMapper.ensureInitialized()
        .equalsValue(this as FeaturedCars, other);
  }

  @override
  int get hashCode {
    return FeaturedCarsMapper.ensureInitialized()
        .hashValue(this as FeaturedCars);
  }
}

extension FeaturedCarsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FeaturedCars, $Out> {
  FeaturedCarsCopyWith<$R, FeaturedCars, $Out> get $asFeaturedCars =>
      $base.as((v, t, t2) => _FeaturedCarsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FeaturedCarsCopyWith<$R, $In extends FeaturedCars, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CarCopyWith<$R, Car, Car>? get car;
  CompanyCopyWith<$R, Company, Company>? get company;
  $R call(
      {String? id,
      String? carId,
      Car? car,
      int? sort,
      String? companyId,
      Company? company,
      DateTime? startAt,
      DateTime? until,
      DateTime? deletedAt,
      bool? available,
      DateTime? createdAt,
      DateTime? updatedAt});
  FeaturedCarsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FeaturedCarsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FeaturedCars, $Out>
    implements FeaturedCarsCopyWith<$R, FeaturedCars, $Out> {
  _FeaturedCarsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FeaturedCars> $mapper =
      FeaturedCarsMapper.ensureInitialized();
  @override
  CarCopyWith<$R, Car, Car>? get car =>
      $value.car?.copyWith.$chain((v) => call(car: v));
  @override
  CompanyCopyWith<$R, Company, Company>? get company =>
      $value.company?.copyWith.$chain((v) => call(company: v));
  @override
  $R call(
          {Object? id = $none,
          Object? carId = $none,
          Object? car = $none,
          Object? sort = $none,
          Object? companyId = $none,
          Object? company = $none,
          Object? startAt = $none,
          Object? until = $none,
          Object? deletedAt = $none,
          Object? available = $none,
          Object? createdAt = $none,
          Object? updatedAt = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (carId != $none) #carId: carId,
        if (car != $none) #car: car,
        if (sort != $none) #sort: sort,
        if (companyId != $none) #companyId: companyId,
        if (company != $none) #company: company,
        if (startAt != $none) #startAt: startAt,
        if (until != $none) #until: until,
        if (deletedAt != $none) #deletedAt: deletedAt,
        if (available != $none) #available: available,
        if (createdAt != $none) #createdAt: createdAt,
        if (updatedAt != $none) #updatedAt: updatedAt
      }));
  @override
  FeaturedCars $make(CopyWithData data) => FeaturedCars(
      id: data.get(#id, or: $value.id),
      carId: data.get(#carId, or: $value.carId),
      car: data.get(#car, or: $value.car),
      sort: data.get(#sort, or: $value.sort),
      companyId: data.get(#companyId, or: $value.companyId),
      company: data.get(#company, or: $value.company),
      startAt: data.get(#startAt, or: $value.startAt),
      until: data.get(#until, or: $value.until),
      deletedAt: data.get(#deletedAt, or: $value.deletedAt),
      available: data.get(#available, or: $value.available),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      updatedAt: data.get(#updatedAt, or: $value.updatedAt));

  @override
  FeaturedCarsCopyWith<$R2, FeaturedCars, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _FeaturedCarsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
