// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'role.dart';

class RoleMapper extends ClassMapperBase<Role> {
  RoleMapper._();

  static RoleMapper? _instance;
  static RoleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RoleMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Role';

  static String? _$roleId(Role v) => v.roleId;
  static const Field<Role, String> _f$roleId =
      Field('roleId', _$roleId, opt: true);
  static String _$roleName(Role v) => v.roleName;
  static const Field<Role, String> _f$roleName = Field('roleName', _$roleName);
  static String? _$description(Role v) => v.description;
  static const Field<Role, String> _f$description =
      Field('description', _$description, opt: true);

  @override
  final MappableFields<Role> fields = const {
    #roleId: _f$roleId,
    #roleName: _f$roleName,
    #description: _f$description,
  };

  static Role _instantiate(DecodingData data) {
    return Role(
        roleId: data.dec(_f$roleId),
        roleName: data.dec(_f$roleName),
        description: data.dec(_f$description));
  }

  @override
  final Function instantiate = _instantiate;

  static Role fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Role>(map);
  }

  static Role fromJson(String json) {
    return ensureInitialized().decodeJson<Role>(json);
  }
}

mixin RoleMappable {
  String toJson() {
    return RoleMapper.ensureInitialized().encodeJson<Role>(this as Role);
  }

  Map<String, dynamic> toMap() {
    return RoleMapper.ensureInitialized().encodeMap<Role>(this as Role);
  }

  RoleCopyWith<Role, Role, Role> get copyWith =>
      _RoleCopyWithImpl<Role, Role>(this as Role, $identity, $identity);
  @override
  String toString() {
    return RoleMapper.ensureInitialized().stringifyValue(this as Role);
  }

  @override
  bool operator ==(Object other) {
    return RoleMapper.ensureInitialized().equalsValue(this as Role, other);
  }

  @override
  int get hashCode {
    return RoleMapper.ensureInitialized().hashValue(this as Role);
  }
}

extension RoleValueCopy<$R, $Out> on ObjectCopyWith<$R, Role, $Out> {
  RoleCopyWith<$R, Role, $Out> get $asRole =>
      $base.as((v, t, t2) => _RoleCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class RoleCopyWith<$R, $In extends Role, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? roleId, String? roleName, String? description});
  RoleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _RoleCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Role, $Out>
    implements RoleCopyWith<$R, Role, $Out> {
  _RoleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Role> $mapper = RoleMapper.ensureInitialized();
  @override
  $R call(
          {Object? roleId = $none,
          String? roleName,
          Object? description = $none}) =>
      $apply(FieldCopyWithData({
        if (roleId != $none) #roleId: roleId,
        if (roleName != null) #roleName: roleName,
        if (description != $none) #description: description
      }));
  @override
  Role $make(CopyWithData data) => Role(
      roleId: data.get(#roleId, or: $value.roleId),
      roleName: data.get(#roleName, or: $value.roleName),
      description: data.get(#description, or: $value.description));

  @override
  RoleCopyWith<$R2, Role, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _RoleCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
