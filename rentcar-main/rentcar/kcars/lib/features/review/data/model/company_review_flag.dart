import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/review/data/model/company_review.dart';
part 'company_review_flag.mapper.dart';

@MappableClass()
class CompanyReviewFlag with CompanyReviewFlagMappable {
  final String id;
  final DateTime flaggedAt;
  final Company? company;
  final CompanyReview? review;

  CompanyReviewFlag({
    required this.id,
    required this.flaggedAt,
    this.company,
    this.review,
  });
}
