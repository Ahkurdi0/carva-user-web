import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
import 'package:kcars/features/review/data/model/enums.dart';

part 'cursor_review.mapper.dart';

@MappableClass()
class CursorReview with CursorReviewMappable, CleanMapMixin {
  final String id;
  final String? cursor;

  const CursorReview({required this.id, this.cursor});
}

@MappableClass()
class AllCursorReview with AllCursorReviewMappable, CleanMapMixin {
  final String? id;
  final String? userId;
  final String? cursor;

  const AllCursorReview({this.id, this.cursor, this.userId});
}

@MappableClass()
class CursorReviewFlags with CursorReviewFlagsMappable, CleanMapMixin {
  final ReviewStatus? status;
  final String? cursor;

  const CursorReviewFlags({this.status, this.cursor});
}
