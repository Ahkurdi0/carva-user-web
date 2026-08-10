import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/core/utils/pagination.dart';
import 'package:kcars/features/booking/data/model/book.dart';
import 'package:kcars/features/booking/data/model/book_cursor.dart';
import 'package:kcars/features/booking/data/model/new_booking.dart';
import 'package:kcars/features/booking/data/model/promo_code.dart';
import 'package:kcars/features/booking/domain/repo/book_repo.dart';
import 'package:kcars/features/booking/presentation/application/book_states.dart';
import 'package:kcars/features/booking/presentation/riverpod/booked.dart';
import 'package:kcars/features/booking/presentation/riverpod/company_book.dart';
import 'package:kcars/features/booking/presentation/riverpod/search_books.dart';
import 'package:kcars/features/company/data/model/contact_statistic.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'book_controller.g.dart';

class FakeComppanyBookProvider extends CompanyBooked {
  @override
  PagingState<Book> build(BookCursor param) {
    return PagingState.initial();
  }

  @override
  void removeFromThisStatus(String bookId) {
    final newState = state.items.where((book) => book.id != bookId).toList();
    state = state.copyWith(items: newState);
  }

  @override
  void moveToNewState(Book book) {
    final newState = state.copyWith(items: [book, ...state.items]);
    state = newState;
  }
}

@riverpod
class BookController extends _$BookController {
  late BookRepo _bookRepo;
  BookController._(this._bookRepo);

  factory BookController.test({required BookRepo bookRepo}) {
    return BookController._(bookRepo);
  }
  BookController() : _bookRepo = sl<BookRepo>();
  @override
  BookStates build() {
    return const BookInitial();
  }

  Future<void> bookCar(NewBooking param) async {
    state = const NewBookLoading();
    final result = await _bookRepo.bookCar(param);
    await result.fold<Future<void>>(
      (l) async => state = NewBookFailed(l.message),
      (r) async => state = const NewBookCompleted(),
    );
  }

  Future<void> cancelBook(NewBooking param) async {
    state = const CancelBookLoading();
    final result = await _bookRepo.cancelUserBooks(param);
    result.fold<Future<void>>(
      (l) async => state = CancelBookFailed(l.message),
      (r) async {
        state = const CancelBookCompleted();
        ref.read(bookedProvider().notifier).cancelBook(param.bookId!);
      },
    );
  }

  Future<void> updateBook(
    NewBooking param,
    BookCursor params,
    Book book,
  ) async {
    state = const UpdateBookLoading();
    final result = await _bookRepo.updateBook(param);
    result.fold<Future<void>>(
      (l) async => state = UpdateBookFailed(l.message),
      (r) async {
        ref
            .read(companyBookedProvider(params).notifier)
            .removeFromThisStatus(param.bookId!);
        ref
            .read(
              companyBookedProvider(
                params.copyWith(status: param.status),
              ).notifier,
            )
            .moveToNewState(book);
        ref
            .read(searchBooksProvider.notifier)
            .updateBook(book.copyWith(status: param.status));
        state = const UpdateBookCompleted();
      },
    );
  }

  Future<void> applyPromoCode(PromoCode param) async {
    state = const ApplyPromotionLoading();
    final result = await _bookRepo.applyPromoCode(param);
    result.fold<Future<void>>(
      (l) async => state = ApplyPromotionFailed(l.message),
      (r) async => state = ApplyPromotionCompleted(r),
    );
  }

  Future<void> contact(ContactStatistic param) async {
    state = const ContactLoading();
    final result = await _bookRepo.contact(param);
    result.fold<Future<void>>(
      (l) async => state = ContactFailed(l.message),
      (r) async => state = ContactCompleted(r),
    );
  }
}
