// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'updare_review.dart';

class UpdateReviewMapper extends ClassMapperBase<UpdateReview> {
  UpdateReviewMapper._();

  static UpdateReviewMapper? _instance;
  static UpdateReviewMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UpdateReviewMapper._());
      ReviewStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UpdateReview';

  static String _$id(UpdateReview v) => v.id;
  static const Field<UpdateReview, String> _f$id = Field('id', _$id);
  static ReviewStatus _$status(UpdateReview v) => v.status;
  static const Field<UpdateReview, ReviewStatus> _f$status =
      Field('status', _$status);

  @override
  final MappableFields<UpdateReview> fields = const {
    #id: _f$id,
    #status: _f$status,
  };

  static UpdateReview _instantiate(DecodingData data) {
    return UpdateReview(id: data.dec(_f$id), status: data.dec(_f$status));
  }

  @override
  final Function instantiate = _instantiate;

  static UpdateReview fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UpdateReview>(map);
  }

  static UpdateReview fromJson(String json) {
    return ensureInitialized().decodeJson<UpdateReview>(json);
  }
}

mixin UpdateReviewMappable {
  String toJson() {
    return UpdateReviewMapper.ensureInitialized()
        .encodeJson<UpdateReview>(this as UpdateReview);
  }

  Map<String, dynamic> toMap() {
    return UpdateReviewMapper.ensureInitialized()
        .encodeMap<UpdateReview>(this as UpdateReview);
  }

  UpdateReviewCopyWith<UpdateReview, UpdateReview, UpdateReview> get copyWith =>
      _UpdateReviewCopyWithImpl<UpdateReview, UpdateReview>(
          this as UpdateReview, $identity, $identity);
  @override
  String toString() {
    return UpdateReviewMapper.ensureInitialized()
        .stringifyValue(this as UpdateReview);
  }

  @override
  bool operator ==(Object other) {
    return UpdateReviewMapper.ensureInitialized()
        .equalsValue(this as UpdateReview, other);
  }

  @override
  int get hashCode {
    return UpdateReviewMapper.ensureInitialized()
        .hashValue(this as UpdateReview);
  }
}

extension UpdateReviewValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UpdateReview, $Out> {
  UpdateReviewCopyWith<$R, UpdateReview, $Out> get $asUpdateReview =>
      $base.as((v, t, t2) => _UpdateReviewCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UpdateReviewCopyWith<$R, $In extends UpdateReview, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, ReviewStatus? status});
  UpdateReviewCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UpdateReviewCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UpdateReview, $Out>
    implements UpdateReviewCopyWith<$R, UpdateReview, $Out> {
  _UpdateReviewCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UpdateReview> $mapper =
      UpdateReviewMapper.ensureInitialized();
  @override
  $R call({String? id, ReviewStatus? status}) => $apply(FieldCopyWithData(
      {if (id != null) #id: id, if (status != null) #status: status}));
  @override
  UpdateReview $make(CopyWithData data) => UpdateReview(
      id: data.get(#id, or: $value.id),
      status: data.get(#status, or: $value.status));

  @override
  UpdateReviewCopyWith<$R2, UpdateReview, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UpdateReviewCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
