import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/booking/data/model/book.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/review/data/model/enums.dart';

part 'car_review.mapper.dart';

@MappableClass()
class CarReview with CarReviewMappable {
  final String id;
  final String desc;
  final int rate;
  final Car? car;
  final Profile? profile;
  final Company? company;
  final ReviewStatus status;
  final Book? book;
  final DateTime reviewedAt;
  String? updatedAt;
  final DateTime? flaggedAt;
  final int? serial;
  final String? reviewId;

  CarReview({
    required this.id,
    required this.desc,
    required this.rate,
    this.car,
    this.profile,
    this.company,
    this.status = ReviewStatus.pending,
    this.book,
    required this.reviewedAt,
    this.updatedAt,
    this.flaggedAt,
    this.serial,
    this.reviewId,
  });
}
