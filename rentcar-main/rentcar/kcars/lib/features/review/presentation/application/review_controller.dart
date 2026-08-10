import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/auth/presentation/riverpod/current_user_controller.dart';
import 'package:kcars/features/car/presentation/riverpod/details_car.dart';
import 'package:kcars/features/company/presentation/riverpod/details_company.dart';
import 'package:kcars/features/review/data/model/car_review.dart';
import 'package:kcars/features/review/data/model/company_review.dart';
import 'package:kcars/features/review/data/model/cursor_review.dart';
import 'package:kcars/features/review/data/model/enums.dart';
import 'package:kcars/features/review/data/model/review_flag.dart';
import 'package:kcars/features/review/data/model/review_post.dart';
import 'package:kcars/features/review/data/model/updare_review.dart';
import 'package:kcars/features/review/domain/repo/review_repo.dart';
import 'package:kcars/features/review/presentation/application/review_states.dart';
import 'package:kcars/features/review/presentation/riverpod/all_car_reviews.dart';
import 'package:kcars/features/review/presentation/riverpod/car_review_flags.dart';
import 'package:kcars/features/review/presentation/riverpod/comapnies_review.dart';
import 'package:kcars/features/review/presentation/riverpod/company_cars_review.dart';
import 'package:kcars/features/review/presentation/riverpod/company_review_flags.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'review_controller.g.dart';

@riverpod
class ReviewController extends _$ReviewController {
  late ReviewRepo _reviewRepo;

  ReviewController._(this._reviewRepo);
  factory ReviewController.test({required ReviewRepo reviewRepo}) {
    return ReviewController._(reviewRepo);
  }
  ReviewController() : _reviewRepo = sl<ReviewRepo>();
  @override
  ReviewSates build() {
    return RevewInitialState();
  }

  Future<void> reviewCar(ReviewPost param) async {
    state = const NewCarReviewLoading();
    final user = await ref.read(currentUserControllerProvider.future);
    final result = await _reviewRepo.reviewCar(param);
    await result.fold<Future<void>>(
      (l) async => state = NewCarReviewFailed(l.message),
      (r) async {
        state = NewCarReviewCompleted(r);
        ref
            .read(detailsCarProvider(param.carId!).notifier)
            .newReview(
              CarReview(
                id: r!,
                profile: user,
                desc: param.desc,
                rate: param.rate,
                reviewedAt: DateTime.now(),
              ),
            );
      },
    );
  }

  Future<void> reviewCompany(ReviewPost param) async {
    state = const NewCompanyReviewLoading();
    final result = await _reviewRepo.reviewCompany(param);
    final profile = await ref.read(currentUserControllerProvider.future);
    await result.fold<Future<void>>(
      (l) async => state = NewCompanyReviewFailed(l.message),
      (r) async {
        ref
            .read(detailCompanyProvider(param.companyId!).notifier)
            .newReview(
              CompanyReview(
                id: r ?? "",
                desc: param.desc,
                rate: param.rate,
                reviewedAt: DateTime.now(),
                status: ReviewStatus.accepted,
                profile: profile,
              ),
            );
        state = NewCompanyReviewCompleted(r);
      },
    );
  }

  Future<void> flagCarReview(ReviewFlag param) async {
    state = const FlagCarReviewLoading();
    final result = await _reviewRepo.flagCarReview(param);
    await result.fold<Future<void>>(
      (l) async => state = FlagCarReviewFailed(l.message),
      (r) async {
        ref.read(companyCarsReviewProvider.notifier).flagReview(param.reviewId);
        state = FlagCarReviewCompleted();
      },
    );
  }

  Future<void> flagCompanyReview(ReviewFlag param) async {
    state = const FlagCompanyReviewLoading();
    final result = await _reviewRepo.flagCompanyReview(param);
    await result.fold<Future<void>>(
      (l) async => state = FlagCompanyReviewFailed(l.message),
      (r) async {
        ref.read(companiesReviewsProvider.notifier).flagReview(param.reviewId);
        state = FlagCompanyReviewCompleted();
      },
    );
  }

  Future<void> updateCarReview(
    UpdateReview param, [
    AllCursorReview? familyParam,
  ]) async {
    state = const UpdateCarReviewLoading();
    final result = await _reviewRepo.updateCarReview(param);
    await result.fold<Future<void>>(
      (l) async => state = UpdateCarReviewFailed(l.message),
      (r) async {
        if (familyParam != null) {
          ref
              .read(allCarReviewsProvider(familyParam).notifier)
              .updateReview(param.id, param.status);
        } else {
          ref.read(carReviewFalgsProvider.notifier).updateReview(param.id);
        }
        state = const UpdateCarReviewCompleted();
      },
    );
  }

  Future<void> updateCompanyReview(
    UpdateReview param, [
    AllCursorReview? familyParam,
  ]) async {
    state = const UpdateCompanyReviewLoading();
    final result = await _reviewRepo.updateCompanyReview(param);
    await result.fold<Future<void>>(
      (l) async => state = UpdateCompanyReviewFailed(l.message),
      (r) async {
        if (familyParam != null) {
          ref
              .read(allCarReviewsProvider(familyParam).notifier)
              .updateReview(param.id, param.status);
        } else {
          ref.read(companyReviewFalgsProvider.notifier).updateReview(param.id);
        }
        state = const UpdateCompanyReviewCompleted();
      },
    );
  }

  Future<void> deleteCarReview(String id, String carId) async {
    state = const DeleteCarReviewLoading();
    final result = await _reviewRepo.deleteCarReview(id);
    await result.fold<Future<void>>(
      (l) async => state = DeleteCarReviewFailed(l.message),
      (r) async {
        state = const DeleteCarReviewCompleted();
        ref.read(detailsCarProvider(carId).notifier).deleteReview();
      },
    );
  }

  Future<void> deleteCompanyReview(String companyId, String id) async {
    state = const DeleteCompanyReviewLoading();
    final result = await _reviewRepo.deleteCompanyReview(id);
    await result.fold<Future<void>>(
      (l) async => state = DeleteCompanyReviewFailed(l.message),
      (r) async {
        ref.read(detailCompanyProvider(companyId).notifier).deleteReview();
        state = const DeleteCompanyReviewCompleted();
      },
    );
  }
}
