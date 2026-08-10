import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/review/data/model/enums.dart';
part 'company_review.mapper.dart';

@MappableClass()
class CompanyReview with CompanyReviewMappable {
  final String id;
  final String desc;
  final int rate;
  final Company? company;
  final Profile? profile;
  final ReviewStatus status;
  final DateTime reviewedAt;
  final DateTime? updatedAt;
  final DateTime? flaggedAt;
  final int? serial;
  final String? reviewId;

  CompanyReview({
    required this.id,
    required this.desc,
    required this.rate,
    this.company,
    this.profile,
    required this.status,
    required this.reviewedAt,
    this.updatedAt,
    this.flaggedAt,
    this.serial,
    this.reviewId,
  });
}

@MappableClass()
class CompanyReviewData with CompanyReviewDataMappable {
  final List<CompanyReview> reviews;
  final CompanyReview? userReview;

  CompanyReviewData({required this.reviews, this.userReview});
}
