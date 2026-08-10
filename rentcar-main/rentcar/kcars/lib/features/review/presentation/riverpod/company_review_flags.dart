import 'dart:async';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/core/utils/pagination.dart';
import 'package:kcars/features/review/data/model/company_review_flag.dart';
import 'package:kcars/features/review/data/model/cursor_review.dart';
import 'package:kcars/features/review/domain/repo/review_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'company_review_flags.g.dart';

@riverpod
class CompanyReviewFalgs extends _$CompanyReviewFalgs {
  late ReviewRepo _reviewRepo;
  @override
  PagingState<CompanyReviewFlag> build() {
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
    final param = CursorReviewFlags();
    final result = await _reviewRepo.companyReviewFlags(param);

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
    final param = CursorReviewFlags(cursor: state.items.last.id);
    final result = await _reviewRepo.companyReviewFlags(param);

    result.fold(
      (l) => state = state.copyWith(
        error: l.message,
        isLoading: false,
        initalLoading: false,
      ),
      (r) {
        final hasMore = r.isNotEmpty;

        final updatedItems = [...state.items, ...r]; // ← append
        state = state.copyWith(
          items: updatedItems,
          hasNextPage: hasMore,
          isLoading: false,
          error: null,
        );
      },
    );
  }

  void updateReview(String id) {
    final newState = state.items.where((r) => r.review?.id != id).toList();
    state = state.copyWith(items: newState);
    return;
  }
}
