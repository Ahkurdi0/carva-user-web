// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'cursor_review.dart';

class CursorReviewMapper extends ClassMapperBase<CursorReview> {
  CursorReviewMapper._();

  static CursorReviewMapper? _instance;
  static CursorReviewMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CursorReviewMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CursorReview';

  static String _$id(CursorReview v) => v.id;
  static const Field<CursorReview, String> _f$id = Field('id', _$id);
  static String? _$cursor(CursorReview v) => v.cursor;
  static const Field<CursorReview, String> _f$cursor =
      Field('cursor', _$cursor, opt: true);

  @override
  final MappableFields<CursorReview> fields = const {
    #id: _f$id,
    #cursor: _f$cursor,
  };

  static CursorReview _instantiate(DecodingData data) {
    return CursorReview(id: data.dec(_f$id), cursor: data.dec(_f$cursor));
  }

  @override
  final Function instantiate = _instantiate;

  static CursorReview fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CursorReview>(map);
  }

  static CursorReview fromJson(String json) {
    return ensureInitialized().decodeJson<CursorReview>(json);
  }
}

mixin CursorReviewMappable {
  String toJson() {
    return CursorReviewMapper.ensureInitialized()
        .encodeJson<CursorReview>(this as CursorReview);
  }

  Map<String, dynamic> toMap() {
    return CursorReviewMapper.ensureInitialized()
        .encodeMap<CursorReview>(this as CursorReview);
  }

  CursorReviewCopyWith<CursorReview, CursorReview, CursorReview> get copyWith =>
      _CursorReviewCopyWithImpl<CursorReview, CursorReview>(
          this as CursorReview, $identity, $identity);
  @override
  String toString() {
    return CursorReviewMapper.ensureInitialized()
        .stringifyValue(this as CursorReview);
  }

  @override
  bool operator ==(Object other) {
    return CursorReviewMapper.ensureInitialized()
        .equalsValue(this as CursorReview, other);
  }

  @override
  int get hashCode {
    return CursorReviewMapper.ensureInitialized()
        .hashValue(this as CursorReview);
  }
}

extension CursorReviewValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CursorReview, $Out> {
  CursorReviewCopyWith<$R, CursorReview, $Out> get $asCursorReview =>
      $base.as((v, t, t2) => _CursorReviewCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CursorReviewCopyWith<$R, $In extends CursorReview, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? cursor});
  CursorReviewCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CursorReviewCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CursorReview, $Out>
    implements CursorReviewCopyWith<$R, CursorReview, $Out> {
  _CursorReviewCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CursorReview> $mapper =
      CursorReviewMapper.ensureInitialized();
  @override
  $R call({String? id, Object? cursor = $none}) => $apply(FieldCopyWithData(
      {if (id != null) #id: id, if (cursor != $none) #cursor: cursor}));
  @override
  CursorReview $make(CopyWithData data) => CursorReview(
      id: data.get(#id, or: $value.id),
      cursor: data.get(#cursor, or: $value.cursor));

  @override
  CursorReviewCopyWith<$R2, CursorReview, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CursorReviewCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AllCursorReviewMapper extends ClassMapperBase<AllCursorReview> {
  AllCursorReviewMapper._();

  static AllCursorReviewMapper? _instance;
  static AllCursorReviewMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AllCursorReviewMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AllCursorReview';

  static String? _$id(AllCursorReview v) => v.id;
  static const Field<AllCursorReview, String> _f$id =
      Field('id', _$id, opt: true);
  static String? _$cursor(AllCursorReview v) => v.cursor;
  static const Field<AllCursorReview, String> _f$cursor =
      Field('cursor', _$cursor, opt: true);
  static String? _$userId(AllCursorReview v) => v.userId;
  static const Field<AllCursorReview, String> _f$userId =
      Field('userId', _$userId, opt: true);

  @override
  final MappableFields<AllCursorReview> fields = const {
    #id: _f$id,
    #cursor: _f$cursor,
    #userId: _f$userId,
  };

  static AllCursorReview _instantiate(DecodingData data) {
    return AllCursorReview(
        id: data.dec(_f$id),
        cursor: data.dec(_f$cursor),
        userId: data.dec(_f$userId));
  }

  @override
  final Function instantiate = _instantiate;

  static AllCursorReview fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AllCursorReview>(map);
  }

  static AllCursorReview fromJson(String json) {
    return ensureInitialized().decodeJson<AllCursorReview>(json);
  }
}

mixin AllCursorReviewMappable {
  String toJson() {
    return AllCursorReviewMapper.ensureInitialized()
        .encodeJson<AllCursorReview>(this as AllCursorReview);
  }

  Map<String, dynamic> toMap() {
    return AllCursorReviewMapper.ensureInitialized()
        .encodeMap<AllCursorReview>(this as AllCursorReview);
  }

  AllCursorReviewCopyWith<AllCursorReview, AllCursorReview, AllCursorReview>
      get copyWith =>
          _AllCursorReviewCopyWithImpl<AllCursorReview, AllCursorReview>(
              this as AllCursorReview, $identity, $identity);
  @override
  String toString() {
    return AllCursorReviewMapper.ensureInitialized()
        .stringifyValue(this as AllCursorReview);
  }

  @override
  bool operator ==(Object other) {
    return AllCursorReviewMapper.ensureInitialized()
        .equalsValue(this as AllCursorReview, other);
  }

  @override
  int get hashCode {
    return AllCursorReviewMapper.ensureInitialized()
        .hashValue(this as AllCursorReview);
  }
}

extension AllCursorReviewValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AllCursorReview, $Out> {
  AllCursorReviewCopyWith<$R, AllCursorReview, $Out> get $asAllCursorReview =>
      $base.as((v, t, t2) => _AllCursorReviewCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AllCursorReviewCopyWith<$R, $In extends AllCursorReview, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? cursor, String? userId});
  AllCursorReviewCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AllCursorReviewCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AllCursorReview, $Out>
    implements AllCursorReviewCopyWith<$R, AllCursorReview, $Out> {
  _AllCursorReviewCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AllCursorReview> $mapper =
      AllCursorReviewMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          Object? cursor = $none,
          Object? userId = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (cursor != $none) #cursor: cursor,
        if (userId != $none) #userId: userId
      }));
  @override
  AllCursorReview $make(CopyWithData data) => AllCursorReview(
      id: data.get(#id, or: $value.id),
      cursor: data.get(#cursor, or: $value.cursor),
      userId: data.get(#userId, or: $value.userId));

  @override
  AllCursorReviewCopyWith<$R2, AllCursorReview, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AllCursorReviewCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CursorReviewFlagsMapper extends ClassMapperBase<CursorReviewFlags> {
  CursorReviewFlagsMapper._();

  static CursorReviewFlagsMapper? _instance;
  static CursorReviewFlagsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CursorReviewFlagsMapper._());
      ReviewStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CursorReviewFlags';

  static ReviewStatus? _$status(CursorReviewFlags v) => v.status;
  static const Field<CursorReviewFlags, ReviewStatus> _f$status =
      Field('status', _$status, opt: true);
  static String? _$cursor(CursorReviewFlags v) => v.cursor;
  static const Field<CursorReviewFlags, String> _f$cursor =
      Field('cursor', _$cursor, opt: true);

  @override
  final MappableFields<CursorReviewFlags> fields = const {
    #status: _f$status,
    #cursor: _f$cursor,
  };

  static CursorReviewFlags _instantiate(DecodingData data) {
    return CursorReviewFlags(
        status: data.dec(_f$status), cursor: data.dec(_f$cursor));
  }

  @override
  final Function instantiate = _instantiate;

  static CursorReviewFlags fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CursorReviewFlags>(map);
  }

  static CursorReviewFlags fromJson(String json) {
    return ensureInitialized().decodeJson<CursorReviewFlags>(json);
  }
}

mixin CursorReviewFlagsMappable {
  String toJson() {
    return CursorReviewFlagsMapper.ensureInitialized()
        .encodeJson<CursorReviewFlags>(this as CursorReviewFlags);
  }

  Map<String, dynamic> toMap() {
    return CursorReviewFlagsMapper.ensureInitialized()
        .encodeMap<CursorReviewFlags>(this as CursorReviewFlags);
  }

  CursorReviewFlagsCopyWith<CursorReviewFlags, CursorReviewFlags,
          CursorReviewFlags>
      get copyWith =>
          _CursorReviewFlagsCopyWithImpl<CursorReviewFlags, CursorReviewFlags>(
              this as CursorReviewFlags, $identity, $identity);
  @override
  String toString() {
    return CursorReviewFlagsMapper.ensureInitialized()
        .stringifyValue(this as CursorReviewFlags);
  }

  @override
  bool operator ==(Object other) {
    return CursorReviewFlagsMapper.ensureInitialized()
        .equalsValue(this as CursorReviewFlags, other);
  }

  @override
  int get hashCode {
    return CursorReviewFlagsMapper.ensureInitialized()
        .hashValue(this as CursorReviewFlags);
  }
}

extension CursorReviewFlagsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CursorReviewFlags, $Out> {
  CursorReviewFlagsCopyWith<$R, CursorReviewFlags, $Out>
      get $asCursorReviewFlags => $base
          .as((v, t, t2) => _CursorReviewFlagsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CursorReviewFlagsCopyWith<$R, $In extends CursorReviewFlags,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({ReviewStatus? status, String? cursor});
  CursorReviewFlagsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CursorReviewFlagsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CursorReviewFlags, $Out>
    implements CursorReviewFlagsCopyWith<$R, CursorReviewFlags, $Out> {
  _CursorReviewFlagsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CursorReviewFlags> $mapper =
      CursorReviewFlagsMapper.ensureInitialized();
  @override
  $R call({Object? status = $none, Object? cursor = $none}) =>
      $apply(FieldCopyWithData({
        if (status != $none) #status: status,
        if (cursor != $none) #cursor: cursor
      }));
  @override
  CursorReviewFlags $make(CopyWithData data) => CursorReviewFlags(
      status: data.get(#status, or: $value.status),
      cursor: data.get(#cursor, or: $value.cursor));

  @override
  CursorReviewFlagsCopyWith<$R2, CursorReviewFlags, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CursorReviewFlagsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
