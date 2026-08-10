import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
import 'package:kcars/features/auth/data/model/permissions.dart';
import 'package:kcars/features/auth/data/model/role.dart';

part 'post_role.mapper.dart';

@MappableClass()
class PostRole with PostRoleMappable, CleanMapMixin {
  final Role role;
  final String userId;
  final List<Permissions> permissions;

  PostRole({
    required this.role,
    required this.userId,
    required this.permissions,
  });
}
