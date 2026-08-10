import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/review/data/model/enums.dart';

part 'updare_review.mapper.dart';

@MappableClass()
class UpdateReview with UpdateReviewMappable {
  final String id;
  final ReviewStatus status;

  UpdateReview({required this.id, required this.status});
}
