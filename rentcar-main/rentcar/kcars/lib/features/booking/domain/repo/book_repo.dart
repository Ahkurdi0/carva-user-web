import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/features/booking/data/model/book.dart';
import 'package:kcars/features/booking/data/model/book_cursor.dart';
import 'package:kcars/features/booking/data/model/new_booking.dart';
import 'package:kcars/features/booking/data/model/promo_code.dart';
import 'package:kcars/features/booking/data/model/promotion_result.dart';
import 'package:kcars/features/company/data/model/contact_statistic.dart';

abstract class BookRepo {
  Result<String?> bookCar([NewBooking? param]);
  Result<PromotionResult> applyPromoCode(PromoCode param);
  Result<void> cancelUserBooks([NewBooking? param]);
  Result<List<Book>> getBooks([BookCursor? param]);
  Result<List<Book>> allBooks([BookCursor? param]);
  Result<List<Book>> getCompanyBooks([BookCursor? param]);
  Result<void> updateBook([NewBooking? param]);
  Result<String?> contact(ContactStatistic param);
}
