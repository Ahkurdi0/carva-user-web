// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'permission.dart';

class PermissionMapper extends ClassMapperBase<Permission> {
  PermissionMapper._();

  static PermissionMapper? _instance;
  static PermissionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PermissionMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Permission';

  static String _$permissionId(Permission v) => v.permissionId;
  static const Field<Permission, String> _f$permissionId =
      Field('permissionId', _$permissionId);
  static String _$permissionName(Permission v) => v.permissionName;
  static const Field<Permission, String> _f$permissionName =
      Field('permissionName', _$permissionName);
  static String? _$description(Permission v) => v.description;
  static const Field<Permission, String> _f$description =
      Field('description', _$description);

  @override
  final MappableFields<Permission> fields = const {
    #permissionId: _f$permissionId,
    #permissionName: _f$permissionName,
    #description: _f$description,
  };

  static Permission _instantiate(DecodingData data) {
    return Permission(
        permissionId: data.dec(_f$permissionId),
        permissionName: data.dec(_f$permissionName),
        description: data.dec(_f$description));
  }

  @override
  final Function instantiate = _instantiate;

  static Permission fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Permission>(map);
  }

  static Permission fromJson(String json) {
    return ensureInitialized().decodeJson<Permission>(json);
  }
}

mixin PermissionMappable {
  String toJson() {
    return PermissionMapper.ensureInitialized()
        .encodeJson<Permission>(this as Permission);
  }

  Map<String, dynamic> toMap() {
    return PermissionMapper.ensureInitialized()
        .encodeMap<Permission>(this as Permission);
  }

  PermissionCopyWith<Permission, Permission, Permission> get copyWith =>
      _PermissionCopyWithImpl<Permission, Permission>(
          this as Permission, $identity, $identity);
  @override
  String toString() {
    return PermissionMapper.ensureInitialized()
        .stringifyValue(this as Permission);
  }

  @override
  bool operator ==(Object other) {
    return PermissionMapper.ensureInitialized()
        .equalsValue(this as Permission, other);
  }

  @override
  int get hashCode {
    return PermissionMapper.ensureInitialized().hashValue(this as Permission);
  }
}

extension PermissionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Permission, $Out> {
  PermissionCopyWith<$R, Permission, $Out> get $asPermission =>
      $base.as((v, t, t2) => _PermissionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PermissionCopyWith<$R, $In extends Permission, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? permissionId, String? permissionName, String? description});
  PermissionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PermissionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Permission, $Out>
    implements PermissionCopyWith<$R, Permission, $Out> {
  _PermissionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Permission> $mapper =
      PermissionMapper.ensureInitialized();
  @override
  $R call(
          {String? permissionId,
          String? permissionName,
          Object? description = $none}) =>
      $apply(FieldCopyWithData({
        if (permissionId != null) #permissionId: permissionId,
        if (permissionName != null) #permissionName: permissionName,
        if (description != $none) #description: description
      }));
  @override
  Permission $make(CopyWithData data) => Permission(
      permissionId: data.get(#permissionId, or: $value.permissionId),
      permissionName: data.get(#permissionName, or: $value.permissionName),
      description: data.get(#description, or: $value.description));

  @override
  PermissionCopyWith<$R2, Permission, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PermissionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
