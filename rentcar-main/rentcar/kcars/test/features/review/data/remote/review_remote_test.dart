import 'package:flutter_test/flutter_test.dart';
import 'package:kcars/core/services/info.dart';
import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/features/review/data/model/car_review.dart';
import 'package:kcars/features/review/data/model/car_review_flag.dart';
import 'package:kcars/features/review/data/model/company_review.dart';
import 'package:kcars/features/review/data/model/company_review_flag.dart';
import 'package:kcars/features/review/data/remote/review_remote.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper_tests.dart';
import '../../../../utils.dart';
import '../../../api_service_mocks.mocks.dart';
import '../../review_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockApiService apiService;
  late ReviewRemote reviewRemote;

  setUp(() {
    apiService = MockApiService();
    reviewRemote = ReviewRemoteImpl(apiService);
  });
  group('User Action TESTS', () {
    test("[Should Sucess When Review Car]", () async {
      final url = "${Info.user}/reviewCar";
      when(
        apiService.post(any, data: anyNamed("data")),
      ).thenAnswer((invocation) async => null);
      final param = ReviewData.reviewPost();
      final result = await reviewRemote.reviewCar(param);
      expect(result, null);
      verify(apiService.post(url, data: param.cleanedMap())).called(1);
    });

    test("[Should Fail When Review Car]", () async {
      final url = "${Info.user}/reviewCar";
      when(
        apiService.post(any, data: anyNamed("data")),
      ).thenThrow(apiException());
      final param = ReviewData.reviewPost();
      expectApiException(() => reviewRemote.reviewCar(param));
      verify(apiService.post(url, data: param.cleanedMap())).called(1);
    });

    test("[Should Sucess When Review Company]", () async {
      final url = "${Info.user}/reviewCompany";
      when(
        apiService.post(any, data: anyNamed("data")),
      ).thenAnswer((invocation) async => null);
      final param = ReviewData.reviewPost();
      final result = await reviewRemote.reviewCompany(param);
      expect(result, null);
      verify(apiService.post(url, data: param.cleanedMap())).called(1);
    });

    test("[Should Fail When Review Company]", () async {
      final url = "${Info.user}/reviewCompany";
      when(
        apiService.post(any, data: anyNamed("data")),
      ).thenThrow(apiException());
      final param = ReviewData.reviewPost();
      expectApiException(() => reviewRemote.reviewCompany(param));
      verify(apiService.post(url, data: param.cleanedMap())).called(1);
    });

    test("[Should Return List of CAR reviewes]", () async {
      final url = "${Info.user}/carReviews";
      when(
        apiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap]
                as List<CarReview> Function(dynamic);
        final data = await loadJsonData("car_review");
        final carReviews = List<DataMap>.from(data);
        return fromMap(carReviews).toList();
      });
      final param = ReviewData.cursorReview();
      final expectData = [ReviewData.carReview()];
      final result = await reviewRemote.carReviews(param);
      expect(result, equals(expectData));
      expect(result, isA<List<CarReview>>());
      verify(
        apiService.post(
          url,
          data: param.cleanedMap(),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Shpuld Fail when return List Of Car Reviews]", () async {
      final url = "${Info.user}/carReviews";
      when(
        apiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      final param = ReviewData.cursorReview();
      expectApiException(() => reviewRemote.carReviews(param));
      verify(
        apiService.post(
          url,
          data: param.cleanedMap(),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Return List of Company reviewes]", () async {
      final url = "${Info.user}/companyReviews";
      when(
        apiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap]
                as List<CompanyReview> Function(dynamic);
        final data = await loadJsonData("company_review");
        final companyReviews = List<DataMap>.from(data);
        return fromMap(companyReviews).toList();
      });
      final param = ReviewData.cursorReview();
      final expectData = [ReviewData.companyReview()];
      final result = await reviewRemote.companyReviews(param);
      expect(result, equals(expectData));
      expect(result, isA<List<CompanyReview>>());
      verify(
        apiService.post(
          url,
          data: param.cleanedMap(),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Shpuld Fail when return List Of Company Reviews]", () async {
      final url = "${Info.user}/companyReviews";
      when(
        apiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      final param = ReviewData.cursorReview();
      expectApiException(() => reviewRemote.companyReviews(param));
      verify(
        apiService.post(
          url,
          data: param.cleanedMap(),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });
  });

  group("[Company Review Tests]", () {
    test("[Should Success When Flag Car Review]", () async {
      final url = "${Info.company}/flagCarReview";
      when(
        apiService.post(any, data: anyNamed("data")),
      ).thenAnswer((_) async => "A");
      final param = ReviewData.reviewFlag();
      final result = await reviewRemote.flagCarReview(param);
      expect(result, equals("A"));
      verify(apiService.post(url, data: param.cleanedMap())).called(1);
    });

    test("[Should Fail When Flag Car Review]", () async {
      final url = "${Info.company}/flagCarReview";
      when(
        apiService.post(any, data: anyNamed("data")),
      ).thenThrow(apiException());
      final param = ReviewData.reviewFlag();
      expectApiException(() => reviewRemote.flagCarReview(param));
      verify(apiService.post(url, data: param.cleanedMap())).called(1);
    });
  });

  group("[Admin Actions]", () {
    test("[Should Success When Update Car Review Flag]", () async {
      final url = "${Info.admin}/updateCarReview";
      when(
        apiService.post(any, data: anyNamed("data")),
      ).thenAnswer((_) async {});
      final param = ReviewData.updateReview();
      await reviewRemote.updateCarReview(param);
      verify(apiService.post(url, data: param.toMap())).called(1);
    });

    test("[Should Fail When Update Car Review Flag]", () async {
      final url = "${Info.admin}/updateCarReview";
      when(
        apiService.post(any, data: anyNamed("data")),
      ).thenThrow(apiException());
      final param = ReviewData.updateReview();
      expectApiException(() => reviewRemote.updateCarReview(param));
      verify(apiService.post(url, data: param.toMap())).called(1);
    });

    test("[Should Success When Update Company Review Flag]", () async {
      final url = "${Info.admin}/updateCompanyReview";
      when(
        apiService.post(any, data: anyNamed("data")),
      ).thenAnswer((_) async {});
      final param = ReviewData.updateReview();
      await reviewRemote.updateCompanyReview(param);
      verify(apiService.post(url, data: param.toMap())).called(1);
    });

    test("[Should Fail When Update Company Review Flag]", () async {
      final url = "${Info.admin}/updateCompanyReview";
      when(
        apiService.post(any, data: anyNamed("data")),
      ).thenThrow(apiException());
      final param = ReviewData.updateReview();
      expectApiException(() => reviewRemote.updateCompanyReview(param));
      verify(apiService.post(url, data: param.toMap())).called(1);
    });

    test("[Should Success When Delete Car Review]", () async {
      final url = "${Info.user}/deleteCarReview";
      when(
        apiService.post(any, data: anyNamed("data")),
      ).thenAnswer((_) async {});
      await reviewRemote.deleteCarReview("A");
      verify(apiService.post(url, data: {"id": "A"})).called(1);
    });

    test("[Should Fail When Delete Car Review]", () async {
      final url = "${Info.user}/deleteCarReview";
      when(
        apiService.post(any, data: anyNamed("data")),
      ).thenThrow(apiException());
      expectApiException(() => reviewRemote.deleteCarReview("A"));
      verify(apiService.post(url, data: {"id": "A"})).called(1);
    });

    test("[Should success when return Car Reviw Flags]", () async {
      final url = "${Info.admin}/carReviewFlags";
      when(
        apiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap]
                as List<CarReviewFlag> Function(dynamic);
        final flags = await loadJsonData("flaged_car_review");
        final listFlags = List<DataMap>.from(flags);
        return fromMap(listFlags).toList();
      });
      final param = ReviewData.cursorReviewFlag();
      final expectedData = [ReviewData.carReviewFlags()];
      final result = await reviewRemote.carReviewFlags(param);
      expect(result, equals(expectedData));
      verify(
        apiService.post(
          url,
          data: param.cleanedMap(),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should fail when return Car Reviw Flags]", () async {
      final url = "${Info.admin}/carReviewFlags";
      when(
        apiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      final param = ReviewData.cursorReviewFlag();
      expectApiException(() => reviewRemote.carReviewFlags(param));
      verify(
        apiService.post(
          url,
          data: param.cleanedMap(),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Success when Return Company Reviw Flags]", () async {
      final url = "${Info.admin}/companyReviewflags";
      when(
        apiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap]
                as List<CompanyReviewFlag> Function(dynamic);
        final flags = await loadJsonData("flaged_compnay_review");
        final listFlags = List<DataMap>.from(flags);
        return fromMap(listFlags).toList();
      });
      final param = ReviewData.cursorReviewFlag();
      final expectedData = [ReviewData.companyReviewFlags()];
      final result = await reviewRemote.companyReviewFlags(param);
      expect(result, equals(expectedData));
      verify(
        apiService.post(
          url,
          data: param.cleanedMap(),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Fail when Return Company Reviw Flags]", () async {
      final url = "${Info.admin}/companyReviewflags";
      when(
        apiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      final param = ReviewData.cursorReviewFlag();
      expectApiException(() => reviewRemote.companyReviewFlags(param));
      verify(
        apiService.post(
          url,
          data: param.cleanedMap(),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Return All Car Reviews]", () async {
      final url = "${Info.admin}/allCarReviews";
      when(
        apiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap]
                as List<CarReview> Function(dynamic);
        final flags = await loadJsonData("all_car_reviews");
        final listFlags = List<DataMap>.from(flags);
        return fromMap(listFlags).toList();
      });
      final param = ReviewData.allCursorReview();
      final expectedData = [ReviewData.allCarReviews()];
      final result = await reviewRemote.allCarReviews(param);
      expect(result, equals(expectedData));
      verify(
        apiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Failed When Return All Car Reviews]", () async {
      final url = "${Info.admin}/allCarReviews";
      when(
        apiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      final param = ReviewData.allCursorReview();
      expectApiException(() => reviewRemote.allCarReviews(param));
      verify(
        apiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Return All Company Reviews]", () async {
      final url = "${Info.admin}/allCompanyReviews";
      when(
        apiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap]
                as List<CompanyReview> Function(dynamic);
        final flags = await loadJsonData("all_company_reviews");
        final listFlags = List<DataMap>.from(flags);
        return fromMap(listFlags).toList();
      });
      final param = ReviewData.allCursorReview();
      final expectedData = [ReviewData.allCompanyReviews()];
      final result = await reviewRemote.allCompanyReviews(param);
      expect(result, equals(expectedData));
      verify(
        apiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Failed When Return All Car Reviews]", () async {
      final url = "${Info.admin}/allCompanyReviews";
      when(
        apiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      final param = ReviewData.allCursorReview();
      expectApiException(() => reviewRemote.allCompanyReviews(param));
      verify(
        apiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });
  });
}
