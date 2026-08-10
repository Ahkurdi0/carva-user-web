import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kcars/configs/error/exception.dart';
import 'package:kcars/features/car/data/model/brand.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/post_location.dart';
import 'package:kcars/features/car/data/model/promotion.dart';
import 'package:kcars/features/car/data/repo/car_repo_impl.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper_tests.dart';
import '../../utils/car_test_data.dart';
import 'car_repo_mocks.mocks.dart';

void main() {
  late MockCarRemote mockCarRemote;
  late CarRepo carRepe;

  setUpAll(() {
    registerEitherListFallback<Promotion>();
    registerEitherListFallback<Car>();
    registerEitherListFallback<Brand>();
    registerEitherVoidFallback();
  });
  setUp(() {
    mockCarRemote = MockCarRemote();
    carRepe = CarRepoImpl(mockCarRemote);
  });
  group('[Company Car Action Tetst] ...', () {
    test("Should Success when List new [Car]", () async {
      when(
        mockCarRemote.listCar(any),
      ).thenAnswer((_) async => Future.value(null));
      final param = CarTestData.carPost();

      final result = await carRepe.listCar(param);

      expectSuccess(result, null);
      verify(carRepe.listCar(param)).called(1);
    });

    test("Should return Failure when listing cars fails", () async {
      when(mockCarRemote.listCar(any)).thenThrow(ApiException.exception());
      final param = CarTestData.carPost();
      final result = await carRepe.listCar(param);
      expectFailureWithStatusCode(result, 400);
      verify(carRepe.listCar(param)).called(1);
    });

    test("should sucess when update [car]", () async {
      when(
        mockCarRemote.updateCar(any),
      ).thenAnswer((_) async => Future.value(null));
      final param = CarTestData.carPost();
      final result = await carRepe.updateCar(param);
      expectSuccess(result, null);
      verify(carRepe.updateCar(param)).called(1);
    });

    test("Should Success when delete [car]", () async {
      when(
        mockCarRemote.deleteCar(any),
      ).thenAnswer((_) async => Future.value(null));
      final result = await carRepe.deleteCar("A");
      expectSuccess(result, null);
      verify(carRepe.deleteCar("A")).called(1);
    });

    test("Should Failure when deleting car fails", () async {
      when(carRepe.deleteCar("A")).thenThrow(ApiException.exception());
      final result = await carRepe.deleteCar("A");
      expectFailureWithStatusCode(result, 400);
      verify(carRepe.deleteCar("A")).called(1);
    });
  });

  group("[Compnay Promotion ation] Tests", () {
    test("Success When add new Promotion", () async {
      when(
        mockCarRemote.promotion(any),
      ).thenAnswer((_) async => Future.value("A"));
      final param = CarTestData.promotion();
      final result = await carRepe.promotion(param);
      expectSuccess(result, "A");
      verify(carRepe.promotion(param)).called(1);
    });

    test("Failed when add new Promotion", () async {
      when(mockCarRemote.promotion(any)).thenThrow(ApiException.exception());
      final param = CarTestData.promotion();
      final result = await carRepe.promotion(param);
      expectFailureWithStatusCode(result, 400);
      verify(carRepe.promotion(param)).called(1);
    });

    test("Success When delete Promotion", () async {
      when(
        mockCarRemote.deletePromotion(any),
      ).thenAnswer((_) async => Future.value(null));
      final param = "A";
      final result = await carRepe.deletePromotion(param);
      expectSuccess(result, null);
      verify(carRepe.deletePromotion(param)).called(1);
    });

    test("[Failed when delete Promotion]", () async {
      when(
        mockCarRemote.deletePromotion(any),
      ).thenThrow(ApiException.exception());
      final param = "A";
      final result = await carRepe.deletePromotion(param);
      expectFailureWithStatusCode(result, 400);
      verify(carRepe.deletePromotion(param)).called(1);
    });

    test("Should Return All [Prmotions]", () async {
      final expectedData = [CarTestData.promotion()];
      final param = PromotionPost();
      when(mockCarRemote.promotions(any)).thenAnswer((_) async => expectedData);
      final result = await carRepe.promotions(param);
      expectSuccess(result, expectedData);
      verify(carRepe.promotions(param)).called(1);
    });

    test("[Fail wehen return All [Prmotions ]", () async {
      when(mockCarRemote.promotions(any)).thenThrow(ApiException.exception());
      final param = PromotionPost();
      final result = await carRepe.promotions(param);
      expectFailureWithStatusCode(result, 400);
      verify(carRepe.promotions(param)).called(1);
    });
  });

  group("[User actons Test]", () {
    test("Should Return [Suggested Cars]", () async {
      final expectedData = [CarTestData.car()];
      when(
        mockCarRemote.suggestedCars(any),
      ).thenAnswer((_) async => expectedData);
      final param = PostLocation();
      final result = await carRepe.suggestedCars(param);
      expectSuccess(result, expectedData);
      verify(carRepe.suggestedCars(param)).called(1);
    });

    test("[Fail when return [Suggested Cars]", () async {
      when(
        mockCarRemote.suggestedCars(any),
      ).thenThrow(ApiException.exception());
      final param = PostLocation();
      final result = await carRepe.suggestedCars(param);
      expectFailureWithStatusCode(result, 400);
      verify(carRepe.suggestedCars(param)).called(1);
    });

    test("Should Return [Brand Cars]", () async {
      final expectedData = [CarTestData.brandCars()];
      final param = PostLocation();
      when(mockCarRemote.brandCars(any)).thenAnswer((_) async => expectedData);
      final result = await carRepe.brandCars(param);
      expectSuccess(result, expectedData);
      verify(carRepe.brandCars(param)).called(1);
    });

    test("[Fail when return [Brand Cars]", () async {
      when(mockCarRemote.brandCars(any)).thenThrow(ApiException.exception());
      final param = PostLocation();
      final result = await carRepe.brandCars(param);
      expectFailureWithStatusCode(result, 400);
      verify(carRepe.brandCars(param)).called(1);
    });

    test("Should Return [Nearby Cars]", () async {
      final expectedData = [CarTestData.car()];
      final param = PostLocation();
      when(
        mockCarRemote.nearBayCars(any),
      ).thenAnswer((_) async => expectedData);
      final result = await carRepe.nearBayCars(param);
      expectSuccess(result, expectedData);
      verify(carRepe.nearBayCars(param)).called(1);
    });

    test("[Fail when return [Nearby Cars]", () async {
      when(mockCarRemote.nearBayCars(any)).thenThrow(ApiException.exception());
      final param = PostLocation();
      final result = await carRepe.nearBayCars(param);
      expectFailureWithStatusCode(result, 400);
      verify(carRepe.nearBayCars(param)).called(1);
    });

    test("Should Return [Recently Viewed Cars]", () async {
      final expectedData = [CarTestData.car()];
      when(
        mockCarRemote.recentlyViewed(),
      ).thenAnswer((_) async => expectedData);
      final result = await carRepe.recentlyViewed();
      expect(result.isRight(), true);
      expect(result, equals(Right(expectedData)));
      verify(carRepe.recentlyViewed()).called(1);
    });

    test("[Fail when return [Recently Viewed Cars]", () async {
      when(mockCarRemote.recentlyViewed()).thenThrow(ApiException.exception());
      final result = await carRepe.recentlyViewed();
      expectFailureWithStatusCode(result, 400);
      verify(carRepe.recentlyViewed()).called(1);
    });
  });
}
