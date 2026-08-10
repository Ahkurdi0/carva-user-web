import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/auth/data/model/permissions.dart';
import 'package:kcars/features/auth/data/model/role.dart';

part 'role_permission.mapper.dart';

@MappableClass()
class RolePermission with RolePermissionMappable {
  final String roleId;
  final String permissionId;
  final Role role;
  final Permissions permission;

  RolePermission({
    required this.roleId,
    required this.permissionId,
    required this.role,
    required this.permission,
  });
}
