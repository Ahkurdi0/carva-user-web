import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
part 'company_cursor.mapper.dart';

@MappableClass()
class CompanyCursor with CompanyCursorMappable, CleanMapMixin {
  final String? id;
  final String? cursor;
  final bool? expired;
  final bool? inl;
  final bool? delivery;

  CompanyCursor({this.id, this.cursor, this.expired, this.inl, this.delivery});
}
