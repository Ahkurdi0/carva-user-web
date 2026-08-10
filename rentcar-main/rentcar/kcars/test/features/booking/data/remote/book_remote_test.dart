import 'package:flutter_test/flutter_test.dart';
import 'package:kcars/core/services/info.dart';
import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/features/booking/data/model/book.dart';
import 'package:kcars/features/booking/data/model/book_cursor.dart';
import 'package:kcars/features/booking/data/model/enums.dart';
import 'package:kcars/features/booking/data/model/new_booking.dart';
import 'package:kcars/features/booking/data/model/promo_code.dart';
import 'package:kcars/features/booking/data/model/promotion_result.dart';
import 'package:kcars/features/booking/data/remote/book_remote.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper_tests.dart';
import '../../../../utils.dart';

import '../../../api_service_mocks.mocks.dart';
import '../../book_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockApiService mockApiService;
  late BookRemote bookRemote;

  setUp(() {
    mockApiService = MockApiService();
    bookRemote = BookRemoteImpl(mockApiService);
  });
  group('[User Book Test]', () {
    test("[Should success when book A Car]", () async {
      final url = "${Info.user}/bookCar";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async => "A");
      final params = NewBooking(
        carId: "A",
        companyId: "A",
        planId: "A",
        rentalPlanId: "A",
      );
      final result = await bookRemote.bookCar(params);
      expect(result, equals("A"));
      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Fail when book A Car]", () async {
      final url = "${Info.user}/bookCar";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      final params = NewBooking(
        carId: "A",
        companyId: "A",
        planId: "A",
        rentalPlanId: "A",
      );
      expectApiException(() => bookRemote.bookCar(params));
      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Success when apply promo code return discount]", () async {
      final url = "${Info.user}/applyPromoCode";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap]
                as PromotionResult Function(dynamic);
        final data = await loadJsonData("promotion_result");

        return fromMap(data);
      });

      final params = PromoCode(
        carId: "A",
        companyId: "A",
        endDate: DateTime.now().toUtc(),
        planId: "A",
        rentalPlanId: "A",
        startDate: DateTime.now().add(Duration(days: 10)).toUtc(),
        code: "A",
      );
      final expectData = BookData.promotionResult();
      final result = await bookRemote.applyPromoCode(params);
      expect(result, equals(expectData));
      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should fail when apply promo code]", () async {
      final url = "${Info.user}/applyPromoCode";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      final params = PromoCode(
        carId: "A",
        companyId: "A",
        endDate: DateTime.now().toUtc(),
        planId: "A",
        rentalPlanId: "A",
        startDate: DateTime.now().add(Duration(days: 10)).toUtc(),
        code: "A",
      );
      expectApiException(() => bookRemote.applyPromoCode(params));
      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("Should Return Booked Cars", () async {
      final books = [BookData.book()];
      final url = "${Info.user}/booked";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap] as List<Book> Function(dynamic);
        final cars = await loadJsonData("book");
        final listCars = List<DataMap>.from(cars);
        return fromMap(listCars).toList();
      });
      final params = BookCursor();
      final result = await bookRemote.getBooks(params);

      expect(result, equals(books));

      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Fail when return Booked]", () async {
      final url = "${Info.user}/booked";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      final params = BookCursor();
      expectApiException(() => bookRemote.getBooks(params));
      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should success when cancel a book]", () async {
      final url = "${Info.user}/cancelBook";
      when(
        mockApiService.post(any, data: anyNamed("data")),
      ).thenAnswer((_) async => null);
      final params = NewBooking(carId: "A", companyId: "A");
      await bookRemote.cancelUserBooks(params);
      verify(mockApiService.post(url, data: anyNamed("data"))).called(1);
    });

    test("[Should Fail when cancel a book ]", () async {
      final url = "${Info.user}/cancelBook";
      when(
        mockApiService.post(any, data: anyNamed("data")),
      ).thenThrow(apiException());
      final params = NewBooking(carId: "A", companyId: "A");
      expectApiException(() => bookRemote.cancelUserBooks(params));
      verify(mockApiService.post(url, data: anyNamed("data"))).called(1);
    });
  });

  group("Compnay Book Tests", () {
    test("[Should success when Return Company Books]", () async {
      final url = "${Info.company}/booked";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap] as List<Book> Function(dynamic);
        final books = await loadJsonData("company_book");
        final listBooks = List<DataMap>.from(books);
        return fromMap(listBooks).toList();
      });
      final expectedData = [BookData.companyBook()];
      final param = BookCursor();
      final result = await bookRemote.getCompanyBooks(param);
      expect(result, expectedData);
      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Fail when Return Company Books]", () async {
      final url = "${Info.company}/booked";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      final param = BookCursor();
      expectApiException(() => bookRemote.getCompanyBooks(param));
      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should success when update a Book]", () async {
      final url = "${Info.company}/updateBook";
      when(
        mockApiService.post(any, data: anyNamed("data")),
      ).thenAnswer((_) async => null);
      final params = NewBooking(
        bookId: "A",
        companyId: "A",
        status: BookStatus.canceled,
        cancelReason: "test",
      );
      await bookRemote.updateBook(params);
      verify(mockApiService.post(url, data: anyNamed("data"))).called(1);
    });

    test("[Should Fail when update a Book]", () async {
      final url = "${Info.company}/updateBook";
      when(
        mockApiService.post(any, data: anyNamed("data")),
      ).thenThrow(apiException());
      final params = NewBooking(
        bookId: "A",
        companyId: "A",
        status: BookStatus.canceled,
        cancelReason: "test",
      );
      expectApiException(() => bookRemote.updateBook(params));
      verify(mockApiService.post(url, data: anyNamed("data"))).called(1);
    });
  });

  group("[Admin Books Tests]", () {
    test("[Should success when Return Company Books]", () async {
      final url = "${Info.admin}/allBooks";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap] as List<Book> Function(dynamic);
        final books = await loadJsonData("company_book");
        final listBooks = List<DataMap>.from(books);
        return fromMap(listBooks).toList();
      });
      final expectedData = [BookData.companyBook()];
      final param = BookCursor();
      final result = await bookRemote.allBooks(param);
      expect(result, expectedData);
      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Fail when Return Company Books]", () async {
      final url = "${Info.admin}/allBooks";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      final param = BookCursor();
      expectApiException(() => bookRemote.allBooks(param));
      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });
  });
}
