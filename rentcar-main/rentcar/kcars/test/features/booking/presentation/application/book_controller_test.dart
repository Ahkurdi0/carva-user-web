import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kcars/core/utils/pagination.dart';
import 'package:kcars/features/booking/data/model/book.dart';
import 'package:kcars/features/booking/data/model/book_cursor.dart';
import 'package:kcars/features/booking/data/model/new_booking.dart';
import 'package:kcars/features/booking/data/model/promotion_result.dart';
import 'package:kcars/features/booking/presentation/application/book_controller.dart';
import 'package:kcars/features/booking/presentation/application/book_states.dart';
import 'package:kcars/features/booking/presentation/riverpod/company_book.dart';
import 'package:kcars/features/booking/presentation/riverpod/search_books.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../helper_tests.dart';
import '../../book_data.dart';
import '../book_mocks.mocks.dart';

class FakeCompanyBookController extends CompanyBooked {
  @override
  PagingState<Book> build(BookCursor param) {
    return PagingState(
      hasNextPage: true,
      isLoading: false,
      items: [BookData.book()],
      error: null,
      initalLoading: true,
      isRefreshing: false,
    );
  }

  @override
  removeFromThisStatus(String bookId) {
    final newState = state.items.where((book) => book.id != bookId).toList();
    state = state.copyWith(items: newState);
  }

  @override
  moveToNewState(Book book) {
    state = state.copyWith(items: [book, ...state.items]);
  }
}

class FakeSearchBooks extends SearchBooks {
  @override
  FutureOr<List<Book>> build() {
    return [];
  }

  @override
  void searchForUsers(search) async {}

  @override
  void updateBook(Book nbook) {
    final newState = state.value
        ?.map((book) => book.id == nbook.id ? nbook : book)
        .toList();
    if (newState == null) return;
    state = AsyncData(newState);
  }
}

void main() {
  late MockBookRepo mockCarRepo;

  late ProviderContainer container;

  setUpAll(() {
    registerEitherListFallback<Book>();
    registerEitherVoidFallback();
    registerEitherFallback<String?>();
    registerEitherFallback<PromotionResult>();
  });

  setUp(() {
    final param = BookCursor();
    mockCarRepo = MockBookRepo();
    container = ProviderContainer(
      overrides: [
        bookControllerProvider.overrideWith(() {
          return BookController.test(bookRepo: mockCarRepo);
        }),
        companyBookedProvider(param).overrideWith(() {
          return FakeCompanyBookController();
        }),
        searchBooksProvider.overrideWith(() => FakeSearchBooks()),
      ],
    );
  });

  group('Company book controller Tests ...', () {
    test("[Company] success when Update Book", () async {
      when(mockCarRepo.updateBook(any)).thenAnswer((_) async => Right(null));
      final controller = container.read(bookControllerProvider.notifier);
      expect(controller.state, isA<BookInitial>());
      final param = NewBooking(carId: "A", companyId: "A", bookId: "A");
      final family = BookCursor();
      final book = BookData.book();
      final future = controller.updateBook(param, family, book);
      expect(controller.state, isA<UpdateBookLoading>());
      await future;
      expect(controller.state, isA<UpdateBookCompleted>());
      verify(mockCarRepo.updateBook(param)).called(1);
    });

    test("[Company] fail when Update Book", () async {
      when(mockCarRepo.updateBook(any)).thenAnswer(failureAnswer());
      final controller = container.read(bookControllerProvider.notifier);
      expect(controller.state, isA<BookInitial>());
      final param = NewBooking(carId: "A", companyId: "A");
      final family = BookCursor();
      final book = BookData.book();
      final future = controller.updateBook(param, family, book);

      expect(controller.state, isA<UpdateBookLoading>());
      await future;
      expect(controller.state, isA<UpdateBookFailed>());
      verify(mockCarRepo.updateBook(param)).called(1);
    });
  });

  group("[User] book Controller Tests ...", () {
    test("[Should success when book a Car]", () async {
      final param = NewBooking();
      when(mockCarRepo.bookCar(any)).thenAnswer((_) async => Right(null));
      final controller = container.read(bookControllerProvider.notifier);
      expect(controller.state, isA<BookInitial>());
      final future = controller.bookCar(param);
      expect(controller.state, isA<NewBookLoading>());
      await future;
      expect(controller.state, isA<NewBookCompleted>());
      verify(mockCarRepo.bookCar(param)).called(1);
    });

    test("[Should fail when book a Car]", () async {
      when(mockCarRepo.bookCar(any)).thenAnswer(failureAnswer());
      final param = NewBooking(carId: "A", companyId: "A");
      final controller = container.read(bookControllerProvider.notifier);
      expect(controller.state, isA<BookInitial>());
      final future = controller.bookCar(param);
      expect(controller.state, isA<NewBookLoading>());
      await future;
      expect(controller.state, isA<NewBookFailed>());
      verify(mockCarRepo.bookCar(param)).called(1);
    });

    test("[Should Success whne Apply Promo Code]", () async {
      final param = BookData.promoCode();
      final expectedData = BookData.promotionResult();
      when(
        mockCarRepo.applyPromoCode(any),
      ).thenAnswer((_) async => Right(expectedData));
      final controller = container.read(bookControllerProvider.notifier);
      expect(controller.state, isA<BookInitial>());
      final future = controller.applyPromoCode(param);
      expect(controller.state, isA<ApplyPromotionLoading>());
      await future;
      expect(controller.state, isA<ApplyPromotionCompleted>());
      verify(mockCarRepo.applyPromoCode(param)).called(1);
    });

    test("[Should fail when Apply Promo Code]", () async {
      when(mockCarRepo.applyPromoCode(any)).thenAnswer(failureAnswer());
      final param = BookData.promoCode();
      final controller = container.read(bookControllerProvider.notifier);
      expect(controller.state, isA<BookInitial>());
      final future = controller.applyPromoCode(param);
      expect(controller.state, isA<ApplyPromotionLoading>());
      await future;
      expect(controller.state, isA<ApplyPromotionFailed>());
      verify(mockCarRepo.applyPromoCode(param)).called(1);
    });
  });
}
