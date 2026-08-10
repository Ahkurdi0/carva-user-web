// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'role_permission.dart';

class RolePermissionMapper extends ClassMapperBase<RolePermission> {
  RolePermissionMapper._();

  static RolePermissionMapper? _instance;
  static RolePermissionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RolePermissionMapper._());
      RoleMapper.ensureInitialized();
      PermissionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RolePermission';

  static String _$roleId(RolePermission v) => v.roleId;
  static const Field<RolePermission, String> _f$roleId =
      Field('roleId', _$roleId);
  static String _$permissionId(RolePermission v) => v.permissionId;
  static const Field<RolePermission, String> _f$permissionId =
      Field('permissionId', _$permissionId);
  static Role _$role(RolePermission v) => v.role;
  static const Field<RolePermission, Role> _f$role = Field('role', _$role);
  static Permissions _$permission(RolePermission v) => v.permission;
  static const Field<RolePermission, Permissions> _f$permission =
      Field('permission', _$permission);

  @override
  final MappableFields<RolePermission> fields = const {
    #roleId: _f$roleId,
    #permissionId: _f$permissionId,
    #role: _f$role,
    #permission: _f$permission,
  };

  static RolePermission _instantiate(DecodingData data) {
    return RolePermission(
        roleId: data.dec(_f$roleId),
        permissionId: data.dec(_f$permissionId),
        role: data.dec(_f$role),
        permission: data.dec(_f$permission));
  }

  @override
  final Function instantiate = _instantiate;

  static RolePermission fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RolePermission>(map);
  }

  static RolePermission fromJson(String json) {
    return ensureInitialized().decodeJson<RolePermission>(json);
  }
}

mixin RolePermissionMappable {
  String toJson() {
    return RolePermissionMapper.ensureInitialized()
        .encodeJson<RolePermission>(this as RolePermission);
  }

  Map<String, dynamic> toMap() {
    return RolePermissionMapper.ensureInitialized()
        .encodeMap<RolePermission>(this as RolePermission);
  }

  RolePermissionCopyWith<RolePermission, RolePermission, RolePermission>
      get copyWith =>
          _RolePermissionCopyWithImpl<RolePermission, RolePermission>(
              this as RolePermission, $identity, $identity);
  @override
  String toString() {
    return RolePermissionMapper.ensureInitialized()
        .stringifyValue(this as RolePermission);
  }

  @override
  bool operator ==(Object other) {
    return RolePermissionMapper.ensureInitialized()
        .equalsValue(this as RolePermission, other);
  }

  @override
  int get hashCode {
    return RolePermissionMapper.ensureInitialized()
        .hashValue(this as RolePermission);
  }
}

extension RolePermissionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RolePermission, $Out> {
  RolePermissionCopyWith<$R, RolePermission, $Out> get $asRolePermission =>
      $base.as((v, t, t2) => _RolePermissionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class RolePermissionCopyWith<$R, $In extends RolePermission, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  RoleCopyWith<$R, Role, Role> get role;
  PermissionsCopyWith<$R, Permissions, Permissions> get permission;
  $R call(
      {String? roleId,
      String? permissionId,
      Role? role,
      Permissions? permission});
  RolePermissionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _RolePermissionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RolePermission, $Out>
    implements RolePermissionCopyWith<$R, RolePermission, $Out> {
  _RolePermissionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RolePermission> $mapper =
      RolePermissionMapper.ensureInitialized();
  @override
  RoleCopyWith<$R, Role, Role> get role =>
      $value.role.copyWith.$chain((v) => call(role: v));
  @override
  PermissionsCopyWith<$R, Permissions, Permissions> get permission =>
      $value.permission.copyWith.$chain((v) => call(permission: v));
  @override
  $R call(
          {String? roleId,
          String? permissionId,
          Role? role,
          Permissions? permission}) =>
      $apply(FieldCopyWithData({
        if (roleId != null) #roleId: roleId,
        if (permissionId != null) #permissionId: permissionId,
        if (role != null) #role: role,
        if (permission != null) #permission: permission
      }));
  @override
  RolePermission $make(CopyWithData data) => RolePermission(
      roleId: data.get(#roleId, or: $value.roleId),
      permissionId: data.get(#permissionId, or: $value.permissionId),
      role: data.get(#role, or: $value.role),
      permission: data.get(#permission, or: $value.permission));

  @override
  RolePermissionCopyWith<$R2, RolePermission, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _RolePermissionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
