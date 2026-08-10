// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'post_location.dart';

class PostLocationMapper extends ClassMapperBase<PostLocation> {
  PostLocationMapper._();

  static PostLocationMapper? _instance;
  static PostLocationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PostLocationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PostLocation';

  static double? _$long(PostLocation v) => v.long;
  static const Field<PostLocation, double> _f$long =
      Field('long', _$long, opt: true);
  static double? _$lat(PostLocation v) => v.lat;
  static const Field<PostLocation, double> _f$lat =
      Field('lat', _$lat, opt: true);
  static double? _$west(PostLocation v) => v.west;
  static const Field<PostLocation, double> _f$west =
      Field('west', _$west, opt: true);
  static double? _$east(PostLocation v) => v.east;
  static const Field<PostLocation, double> _f$east =
      Field('east', _$east, opt: true);
  static double? _$north(PostLocation v) => v.north;
  static const Field<PostLocation, double> _f$north =
      Field('north', _$north, opt: true);
  static double? _$south(PostLocation v) => v.south;
  static const Field<PostLocation, double> _f$south =
      Field('south', _$south, opt: true);
  static int? _$radiusKm(PostLocation v) => v.radiusKm;
  static const Field<PostLocation, int> _f$radiusKm =
      Field('radiusKm', _$radiusKm, opt: true);

  @override
  final MappableFields<PostLocation> fields = const {
    #long: _f$long,
    #lat: _f$lat,
    #west: _f$west,
    #east: _f$east,
    #north: _f$north,
    #south: _f$south,
    #radiusKm: _f$radiusKm,
  };

  static PostLocation _instantiate(DecodingData data) {
    return PostLocation(
        long: data.dec(_f$long),
        lat: data.dec(_f$lat),
        west: data.dec(_f$west),
        east: data.dec(_f$east),
        north: data.dec(_f$north),
        south: data.dec(_f$south),
        radiusKm: data.dec(_f$radiusKm));
  }

  @override
  final Function instantiate = _instantiate;

  static PostLocation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PostLocation>(map);
  }

  static PostLocation fromJson(String json) {
    return ensureInitialized().decodeJson<PostLocation>(json);
  }
}

mixin PostLocationMappable {
  String toJson() {
    return PostLocationMapper.ensureInitialized()
        .encodeJson<PostLocation>(this as PostLocation);
  }

  Map<String, dynamic> toMap() {
    return PostLocationMapper.ensureInitialized()
        .encodeMap<PostLocation>(this as PostLocation);
  }

  PostLocationCopyWith<PostLocation, PostLocation, PostLocation> get copyWith =>
      _PostLocationCopyWithImpl<PostLocation, PostLocation>(
          this as PostLocation, $identity, $identity);
  @override
  String toString() {
    return PostLocationMapper.ensureInitialized()
        .stringifyValue(this as PostLocation);
  }

  @override
  bool operator ==(Object other) {
    return PostLocationMapper.ensureInitialized()
        .equalsValue(this as PostLocation, other);
  }

  @override
  int get hashCode {
    return PostLocationMapper.ensureInitialized()
        .hashValue(this as PostLocation);
  }
}

extension PostLocationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PostLocation, $Out> {
  PostLocationCopyWith<$R, PostLocation, $Out> get $asPostLocation =>
      $base.as((v, t, t2) => _PostLocationCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PostLocationCopyWith<$R, $In extends PostLocation, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {double? long,
      double? lat,
      double? west,
      double? east,
      double? north,
      double? south,
      int? radiusKm});
  PostLocationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PostLocationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PostLocation, $Out>
    implements PostLocationCopyWith<$R, PostLocation, $Out> {
  _PostLocationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PostLocation> $mapper =
      PostLocationMapper.ensureInitialized();
  @override
  $R call(
          {Object? long = $none,
          Object? lat = $none,
          Object? west = $none,
          Object? east = $none,
          Object? north = $none,
          Object? south = $none,
          Object? radiusKm = $none}) =>
      $apply(FieldCopyWithData({
        if (long != $none) #long: long,
        if (lat != $none) #lat: lat,
        if (west != $none) #west: west,
        if (east != $none) #east: east,
        if (north != $none) #north: north,
        if (south != $none) #south: south,
        if (radiusKm != $none) #radiusKm: radiusKm
      }));
  @override
  PostLocation $make(CopyWithData data) => PostLocation(
      long: data.get(#long, or: $value.long),
      lat: data.get(#lat, or: $value.lat),
      west: data.get(#west, or: $value.west),
      east: data.get(#east, or: $value.east),
      north: data.get(#north, or: $value.north),
      south: data.get(#south, or: $value.south),
      radiusKm: data.get(#radiusKm, or: $value.radiusKm));

  @override
  PostLocationCopyWith<$R2, PostLocation, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PostLocationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
