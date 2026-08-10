// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'review_flag.dart';

class ReviewFlagMapper extends ClassMapperBase<ReviewFlag> {
  ReviewFlagMapper._();

  static ReviewFlagMapper? _instance;
  static ReviewFlagMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ReviewFlagMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ReviewFlag';

  static String? _$carId(ReviewFlag v) => v.carId;
  static const Field<ReviewFlag, String> _f$carId =
      Field('carId', _$carId, opt: true);
  static String? _$companyId(ReviewFlag v) => v.companyId;
  static const Field<ReviewFlag, String> _f$companyId =
      Field('companyId', _$companyId, opt: true);
  static String _$reviewId(ReviewFlag v) => v.reviewId;
  static const Field<ReviewFlag, String> _f$reviewId =
      Field('reviewId', _$reviewId);

  @override
  final MappableFields<ReviewFlag> fields = const {
    #carId: _f$carId,
    #companyId: _f$companyId,
    #reviewId: _f$reviewId,
  };

  static ReviewFlag _instantiate(DecodingData data) {
    return ReviewFlag(
        carId: data.dec(_f$carId),
        companyId: data.dec(_f$companyId),
        reviewId: data.dec(_f$reviewId));
  }

  @override
  final Function instantiate = _instantiate;

  static ReviewFlag fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ReviewFlag>(map);
  }

  static ReviewFlag fromJson(String json) {
    return ensureInitialized().decodeJson<ReviewFlag>(json);
  }
}

mixin ReviewFlagMappable {
  String toJson() {
    return ReviewFlagMapper.ensureInitialized()
        .encodeJson<ReviewFlag>(this as ReviewFlag);
  }

  Map<String, dynamic> toMap() {
    return ReviewFlagMapper.ensureInitialized()
        .encodeMap<ReviewFlag>(this as ReviewFlag);
  }

  ReviewFlagCopyWith<ReviewFlag, ReviewFlag, ReviewFlag> get copyWith =>
      _ReviewFlagCopyWithImpl<ReviewFlag, ReviewFlag>(
          this as ReviewFlag, $identity, $identity);
  @override
  String toString() {
    return ReviewFlagMapper.ensureInitialized()
        .stringifyValue(this as ReviewFlag);
  }

  @override
  bool operator ==(Object other) {
    return ReviewFlagMapper.ensureInitialized()
        .equalsValue(this as ReviewFlag, other);
  }

  @override
  int get hashCode {
    return ReviewFlagMapper.ensureInitialized().hashValue(this as ReviewFlag);
  }
}

extension ReviewFlagValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ReviewFlag, $Out> {
  ReviewFlagCopyWith<$R, ReviewFlag, $Out> get $asReviewFlag =>
      $base.as((v, t, t2) => _ReviewFlagCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ReviewFlagCopyWith<$R, $In extends ReviewFlag, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? carId, String? companyId, String? reviewId});
  ReviewFlagCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ReviewFlagCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ReviewFlag, $Out>
    implements ReviewFlagCopyWith<$R, ReviewFlag, $Out> {
  _ReviewFlagCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ReviewFlag> $mapper =
      ReviewFlagMapper.ensureInitialized();
  @override
  $R call(
          {Object? carId = $none,
          Object? companyId = $none,
          String? reviewId}) =>
      $apply(FieldCopyWithData({
        if (carId != $none) #carId: carId,
        if (companyId != $none) #companyId: companyId,
        if (reviewId != null) #reviewId: reviewId
      }));
  @override
  ReviewFlag $make(CopyWithData data) => ReviewFlag(
      carId: data.get(#carId, or: $value.carId),
      companyId: data.get(#companyId, or: $value.companyId),
      reviewId: data.get(#reviewId, or: $value.reviewId));

  @override
  ReviewFlagCopyWith<$R2, ReviewFlag, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ReviewFlagCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
