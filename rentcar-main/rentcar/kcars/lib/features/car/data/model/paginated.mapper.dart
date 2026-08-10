// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'paginated.dart';

class PaginatedMapper extends ClassMapperBase<Paginated> {
  PaginatedMapper._();

  static PaginatedMapper? _instance;
  static PaginatedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PaginatedMapper._());
      CarMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Paginated';

  static String? _$cursor(Paginated v) => v.cursor;
  static const Field<Paginated, String> _f$cursor =
      Field('cursor', _$cursor, opt: true);
  static List<Car> _$cars(Paginated v) => v.cars;
  static const Field<Paginated, List<Car>> _f$cars = Field('cars', _$cars);
  static bool? _$hasMore(Paginated v) => v.hasMore;
  static const Field<Paginated, bool> _f$hasMore =
      Field('hasMore', _$hasMore, opt: true);

  @override
  final MappableFields<Paginated> fields = const {
    #cursor: _f$cursor,
    #cars: _f$cars,
    #hasMore: _f$hasMore,
  };

  static Paginated _instantiate(DecodingData data) {
    return Paginated(
        cursor: data.dec(_f$cursor),
        cars: data.dec(_f$cars),
        hasMore: data.dec(_f$hasMore));
  }

  @override
  final Function instantiate = _instantiate;

  static Paginated fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Paginated>(map);
  }

  static Paginated fromJson(String json) {
    return ensureInitialized().decodeJson<Paginated>(json);
  }
}

mixin PaginatedMappable {
  String toJson() {
    return PaginatedMapper.ensureInitialized()
        .encodeJson<Paginated>(this as Paginated);
  }

  Map<String, dynamic> toMap() {
    return PaginatedMapper.ensureInitialized()
        .encodeMap<Paginated>(this as Paginated);
  }

  PaginatedCopyWith<Paginated, Paginated, Paginated> get copyWith =>
      _PaginatedCopyWithImpl<Paginated, Paginated>(
          this as Paginated, $identity, $identity);
  @override
  String toString() {
    return PaginatedMapper.ensureInitialized()
        .stringifyValue(this as Paginated);
  }

  @override
  bool operator ==(Object other) {
    return PaginatedMapper.ensureInitialized()
        .equalsValue(this as Paginated, other);
  }

  @override
  int get hashCode {
    return PaginatedMapper.ensureInitialized().hashValue(this as Paginated);
  }
}

extension PaginatedValueCopy<$R, $Out> on ObjectCopyWith<$R, Paginated, $Out> {
  PaginatedCopyWith<$R, Paginated, $Out> get $asPaginated =>
      $base.as((v, t, t2) => _PaginatedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PaginatedCopyWith<$R, $In extends Paginated, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Car, CarCopyWith<$R, Car, Car>> get cars;
  $R call({String? cursor, List<Car>? cars, bool? hasMore});
  PaginatedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PaginatedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Paginated, $Out>
    implements PaginatedCopyWith<$R, Paginated, $Out> {
  _PaginatedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Paginated> $mapper =
      PaginatedMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Car, CarCopyWith<$R, Car, Car>> get cars => ListCopyWith(
      $value.cars, (v, t) => v.copyWith.$chain(t), (v) => call(cars: v));
  @override
  $R call({Object? cursor = $none, List<Car>? cars, Object? hasMore = $none}) =>
      $apply(FieldCopyWithData({
        if (cursor != $none) #cursor: cursor,
        if (cars != null) #cars: cars,
        if (hasMore != $none) #hasMore: hasMore
      }));
  @override
  Paginated $make(CopyWithData data) => Paginated(
      cursor: data.get(#cursor, or: $value.cursor),
      cars: data.get(#cars, or: $value.cars),
      hasMore: data.get(#hasMore, or: $value.hasMore));

  @override
  PaginatedCopyWith<$R2, Paginated, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PaginatedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
