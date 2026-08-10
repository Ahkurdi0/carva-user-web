import 'dart:async';

import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/core/utils/pagination.dart';
import 'package:kcars/features/booking/data/model/book.dart';
import 'package:kcars/features/booking/data/model/book_cursor.dart';
import 'package:kcars/features/booking/domain/repo/book_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'company_book.g.dart';

@riverpod
class CompanyBooked extends _$CompanyBooked {
  late BookRepo _bookRepo;
  @override
  PagingState<Book> build(BookCursor param) {
    _bookRepo = sl<BookRepo>();
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
    final result = await _bookRepo.getCompanyBooks(param);
    return result.fold(
      (l) => state = state.copyWith(
        error: l.message,
        isRefreshing: false,
        initalLoading: false,
        isLoading: false,
      ),
      (r) {
        state = state.copyWith(
          items: r,
          hasNextPage: true,
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

    final result = await _bookRepo.getCompanyBooks(cursor);

    result.fold(
      (l) => state = state.copyWith(error: l.message, isLoading: false),
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

  void removeFromThisStatus(String bookId) {
    final newState = state.items.where((book) => book.id != bookId).toList();
    state = state.copyWith(items: newState);
  }

  void moveToNewState(Book book) {
    final newState = state.copyWith(items: [book, ...state.items]);
    state = newState;
  }
}
