import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kcars/core/utils/pagination.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/auth/data/model/role.dart';
import 'package:kcars/features/auth/presentation/riverpod/current_user_controller.dart';
import 'package:kcars/features/review/data/model/car_review.dart';
import 'package:kcars/features/review/data/model/car_review_flag.dart';
import 'package:kcars/features/review/data/model/company_review.dart';
import 'package:kcars/features/review/data/model/cursor_review.dart';
import 'package:kcars/features/review/data/model/enums.dart';
import 'package:kcars/features/review/presentation/application/review_controller.dart';
import 'package:kcars/features/review/presentation/application/review_states.dart';
import 'package:kcars/features/review/presentation/riverpod/all_car_reviews.dart';
import 'package:kcars/features/review/presentation/riverpod/car_review_flags.dart';
import 'package:kcars/features/review/presentation/riverpod/comapnies_review.dart';
import 'package:kcars/features/review/presentation/riverpod/company_cars_review.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper_tests.dart';
import '../../review_data.dart';
import '../review_mocks.mocks.dart';

class FakeCompanyCarsProvider extends CompanyCarsReview {
  @override
  PagingState<CarReview> build() {
    return PagingState(
      items: [],
      hasNextPage: true,
      error: null,
      isLoading: true,
    );
  }

  @override
  void flagReview(String id) {
    final newState = state.copyWith(
      items: state.items
          .map(
            (r) => r.id == id
                ? r.copyWith(
                    status: ReviewStatus.flagged,
                    flaggedAt: DateTime.now(),
                  )
                : r,
          )
          .toList(),
    );
    state = newState;
  }
}

class FakeCompanyReviewsProvider extends CompaniesReviews {
  @override
  PagingState<CompanyReview> build() {
    return PagingState(
      items: [],
      hasNextPage: true,
      isLoading: false,
      initalLoading: true,
      isRefreshing: false,
    );
  }

  @override
  void flagReview(String id) {
    final newState = state.copyWith(
      items: state.items
          .map(
            (r) => r.id == id
                ? r.copyWith(
                    status: ReviewStatus.flagged,
                    flaggedAt: DateTime.now(),
                  )
                : r,
          )
          .toList(),
    );
    state = newState;
  }
}

class FakeCurrentUserController extends CurrentUserController {
  FakeCurrentUserController();

  @override
  FutureOr<Profile?> build() async {
    return Profile(
      userId: "A",
      email: "test@gmail.com",
      id: '123',
      name: 'Test User',
      role: Role(roleName: "user"),
      phoneNumber: '',
      countryCode: '',
      permissions: [],
    );
  }
}

class FakeAllReviewProvider extends AllCarReviews {
  @override
  PagingState<CarReview> build(AllCursorReview param) {
    return PagingState.initial();
  }

  @override
  Future<void> loadInitial() async {
    state = PagingState.initial();
  }

  @override
  void updateReview(String id, ReviewStatus status) {
    if (status == ReviewStatus.deleted) {
      final newState = state.items.where((r) => r.id != id).toList();
      state = state.copyWith(items: newState);
      return;
    }
    final newState = state.items
        .map(
          (review) => review.id == id
              ? review.copyWith(status: ReviewStatus.accepted)
              : review,
        )
        .toList();
    state = state.copyWith(items: newState);
  }
}

class FakeCarReviewsProvider extends CarReviewFalgs {
  @override
  PagingState<CarReviewFlag> build() {
    return PagingState.initial();
  }

  @override
  void updateReview(String id) {
    final newState = state.items.where((r) => r.review?.id != id).toList();
    state = state.copyWith(items: newState);
    return;
  }
}

void main() {
  late MockReviewRepo mockReviewRepo;
  late ProviderContainer container;
  setUpAll(() {
    registerEitherFallback<String?>();
    registerEitherVoidFallback();
  });
  setUp(() {
    mockReviewRepo = MockReviewRepo();
    container = ProviderContainer(
      overrides: [
        reviewControllerProvider.overrideWith(() {
          return ReviewController.test(reviewRepo: mockReviewRepo);
        }),
        currentUserControllerProvider.overrideWith(
          () => FakeCurrentUserController(),
        ),
        companyCarsReviewProvider.overrideWith(() => FakeCompanyCarsProvider()),
        companiesReviewsProvider.overrideWith(
          () => FakeCompanyReviewsProvider(),
        ),
        allCarReviewsProvider(
          AllCursorReview(),
        ).overrideWith(() => FakeAllReviewProvider()),
        carReviewFalgsProvider.overrideWith(() => FakeCarReviewsProvider()),
      ],
    );
  });
  group('[Review User Controller Tests] ...', () {
    test("[Should Success when revew A Car]", () async {
      final param = ReviewData.reviewPost();
      when(mockReviewRepo.reviewCar(param)).thenAnswer((_) async => Right("A"));
      final controller = container.read(reviewControllerProvider.notifier);
      expect(controller.state, isA<RevewInitialState>());
      final future = controller.reviewCar(param);
      expect(controller.state, isA<NewCarReviewLoading>());
      await future;
      expect(controller.state, isA<NewCarReviewCompleted>());
      verify(mockReviewRepo.reviewCar(param)).called(1);
    });

    test("[Should Failed when revew A Car]", () async {
      final param = ReviewData.reviewPost();
      when(mockReviewRepo.reviewCar(param)).thenAnswer(failureAnswer());
      final controller = container.read(reviewControllerProvider.notifier);
      expect(controller.state, isA<RevewInitialState>());
      final future = controller.reviewCar(param);
      expect(controller.state, isA<NewCarReviewLoading>());
      await future;
      expect(controller.state, isA<NewCarReviewFailed>());
      verify(mockReviewRepo.reviewCar(param)).called(1);
    });

    test("[Should Success When Review Company]", () async {
      final param = ReviewData.reviewPost();
      when(
        mockReviewRepo.reviewCompany(param),
      ).thenAnswer((_) async => Right("A"));
      final controller = container.read(reviewControllerProvider.notifier);
      expect(controller.state, isA<RevewInitialState>());
      final future = controller.reviewCompany(param);
      expect(controller.state, isA<NewCompanyReviewLoading>());
      await future;
      expect(controller.state, isA<NewCompanyReviewCompleted>());
      verify(mockReviewRepo.reviewCompany(param)).called(1);
    });

    test("[Should Failed When Review Company]", () async {
      final param = ReviewData.reviewPost();
      when(mockReviewRepo.reviewCompany(param)).thenAnswer(failureAnswer());
      final controller = container.read(reviewControllerProvider.notifier);
      expect(controller.state, isA<RevewInitialState>());
      final future = controller.reviewCompany(param);
      expect(controller.state, isA<NewCompanyReviewLoading>());
      await future;
      expect(controller.state, isA<NewCompanyReviewFailed>());
      verify(mockReviewRepo.reviewCompany(param)).called(1);
    });
  });

  group("[Company Review Tests]", () {
    test("[Should Success When Flag A car Review]", () async {
      final param = ReviewData.reviewFlag();
      when(
        mockReviewRepo.flagCarReview(param),
      ).thenAnswer((_) async => Right("A"));
      final controller = container.read(reviewControllerProvider.notifier);
      expect(controller.state, isA<RevewInitialState>());
      final future = controller.flagCarReview(param);
      expect(controller.state, isA<FlagCarReviewLoading>());
      await future;
      expect(controller.state, isA<FlagCarReviewCompleted>());
      verify(mockReviewRepo.flagCarReview(param)).called(1);
    });

    test("[Should Failed When Flag A car Review]", () async {
      final param = ReviewData.reviewFlag();
      when(mockReviewRepo.flagCarReview(param)).thenAnswer(failureAnswer());
      final controller = container.read(reviewControllerProvider.notifier);
      expect(controller.state, isA<RevewInitialState>());
      final future = controller.flagCarReview(param);
      expect(controller.state, isA<FlagCarReviewLoading>());
      await future;
      expect(controller.state, isA<FlagCarReviewFailed>());
      verify(mockReviewRepo.flagCarReview(param)).called(1);
    });

    test("[Should Success When Flag A Company Review]", () async {
      final param = ReviewData.reviewFlag();
      when(
        mockReviewRepo.flagCompanyReview(param),
      ).thenAnswer((_) async => Right("A"));
      final controller = container.read(reviewControllerProvider.notifier);
      expect(controller.state, isA<RevewInitialState>());
      final future = controller.flagCompanyReview(param);
      expect(controller.state, isA<FlagCompanyReviewLoading>());
      await future;
      expect(controller.state, isA<FlagCompanyReviewCompleted>());
      verify(mockReviewRepo.flagCompanyReview(param)).called(1);
    });

    test("[Should Failed When Flag A Company Review]", () async {
      final param = ReviewData.reviewFlag();
      when(mockReviewRepo.flagCompanyReview(param)).thenAnswer(failureAnswer());
      final controller = container.read(reviewControllerProvider.notifier);
      expect(controller.state, isA<RevewInitialState>());
      final future = controller.flagCompanyReview(param);
      expect(controller.state, isA<FlagCompanyReviewLoading>());
      await future;
      expect(controller.state, isA<FlagCompanyReviewFailed>());
      verify(mockReviewRepo.flagCompanyReview(param)).called(1);
    });
  });

  group("[Admin Reviw Tests]", () {
    test("[Should Sucess When Update Car Reviw]", () async {
      final param = ReviewData.updateReview();
      when(
        mockReviewRepo.updateCarReview(param),
      ).thenAnswer((_) async => Right(null));
      final controller = container.read(reviewControllerProvider.notifier);
      expect(controller.state, isA<RevewInitialState>());
      final future = controller.updateCarReview(param);
      expect(controller.state, isA<UpdateCarReviewLoading>());
      await future;
      expect(controller.state, isA<UpdateCarReviewCompleted>());
      verify(mockReviewRepo.updateCarReview(param)).called(1);
    });

    test("[Should Failed When Update Car Reviw]", () async {
      final param = ReviewData.updateReview();
      when(mockReviewRepo.updateCarReview(param)).thenAnswer(failureAnswer());
      final controller = container.read(reviewControllerProvider.notifier);
      expect(controller.state, isA<RevewInitialState>());
      final future = controller.updateCarReview(param);
      expect(controller.state, isA<UpdateCarReviewLoading>());
      await future;
      expect(controller.state, isA<UpdateCarReviewFailed>());
      verify(mockReviewRepo.updateCarReview(param)).called(1);
    });

    test("[Should Success When delete Car Review]", () async {
      final param = "A";
      when(
        mockReviewRepo.deleteCarReview(param),
      ).thenAnswer((_) async => Right(null));
      final controller = container.read(reviewControllerProvider.notifier);
      expect(controller.state, isA<RevewInitialState>());
      final future = controller.deleteCarReview(param, param);
      expect(controller.state, isA<DeleteCarReviewLoading>());
      await future;
      expect(controller.state, isA<DeleteCarReviewCompleted>());
      verify(mockReviewRepo.deleteCarReview(param)).called(1);
    });

    test("[Should Failed When delete Car Review]", () async {
      final param = "A";
      when(mockReviewRepo.deleteCarReview(param)).thenAnswer(failureAnswer());
      final controller = container.read(reviewControllerProvider.notifier);
      expect(controller.state, isA<RevewInitialState>());
      final future = controller.deleteCarReview(param, param);
      expect(controller.state, isA<DeleteCarReviewLoading>());
      await future;
      expect(controller.state, isA<DeleteCarReviewFailed>());
      verify(mockReviewRepo.deleteCarReview(param)).called(1);
    });

    test("[Should Success When Delete Company Review]", () async {
      final param = "A";
      when(
        mockReviewRepo.deleteCompanyReview(param),
      ).thenAnswer((_) async => Right(null));
      final controller = container.read(reviewControllerProvider.notifier);
      expect(controller.state, isA<RevewInitialState>());
      final future = controller.deleteCompanyReview(param, param);
      expect(controller.state, isA<DeleteCompanyReviewLoading>());
      await future;
      expect(controller.state, isA<DeleteCompanyReviewCompleted>());
      verify(mockReviewRepo.deleteCompanyReview(param)).called(1);
    });

    test("[Should Failed When Delete Company Review]", () async {
      final param = "A";
      when(
        mockReviewRepo.deleteCompanyReview(param),
      ).thenAnswer(failureAnswer());
      final controller = container.read(reviewControllerProvider.notifier);
      expect(controller.state, isA<RevewInitialState>());
      final future = controller.deleteCompanyReview(param, param);
      expect(controller.state, isA<DeleteCompanyReviewLoading>());
      await future;
      expect(controller.state, isA<DeleteCompanyReviewFailed>());
      verify(mockReviewRepo.deleteCompanyReview(param)).called(1);
    });
  });
}
