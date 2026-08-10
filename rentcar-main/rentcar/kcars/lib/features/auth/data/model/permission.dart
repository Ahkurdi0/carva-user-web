import 'package:dart_mappable/dart_mappable.dart';

part 'permission.mapper.dart';

@MappableClass()
class Permission with PermissionMappable {
  final String permissionId;
  final String permissionName;
  final String? description;

  Permission({
    required this.permissionId,
    required this.permissionName,
    required this.description,
  });
}
