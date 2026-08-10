// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'post_role.dart';

class PostRoleMapper extends ClassMapperBase<PostRole> {
  PostRoleMapper._();

  static PostRoleMapper? _instance;
  static PostRoleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PostRoleMapper._());
      RoleMapper.ensureInitialized();
      PermissionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PostRole';

  static Role _$role(PostRole v) => v.role;
  static const Field<PostRole, Role> _f$role = Field('role', _$role);
  static String _$userId(PostRole v) => v.userId;
  static const Field<PostRole, String> _f$userId = Field('userId', _$userId);
  static List<Permissions> _$permissions(PostRole v) => v.permissions;
  static const Field<PostRole, List<Permissions>> _f$permissions =
      Field('permissions', _$permissions);

  @override
  final MappableFields<PostRole> fields = const {
    #role: _f$role,
    #userId: _f$userId,
    #permissions: _f$permissions,
  };

  static PostRole _instantiate(DecodingData data) {
    return PostRole(
        role: data.dec(_f$role),
        userId: data.dec(_f$userId),
        permissions: data.dec(_f$permissions));
  }

  @override
  final Function instantiate = _instantiate;

  static PostRole fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PostRole>(map);
  }

  static PostRole fromJson(String json) {
    return ensureInitialized().decodeJson<PostRole>(json);
  }
}

mixin PostRoleMappable {
  String toJson() {
    return PostRoleMapper.ensureInitialized()
        .encodeJson<PostRole>(this as PostRole);
  }

  Map<String, dynamic> toMap() {
    return PostRoleMapper.ensureInitialized()
        .encodeMap<PostRole>(this as PostRole);
  }

  PostRoleCopyWith<PostRole, PostRole, PostRole> get copyWith =>
      _PostRoleCopyWithImpl<PostRole, PostRole>(
          this as PostRole, $identity, $identity);
  @override
  String toString() {
    return PostRoleMapper.ensureInitialized().stringifyValue(this as PostRole);
  }

  @override
  bool operator ==(Object other) {
    return PostRoleMapper.ensureInitialized()
        .equalsValue(this as PostRole, other);
  }

  @override
  int get hashCode {
    return PostRoleMapper.ensureInitialized().hashValue(this as PostRole);
  }
}

extension PostRoleValueCopy<$R, $Out> on ObjectCopyWith<$R, PostRole, $Out> {
  PostRoleCopyWith<$R, PostRole, $Out> get $asPostRole =>
      $base.as((v, t, t2) => _PostRoleCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PostRoleCopyWith<$R, $In extends PostRole, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  RoleCopyWith<$R, Role, Role> get role;
  ListCopyWith<$R, Permissions,
      PermissionsCopyWith<$R, Permissions, Permissions>> get permissions;
  $R call({Role? role, String? userId, List<Permissions>? permissions});
  PostRoleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PostRoleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PostRole, $Out>
    implements PostRoleCopyWith<$R, PostRole, $Out> {
  _PostRoleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PostRole> $mapper =
      PostRoleMapper.ensureInitialized();
  @override
  RoleCopyWith<$R, Role, Role> get role =>
      $value.role.copyWith.$chain((v) => call(role: v));
  @override
  ListCopyWith<$R, Permissions,
          PermissionsCopyWith<$R, Permissions, Permissions>>
      get permissions => ListCopyWith($value.permissions,
          (v, t) => v.copyWith.$chain(t), (v) => call(permissions: v));
  @override
  $R call({Role? role, String? userId, List<Permissions>? permissions}) =>
      $apply(FieldCopyWithData({
        if (role != null) #role: role,
        if (userId != null) #userId: userId,
        if (permissions != null) #permissions: permissions
      }));
  @override
  PostRole $make(CopyWithData data) => PostRole(
      role: data.get(#role, or: $value.role),
      userId: data.get(#userId, or: $value.userId),
      permissions: data.get(#permissions, or: $value.permissions));

  @override
  PostRoleCopyWith<$R2, PostRole, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PostRoleCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
