// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'car_cursor.dart';

class CarsCursorMapper extends ClassMapperBase<CarsCursor> {
  CarsCursorMapper._();

  static CarsCursorMapper? _instance;
  static CarsCursorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CarsCursorMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CarsCursor';

  static String? _$cursor(CarsCursor v) => v.cursor;
  static const Field<CarsCursor, String> _f$cursor =
      Field('cursor', _$cursor, opt: true);
  static String? _$companyId(CarsCursor v) => v.companyId;
  static const Field<CarsCursor, String> _f$companyId =
      Field('companyId', _$companyId, opt: true);
  static String? _$id(CarsCursor v) => v.id;
  static const Field<CarsCursor, String> _f$id = Field('id', _$id, opt: true);

  @override
  final MappableFields<CarsCursor> fields = const {
    #cursor: _f$cursor,
    #companyId: _f$companyId,
    #id: _f$id,
  };

  static CarsCursor _instantiate(DecodingData data) {
    return CarsCursor(
        cursor: data.dec(_f$cursor),
        companyId: data.dec(_f$companyId),
        id: data.dec(_f$id));
  }

  @override
  final Function instantiate = _instantiate;

  static CarsCursor fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CarsCursor>(map);
  }

  static CarsCursor fromJson(String json) {
    return ensureInitialized().decodeJson<CarsCursor>(json);
  }
}

mixin CarsCursorMappable {
  String toJson() {
    return CarsCursorMapper.ensureInitialized()
        .encodeJson<CarsCursor>(this as CarsCursor);
  }

  Map<String, dynamic> toMap() {
    return CarsCursorMapper.ensureInitialized()
        .encodeMap<CarsCursor>(this as CarsCursor);
  }

  CarsCursorCopyWith<CarsCursor, CarsCursor, CarsCursor> get copyWith =>
      _CarsCursorCopyWithImpl<CarsCursor, CarsCursor>(
          this as CarsCursor, $identity, $identity);
  @override
  String toString() {
    return CarsCursorMapper.ensureInitialized()
        .stringifyValue(this as CarsCursor);
  }

  @override
  bool operator ==(Object other) {
    return CarsCursorMapper.ensureInitialized()
        .equalsValue(this as CarsCursor, other);
  }

  @override
  int get hashCode {
    return CarsCursorMapper.ensureInitialized().hashValue(this as CarsCursor);
  }
}

extension CarsCursorValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CarsCursor, $Out> {
  CarsCursorCopyWith<$R, CarsCursor, $Out> get $asCarsCursor =>
      $base.as((v, t, t2) => _CarsCursorCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CarsCursorCopyWith<$R, $In extends CarsCursor, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? cursor, String? companyId, String? id});
  CarsCursorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CarsCursorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CarsCursor, $Out>
    implements CarsCursorCopyWith<$R, CarsCursor, $Out> {
  _CarsCursorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CarsCursor> $mapper =
      CarsCursorMapper.ensureInitialized();
  @override
  $R call(
          {Object? cursor = $none,
          Object? companyId = $none,
          Object? id = $none}) =>
      $apply(FieldCopyWithData({
        if (cursor != $none) #cursor: cursor,
        if (companyId != $none) #companyId: companyId,
        if (id != $none) #id: id
      }));
  @override
  CarsCursor $make(CopyWithData data) => CarsCursor(
      cursor: data.get(#cursor, or: $value.cursor),
      companyId: data.get(#companyId, or: $value.companyId),
      id: data.get(#id, or: $value.id));

  @override
  CarsCursorCopyWith<$R2, CarsCursor, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CarsCursorCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
