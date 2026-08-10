// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'location.dart';

class LocationMapper extends ClassMapperBase<Location> {
  LocationMapper._();

  static LocationMapper? _instance;
  static LocationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocationMapper._());
      CityMapper.ensureInitialized();
      TownMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Location';

  static String? _$id(Location v) => v.id;
  static const Field<Location, String> _f$id = Field('id', _$id, opt: true);
  static double _$lat(Location v) => v.lat;
  static const Field<Location, double> _f$lat = Field('lat', _$lat);
  static double _$long(Location v) => v.long;
  static const Field<Location, double> _f$long = Field('long', _$long);
  static DateTime? _$createdAt(Location v) => v.createdAt;
  static const Field<Location, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, opt: true);
  static City? _$city(Location v) => v.city;
  static const Field<Location, City> _f$city = Field('city', _$city, opt: true);
  static String? _$cityId(Location v) => v.cityId;
  static const Field<Location, String> _f$cityId =
      Field('cityId', _$cityId, opt: true);
  static Town? _$town(Location v) => v.town;
  static const Field<Location, Town> _f$town = Field('town', _$town, opt: true);
  static String? _$townId(Location v) => v.townId;
  static const Field<Location, String> _f$townId =
      Field('townId', _$townId, opt: true);
  static int? _$radiusKm(Location v) => v.radiusKm;
  static const Field<Location, int> _f$radiusKm =
      Field('radiusKm', _$radiusKm, opt: true);

  @override
  final MappableFields<Location> fields = const {
    #id: _f$id,
    #lat: _f$lat,
    #long: _f$long,
    #createdAt: _f$createdAt,
    #city: _f$city,
    #cityId: _f$cityId,
    #town: _f$town,
    #townId: _f$townId,
    #radiusKm: _f$radiusKm,
  };

  static Location _instantiate(DecodingData data) {
    return Location(
        id: data.dec(_f$id),
        lat: data.dec(_f$lat),
        long: data.dec(_f$long),
        createdAt: data.dec(_f$createdAt),
        city: data.dec(_f$city),
        cityId: data.dec(_f$cityId),
        town: data.dec(_f$town),
        townId: data.dec(_f$townId),
        radiusKm: data.dec(_f$radiusKm));
  }

  @override
  final Function instantiate = _instantiate;

  static Location fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Location>(map);
  }

  static Location fromJson(String json) {
    return ensureInitialized().decodeJson<Location>(json);
  }
}

mixin LocationMappable {
  String toJson() {
    return LocationMapper.ensureInitialized()
        .encodeJson<Location>(this as Location);
  }

  Map<String, dynamic> toMap() {
    return LocationMapper.ensureInitialized()
        .encodeMap<Location>(this as Location);
  }

  LocationCopyWith<Location, Location, Location> get copyWith =>
      _LocationCopyWithImpl<Location, Location>(
          this as Location, $identity, $identity);
  @override
  String toString() {
    return LocationMapper.ensureInitialized().stringifyValue(this as Location);
  }

  @override
  bool operator ==(Object other) {
    return LocationMapper.ensureInitialized()
        .equalsValue(this as Location, other);
  }

  @override
  int get hashCode {
    return LocationMapper.ensureInitialized().hashValue(this as Location);
  }
}

extension LocationValueCopy<$R, $Out> on ObjectCopyWith<$R, Location, $Out> {
  LocationCopyWith<$R, Location, $Out> get $asLocation =>
      $base.as((v, t, t2) => _LocationCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LocationCopyWith<$R, $In extends Location, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CityCopyWith<$R, City, City>? get city;
  TownCopyWith<$R, Town, Town>? get town;
  $R call(
      {String? id,
      double? lat,
      double? long,
      DateTime? createdAt,
      City? city,
      String? cityId,
      Town? town,
      String? townId,
      int? radiusKm});
  LocationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LocationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Location, $Out>
    implements LocationCopyWith<$R, Location, $Out> {
  _LocationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Location> $mapper =
      LocationMapper.ensureInitialized();
  @override
  CityCopyWith<$R, City, City>? get city =>
      $value.city?.copyWith.$chain((v) => call(city: v));
  @override
  TownCopyWith<$R, Town, Town>? get town =>
      $value.town?.copyWith.$chain((v) => call(town: v));
  @override
  $R call(
          {Object? id = $none,
          double? lat,
          double? long,
          Object? createdAt = $none,
          Object? city = $none,
          Object? cityId = $none,
          Object? town = $none,
          Object? townId = $none,
          Object? radiusKm = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (lat != null) #lat: lat,
        if (long != null) #long: long,
        if (createdAt != $none) #createdAt: createdAt,
        if (city != $none) #city: city,
        if (cityId != $none) #cityId: cityId,
        if (town != $none) #town: town,
        if (townId != $none) #townId: townId,
        if (radiusKm != $none) #radiusKm: radiusKm
      }));
  @override
  Location $make(CopyWithData data) => Location(
      id: data.get(#id, or: $value.id),
      lat: data.get(#lat, or: $value.lat),
      long: data.get(#long, or: $value.long),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      city: data.get(#city, or: $value.city),
      cityId: data.get(#cityId, or: $value.cityId),
      town: data.get(#town, or: $value.town),
      townId: data.get(#townId, or: $value.townId),
      radiusKm: data.get(#radiusKm, or: $value.radiusKm));

  @override
  LocationCopyWith<$R2, Location, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _LocationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
