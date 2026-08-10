import 'dart:async';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/core/utils/pagination.dart';
import 'package:kcars/features/review/data/model/company_review.dart';
import 'package:kcars/features/review/data/model/cursor_review.dart';
import 'package:kcars/features/review/domain/repo/review_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'company_reviwes.g.dart';

@riverpod
class CompanyReviews extends _$CompanyReviews {
  late ReviewRepo _reviewRepo;
  @override
  PagingState<CompanyReview> build(CursorReview param) {
    _reviewRepo = sl<ReviewRepo>();
    ref.keepAlive();
    final refreshTimer = Timer.periodic(const Duration(minutes: 10), (_) {
      loadInitial();
    });

    ref.onDispose(() {
      refreshTimer.cancel();
    });
    Future.microtask(() => loadInitial());
    return PagingState(
      items: [],
      hasNextPage: true,
      error: null,
      isLoading: false,
    );
  }

  Future<void> loadInitial() async {
    state = state.copyWith(isLoading: true, isRefreshing: true, error: null);
    final result = await _reviewRepo.companyReviews(param);

    result.fold(
      (l) => state = state.copyWith(
        error: l.message,
        initalLoading: false,
        isLoading: false,
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
    final cursor = param.copyWith(cursor: state.items.last.id);
    final result = await _reviewRepo.companyReviews(cursor);

    result.fold((l) => state = state.copyWith(error: l.message), (r) {
      final hasMore = r.isNotEmpty;
      final updatedItems = [...state.items, ...r];
      state = state.copyWith(
        items: updatedItems,
        hasNextPage: hasMore,
        isLoading: false,
        error: null,
      );
    });
  }
}
