import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/features/review/data/model/car_review.dart';
import 'package:kcars/features/review/data/model/car_review_flag.dart';
import 'package:kcars/features/review/data/model/company_review.dart';
import 'package:kcars/features/review/data/model/company_review_flag.dart';
import 'package:kcars/features/review/data/model/cursor_review.dart';
import 'package:kcars/features/review/data/model/review_flag.dart';
import 'package:kcars/features/review/data/model/review_post.dart';
import 'package:kcars/features/review/data/model/updare_review.dart';

abstract class ReviewRepo {
  Result<String?> reviewCar(ReviewPost param);
  Result<String?> reviewCompany(ReviewPost param);

  Result<String?> flagCarReview(ReviewFlag param);
  Result<String?> flagCompanyReview(ReviewFlag param);

  Result<List<CarReview>> carReviews(CursorReview param);
  Result<List<CompanyReview>> companyReviews(CursorReview param);

  Result<List<CarReview>> companyCarsReviews([CursorReview? param]);
  Result<List<CompanyReview>> companiesReviews([CursorReview? param]);

  Result<List<CarReview>> allCarReviews(AllCursorReview param);
  Result<List<CompanyReview>> allCompanyReviews(AllCursorReview param);

  Result<List<CarReviewFlag>> carReviewFlags([CursorReviewFlags? param]);
  Result<List<CompanyReviewFlag>> companyReviewFlags([
    CursorReviewFlags? param,
  ]);

  Result<void> updateCarReview(UpdateReview param);
  Result<void> updateCompanyReview(UpdateReview param);

  Result<void> deleteCarReview(String id);
  Result<void> deleteCompanyReview(String id);
}
