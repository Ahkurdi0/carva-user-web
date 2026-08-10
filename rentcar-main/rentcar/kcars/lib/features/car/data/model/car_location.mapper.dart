// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'car_location.dart';

class CarLocationMapper extends ClassMapperBase<CarLocation> {
  CarLocationMapper._();

  static CarLocationMapper? _instance;
  static CarLocationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CarLocationMapper._());
      CityMapper.ensureInitialized();
      TownMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CarLocation';

  static String? _$id(CarLocation v) => v.id;
  static const Field<CarLocation, String> _f$id = Field('id', _$id, opt: true);
  static double? _$lat(CarLocation v) => v.lat;
  static const Field<CarLocation, double> _f$lat =
      Field('lat', _$lat, opt: true);
  static double? _$long(CarLocation v) => v.long;
  static const Field<CarLocation, double> _f$long =
      Field('long', _$long, opt: true);
  static String? _$companyId(CarLocation v) => v.companyId;
  static const Field<CarLocation, String> _f$companyId =
      Field('companyId', _$companyId, opt: true);
  static String? _$townId(CarLocation v) => v.townId;
  static const Field<CarLocation, String> _f$townId =
      Field('townId', _$townId, opt: true);
  static int? _$radiusKm(CarLocation v) => v.radiusKm;
  static const Field<CarLocation, int> _f$radiusKm =
      Field('radiusKm', _$radiusKm, opt: true);
  static City? _$city(CarLocation v) => v.city;
  static const Field<CarLocation, City> _f$city =
      Field('city', _$city, opt: true);
  static Town? _$town(CarLocation v) => v.town;
  static const Field<CarLocation, Town> _f$town =
      Field('town', _$town, opt: true);
  static String? _$cityId(CarLocation v) => v.cityId;
  static const Field<CarLocation, String> _f$cityId =
      Field('cityId', _$cityId, opt: true);

  @override
  final MappableFields<CarLocation> fields = const {
    #id: _f$id,
    #lat: _f$lat,
    #long: _f$long,
    #companyId: _f$companyId,
    #townId: _f$townId,
    #radiusKm: _f$radiusKm,
    #city: _f$city,
    #town: _f$town,
    #cityId: _f$cityId,
  };

  static CarLocation _instantiate(DecodingData data) {
    return CarLocation(
        id: data.dec(_f$id),
        lat: data.dec(_f$lat),
        long: data.dec(_f$long),
        companyId: data.dec(_f$companyId),
        townId: data.dec(_f$townId),
        radiusKm: data.dec(_f$radiusKm),
        city: data.dec(_f$city),
        town: data.dec(_f$town),
        cityId: data.dec(_f$cityId));
  }

  @override
  final Function instantiate = _instantiate;

  static CarLocation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CarLocation>(map);
  }

  static CarLocation fromJson(String json) {
    return ensureInitialized().decodeJson<CarLocation>(json);
  }
}

mixin CarLocationMappable {
  String toJson() {
    return CarLocationMapper.ensureInitialized()
        .encodeJson<CarLocation>(this as CarLocation);
  }

  Map<String, dynamic> toMap() {
    return CarLocationMapper.ensureInitialized()
        .encodeMap<CarLocation>(this as CarLocation);
  }

  CarLocationCopyWith<CarLocation, CarLocation, CarLocation> get copyWith =>
      _CarLocationCopyWithImpl<CarLocation, CarLocation>(
          this as CarLocation, $identity, $identity);
  @override
  String toString() {
    return CarLocationMapper.ensureInitialized()
        .stringifyValue(this as CarLocation);
  }

  @override
  bool operator ==(Object other) {
    return CarLocationMapper.ensureInitialized()
        .equalsValue(this as CarLocation, other);
  }

  @override
  int get hashCode {
    return CarLocationMapper.ensureInitialized().hashValue(this as CarLocation);
  }
}

extension CarLocationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CarLocation, $Out> {
  CarLocationCopyWith<$R, CarLocation, $Out> get $asCarLocation =>
      $base.as((v, t, t2) => _CarLocationCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CarLocationCopyWith<$R, $In extends CarLocation, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CityCopyWith<$R, City, City>? get city;
  TownCopyWith<$R, Town, Town>? get town;
  $R call(
      {String? id,
      double? lat,
      double? long,
      String? companyId,
      String? townId,
      int? radiusKm,
      City? city,
      Town? town,
      String? cityId});
  CarLocationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CarLocationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CarLocation, $Out>
    implements CarLocationCopyWith<$R, CarLocation, $Out> {
  _CarLocationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CarLocation> $mapper =
      CarLocationMapper.ensureInitialized();
  @override
  CityCopyWith<$R, City, City>? get city =>
      $value.city?.copyWith.$chain((v) => call(city: v));
  @override
  TownCopyWith<$R, Town, Town>? get town =>
      $value.town?.copyWith.$chain((v) => call(town: v));
  @override
  $R call(
          {Object? id = $none,
          Object? lat = $none,
          Object? long = $none,
          Object? companyId = $none,
          Object? townId = $none,
          Object? radiusKm = $none,
          Object? city = $none,
          Object? town = $none,
          Object? cityId = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (lat != $none) #lat: lat,
        if (long != $none) #long: long,
        if (companyId != $none) #companyId: companyId,
        if (townId != $none) #townId: townId,
        if (radiusKm != $none) #radiusKm: radiusKm,
        if (city != $none) #city: city,
        if (town != $none) #town: town,
        if (cityId != $none) #cityId: cityId
      }));
  @override
  CarLocation $make(CopyWithData data) => CarLocation(
      id: data.get(#id, or: $value.id),
      lat: data.get(#lat, or: $value.lat),
      long: data.get(#long, or: $value.long),
      companyId: data.get(#companyId, or: $value.companyId),
      townId: data.get(#townId, or: $value.townId),
      radiusKm: data.get(#radiusKm, or: $value.radiusKm),
      city: data.get(#city, or: $value.city),
      town: data.get(#town, or: $value.town),
      cityId: data.get(#cityId, or: $value.cityId));

  @override
  CarLocationCopyWith<$R2, CarLocation, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CarLocationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
