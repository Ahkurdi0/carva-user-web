import 'dart:async';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/core/utils/pagination.dart';
import 'package:kcars/features/booking/data/model/book.dart';
import 'package:kcars/features/booking/data/model/book_cursor.dart';
import 'package:kcars/features/booking/data/model/enums.dart';
import 'package:kcars/features/booking/domain/repo/book_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booked.g.dart';

@riverpod
class Booked extends _$Booked {
  late BookRepo _bookRepo;
  @override
  PagingState<Book> build([BookCursor? param]) {
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
    final result = await _bookRepo.getBooks();

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

  Future<void> loadMore(String? lastId) async {
    if (state.isLoading || !state.hasNextPage) return;
    state = state.copyWith(isLoading: true);
    final p = BookCursor(cursor: lastId);
    final result = await _bookRepo.getBooks(p);
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

  void cancelBook(String bookId) {
    final newState = state.items
        .map(
          (book) => book.id == bookId
              ? book.copyWith(status: BookStatus.canceled)
              : book,
        )
        .toList();
    state = state.copyWith(items: newState, hasNextPage: true);
  }
}
