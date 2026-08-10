import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
import 'package:kcars/features/booking/data/model/enums.dart';
part 'book_cursor.mapper.dart';

@MappableClass()
class BookCursor with BookCursorMappable, CleanMapMixin {
  final String? id;
  final String? cursor;
  final String? companyId;
  final BookStatus? status;
  final String? search;
  final String? userId;

  BookCursor({
    this.id,
    this.cursor,
    this.companyId,
    this.status,
    this.search,
    this.userId,
  });
}
