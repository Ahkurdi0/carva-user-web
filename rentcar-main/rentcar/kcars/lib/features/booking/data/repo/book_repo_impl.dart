import 'package:fpdart/fpdart.dart';
import 'package:kcars/configs/error/exception.dart';
import 'package:kcars/configs/error/failure.dart';
import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/features/booking/data/model/book.dart';
import 'package:kcars/features/booking/data/model/book_cursor.dart';
import 'package:kcars/features/booking/data/model/new_booking.dart';
import 'package:kcars/features/booking/data/model/promo_code.dart';
import 'package:kcars/features/booking/data/model/promotion_result.dart';
import 'package:kcars/features/booking/data/remote/book_remote.dart';
import 'package:kcars/features/booking/domain/repo/book_repo.dart';
import 'package:kcars/features/company/data/model/contact_statistic.dart';

class BookRepoImpl implements BookRepo {
  BookRepoImpl(this._bookRemote);
  final BookRemote _bookRemote;

  @override
  Result<PromotionResult> applyPromoCode(PromoCode param) async {
    try {
      final result = await _bookRemote.applyPromoCode(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<String?> bookCar([NewBooking? param]) async {
    try {
      final result = await _bookRemote.bookCar(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> cancelUserBooks([NewBooking? param]) async {
    try {
      final result = await _bookRemote.cancelUserBooks(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Book>> getBooks([BookCursor? param]) async {
    try {
      final result = await _bookRemote.getBooks(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Book>> getCompanyBooks([BookCursor? param]) async {
    try {
      final result = await _bookRemote.getCompanyBooks(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> updateBook([NewBooking? param]) async {
    try {
      final result = await _bookRemote.updateBook(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Book>> allBooks([BookCursor? param]) async {
    try {
      final result = await _bookRemote.allBooks(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<String?> contact(ContactStatistic param) async {
    try {
      final result = await _bookRemote.contact(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }
}
