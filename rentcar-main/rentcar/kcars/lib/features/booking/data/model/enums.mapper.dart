// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'enums.dart';

class BookStatusMapper extends EnumMapper<BookStatus> {
  BookStatusMapper._();

  static BookStatusMapper? _instance;
  static BookStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BookStatusMapper._());
    }
    return _instance!;
  }

  static BookStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  BookStatus decode(dynamic value) {
    switch (value) {
      case r'pending':
        return BookStatus.pending;
      case r'ongoing':
        return BookStatus.ongoing;
      case r'canceled':
        return BookStatus.canceled;
      case r'refunded':
        return BookStatus.refunded;
      case r'rejected':
        return BookStatus.rejected;
      case r'completed':
        return BookStatus.completed;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(BookStatus self) {
    switch (self) {
      case BookStatus.pending:
        return r'pending';
      case BookStatus.ongoing:
        return r'ongoing';
      case BookStatus.canceled:
        return r'canceled';
      case BookStatus.refunded:
        return r'refunded';
      case BookStatus.rejected:
        return r'rejected';
      case BookStatus.completed:
        return r'completed';
    }
  }
}

extension BookStatusMapperExtension on BookStatus {
  String toValue() {
    BookStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<BookStatus>(this) as String;
  }
}
