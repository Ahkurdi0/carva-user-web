import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/auth/data/model/permission.dart';

part 'permissions.mapper.dart';

@MappableClass()
class Permissions with PermissionsMappable {
  final Permission permission;

  Permissions({required this.permission});
}
