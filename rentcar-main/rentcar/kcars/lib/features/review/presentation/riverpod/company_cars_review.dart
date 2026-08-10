import 'dart:async';

import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/core/utils/pagination.dart';
import 'package:kcars/features/review/data/model/car_review.dart';
import 'package:kcars/features/review/data/model/cursor_review.dart';
import 'package:kcars/features/review/data/model/enums.dart';
import 'package:kcars/features/review/domain/repo/review_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'company_cars_review.g.dart';

@riverpod
class CompanyCarsReview extends _$CompanyCarsReview {
  late ReviewRepo _reviewRepo;
  @override
  PagingState<CarReview> build() {
    _reviewRepo = sl<ReviewRepo>();
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
    final result = await _reviewRepo.companyCarsReviews();
    result.fold(
      (l) => state = state.copyWith(
        error: l.message,
        isLoading: false,
        initalLoading: false,
      ),
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
    final cursor = CursorReview(id: "", cursor: state.items.last.id);
    final result = await _reviewRepo.companyCarsReviews(cursor);

    result.fold((l) => state = state.copyWith(error: l.message), (r) {
      final hasMore = r.isNotEmpty;

      final updatedItems = [...state.items, ...r]; // ← append
      state = state.copyWith(
        items: updatedItems,
        hasNextPage: hasMore,
        isLoading: false,
        error: null,
      );
    });
  }

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
