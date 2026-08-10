// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'filter_data.dart';

class FilterDataMapper extends ClassMapperBase<FilterData> {
  FilterDataMapper._();

  static FilterDataMapper? _instance;
  static FilterDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FilterDataMapper._());
      BrandMapper.ensureInitialized();
      CarTypeMapper.ensureInitialized();
      CityMapper.ensureInitialized();
      PlanMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FilterData';

  static List<Brand>? _$brands(FilterData v) => v.brands;
  static const Field<FilterData, List<Brand>> _f$brands =
      Field('brands', _$brands, opt: true);
  static List<CarType>? _$types(FilterData v) => v.types;
  static const Field<FilterData, List<CarType>> _f$types =
      Field('types', _$types, opt: true);
  static List<City>? _$cities(FilterData v) => v.cities;
  static const Field<FilterData, List<City>> _f$cities =
      Field('cities', _$cities, opt: true);
  static List<Plan>? _$plans(FilterData v) => v.plans;
  static const Field<FilterData, List<Plan>> _f$plans =
      Field('plans', _$plans, opt: true);

  @override
  final MappableFields<FilterData> fields = const {
    #brands: _f$brands,
    #types: _f$types,
    #cities: _f$cities,
    #plans: _f$plans,
  };

  static FilterData _instantiate(DecodingData data) {
    return FilterData(
        brands: data.dec(_f$brands),
        types: data.dec(_f$types),
        cities: data.dec(_f$cities),
        plans: data.dec(_f$plans));
  }

  @override
  final Function instantiate = _instantiate;

  static FilterData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FilterData>(map);
  }

  static FilterData fromJson(String json) {
    return ensureInitialized().decodeJson<FilterData>(json);
  }
}

mixin FilterDataMappable {
  String toJson() {
    return FilterDataMapper.ensureInitialized()
        .encodeJson<FilterData>(this as FilterData);
  }

  Map<String, dynamic> toMap() {
    return FilterDataMapper.ensureInitialized()
        .encodeMap<FilterData>(this as FilterData);
  }

  FilterDataCopyWith<FilterData, FilterData, FilterData> get copyWith =>
      _FilterDataCopyWithImpl<FilterData, FilterData>(
          this as FilterData, $identity, $identity);
  @override
  String toString() {
    return FilterDataMapper.ensureInitialized()
        .stringifyValue(this as FilterData);
  }

  @override
  bool operator ==(Object other) {
    return FilterDataMapper.ensureInitialized()
        .equalsValue(this as FilterData, other);
  }

  @override
  int get hashCode {
    return FilterDataMapper.ensureInitialized().hashValue(this as FilterData);
  }
}

extension FilterDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FilterData, $Out> {
  FilterDataCopyWith<$R, FilterData, $Out> get $asFilterData =>
      $base.as((v, t, t2) => _FilterDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FilterDataCopyWith<$R, $In extends FilterData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Brand, BrandCopyWith<$R, Brand, Brand>>? get brands;
  ListCopyWith<$R, CarType, CarTypeCopyWith<$R, CarType, CarType>>? get types;
  ListCopyWith<$R, City, CityCopyWith<$R, City, City>>? get cities;
  ListCopyWith<$R, Plan, PlanCopyWith<$R, Plan, Plan>>? get plans;
  $R call(
      {List<Brand>? brands,
      List<CarType>? types,
      List<City>? cities,
      List<Plan>? plans});
  FilterDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FilterDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FilterData, $Out>
    implements FilterDataCopyWith<$R, FilterData, $Out> {
  _FilterDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FilterData> $mapper =
      FilterDataMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Brand, BrandCopyWith<$R, Brand, Brand>>? get brands =>
      $value.brands != null
          ? ListCopyWith($value.brands!, (v, t) => v.copyWith.$chain(t),
              (v) => call(brands: v))
          : null;
  @override
  ListCopyWith<$R, CarType, CarTypeCopyWith<$R, CarType, CarType>>? get types =>
      $value.types != null
          ? ListCopyWith($value.types!, (v, t) => v.copyWith.$chain(t),
              (v) => call(types: v))
          : null;
  @override
  ListCopyWith<$R, City, CityCopyWith<$R, City, City>>? get cities =>
      $value.cities != null
          ? ListCopyWith($value.cities!, (v, t) => v.copyWith.$chain(t),
              (v) => call(cities: v))
          : null;
  @override
  ListCopyWith<$R, Plan, PlanCopyWith<$R, Plan, Plan>>? get plans =>
      $value.plans != null
          ? ListCopyWith($value.plans!, (v, t) => v.copyWith.$chain(t),
              (v) => call(plans: v))
          : null;
  @override
  $R call(
          {Object? brands = $none,
          Object? types = $none,
          Object? cities = $none,
          Object? plans = $none}) =>
      $apply(FieldCopyWithData({
        if (brands != $none) #brands: brands,
        if (types != $none) #types: types,
        if (cities != $none) #cities: cities,
        if (plans != $none) #plans: plans
      }));
  @override
  FilterData $make(CopyWithData data) => FilterData(
      brands: data.get(#brands, or: $value.brands),
      types: data.get(#types, or: $value.types),
      cities: data.get(#cities, or: $value.cities),
      plans: data.get(#plans, or: $value.plans));

  @override
  FilterDataCopyWith<$R2, FilterData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _FilterDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
