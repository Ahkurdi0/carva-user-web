import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
part 'user_cursor.mapper.dart';

@MappableClass()
class UserCursor with UserCursorMappable, CleanMapMixin {
  final String? cursor;
  final String? roleName;
  final String? userId;
  final String? search;

  UserCursor({this.cursor, this.roleName, this.userId, this.search});
}
