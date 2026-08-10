// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_permission.dart';

class UserPermissionMapper extends ClassMapperBase<UserPermission> {
  UserPermissionMapper._();

  static UserPermissionMapper? _instance;
  static UserPermissionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserPermissionMapper._());
      ProfileMapper.ensureInitialized();
      PermissionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UserPermission';

  static String _$userId(UserPermission v) => v.userId;
  static const Field<UserPermission, String> _f$userId =
      Field('userId', _$userId);
  static Profile _$user(UserPermission v) => v.user;
  static const Field<UserPermission, Profile> _f$user = Field('user', _$user);
  static Permissions _$permission(UserPermission v) => v.permission;
  static const Field<UserPermission, Permissions> _f$permission =
      Field('permission', _$permission);

  @override
  final MappableFields<UserPermission> fields = const {
    #userId: _f$userId,
    #user: _f$user,
    #permission: _f$permission,
  };

  static UserPermission _instantiate(DecodingData data) {
    return UserPermission(
        userId: data.dec(_f$userId),
        user: data.dec(_f$user),
        permission: data.dec(_f$permission));
  }

  @override
  final Function instantiate = _instantiate;

  static UserPermission fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserPermission>(map);
  }

  static UserPermission fromJson(String json) {
    return ensureInitialized().decodeJson<UserPermission>(json);
  }
}

mixin UserPermissionMappable {
  String toJson() {
    return UserPermissionMapper.ensureInitialized()
        .encodeJson<UserPermission>(this as UserPermission);
  }

  Map<String, dynamic> toMap() {
    return UserPermissionMapper.ensureInitialized()
        .encodeMap<UserPermission>(this as UserPermission);
  }

  UserPermissionCopyWith<UserPermission, UserPermission, UserPermission>
      get copyWith =>
          _UserPermissionCopyWithImpl<UserPermission, UserPermission>(
              this as UserPermission, $identity, $identity);
  @override
  String toString() {
    return UserPermissionMapper.ensureInitialized()
        .stringifyValue(this as UserPermission);
  }

  @override
  bool operator ==(Object other) {
    return UserPermissionMapper.ensureInitialized()
        .equalsValue(this as UserPermission, other);
  }

  @override
  int get hashCode {
    return UserPermissionMapper.ensureInitialized()
        .hashValue(this as UserPermission);
  }
}

extension UserPermissionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserPermission, $Out> {
  UserPermissionCopyWith<$R, UserPermission, $Out> get $asUserPermission =>
      $base.as((v, t, t2) => _UserPermissionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserPermissionCopyWith<$R, $In extends UserPermission, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ProfileCopyWith<$R, Profile, Profile> get user;
  PermissionsCopyWith<$R, Permissions, Permissions> get permission;
  $R call({String? userId, Profile? user, Permissions? permission});
  UserPermissionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _UserPermissionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserPermission, $Out>
    implements UserPermissionCopyWith<$R, UserPermission, $Out> {
  _UserPermissionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserPermission> $mapper =
      UserPermissionMapper.ensureInitialized();
  @override
  ProfileCopyWith<$R, Profile, Profile> get user =>
      $value.user.copyWith.$chain((v) => call(user: v));
  @override
  PermissionsCopyWith<$R, Permissions, Permissions> get permission =>
      $value.permission.copyWith.$chain((v) => call(permission: v));
  @override
  $R call({String? userId, Profile? user, Permissions? permission}) =>
      $apply(FieldCopyWithData({
        if (userId != null) #userId: userId,
        if (user != null) #user: user,
        if (permission != null) #permission: permission
      }));
  @override
  UserPermission $make(CopyWithData data) => UserPermission(
      userId: data.get(#userId, or: $value.userId),
      user: data.get(#user, or: $value.user),
      permission: data.get(#permission, or: $value.permission));

  @override
  UserPermissionCopyWith<$R2, UserPermission, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UserPermissionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
