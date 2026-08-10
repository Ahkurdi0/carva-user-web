import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kcars/configs/error/exception.dart';
import 'package:kcars/features/review/data/repo/review_repo_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper_tests.dart';
import '../../review_data.dart';
import 'review_repo_mocks.mocks.dart';

void main() {
  late MockReviewRemote mockReviewRemote;
  late ReviewRepoImpl reviewRepoImpl;

  setUp(() {
    mockReviewRemote = MockReviewRemote();
    reviewRepoImpl = ReviewRepoImpl(mockReviewRemote);
  });
  group("[User Actions Test]", () {
    test("[Should Success when Review A Car]", () async {
      final param = ReviewData.reviewPost();
      when(
        mockReviewRemote.reviewCar(param),
      ).thenAnswer((invocation) async => Future.value(null));
      final result = await reviewRepoImpl.reviewCar(param);
      expectSuccess(result, null);
      verify(mockReviewRemote.reviewCar(param)).called(1);
    });

    test("[Should Fail when Review A Carr]", () async {
      final param = ReviewData.reviewPost();
      when(
        mockReviewRemote.reviewCar(param),
      ).thenThrow(ApiException.exception());
      final result = await reviewRepoImpl.reviewCar(param);
      expectFailureWithStatusCode(result, 400);
      verify(mockReviewRemote.reviewCar(param)).called(1);
    });

    test("[Should Success when Review A Company]", () async {
      final param = ReviewData.reviewPost();
      when(
        mockReviewRemote.reviewCompany(param),
      ).thenAnswer((invocation) async => Future.value("A"));
      final result = await reviewRepoImpl.reviewCompany(param);
      expectSuccess(result, "A");
      verify(mockReviewRemote.reviewCompany(param)).called(1);
    });

    test("[Should Fail when Review A Company]", () async {
      final param = ReviewData.reviewPost();
      when(
        mockReviewRemote.reviewCompany(param),
      ).thenThrow(ApiException.exception());
      final result = await reviewRepoImpl.reviewCompany(param);
      expectFailureWithStatusCode(result, 400);
      verify(mockReviewRemote.reviewCompany(param)).called(1);
    });

    test("Should Success When Return Car Review", () async {
      final param = ReviewData.cursorReview();
      final expectedData = [ReviewData.carReview()];
      when(
        mockReviewRemote.carReviews(param),
      ).thenAnswer((invocation) async => Future.value(expectedData));
      final result = await reviewRepoImpl.carReviews(param);
      expectSuccess(result, expectedData);
      verify(mockReviewRemote.carReviews(param)).called(1);
    });

    test("Should Fail When Return Car Review", () async {
      final param = ReviewData.cursorReview();
      when(
        mockReviewRemote.carReviews(param),
      ).thenThrow(ApiException.exception());
      final result = await reviewRepoImpl.carReviews(param);
      expectFailureWithStatusCode(result, 400);
      verify(mockReviewRemote.carReviews(param)).called(1);
    });

    test("[Should Success When Return Company Review]", () async {
      final param = ReviewData.cursorReview();
      final expectedData = [ReviewData.companyReview()];
      when(
        mockReviewRemote.companyReviews(param),
      ).thenAnswer((invocation) async => Future.value(expectedData));
      final result = await reviewRepoImpl.companyReviews(param);
      expectSuccess(result, expectedData);
      verify(mockReviewRemote.companyReviews(param)).called(1);
    });

    test("[Should Fail When Return Company Review]", () async {
      final param = ReviewData.cursorReview();
      when(
        mockReviewRemote.companyReviews(param),
      ).thenThrow(ApiException.exception());
      final result = await reviewRepoImpl.companyReviews(param);
      expectFailureWithStatusCode(result, 400);
      verify(mockReviewRemote.companyReviews(param)).called(1);
    });
  });

  group("[Compnay Review Test]", () {
    test("[Should Success when Flag A Car Review]", () async {
      final param = ReviewData.reviewFlag();
      when(
        mockReviewRemote.flagCarReview(param),
      ).thenAnswer((invocation) async => Future.value("A"));
      final result = await reviewRepoImpl.flagCarReview(param);
      expectSuccess(result, "A");
      verify(mockReviewRemote.flagCarReview(param)).called(1);
    });

    test("[Should Fail when Flag A Car Review]", () async {
      final param = ReviewData.reviewFlag();
      when(
        mockReviewRemote.flagCarReview(param),
      ).thenThrow(ApiException.exception());
      final result = await reviewRepoImpl.flagCarReview(param);
      expectFailureWithStatusCode(result, 400);
      verify(mockReviewRemote.flagCarReview(param)).called(1);
    });

    test("[Should Success when Flag A Company Review]", () async {
      final param = ReviewData.reviewFlag();
      when(
        mockReviewRemote.flagCompanyReview(param),
      ).thenAnswer((invocation) async => Future.value("A"));
      final result = await reviewRepoImpl.flagCompanyReview(param);
      expectSuccess(result, "A");
      verify(mockReviewRemote.flagCompanyReview(param)).called(1);
    });

    test("[Should Fail when Flag A Company Review]", () async {
      final param = ReviewData.reviewFlag();
      when(
        mockReviewRemote.flagCompanyReview(param),
      ).thenThrow(ApiException.exception());
      final result = await reviewRepoImpl.flagCompanyReview(param);
      expectFailureWithStatusCode(result, 400);
      verify(mockReviewRemote.flagCompanyReview(param)).called(1);
    });
  });

  group("[Admin Review Test]", () {
    test("[Should Success When Update Car Review]", () async {
      final param = ReviewData.updateReview();
      when(
        mockReviewRemote.updateCarReview(param),
      ).thenAnswer((invocation) async => Future.value(null));
      final result = await reviewRepoImpl.updateCarReview(param);
      expectSuccess(result, null);
      verify(mockReviewRemote.updateCarReview(param)).called(1);
    });

    test("[Should Fail When Update Car Review]", () async {
      final param = ReviewData.updateReview();
      when(
        mockReviewRemote.updateCarReview(param),
      ).thenThrow(ApiException.exception());
      final result = await reviewRepoImpl.updateCarReview(param);
      expectFailureWithStatusCode(result, 400);
      verify(mockReviewRemote.updateCarReview(param)).called(1);
    });

    test("[Should Success When Update Company Review]", () async {
      final param = ReviewData.updateReview();
      when(
        mockReviewRemote.updateCompanyReview(param),
      ).thenAnswer((invocation) async => Future.value(null));
      final result = await reviewRepoImpl.updateCompanyReview(param);
      expectSuccess(result, null);
      verify(mockReviewRemote.updateCompanyReview(param)).called(1);
    });

    test("[Should Fail When Update Company Review]", () async {
      final param = ReviewData.updateReview();
      when(
        mockReviewRemote.updateCompanyReview(param),
      ).thenThrow(ApiException.exception());
      final result = await reviewRepoImpl.updateCompanyReview(param);
      expectFailureWithStatusCode(result, 400);
      verify(mockReviewRemote.updateCompanyReview(param)).called(1);
    });

    test("[Should Success when Delete A Car Review]", () async {
      when(
        mockReviewRemote.deleteCarReview("A"),
      ).thenAnswer((invocation) async => Future.value(null));
      final result = await reviewRepoImpl.deleteCarReview("A");
      expectSuccess(result, null);
      verify(mockReviewRemote.deleteCarReview("A")).called(1);
    });

    test("[Should Fail when Delete A Car Review]", () async {
      when(
        mockReviewRemote.deleteCarReview("A"),
      ).thenThrow(ApiException.exception());
      final result = await reviewRepoImpl.deleteCarReview("A");
      expectFailureWithStatusCode(result, 400);
      verify(mockReviewRemote.deleteCarReview("A")).called(1);
    });

    test("[Should Success Whene delete a company review]", () async {
      when(
        mockReviewRemote.deleteCompanyReview("A"),
      ).thenAnswer((invocation) async => Future.value(null));
      final result = await reviewRepoImpl.deleteCompanyReview("A");
      expectSuccess(result, null);
      verify(mockReviewRemote.deleteCompanyReview("A")).called(1);
    });

    test("[Should Fail when delete a company review]", () async {
      when(
        mockReviewRemote.deleteCompanyReview("A"),
      ).thenThrow(ApiException.exception());
      final result = await reviewRepoImpl.deleteCompanyReview("A");
      expectFailureWithStatusCode(result, 400);
      verify(mockReviewRemote.deleteCompanyReview("A")).called(1);
    });

    test("[Should Retutn List Car Review Flag]", () async {
      final expectedData = [ReviewData.carReviewFlags()];
      final param = ReviewData.cursorReviewFlag();
      when(
        mockReviewRemote.carReviewFlags(param),
      ).thenAnswer((invocation) async => Future.value(expectedData));
      final result = await reviewRepoImpl.carReviewFlags(param);
      expectSuccess(result, expectedData);
      verify(mockReviewRemote.carReviewFlags(param)).called(1);
    });

    test("[Should Fail when Return List Car Review Flag]", () async {
      final param = ReviewData.cursorReviewFlag();
      when(
        mockReviewRemote.carReviewFlags(param),
      ).thenThrow(ApiException.exception());
      final result = await reviewRepoImpl.carReviewFlags(param);
      expectFailureWithStatusCode(result, 400);
      verify(mockReviewRemote.carReviewFlags(param)).called(1);
    });

    test("[Should Retutn List Company Review Flag]", () async {
      final expectedData = [ReviewData.companyReviewFlags()];
      final param = ReviewData.cursorReviewFlag();
      when(
        mockReviewRemote.companyReviewFlags(param),
      ).thenAnswer((invocation) async => Future.value(expectedData));
      final result = await reviewRepoImpl.companyReviewFlags(param);
      expect(result, Right(expectedData));
      verify(mockReviewRemote.companyReviewFlags(param)).called(1);
    });

    test("[Should Fail when Return List Company Review Flag]", () async {
      final param = ReviewData.cursorReviewFlag();
      when(
        mockReviewRemote.companyReviewFlags(param),
      ).thenThrow(ApiException.exception());
      final result = await reviewRepoImpl.companyReviewFlags(param);
      expectFailureWithStatusCode(result, 400);
      verify(mockReviewRemote.companyReviewFlags(param)).called(1);
    });
  });
}
