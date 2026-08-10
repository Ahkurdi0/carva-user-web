// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'booked_dates.dart';

class BookedDatesMapper extends ClassMapperBase<BookedDates> {
  BookedDatesMapper._();

  static BookedDatesMapper? _instance;
  static BookedDatesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BookedDatesMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BookedDates';

  static DateTime _$startDate(BookedDates v) => v.startDate;
  static const Field<BookedDates, DateTime> _f$startDate =
      Field('startDate', _$startDate);
  static DateTime _$endDate(BookedDates v) => v.endDate;
  static const Field<BookedDates, DateTime> _f$endDate =
      Field('endDate', _$endDate);

  @override
  final MappableFields<BookedDates> fields = const {
    #startDate: _f$startDate,
    #endDate: _f$endDate,
  };

  static BookedDates _instantiate(DecodingData data) {
    return BookedDates(
        startDate: data.dec(_f$startDate), endDate: data.dec(_f$endDate));
  }

  @override
  final Function instantiate = _instantiate;

  static BookedDates fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BookedDates>(map);
  }

  static BookedDates fromJson(String json) {
    return ensureInitialized().decodeJson<BookedDates>(json);
  }
}

mixin BookedDatesMappable {
  String toJson() {
    return BookedDatesMapper.ensureInitialized()
        .encodeJson<BookedDates>(this as BookedDates);
  }

  Map<String, dynamic> toMap() {
    return BookedDatesMapper.ensureInitialized()
        .encodeMap<BookedDates>(this as BookedDates);
  }

  BookedDatesCopyWith<BookedDates, BookedDates, BookedDates> get copyWith =>
      _BookedDatesCopyWithImpl<BookedDates, BookedDates>(
          this as BookedDates, $identity, $identity);
  @override
  String toString() {
    return BookedDatesMapper.ensureInitialized()
        .stringifyValue(this as BookedDates);
  }

  @override
  bool operator ==(Object other) {
    return BookedDatesMapper.ensureInitialized()
        .equalsValue(this as BookedDates, other);
  }

  @override
  int get hashCode {
    return BookedDatesMapper.ensureInitialized().hashValue(this as BookedDates);
  }
}

extension BookedDatesValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BookedDates, $Out> {
  BookedDatesCopyWith<$R, BookedDates, $Out> get $asBookedDates =>
      $base.as((v, t, t2) => _BookedDatesCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BookedDatesCopyWith<$R, $In extends BookedDates, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({DateTime? startDate, DateTime? endDate});
  BookedDatesCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BookedDatesCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BookedDates, $Out>
    implements BookedDatesCopyWith<$R, BookedDates, $Out> {
  _BookedDatesCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BookedDates> $mapper =
      BookedDatesMapper.ensureInitialized();
  @override
  $R call({DateTime? startDate, DateTime? endDate}) =>
      $apply(FieldCopyWithData({
        if (startDate != null) #startDate: startDate,
        if (endDate != null) #endDate: endDate
      }));
  @override
  BookedDates $make(CopyWithData data) => BookedDates(
      startDate: data.get(#startDate, or: $value.startDate),
      endDate: data.get(#endDate, or: $value.endDate));

  @override
  BookedDatesCopyWith<$R2, BookedDates, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BookedDatesCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
