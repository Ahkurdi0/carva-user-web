import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';

part 'review_post.mapper.dart';

@MappableClass()
class ReviewPost with ReviewPostMappable, CleanMapMixin {
  final String? carId;
  final String? companyId;
  final int rate;
  final String desc;

  ReviewPost({
    this.carId,
    this.companyId,
    required this.rate,
    required this.desc,
  });
}
