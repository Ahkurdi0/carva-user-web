// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'review_post.dart';

class ReviewPostMapper extends ClassMapperBase<ReviewPost> {
  ReviewPostMapper._();

  static ReviewPostMapper? _instance;
  static ReviewPostMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ReviewPostMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ReviewPost';

  static String? _$carId(ReviewPost v) => v.carId;
  static const Field<ReviewPost, String> _f$carId =
      Field('carId', _$carId, opt: true);
  static String? _$companyId(ReviewPost v) => v.companyId;
  static const Field<ReviewPost, String> _f$companyId =
      Field('companyId', _$companyId, opt: true);
  static int _$rate(ReviewPost v) => v.rate;
  static const Field<ReviewPost, int> _f$rate = Field('rate', _$rate);
  static String _$desc(ReviewPost v) => v.desc;
  static const Field<ReviewPost, String> _f$desc = Field('desc', _$desc);

  @override
  final MappableFields<ReviewPost> fields = const {
    #carId: _f$carId,
    #companyId: _f$companyId,
    #rate: _f$rate,
    #desc: _f$desc,
  };

  static ReviewPost _instantiate(DecodingData data) {
    return ReviewPost(
        carId: data.dec(_f$carId),
        companyId: data.dec(_f$companyId),
        rate: data.dec(_f$rate),
        desc: data.dec(_f$desc));
  }

  @override
  final Function instantiate = _instantiate;

  static ReviewPost fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ReviewPost>(map);
  }

  static ReviewPost fromJson(String json) {
    return ensureInitialized().decodeJson<ReviewPost>(json);
  }
}

mixin ReviewPostMappable {
  String toJson() {
    return ReviewPostMapper.ensureInitialized()
        .encodeJson<ReviewPost>(this as ReviewPost);
  }

  Map<String, dynamic> toMap() {
    return ReviewPostMapper.ensureInitialized()
        .encodeMap<ReviewPost>(this as ReviewPost);
  }

  ReviewPostCopyWith<ReviewPost, ReviewPost, ReviewPost> get copyWith =>
      _ReviewPostCopyWithImpl<ReviewPost, ReviewPost>(
          this as ReviewPost, $identity, $identity);
  @override
  String toString() {
    return ReviewPostMapper.ensureInitialized()
        .stringifyValue(this as ReviewPost);
  }

  @override
  bool operator ==(Object other) {
    return ReviewPostMapper.ensureInitialized()
        .equalsValue(this as ReviewPost, other);
  }

  @override
  int get hashCode {
    return ReviewPostMapper.ensureInitialized().hashValue(this as ReviewPost);
  }
}

extension ReviewPostValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ReviewPost, $Out> {
  ReviewPostCopyWith<$R, ReviewPost, $Out> get $asReviewPost =>
      $base.as((v, t, t2) => _ReviewPostCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ReviewPostCopyWith<$R, $In extends ReviewPost, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? carId, String? companyId, int? rate, String? desc});
  ReviewPostCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ReviewPostCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ReviewPost, $Out>
    implements ReviewPostCopyWith<$R, ReviewPost, $Out> {
  _ReviewPostCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ReviewPost> $mapper =
      ReviewPostMapper.ensureInitialized();
  @override
  $R call(
          {Object? carId = $none,
          Object? companyId = $none,
          int? rate,
          String? desc}) =>
      $apply(FieldCopyWithData({
        if (carId != $none) #carId: carId,
        if (companyId != $none) #companyId: companyId,
        if (rate != null) #rate: rate,
        if (desc != null) #desc: desc
      }));
  @override
  ReviewPost $make(CopyWithData data) => ReviewPost(
      carId: data.get(#carId, or: $value.carId),
      companyId: data.get(#companyId, or: $value.companyId),
      rate: data.get(#rate, or: $value.rate),
      desc: data.get(#desc, or: $value.desc));

  @override
  ReviewPostCopyWith<$R2, ReviewPost, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ReviewPostCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
