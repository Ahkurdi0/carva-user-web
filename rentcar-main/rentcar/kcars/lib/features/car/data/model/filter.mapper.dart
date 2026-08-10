// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'filter.dart';

class FilterMapper extends ClassMapperBase<Filter> {
  FilterMapper._();

  static FilterMapper? _instance;
  static FilterMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FilterMapper._());
      FeatureMapper.ensureInitialized();
      FilterRentalPlanMapper.ensureInitialized();
      CarLocationMapper.ensureInitialized();
      BrandMapper.ensureInitialized();
      CarTypeMapper.ensureInitialized();
      CityMapper.ensureInitialized();
      PlanMapper.ensureInitialized();
      TownMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Filter';

  static String? _$typeId(Filter v) => v.typeId;
  static const Field<Filter, String> _f$typeId =
      Field('typeId', _$typeId, opt: true);
  static String? _$brandId(Filter v) => v.brandId;
  static const Field<Filter, String> _f$brandId =
      Field('brandId', _$brandId, opt: true);
  static String? _$cityId(Filter v) => v.cityId;
  static const Field<Filter, String> _f$cityId =
      Field('cityId', _$cityId, opt: true);
  static String? _$townId(Filter v) => v.townId;
  static const Field<Filter, String> _f$townId =
      Field('townId', _$townId, opt: true);
  static int? _$minPrice(Filter v) => v.minPrice;
  static const Field<Filter, int> _f$minPrice =
      Field('minPrice', _$minPrice, opt: true);
  static int? _$maxPrice(Filter v) => v.maxPrice;
  static const Field<Filter, int> _f$maxPrice =
      Field('maxPrice', _$maxPrice, opt: true);
  static int? _$minYear(Filter v) => v.minYear;
  static const Field<Filter, int> _f$minYear =
      Field('minYear', _$minYear, opt: true);
  static int? _$maxYear(Filter v) => v.maxYear;
  static const Field<Filter, int> _f$maxYear =
      Field('maxYear', _$maxYear, opt: true);
  static Feature? _$feature(Filter v) => v.feature;
  static const Field<Filter, Feature> _f$feature =
      Field('feature', _$feature, opt: true);
  static FilterRentalPlan? _$rentalPlan(Filter v) => v.rentalPlan;
  static const Field<Filter, FilterRentalPlan> _f$rentalPlan =
      Field('rentalPlan', _$rentalPlan, opt: true);
  static CarLocation? _$location(Filter v) => v.location;
  static const Field<Filter, CarLocation> _f$location =
      Field('location', _$location, opt: true);
  static Brand? _$brand(Filter v) => v.brand;
  static const Field<Filter, Brand> _f$brand =
      Field('brand', _$brand, opt: true);
  static CarType? _$type(Filter v) => v.type;
  static const Field<Filter, CarType> _f$type =
      Field('type', _$type, opt: true);
  static City? _$city(Filter v) => v.city;
  static const Field<Filter, City> _f$city = Field('city', _$city, opt: true);
  static Plan? _$plan(Filter v) => v.plan;
  static const Field<Filter, Plan> _f$plan = Field('plan', _$plan, opt: true);
  static Town? _$town(Filter v) => v.town;
  static const Field<Filter, Town> _f$town = Field('town', _$town, opt: true);
  static String? _$cursor(Filter v) => v.cursor;
  static const Field<Filter, String> _f$cursor =
      Field('cursor', _$cursor, opt: true);
  static String? _$companyId(Filter v) => v.companyId;
  static const Field<Filter, String> _f$companyId =
      Field('companyId', _$companyId, opt: true);

  @override
  final MappableFields<Filter> fields = const {
    #typeId: _f$typeId,
    #brandId: _f$brandId,
    #cityId: _f$cityId,
    #townId: _f$townId,
    #minPrice: _f$minPrice,
    #maxPrice: _f$maxPrice,
    #minYear: _f$minYear,
    #maxYear: _f$maxYear,
    #feature: _f$feature,
    #rentalPlan: _f$rentalPlan,
    #location: _f$location,
    #brand: _f$brand,
    #type: _f$type,
    #city: _f$city,
    #plan: _f$plan,
    #town: _f$town,
    #cursor: _f$cursor,
    #companyId: _f$companyId,
  };

  static Filter _instantiate(DecodingData data) {
    return Filter(
        typeId: data.dec(_f$typeId),
        brandId: data.dec(_f$brandId),
        cityId: data.dec(_f$cityId),
        townId: data.dec(_f$townId),
        minPrice: data.dec(_f$minPrice),
        maxPrice: data.dec(_f$maxPrice),
        minYear: data.dec(_f$minYear),
        maxYear: data.dec(_f$maxYear),
        feature: data.dec(_f$feature),
        rentalPlan: data.dec(_f$rentalPlan),
        location: data.dec(_f$location),
        brand: data.dec(_f$brand),
        type: data.dec(_f$type),
        city: data.dec(_f$city),
        plan: data.dec(_f$plan),
        town: data.dec(_f$town),
        cursor: data.dec(_f$cursor),
        companyId: data.dec(_f$companyId));
  }

  @override
  final Function instantiate = _instantiate;

  static Filter fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Filter>(map);
  }

  static Filter fromJson(String json) {
    return ensureInitialized().decodeJson<Filter>(json);
  }
}

mixin FilterMappable {
  String toJson() {
    return FilterMapper.ensureInitialized().encodeJson<Filter>(this as Filter);
  }

  Map<String, dynamic> toMap() {
    return FilterMapper.ensureInitialized().encodeMap<Filter>(this as Filter);
  }

  FilterCopyWith<Filter, Filter, Filter> get copyWith =>
      _FilterCopyWithImpl<Filter, Filter>(this as Filter, $identity, $identity);
  @override
  String toString() {
    return FilterMapper.ensureInitialized().stringifyValue(this as Filter);
  }

  @override
  bool operator ==(Object other) {
    return FilterMapper.ensureInitialized().equalsValue(this as Filter, other);
  }

  @override
  int get hashCode {
    return FilterMapper.ensureInitialized().hashValue(this as Filter);
  }
}

extension FilterValueCopy<$R, $Out> on ObjectCopyWith<$R, Filter, $Out> {
  FilterCopyWith<$R, Filter, $Out> get $asFilter =>
      $base.as((v, t, t2) => _FilterCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FilterCopyWith<$R, $In extends Filter, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  FeatureCopyWith<$R, Feature, Feature>? get feature;
  FilterRentalPlanCopyWith<$R, FilterRentalPlan, FilterRentalPlan>?
      get rentalPlan;
  CarLocationCopyWith<$R, CarLocation, CarLocation>? get location;
  BrandCopyWith<$R, Brand, Brand>? get brand;
  CarTypeCopyWith<$R, CarType, CarType>? get type;
  CityCopyWith<$R, City, City>? get city;
  PlanCopyWith<$R, Plan, Plan>? get plan;
  TownCopyWith<$R, Town, Town>? get town;
  $R call(
      {String? typeId,
      String? brandId,
      String? cityId,
      String? townId,
      int? minPrice,
      int? maxPrice,
      int? minYear,
      int? maxYear,
      Feature? feature,
      FilterRentalPlan? rentalPlan,
      CarLocation? location,
      Brand? brand,
      CarType? type,
      City? city,
      Plan? plan,
      Town? town,
      String? cursor,
      String? companyId});
  FilterCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FilterCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Filter, $Out>
    implements FilterCopyWith<$R, Filter, $Out> {
  _FilterCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Filter> $mapper = FilterMapper.ensureInitialized();
  @override
  FeatureCopyWith<$R, Feature, Feature>? get feature =>
      $value.feature?.copyWith.$chain((v) => call(feature: v));
  @override
  FilterRentalPlanCopyWith<$R, FilterRentalPlan, FilterRentalPlan>?
      get rentalPlan =>
          $value.rentalPlan?.copyWith.$chain((v) => call(rentalPlan: v));
  @override
  CarLocationCopyWith<$R, CarLocation, CarLocation>? get location =>
      $value.location?.copyWith.$chain((v) => call(location: v));
  @override
  BrandCopyWith<$R, Brand, Brand>? get brand =>
      $value.brand?.copyWith.$chain((v) => call(brand: v));
  @override
  CarTypeCopyWith<$R, CarType, CarType>? get type =>
      $value.type?.copyWith.$chain((v) => call(type: v));
  @override
  CityCopyWith<$R, City, City>? get city =>
      $value.city?.copyWith.$chain((v) => call(city: v));
  @override
  PlanCopyWith<$R, Plan, Plan>? get plan =>
      $value.plan?.copyWith.$chain((v) => call(plan: v));
  @override
  TownCopyWith<$R, Town, Town>? get town =>
      $value.town?.copyWith.$chain((v) => call(town: v));
  @override
  $R call(
          {Object? typeId = $none,
          Object? brandId = $none,
          Object? cityId = $none,
          Object? townId = $none,
          Object? minPrice = $none,
          Object? maxPrice = $none,
          Object? minYear = $none,
          Object? maxYear = $none,
          Object? feature = $none,
          Object? rentalPlan = $none,
          Object? location = $none,
          Object? brand = $none,
          Object? type = $none,
          Object? city = $none,
          Object? plan = $none,
          Object? town = $none,
          Object? cursor = $none,
          Object? companyId = $none}) =>
      $apply(FieldCopyWithData({
        if (typeId != $none) #typeId: typeId,
        if (brandId != $none) #brandId: brandId,
        if (cityId != $none) #cityId: cityId,
        if (townId != $none) #townId: townId,
        if (minPrice != $none) #minPrice: minPrice,
        if (maxPrice != $none) #maxPrice: maxPrice,
        if (minYear != $none) #minYear: minYear,
        if (maxYear != $none) #maxYear: maxYear,
        if (feature != $none) #feature: feature,
        if (rentalPlan != $none) #rentalPlan: rentalPlan,
        if (location != $none) #location: location,
        if (brand != $none) #brand: brand,
        if (type != $none) #type: type,
        if (city != $none) #city: city,
        if (plan != $none) #plan: plan,
        if (town != $none) #town: town,
        if (cursor != $none) #cursor: cursor,
        if (companyId != $none) #companyId: companyId
      }));
  @override
  Filter $make(CopyWithData data) => Filter(
      typeId: data.get(#typeId, or: $value.typeId),
      brandId: data.get(#brandId, or: $value.brandId),
      cityId: data.get(#cityId, or: $value.cityId),
      townId: data.get(#townId, or: $value.townId),
      minPrice: data.get(#minPrice, or: $value.minPrice),
      maxPrice: data.get(#maxPrice, or: $value.maxPrice),
      minYear: data.get(#minYear, or: $value.minYear),
      maxYear: data.get(#maxYear, or: $value.maxYear),
      feature: data.get(#feature, or: $value.feature),
      rentalPlan: data.get(#rentalPlan, or: $value.rentalPlan),
      location: data.get(#location, or: $value.location),
      brand: data.get(#brand, or: $value.brand),
      type: data.get(#type, or: $value.type),
      city: data.get(#city, or: $value.city),
      plan: data.get(#plan, or: $value.plan),
      town: data.get(#town, or: $value.town),
      cursor: data.get(#cursor, or: $value.cursor),
      companyId: data.get(#companyId, or: $value.companyId));

  @override
  FilterCopyWith<$R2, Filter, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FilterCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
