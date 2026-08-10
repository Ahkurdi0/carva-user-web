import 'package:kcars/core/services/api_service.dart';
import 'package:kcars/core/services/info.dart';
import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/features/review/data/model/car_review.dart';
import 'package:kcars/features/review/data/model/car_review_flag.dart';
import 'package:kcars/features/review/data/model/company_review.dart';
import 'package:kcars/features/review/data/model/company_review_flag.dart';
import 'package:kcars/features/review/data/model/cursor_review.dart';
import 'package:kcars/features/review/data/model/review_flag.dart';
import 'package:kcars/features/review/data/model/review_post.dart';
import 'package:kcars/features/review/data/model/updare_review.dart';

abstract class ReviewRemote {
  Future<String?> reviewCar(ReviewPost param);
  Future<String?> reviewCompany(ReviewPost param);

  Future<String?> flagCarReview(ReviewFlag param);
  Future<String?> flagCompanyReview(ReviewFlag param);

  Future<List<CarReview>> carReviews(CursorReview param);
  Future<List<CompanyReview>> companyReviews(CursorReview param);

  Future<List<CarReview>> companyCarsReviews([CursorReview? param]);
  Future<List<CompanyReview>> companiesReviews([CursorReview? param]);

  Future<List<CarReview>> allCarReviews(AllCursorReview param);
  Future<List<CompanyReview>> allCompanyReviews(AllCursorReview param);

  Future<List<CarReviewFlag>> carReviewFlags([CursorReviewFlags? param]);
  Future<List<CompanyReviewFlag>> companyReviewFlags([
    CursorReviewFlags? param,
  ]);

  Future<void> updateCarReview(UpdateReview param);
  Future<void> updateCompanyReview(UpdateReview param);

  Future<void> deleteCarReview(String id);
  Future<void> deleteCompanyReview(String id);
}

class ReviewRemoteImpl implements ReviewRemote {
  ReviewRemoteImpl(this._apiService);
  final ApiService _apiService;
  final userUrl = Info.user;
  final companyUrl = Info.company;
  final adminUrl = Info.admin;
  @override
  Future<List<CarReviewFlag>> carReviewFlags([CursorReviewFlags? param]) async {
    return await _apiService.post(
      "$adminUrl/carReviewFlags",
      data: param?.cleanedMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((review) => CarReviewFlagMapper.fromMap(review)).toList(),
    );
  }

  @override
  Future<List<CarReview>> carReviews(CursorReview param) async {
    return await _apiService.post(
      "$userUrl/carReviews",
      data: param.cleanedMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((review) => CarReviewMapper.fromMap(review)).toList(),
    );
  }

  @override
  Future<List<CompanyReviewFlag>> companyReviewFlags([
    CursorReviewFlags? param,
  ]) async {
    return await _apiService.post(
      "$adminUrl/companyReviewflags",
      data: param?.cleanedMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((review) => CompanyReviewFlagMapper.fromMap(review)).toList(),
    );
  }

  @override
  Future<List<CompanyReview>> companyReviews(CursorReview param) async {
    return await _apiService.post(
      "$userUrl/companyReviews",
      data: param.toMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((review) => CompanyReviewMapper.fromMap(review)).toList(),
    );
  }

  @override
  Future<void> deleteCarReview(String id) async {
    await _apiService.post("$userUrl/deleteCarReview", data: {"id": id});
  }

  @override
  Future<void> deleteCompanyReview(String id) async {
    await _apiService.post("$userUrl/deleteCompanyReview", data: {"id": id});
  }

  @override
  Future<String?> flagCarReview(ReviewFlag param) async {
    return await _apiService.post(
      "$companyUrl/flagCarReview",
      data: param.cleanedMap(),
    );
  }

  @override
  Future<String?> flagCompanyReview(ReviewFlag param) async {
    return await _apiService.post(
      "$companyUrl/flagCompanyReview",
      data: param.cleanedMap(),
    );
  }

  @override
  Future<String?> reviewCar(ReviewPost param) async {
    return await _apiService.post(
      "$userUrl/reviewCar",
      data: param.cleanedMap(),
    );
  }

  @override
  Future<String?> reviewCompany(ReviewPost param) async {
    return await _apiService.post(
      "$userUrl/reviewCompany",
      data: param.cleanedMap(),
    );
  }

  @override
  Future<void> updateCarReview(UpdateReview param) async {
    return await _apiService.post(
      "$adminUrl/updateCarReview",
      data: param.toMap(),
    );
  }

  @override
  Future<void> updateCompanyReview(UpdateReview param) async {
    return await _apiService.post(
      "$adminUrl/updateCompanyReview",
      data: param.toMap(),
    );
  }

  @override
  Future<List<CarReview>> allCarReviews(AllCursorReview param) async {
    return await _apiService.post(
      "$adminUrl/allCarReviews",
      data: param.toMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((review) => CarReviewMapper.fromMap(review)).toList(),
    );
  }

  @override
  Future<List<CompanyReview>> allCompanyReviews(AllCursorReview param) async {
    return await _apiService.post(
      "$adminUrl/allCompanyReviews",
      data: param.cleanedMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((review) => CompanyReviewMapper.fromMap(review)).toList(),
    );
  }

  @override
  Future<List<CompanyReview>> companiesReviews([CursorReview? param]) async {
    return await _apiService.post(
      "$companyUrl/companiesReviews",
      data: param?.cleanedMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((review) => CompanyReviewMapper.fromMap(review)).toList(),
    );
  }

  @override
  Future<List<CarReview>> companyCarsReviews([CursorReview? param]) async {
    return await _apiService.post(
      "$companyUrl/companyCarsReviews",
      data: param?.cleanedMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((review) => CarReviewMapper.fromMap(review)).toList(),
    );
  }
}
