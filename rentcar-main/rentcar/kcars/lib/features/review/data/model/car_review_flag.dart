import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/review/data/model/car_review.dart';
part 'car_review_flag.mapper.dart';

@MappableClass()
class CarReviewFlag with CarReviewFlagMappable {
  final String id;
  final String reviewId;
  final DateTime flaggedAt;
  final Car? car;
  final Company? company;
  final CarReview? review;

  CarReviewFlag({
    required this.id,
    required this.reviewId,
    required this.flaggedAt,
    this.car,
    this.company,
    this.review,
  });
}
