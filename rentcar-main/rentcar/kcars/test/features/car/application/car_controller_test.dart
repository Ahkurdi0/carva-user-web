import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kcars/core/utils/pagination.dart';
import 'package:kcars/features/auth/presentation/riverpod/is_admin.dart';
import 'package:kcars/features/car/application/car_controller.dart';
import 'package:kcars/features/car/application/car_states.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/image.dart';
import 'package:kcars/features/car/data/model/promotion.dart';
import 'package:kcars/features/car/presentation/riverpod/all_cars.dart';
import 'package:kcars/features/car/presentation/riverpod/company_cars.dart';
import 'package:kcars/features/review/data/model/cursor_review.dart';
import 'package:kcars/features/review/presentation/riverpod/all_car_reviews.dart';
import 'package:mockito/mockito.dart';

import '../../../helper_tests.dart';
import '../../review/presentation/application/review_controller_test.dart';
import '../utils/car_test_data.dart';
import 'car_controller.mocks.mocks.dart';

class FakeCompanyCarsProvider extends CompanyCars {
  @override
  PagingState<Car> build() {
    return PagingState.initial();
  }

  @override
  Future<void> loadInitial() async {
    await Future.delayed(Duration(milliseconds: 10));
    state = state.copyWith(initalLoading: false, items: []);
  }

  @override
  void sortedImages(List<Images> images, String carId) {
    state = state.copyWith(
      items: state.items
          .map((car) => car.id == carId ? car.copyWith(images: images) : car)
          .toList(),
    );
  }
}

class FakeAllCarsProvider extends AllCars {
  @override
  PagingState<Car> build() {
    return PagingState(items: [], hasNextPage: true, isLoading: false);
  }

  @override
  Future<void> loadInitial() async {
    state = PagingState.initial();
  }
}

void main() {
  late MockCarRepo mockCarRepo;
  late ProviderContainer container;

  setUpAll(() {
    registerEitherVoidFallback();
    registerEitherFallback<String>();
  });
  setUp(() {
    mockCarRepo = MockCarRepo();
    container = ProviderContainer(
      overrides: [
        carControllerProvider.overrideWith(() {
          return CarController.test(carRepo: mockCarRepo);
        }),
        allCarReviewsProvider(
          AllCursorReview(),
        ).overrideWith(() => FakeAllReviewProvider()),
        allCarsProvider.overrideWith(() => FakeAllCarsProvider()),
        hasPermossionProvider().overrideWith((ref) => false),
        companyCarsProvider.overrideWith(() => FakeCompanyCarsProvider()),
      ],
    );
  });
  group('[Car List Update Delete]', () {
    test("[Should success when list new CAR]", () async {
      final car = CarTestData.carPost();
      when(mockCarRepo.listCar(any)).thenAnswer((_) async => Right(null));
      final controller = container.read(carControllerProvider.notifier);
      expect(controller.state, isA<InitialCarState>());
      final future = controller.listCar(car);
      expect(controller.state, isA<NewCarLoading>());
      await future;
      expect(controller.state, isA<NewCarCompleted>());
      verify(mockCarRepo.listCar(any)).called(1);
    });

    test("Should fail when list new CAR", () async {
      final car = CarTestData.carPost();

      when(mockCarRepo.listCar(any)).thenAnswer(failureAnswer());
      final controller = container.read(carControllerProvider.notifier);
      expect(controller.state, isA<InitialCarState>());
      final future = controller.listCar(car);
      expect(controller.state, isA<NewCarLoading>());
      await future;
      expect(controller.state, isA<NewCarFailed>());
      verify(mockCarRepo.listCar(any)).called(1);
    });

    test("[Should success when update Car ]", () async {
      final car = CarTestData.carPost();
      when(mockCarRepo.updateCar(any)).thenAnswer((_) async => Right(null));
      final controller = container.read(carControllerProvider.notifier);
      expect(controller.state, isA<InitialCarState>());
      final future = controller.updateCar(car);
      expect(controller.state, isA<NewCarLoading>());
      await future;
      expect(controller.state, isA<NewCarCompleted>());
      verify(mockCarRepo.updateCar(any)).called(1);
    });

    test("[Should fail when update Car ]", () async {
      final car = CarTestData.carPost();
      when(mockCarRepo.updateCar(any)).thenAnswer(failureAnswer());
      final controller = container.read(carControllerProvider.notifier);
      expect(controller.state, isA<InitialCarState>());
      final future = controller.updateCar(car);
      expect(controller.state, isA<NewCarLoading>());
      await future;
      expect(controller.state, isA<NewCarFailed>());

      verify(mockCarRepo.updateCar(any)).called(1);
    });

    test("[Should success when delete CAR ]", () async {
      when(mockCarRepo.deleteCar(any)).thenAnswer((_) async => Right(null));
      final controller = container.read(carControllerProvider.notifier);
      expect(controller.state, isA<InitialCarState>());
      final future = controller.deleteCar("A");
      expect(controller.state, isA<DeleteCarLoading>());
      await future;
      expect(controller.state, isA<DeleteCarCompleted>());
      verify(mockCarRepo.deleteCar(any)).called(1);
    });

    test("[Should fail when delete CAR ]", () async {
      when(mockCarRepo.deleteCar(any)).thenAnswer(failureAnswer());
      final controller = container.read(carControllerProvider.notifier);
      expect(controller.state, isA<InitialCarState>());
      final future = controller.deleteCar("A");
      expect(controller.state, isA<DeleteCarLoading>());
      await future;
      expect(controller.state, isA<DeleteCarFailed>());
      verify(mockCarRepo.deleteCar(any)).called(1);
    });
  });

  group("[Promotion Tests]", () {
    test("[Should success wen add new Promotion]", () async {
      final param = PromotionPost(carId: "A");
      final promotion = CarTestData.promotion();
      when(mockCarRepo.promotion(any)).thenAnswer((_) async => Right("A"));
      final controller = container.read(carControllerProvider.notifier);
      expect(controller.state, isA<InitialCarState>());
      final future = controller.newPromotion(promotion, param);
      expect(controller.state, isA<NewPromotionLoading>());
      await future;
      expect(controller.state, isA<NewPromotionCompleted>());
      verify(mockCarRepo.promotion(any)).called(1);
    });

    test("[Should fail wen add/update new Promotion]", () async {
      final param = PromotionPost(carId: "A");
      final promotion = CarTestData.promotion();
      when(mockCarRepo.promotion(any)).thenAnswer(failureAnswer());
      final controller = container.read(carControllerProvider.notifier);
      expect(controller.state, isA<InitialCarState>());
      final future = controller.newPromotion(promotion, param);
      expect(controller.state, isA<NewPromotionLoading>());
      await future;
      expect(controller.state, isA<NewPromotionFailed>());
      verify(mockCarRepo.promotion(any)).called(1);
    });

    test("[Should success when delete Promotion ", () async {
      when(
        mockCarRepo.deletePromotion(any),
      ).thenAnswer((_) async => Right(null));
      final controller = container.read(carControllerProvider.notifier);
      expect(controller.state, isA<InitialCarState>());
      final future = controller.deletePromotion("A");
      expect(controller.state, isA<DeletePromotionLoading>());
      await future;
      expect(controller.state, isA<DeletePromotionCompleted>());
      verify(mockCarRepo.deletePromotion(any)).called(1);
    });

    test("[Should fail when delete Promotion ", () async {
      when(mockCarRepo.deletePromotion(any)).thenAnswer(failureAnswer());
      final controller = container.read(carControllerProvider.notifier);
      expect(controller.state, isA<InitialCarState>());
      final future = controller.deletePromotion("A");
      expect(controller.state, isA<DeletePromotionLoading>());
      await future;
      expect(controller.state, isA<DeletePromotionFailed>());
      verify(mockCarRepo.deletePromotion(any)).called(1);
    });
  });

  group("Oher Tests", () {
    test("[Should success when sort Images]", () async {
      when(mockCarRepo.sortImages(any)).thenAnswer((_) async => Right(null));
      final controller = container.read(carControllerProvider.notifier);
      expect(controller.state, isA<InitialCarState>());
      final future = controller.sortImages([], "A");
      expect(controller.state, isA<SortImagesLoading>());
      await future;
      expect(controller.state, isA<SortImagesCompleted>());
      verify(mockCarRepo.sortImages(any)).called(1);
    });

    test("[Should fail when sort Images]", () async {
      when(mockCarRepo.sortImages(any)).thenAnswer(failureAnswer());
      final controller = container.read(carControllerProvider.notifier);
      expect(controller.state, isA<InitialCarState>());
      final future = controller.sortImages([], "A");
      expect(controller.state, isA<SortImagesLoading>());
      await future;
      expect(controller.state, isA<SortImagesFailed>());
      verify(mockCarRepo.sortImages(any)).called(1);
    });
  });
}
