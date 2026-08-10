// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_cursor.dart';

class UserCursorMapper extends ClassMapperBase<UserCursor> {
  UserCursorMapper._();

  static UserCursorMapper? _instance;
  static UserCursorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserCursorMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserCursor';

  static String? _$cursor(UserCursor v) => v.cursor;
  static const Field<UserCursor, String> _f$cursor =
      Field('cursor', _$cursor, opt: true);
  static String? _$roleName(UserCursor v) => v.roleName;
  static const Field<UserCursor, String> _f$roleName =
      Field('roleName', _$roleName, opt: true);
  static String? _$userId(UserCursor v) => v.userId;
  static const Field<UserCursor, String> _f$userId =
      Field('userId', _$userId, opt: true);
  static String? _$search(UserCursor v) => v.search;
  static const Field<UserCursor, String> _f$search =
      Field('search', _$search, opt: true);

  @override
  final MappableFields<UserCursor> fields = const {
    #cursor: _f$cursor,
    #roleName: _f$roleName,
    #userId: _f$userId,
    #search: _f$search,
  };

  static UserCursor _instantiate(DecodingData data) {
    return UserCursor(
        cursor: data.dec(_f$cursor),
        roleName: data.dec(_f$roleName),
        userId: data.dec(_f$userId),
        search: data.dec(_f$search));
  }

  @override
  final Function instantiate = _instantiate;

  static UserCursor fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserCursor>(map);
  }

  static UserCursor fromJson(String json) {
    return ensureInitialized().decodeJson<UserCursor>(json);
  }
}

mixin UserCursorMappable {
  String toJson() {
    return UserCursorMapper.ensureInitialized()
        .encodeJson<UserCursor>(this as UserCursor);
  }

  Map<String, dynamic> toMap() {
    return UserCursorMapper.ensureInitialized()
        .encodeMap<UserCursor>(this as UserCursor);
  }

  UserCursorCopyWith<UserCursor, UserCursor, UserCursor> get copyWith =>
      _UserCursorCopyWithImpl<UserCursor, UserCursor>(
          this as UserCursor, $identity, $identity);
  @override
  String toString() {
    return UserCursorMapper.ensureInitialized()
        .stringifyValue(this as UserCursor);
  }

  @override
  bool operator ==(Object other) {
    return UserCursorMapper.ensureInitialized()
        .equalsValue(this as UserCursor, other);
  }

  @override
  int get hashCode {
    return UserCursorMapper.ensureInitialized().hashValue(this as UserCursor);
  }
}

extension UserCursorValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserCursor, $Out> {
  UserCursorCopyWith<$R, UserCursor, $Out> get $asUserCursor =>
      $base.as((v, t, t2) => _UserCursorCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserCursorCopyWith<$R, $In extends UserCursor, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? cursor, String? roleName, String? userId, String? search});
  UserCursorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserCursorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserCursor, $Out>
    implements UserCursorCopyWith<$R, UserCursor, $Out> {
  _UserCursorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserCursor> $mapper =
      UserCursorMapper.ensureInitialized();
  @override
  $R call(
          {Object? cursor = $none,
          Object? roleName = $none,
          Object? userId = $none,
          Object? search = $none}) =>
      $apply(FieldCopyWithData({
        if (cursor != $none) #cursor: cursor,
        if (roleName != $none) #roleName: roleName,
        if (userId != $none) #userId: userId,
        if (search != $none) #search: search
      }));
  @override
  UserCursor $make(CopyWithData data) => UserCursor(
      cursor: data.get(#cursor, or: $value.cursor),
      roleName: data.get(#roleName, or: $value.roleName),
      userId: data.get(#userId, or: $value.userId),
      search: data.get(#search, or: $value.search));

  @override
  UserCursorCopyWith<$R2, UserCursor, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UserCursorCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
