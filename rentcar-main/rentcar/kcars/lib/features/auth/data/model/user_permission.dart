import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/auth/data/model/permissions.dart';
import 'package:kcars/features/auth/data/model/profile.dart';

part 'user_permission.mapper.dart';

@MappableClass()
class UserPermission with UserPermissionMappable {
  final String userId;
  final Profile user;
  final Permissions permission;

  UserPermission({
    required this.userId,
    required this.user,
    required this.permission,
  });
}
