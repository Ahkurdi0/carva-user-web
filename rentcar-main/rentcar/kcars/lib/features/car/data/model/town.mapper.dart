// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'town.dart';

class TownMapper extends ClassMapperBase<Town> {
  TownMapper._();

  static TownMapper? _instance;
  static TownMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TownMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Town';

  static String? _$id(Town v) => v.id;
  static const Field<Town, String> _f$id = Field('id', _$id, opt: true);
  static String _$en(Town v) => v.en;
  static const Field<Town, String> _f$en = Field('en', _$en);
  static String? _$ku(Town v) => v.ku;
  static const Field<Town, String> _f$ku = Field('ku', _$ku, opt: true);
  static String? _$ar(Town v) => v.ar;
  static const Field<Town, String> _f$ar = Field('ar', _$ar, opt: true);
  static double? _$lat(Town v) => v.lat;
  static const Field<Town, double> _f$lat = Field('lat', _$lat, opt: true);
  static double? _$long(Town v) => v.long;
  static const Field<Town, double> _f$long = Field('long', _$long, opt: true);
  static int? _$sort(Town v) => v.sort;
  static const Field<Town, int> _f$sort = Field('sort', _$sort, opt: true);
  static int? _$radiusKm(Town v) => v.radiusKm;
  static const Field<Town, int> _f$radiusKm =
      Field('radiusKm', _$radiusKm, opt: true);
  static String? _$cityId(Town v) => v.cityId;
  static const Field<Town, String> _f$cityId =
      Field('cityId', _$cityId, opt: true);
  static bool? _$available(Town v) => v.available;
  static const Field<Town, bool> _f$available =
      Field('available', _$available, opt: true);

  @override
  final MappableFields<Town> fields = const {
    #id: _f$id,
    #en: _f$en,
    #ku: _f$ku,
    #ar: _f$ar,
    #lat: _f$lat,
    #long: _f$long,
    #sort: _f$sort,
    #radiusKm: _f$radiusKm,
    #cityId: _f$cityId,
    #available: _f$available,
  };

  static Town _instantiate(DecodingData data) {
    return Town(
        id: data.dec(_f$id),
        en: data.dec(_f$en),
        ku: data.dec(_f$ku),
        ar: data.dec(_f$ar),
        lat: data.dec(_f$lat),
        long: data.dec(_f$long),
        sort: data.dec(_f$sort),
        radiusKm: data.dec(_f$radiusKm),
        cityId: data.dec(_f$cityId),
        available: data.dec(_f$available));
  }

  @override
  final Function instantiate = _instantiate;

  static Town fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Town>(map);
  }

  static Town fromJson(String json) {
    return ensureInitialized().decodeJson<Town>(json);
  }
}

mixin TownMappable {
  String toJson() {
    return TownMapper.ensureInitialized().encodeJson<Town>(this as Town);
  }

  Map<String, dynamic> toMap() {
    return TownMapper.ensureInitialized().encodeMap<Town>(this as Town);
  }

  TownCopyWith<Town, Town, Town> get copyWith =>
      _TownCopyWithImpl<Town, Town>(this as Town, $identity, $identity);
  @override
  String toString() {
    return TownMapper.ensureInitialized().stringifyValue(this as Town);
  }

  @override
  bool operator ==(Object other) {
    return TownMapper.ensureInitialized().equalsValue(this as Town, other);
  }

  @override
  int get hashCode {
    return TownMapper.ensureInitialized().hashValue(this as Town);
  }
}

extension TownValueCopy<$R, $Out> on ObjectCopyWith<$R, Town, $Out> {
  TownCopyWith<$R, Town, $Out> get $asTown =>
      $base.as((v, t, t2) => _TownCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TownCopyWith<$R, $In extends Town, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? en,
      String? ku,
      String? ar,
      double? lat,
      double? long,
      int? sort,
      int? radiusKm,
      String? cityId,
      bool? available});
  TownCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TownCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Town, $Out>
    implements TownCopyWith<$R, Town, $Out> {
  _TownCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Town> $mapper = TownMapper.ensureInitialized();
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
          Object? cityId = $none,
          Object? available = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (en != null) #en: en,
        if (ku != $none) #ku: ku,
        if (ar != $none) #ar: ar,
        if (lat != $none) #lat: lat,
        if (long != $none) #long: long,
        if (sort != $none) #sort: sort,
        if (radiusKm != $none) #radiusKm: radiusKm,
        if (cityId != $none) #cityId: cityId,
        if (available != $none) #available: available
      }));
  @override
  Town $make(CopyWithData data) => Town(
      id: data.get(#id, or: $value.id),
      en: data.get(#en, or: $value.en),
      ku: data.get(#ku, or: $value.ku),
      ar: data.get(#ar, or: $value.ar),
      lat: data.get(#lat, or: $value.lat),
      long: data.get(#long, or: $value.long),
      sort: data.get(#sort, or: $value.sort),
      radiusKm: data.get(#radiusKm, or: $value.radiusKm),
      cityId: data.get(#cityId, or: $value.cityId),
      available: data.get(#available, or: $value.available));

  @override
  TownCopyWith<$R2, Town, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _TownCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
