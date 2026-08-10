// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'enums.dart';

class ReviewStatusMapper extends EnumMapper<ReviewStatus> {
  ReviewStatusMapper._();

  static ReviewStatusMapper? _instance;
  static ReviewStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ReviewStatusMapper._());
    }
    return _instance!;
  }

  static ReviewStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ReviewStatus decode(dynamic value) {
    switch (value) {
      case r'pending':
        return ReviewStatus.pending;
      case r'accepted':
        return ReviewStatus.accepted;
      case r'canceled':
        return ReviewStatus.canceled;
      case r'flagged':
        return ReviewStatus.flagged;
      case r'deleted':
        return ReviewStatus.deleted;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ReviewStatus self) {
    switch (self) {
      case ReviewStatus.pending:
        return r'pending';
      case ReviewStatus.accepted:
        return r'accepted';
      case ReviewStatus.canceled:
        return r'canceled';
      case ReviewStatus.flagged:
        return r'flagged';
      case ReviewStatus.deleted:
        return r'deleted';
    }
  }
}

extension ReviewStatusMapperExtension on ReviewStatus {
  String toValue() {
    ReviewStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ReviewStatus>(this) as String;
  }
}
