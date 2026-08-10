import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/core/utils/debouncer.dart';
import 'package:kcars/features/booking/data/model/book.dart';
import 'package:kcars/features/booking/data/model/book_cursor.dart';
import 'package:kcars/features/booking/domain/repo/book_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'search_books.g.dart';

@riverpod
class SearchBooks extends _$SearchBooks {
  late BookRepo _bookRepo;
  @override
  FutureOr<List<Book>> build() {
    _bookRepo = sl<BookRepo>();
    return [];
  }

  void searchForUsers(search) async {
    state = AsyncLoading();
    AppDebounce.debounce("searching_books", Duration(seconds: 1), () async {
      final result = await _bookRepo.getCompanyBooks(
        BookCursor(search: search),
      );
      result.fold(
        (l) => state = AsyncError(l.message, StackTrace.empty),
        (r) => state = AsyncData(r),
      );
    });
  }

  void updateBook(Book nbook) {
    final newState = state.value
        ?.map((book) => book.id == nbook.id ? nbook : book)
        .toList();
    if (newState == null) return;
    state = AsyncData(newState);
  }
}
