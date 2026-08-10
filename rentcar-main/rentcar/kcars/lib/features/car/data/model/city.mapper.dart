// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'city.dart';

class CityMapper extends ClassMapperBase<City> {
  CityMapper._();

  static CityMapper? _instance;
  static CityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CityMapper._());
      TownMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'City';

  static String? _$id(City v) => v.id;
  static const Field<City, String> _f$id = Field('id', _$id, opt: true);
  static String _$en(City v) => v.en;
  static const Field<City, String> _f$en = Field('en', _$en);
  static String? _$ku(City v) => v.ku;
  static const Field<City, String> _f$ku = Field('ku', _$ku, opt: true);
  static String? _$ar(City v) => v.ar;
  static const Field<City, String> _f$ar = Field('ar', _$ar, opt: true);
  static double? _$lat(City v) => v.lat;
  static const Field<City, double> _f$lat = Field('lat', _$lat, opt: true);
  static double? _$long(City v) => v.long;
  static const Field<City, double> _f$long = Field('long', _$long, opt: true);
  static int? _$sort(City v) => v.sort;
  static const Field<City, int> _f$sort = Field('sort', _$sort, opt: true);
  static int? _$radiusKm(City v) => v.radiusKm;
  static const Field<City, int> _f$radiusKm =
      Field('radiusKm', _$radiusKm, opt: true);
  static bool? _$available(City v) => v.available;
  static const Field<City, bool> _f$available =
      Field('available', _$available, opt: true);
  static List<Town>? _$towns(City v) => v.towns;
  static const Field<City, List<Town>> _f$towns =
      Field('towns', _$towns, opt: true);

  @override
  final MappableFields<City> fields = const {
    #id: _f$id,
    #en: _f$en,
    #ku: _f$ku,
    #ar: _f$ar,
    #lat: _f$lat,
    #long: _f$long,
    #sort: _f$sort,
    #radiusKm: _f$radiusKm,
    #available: _f$available,
    #towns: _f$towns,
  };

  static City _instantiate(DecodingData data) {
    return City(
        id: data.dec(_f$id),
        en: data.dec(_f$en),
        ku: data.dec(_f$ku),
        ar: data.dec(_f$ar),
        lat: data.dec(_f$lat),
        long: data.dec(_f$long),
        sort: data.dec(_f$sort),
        radiusKm: data.dec(_f$radiusKm),
        available: data.dec(_f$available),
        towns: data.dec(_f$towns));
  }

  @override
  final Function instantiate = _instantiate;

  static City fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<City>(map);
  }

  static City fromJson(String json) {
    return ensureInitialized().decodeJson<City>(json);
  }
}

mixin CityMappable {
  String toJson() {
    return CityMapper.ensureInitialized().encodeJson<City>(this as City);
  }

  Map<String, dynamic> toMap() {
    return CityMapper.ensureInitialized().encodeMap<City>(this as City);
  }

  CityCopyWith<City, City, City> get copyWith =>
      _CityCopyWithImpl<City, City>(this as City, $identity, $identity);
  @override
  String toString() {
    return CityMapper.ensureInitialized().stringifyValue(this as City);
  }

  @override
  bool operator ==(Object other) {
    return CityMapper.ensureInitialized().equalsValue(this as City, other);
  }

  @override
  int get hashCode {
    return CityMapper.ensureInitialized().hashValue(this as City);
  }
}

extension CityValueCopy<$R, $Out> on ObjectCopyWith<$R, City, $Out> {
  CityCopyWith<$R, City, $Out> get $asCity =>
      $base.as((v, t, t2) => _CityCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CityCopyWith<$R, $In extends City, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Town, TownCopyWith<$R, Town, Town>>? get towns;
  $R call(
      {String? id,
      String? en,
      String? ku,
      String? ar,
      double? lat,
      double? long,
      int? sort,
      int? radiusKm,
      bool? available,
      List<Town>? towns});
  CityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CityCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, City, $Out>
    implements CityCopyWith<$R, City, $Out> {
  _CityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<City> $mapper = CityMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Town, TownCopyWith<$R, Town, Town>>? get towns =>
      $value.towns != null
          ? ListCopyWith($value.towns!, (v, t) => v.copyWith.$chain(t),
              (v) => call(towns: v))
          : null;
  @override
  $R call(
          {Object? id = $none,
          String? en,
          Object? ku = $none,
          Object? ar = $none,
          Object? lat = $none,
          Object? long = $none,
          Object? sort = $none,
          Object? radiusKm = $none,
          Object? available = $none,
          Object? towns = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (en != null) #en: en,
        if (ku != $none) #ku: ku,
        if (ar != $none) #ar: ar,
        if (lat != $none) #lat: lat,
        if (long != $none) #long: long,
        if (sort != $none) #sort: sort,
        if (radiusKm != $none) #radiusKm: radiusKm,
        if (available != $none) #available: available,
        if (towns != $none) #towns: towns
      }));
  @override
  City $make(CopyWithData data) => City(
      id: data.get(#id, or: $value.id),
      en: data.get(#en, or: $value.en),
      ku: data.get(#ku, or: $value.ku),
      ar: data.get(#ar, or: $value.ar),
      lat: data.get(#lat, or: $value.lat),
      long: data.get(#long, or: $value.long),
      sort: data.get(#sort, or: $value.sort),
      radiusKm: data.get(#radiusKm, or: $value.radiusKm),
      available: data.get(#available, or: $value.available),
      towns: data.get(#towns, or: $value.towns));

  @override
  CityCopyWith<$R2, City, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CityCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
