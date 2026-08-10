import 'package:fpdart/fpdart.dart';
import 'package:kcars/configs/error/exception.dart';
import 'package:kcars/configs/error/failure.dart';
import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/features/review/data/model/car_review.dart';
import 'package:kcars/features/review/data/model/car_review_flag.dart';
import 'package:kcars/features/review/data/model/company_review.dart';
import 'package:kcars/features/review/data/model/company_review_flag.dart';
import 'package:kcars/features/review/data/model/cursor_review.dart';
import 'package:kcars/features/review/data/model/review_flag.dart';
import 'package:kcars/features/review/data/model/review_post.dart';
import 'package:kcars/features/review/data/model/updare_review.dart';
import 'package:kcars/features/review/data/remote/review_remote.dart';
import 'package:kcars/features/review/domain/repo/review_repo.dart';

class ReviewRepoImpl implements ReviewRepo {
  ReviewRepoImpl(this._reviewRemote);
  final ReviewRemote _reviewRemote;

  @override
  Result<List<CarReviewFlag>> carReviewFlags([CursorReviewFlags? param]) async {
    try {
      final result = await _reviewRemote.carReviewFlags(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<CarReview>> carReviews(CursorReview param) async {
    try {
      final result = await _reviewRemote.carReviews(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<CompanyReviewFlag>> companyReviewFlags([
    CursorReviewFlags? param,
  ]) async {
    try {
      final result = await _reviewRemote.companyReviewFlags(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<CompanyReview>> companyReviews(CursorReview param) async {
    try {
      final result = await _reviewRemote.companyReviews(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> deleteCarReview(String id) async {
    try {
      final result = await _reviewRemote.deleteCarReview(id);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> deleteCompanyReview(String id) async {
    try {
      final result = await _reviewRemote.deleteCompanyReview(id);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<String?> flagCarReview(ReviewFlag param) async {
    try {
      final result = await _reviewRemote.flagCarReview(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<String?> flagCompanyReview(ReviewFlag param) async {
    try {
      final result = await _reviewRemote.flagCompanyReview(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<String?> reviewCar(ReviewPost param) async {
    try {
      final result = await _reviewRemote.reviewCar(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<String?> reviewCompany(ReviewPost param) async {
    try {
      final result = await _reviewRemote.reviewCompany(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> updateCarReview(UpdateReview param) async {
    try {
      final result = await _reviewRemote.updateCarReview(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> updateCompanyReview(UpdateReview param) async {
    try {
      final result = await _reviewRemote.updateCompanyReview(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<CarReview>> allCarReviews(AllCursorReview param) async {
    try {
      final result = await _reviewRemote.allCarReviews(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<CompanyReview>> allCompanyReviews(AllCursorReview param) async {
    try {
      final result = await _reviewRemote.allCompanyReviews(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<CompanyReview>> companiesReviews([CursorReview? param]) async {
    try {
      final result = await _reviewRemote.companiesReviews(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<CarReview>> companyCarsReviews([CursorReview? param]) async {
    try {
      final result = await _reviewRemote.companyCarsReviews(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }
}
