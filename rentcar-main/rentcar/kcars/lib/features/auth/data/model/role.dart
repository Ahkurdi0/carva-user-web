import 'package:dart_mappable/dart_mappable.dart';

part 'role.mapper.dart';

@MappableClass()
class Role with RoleMappable {
  final String? roleId;
  final String roleName;
  final String? description;

  Role({this.roleId, required this.roleName, this.description});
}
