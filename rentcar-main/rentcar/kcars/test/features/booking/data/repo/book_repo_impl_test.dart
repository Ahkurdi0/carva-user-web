import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kcars/configs/error/exception.dart';
import 'package:kcars/features/booking/data/model/book_cursor.dart';
import 'package:kcars/features/booking/data/model/new_booking.dart';
import 'package:kcars/features/booking/data/repo/book_repo_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper_tests.dart';
import '../../book_data.dart';
import 'book_repo_mocks.mocks.dart';

void main() {
  late MockBookRemote mockBookRemote;
  late BookRepoImpl bookRepoImpl;

  setUpAll(() {
    registerFailureFallback();
    registerEitherFallback();
    // registerEitherListFallback();
  });
  setUp(() {
    mockBookRemote = MockBookRemote();
    bookRepoImpl = BookRepoImpl(mockBookRemote);
  });
  group('User Book Tests', () {
    test("[Should success when book a Car]", () async {
      final param = NewBooking();
      when(mockBookRemote.bookCar(param)).thenAnswer((_) async => null);
      final result = await bookRepoImpl.bookCar(param);
      expectSuccess(result, null);
      verify(mockBookRemote.bookCar(param)).called(1);
    });

    test("[Should fail when book a Car]", () async {
      when(mockBookRemote.bookCar(any)).thenThrow(ApiException.exception());
      final param = NewBooking(carId: "A", companyId: "A");
      final result = await bookRepoImpl.bookCar(param);
      expect(result, isA<Left>());
      expectFailureWithStatusCode(result, 400);
      verify(mockBookRemote.bookCar(param)).called(1);
    });

    test("[Should success when cancel a Car]", () async {
      final param = NewBooking();
      when(
        mockBookRemote.cancelUserBooks(any),
      ).thenAnswer((_) async => Future.value(null));
      final result = await bookRepoImpl.cancelUserBooks(param);
      expectSuccess(result, null);
      verify(mockBookRemote.cancelUserBooks(param)).called(1);
    });

    test("[Should fail when cancel a Car]", () async {
      when(
        mockBookRemote.cancelUserBooks(any),
      ).thenThrow(ApiException.exception());
      final param = NewBooking(carId: "A", companyId: "A");
      final result = await bookRepoImpl.cancelUserBooks(param);
      expect(result, isA<Left>());
      expectFailureWithStatusCode(result, 400);
      verify(mockBookRemote.cancelUserBooks(param)).called(1);
    });

    test("[Should Succes when Apply Promo Code]", () async {
      final expectData = BookData.promotionResult();
      when(
        mockBookRemote.applyPromoCode(any),
      ).thenAnswer((_) async => expectData);
      final param = BookData.promoCode();
      final result = await bookRepoImpl.applyPromoCode(param);
      expectSuccess(result, expectData);
      verify(mockBookRemote.applyPromoCode(param)).called(1);
    });

    test("[Should fail when Apply Promo Code]", () async {
      when(
        mockBookRemote.applyPromoCode(any),
      ).thenThrow(ApiException.exception());
      final param = BookData.promoCode();
      final result = await bookRepoImpl.applyPromoCode(param);
      expectFailureWithStatusCode(result, 400);
      verify(mockBookRemote.applyPromoCode(param)).called(1);
    });

    test("[Should retun List Book]", () async {
      final books = [BookData.book()];
      final param = BookCursor();
      when(mockBookRemote.getBooks(param)).thenAnswer((_) async => books);
      final result = await bookRepoImpl.getBooks(param);
      expect(result.isRight(), true);
      expect(result, equals(Right(books)));
      verify(mockBookRemote.getBooks(param)).called(1);
    });

    test("Should fail when return List Book", () async {
      final param = BookCursor();
      when(mockBookRemote.getBooks(param)).thenThrow(ApiException.exception());
      final result = await bookRepoImpl.getBooks(param);
      expectFailureWithStatusCode(result, 400);
      verify(mockBookRemote.getBooks(param)).called(1);
    });
  });

  group("[Comonay Book Tests]", () {
    test("[Should retun List Book]", () async {
      final books = [BookData.book()];
      final param = BookCursor();
      when(
        mockBookRemote.getCompanyBooks(param),
      ).thenAnswer((_) async => books);
      final result = await bookRepoImpl.getCompanyBooks(param);
      expect(result.isRight(), true);
      expect(result, equals(Right(books)));
      verify(mockBookRemote.getCompanyBooks(param)).called(1);
    });

    test("Should fail when return List Book", () async {
      final param = BookCursor();
      when(
        mockBookRemote.getCompanyBooks(param),
      ).thenThrow(ApiException.exception());
      final result = await bookRepoImpl.getCompanyBooks(param);
      expectFailureWithStatusCode(result, 400);
      verify(mockBookRemote.getCompanyBooks(param)).called(1);
    });

    test("[[Compnay] Should success when update a Book]", () async {
      final param = NewBooking();
      when(
        mockBookRemote.updateBook(param),
      ).thenAnswer((_) async => Future.value(null));
      final result = await bookRepoImpl.updateBook(param);
      expectSuccess(result, null);
      verify(mockBookRemote.updateBook(param)).called(1);
    });

    test("[[Compnay]Should fail when update a Book]", () async {
      when(mockBookRemote.updateBook(any)).thenThrow(ApiException.exception());
      final param = NewBooking(carId: "A", companyId: "A");
      final result = await bookRepoImpl.updateBook(param);
      expect(result, isA<Left>());
      expectFailureWithStatusCode(result, 400);
      verify(mockBookRemote.updateBook(param)).called(1);
    });
  });
}
