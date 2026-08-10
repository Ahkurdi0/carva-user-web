import 'dart:async';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/core/utils/pagination.dart';
import 'package:kcars/features/review/data/model/company_review.dart';
import 'package:kcars/features/review/data/model/cursor_review.dart';
import 'package:kcars/features/review/data/model/enums.dart';
import 'package:kcars/features/review/domain/repo/review_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'all_company_reviews.g.dart';

@riverpod
class AllCompanyReviews extends _$AllCompanyReviews {
  late ReviewRepo _reviewRepo;
  @override
  PagingState<CompanyReview> build(AllCursorReview param) {
    _reviewRepo = sl();

    ref.keepAlive();

    final refreshTimer = Timer.periodic(const Duration(minutes: 15), (_) {
      loadInitial();
    });

    ref.onDispose(() {
      refreshTimer.cancel();
    });
    Future.microtask(() => loadInitial());
    return PagingState.initial();
  }

  Future<void> loadInitial() async {
    final result = await _reviewRepo.allCompanyReviews(param);

    result.fold(
      (l) => state = state.copyWith(error: l.message, isLoading: false),
      (r) {
        final hasMore = r.isNotEmpty;
        state = state.copyWith(
          items: r,
          hasNextPage: hasMore,
          isLoading: false,
          error: null,
          isRefreshing: false,
          initalLoading: false,
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasNextPage) return;
    state = state.copyWith(isLoading: true);
    final result = await _reviewRepo.allCompanyReviews(
      param.copyWith(cursor: state.items.last.id),
    );

    result.fold(
      (l) => state = state.copyWith(
        error: l.message,
        isLoading: false,
        initalLoading: false,
      ),
      (r) {
        final hasMore = r.isNotEmpty;

        final updatedItems = [...state.items, ...r];
        state = state.copyWith(
          items: updatedItems,
          hasNextPage: hasMore,
          isLoading: false,
          error: null,
        );
      },
    );
  }

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
