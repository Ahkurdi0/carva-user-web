// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'book_cursor.dart';

class BookCursorMapper extends ClassMapperBase<BookCursor> {
  BookCursorMapper._();

  static BookCursorMapper? _instance;
  static BookCursorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BookCursorMapper._());
      BookStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BookCursor';

  static String? _$id(BookCursor v) => v.id;
  static const Field<BookCursor, String> _f$id = Field('id', _$id, opt: true);
  static String? _$cursor(BookCursor v) => v.cursor;
  static const Field<BookCursor, String> _f$cursor =
      Field('cursor', _$cursor, opt: true);
  static String? _$companyId(BookCursor v) => v.companyId;
  static const Field<BookCursor, String> _f$companyId =
      Field('companyId', _$companyId, opt: true);
  static BookStatus? _$status(BookCursor v) => v.status;
  static const Field<BookCursor, BookStatus> _f$status =
      Field('status', _$status, opt: true);
  static String? _$search(BookCursor v) => v.search;
  static const Field<BookCursor, String> _f$search =
      Field('search', _$search, opt: true);
  static String? _$userId(BookCursor v) => v.userId;
  static const Field<BookCursor, String> _f$userId =
      Field('userId', _$userId, opt: true);

  @override
  final MappableFields<BookCursor> fields = const {
    #id: _f$id,
    #cursor: _f$cursor,
    #companyId: _f$companyId,
    #status: _f$status,
    #search: _f$search,
    #userId: _f$userId,
  };

  static BookCursor _instantiate(DecodingData data) {
    return BookCursor(
        id: data.dec(_f$id),
        cursor: data.dec(_f$cursor),
        companyId: data.dec(_f$companyId),
        status: data.dec(_f$status),
        search: data.dec(_f$search),
        userId: data.dec(_f$userId));
  }

  @override
  final Function instantiate = _instantiate;

  static BookCursor fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BookCursor>(map);
  }

  static BookCursor fromJson(String json) {
    return ensureInitialized().decodeJson<BookCursor>(json);
  }
}

mixin BookCursorMappable {
  String toJson() {
    return BookCursorMapper.ensureInitialized()
        .encodeJson<BookCursor>(this as BookCursor);
  }

  Map<String, dynamic> toMap() {
    return BookCursorMapper.ensureInitialized()
        .encodeMap<BookCursor>(this as BookCursor);
  }

  BookCursorCopyWith<BookCursor, BookCursor, BookCursor> get copyWith =>
      _BookCursorCopyWithImpl<BookCursor, BookCursor>(
          this as BookCursor, $identity, $identity);
  @override
  String toString() {
    return BookCursorMapper.ensureInitialized()
        .stringifyValue(this as BookCursor);
  }

  @override
  bool operator ==(Object other) {
    return BookCursorMapper.ensureInitialized()
        .equalsValue(this as BookCursor, other);
  }

  @override
  int get hashCode {
    return BookCursorMapper.ensureInitialized().hashValue(this as BookCursor);
  }
}

extension BookCursorValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BookCursor, $Out> {
  BookCursorCopyWith<$R, BookCursor, $Out> get $asBookCursor =>
      $base.as((v, t, t2) => _BookCursorCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BookCursorCopyWith<$R, $In extends BookCursor, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? cursor,
      String? companyId,
      BookStatus? status,
      String? search,
      String? userId});
  BookCursorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BookCursorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BookCursor, $Out>
    implements BookCursorCopyWith<$R, BookCursor, $Out> {
  _BookCursorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BookCursor> $mapper =
      BookCursorMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          Object? cursor = $none,
          Object? companyId = $none,
          Object? status = $none,
          Object? search = $none,
          Object? userId = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (cursor != $none) #cursor: cursor,
        if (companyId != $none) #companyId: companyId,
        if (status != $none) #status: status,
        if (search != $none) #search: search,
        if (userId != $none) #userId: userId
      }));
  @override
  BookCursor $make(CopyWithData data) => BookCursor(
      id: data.get(#id, or: $value.id),
      cursor: data.get(#cursor, or: $value.cursor),
      companyId: data.get(#companyId, or: $value.companyId),
      status: data.get(#status, or: $value.status),
      search: data.get(#search, or: $value.search),
      userId: data.get(#userId, or: $value.userId));

  @override
  BookCursorCopyWith<$R2, BookCursor, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BookCursorCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
