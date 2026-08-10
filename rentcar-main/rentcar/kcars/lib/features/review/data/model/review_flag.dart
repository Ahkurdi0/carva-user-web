import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
part 'review_flag.mapper.dart';

@MappableClass()
class ReviewFlag with ReviewFlagMappable, CleanMapMixin {
  final String? carId;
  final String? companyId;
  final String reviewId;

  ReviewFlag({this.carId, this.companyId, required this.reviewId});
}
