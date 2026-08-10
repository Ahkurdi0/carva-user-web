import 'package:kcars/core/services/api_service.dart';
import 'package:kcars/core/services/info.dart';
import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/features/booking/data/model/book.dart';
import 'package:kcars/features/booking/data/model/book_cursor.dart';
import 'package:kcars/features/booking/data/model/new_booking.dart';
import 'package:kcars/features/booking/data/model/promo_code.dart';
import 'package:kcars/features/booking/data/model/promotion_result.dart';
import 'package:kcars/features/company/data/model/contact_statistic.dart';

abstract class BookRemote {
  Future<String?> bookCar([NewBooking? param]);
  Future<PromotionResult> applyPromoCode(PromoCode param);
  Future<void> cancelUserBooks([NewBooking? param]);
  Future<List<Book>> getBooks([BookCursor? param]);
  Future<List<Book>> allBooks([BookCursor? param]);
  Future<List<Book>> getCompanyBooks([BookCursor? param]);
  Future<void> updateBook([NewBooking? param]);
  Future<String?> contact(ContactStatistic param);
}

class BookRemoteImpl implements BookRemote {
  BookRemoteImpl(this._apiService);
  final ApiService _apiService;
  final userUrl = Info.user;
  final companyUrl = Info.company;
  final adminUrl = Info.admin;

  @override
  Future<String?> bookCar([NewBooking? param]) async {
    return await _apiService.post(
      "$userUrl/bookCar",
      data: param?.cleanedMap(),
    );
  }

  @override
  Future<PromotionResult> applyPromoCode(PromoCode param) async {
    return await _apiService.post(
      "$userUrl/applyPromoCode",
      data: param.toMap(),
      fromMap: (data) => PromotionResultMapper.fromMap(data),
    );
  }

  @override
  Future<void> cancelUserBooks([NewBooking? param]) async {
    return await _apiService.post(
      "$userUrl/cancelBook",
      data: {"id": param?.bookId},
    );
  }

  @override
  Future<List<Book>> getBooks([BookCursor? param]) async {
    return await _apiService.post(
      "$userUrl/booked",
      data: param?.cleanedMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((book) => BookMapper.fromMap(book)).toList(),
    );
  }

  @override
  Future<List<Book>> getCompanyBooks([BookCursor? param]) async {
    return await _apiService.post(
      "$companyUrl/booked",
      data: param?.cleanedMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((book) => BookMapper.fromMap(book)).toList(),
    );
  }

  @override
  Future<void> updateBook([NewBooking? param]) async {
    return await _apiService.post(
      "$companyUrl/updateBook",
      data: param?.cleanedMap(),
    );
  }

  @override
  Future<List<Book>> allBooks([BookCursor? param]) async {
    return await _apiService.post(
      "$adminUrl/allBooks",
      data: param?.cleanedMap(),
      fromMap: (data) =>
          List.from(data).map((book) => BookMapper.fromMap(book)).toList(),
    );
  }

  @override
  Future<String?> contact(ContactStatistic param) async {
    return await _apiService.post("$userUrl/contact", data: param.cleanedMap());
  }
}
