import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
part 'car_cursor.mapper.dart';

@MappableClass()
class CarsCursor with CarsCursorMappable, CleanMapMixin {
  final String? cursor;
  final String? companyId;
  final String? id;
  CarsCursor({this.cursor, this.companyId, this.id});
}
