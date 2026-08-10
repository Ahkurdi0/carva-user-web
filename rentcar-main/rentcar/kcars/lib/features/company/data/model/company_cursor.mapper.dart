// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'company_cursor.dart';

class CompanyCursorMapper extends ClassMapperBase<CompanyCursor> {
  CompanyCursorMapper._();

  static CompanyCursorMapper? _instance;
  static CompanyCursorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CompanyCursorMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CompanyCursor';

  static String? _$id(CompanyCursor v) => v.id;
  static const Field<CompanyCursor, String> _f$id =
      Field('id', _$id, opt: true);
  static String? _$cursor(CompanyCursor v) => v.cursor;
  static const Field<CompanyCursor, String> _f$cursor =
      Field('cursor', _$cursor, opt: true);
  static bool? _$expired(CompanyCursor v) => v.expired;
  static const Field<CompanyCursor, bool> _f$expired =
      Field('expired', _$expired, opt: true);
  static bool? _$inl(CompanyCursor v) => v.inl;
  static const Field<CompanyCursor, bool> _f$inl =
      Field('inl', _$inl, opt: true);
  static bool? _$delivery(CompanyCursor v) => v.delivery;
  static const Field<CompanyCursor, bool> _f$delivery =
      Field('delivery', _$delivery, opt: true);

  @override
  final MappableFields<CompanyCursor> fields = const {
    #id: _f$id,
    #cursor: _f$cursor,
    #expired: _f$expired,
    #inl: _f$inl,
    #delivery: _f$delivery,
  };

  static CompanyCursor _instantiate(DecodingData data) {
    return CompanyCursor(
        id: data.dec(_f$id),
        cursor: data.dec(_f$cursor),
        expired: data.dec(_f$expired),
        inl: data.dec(_f$inl),
        delivery: data.dec(_f$delivery));
  }

  @override
  final Function instantiate = _instantiate;

  static CompanyCursor fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CompanyCursor>(map);
  }

  static CompanyCursor fromJson(String json) {
    return ensureInitialized().decodeJson<CompanyCursor>(json);
  }
}

mixin CompanyCursorMappable {
  String toJson() {
    return CompanyCursorMapper.ensureInitialized()
        .encodeJson<CompanyCursor>(this as CompanyCursor);
  }

  Map<String, dynamic> toMap() {
    return CompanyCursorMapper.ensureInitialized()
        .encodeMap<CompanyCursor>(this as CompanyCursor);
  }

  CompanyCursorCopyWith<CompanyCursor, CompanyCursor, CompanyCursor>
      get copyWith => _CompanyCursorCopyWithImpl<CompanyCursor, CompanyCursor>(
          this as CompanyCursor, $identity, $identity);
  @override
  String toString() {
    return CompanyCursorMapper.ensureInitialized()
        .stringifyValue(this as CompanyCursor);
  }

  @override
  bool operator ==(Object other) {
    return CompanyCursorMapper.ensureInitialized()
        .equalsValue(this as CompanyCursor, other);
  }

  @override
  int get hashCode {
    return CompanyCursorMapper.ensureInitialized()
        .hashValue(this as CompanyCursor);
  }
}

extension CompanyCursorValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CompanyCursor, $Out> {
  CompanyCursorCopyWith<$R, CompanyCursor, $Out> get $asCompanyCursor =>
      $base.as((v, t, t2) => _CompanyCursorCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CompanyCursorCopyWith<$R, $In extends CompanyCursor, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id, String? cursor, bool? expired, bool? inl, bool? delivery});
  CompanyCursorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CompanyCursorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CompanyCursor, $Out>
    implements CompanyCursorCopyWith<$R, CompanyCursor, $Out> {
  _CompanyCursorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CompanyCursor> $mapper =
      CompanyCursorMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          Object? cursor = $none,
          Object? expired = $none,
          Object? inl = $none,
          Object? delivery = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (cursor != $none) #cursor: cursor,
        if (expired != $none) #expired: expired,
        if (inl != $none) #inl: inl,
        if (delivery != $none) #delivery: delivery
      }));
  @override
  CompanyCursor $make(CopyWithData data) => CompanyCursor(
      id: data.get(#id, or: $value.id),
      cursor: data.get(#cursor, or: $value.cursor),
      expired: data.get(#expired, or: $value.expired),
      inl: data.get(#inl, or: $value.inl),
      delivery: data.get(#delivery, or: $value.delivery));

  @override
  CompanyCursorCopyWith<$R2, CompanyCursor, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CompanyCursorCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
