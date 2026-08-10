// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'company_review_flag.dart';

class CompanyReviewFlagMapper extends ClassMapperBase<CompanyReviewFlag> {
  CompanyReviewFlagMapper._();

  static CompanyReviewFlagMapper? _instance;
  static CompanyReviewFlagMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CompanyReviewFlagMapper._());
      CompanyMapper.ensureInitialized();
      CompanyReviewMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CompanyReviewFlag';

  static String _$id(CompanyReviewFlag v) => v.id;
  static const Field<CompanyReviewFlag, String> _f$id = Field('id', _$id);
  static DateTime _$flaggedAt(CompanyReviewFlag v) => v.flaggedAt;
  static const Field<CompanyReviewFlag, DateTime> _f$flaggedAt =
      Field('flaggedAt', _$flaggedAt);
  static Company? _$company(CompanyReviewFlag v) => v.company;
  static const Field<CompanyReviewFlag, Company> _f$company =
      Field('company', _$company, opt: true);
  static CompanyReview? _$review(CompanyReviewFlag v) => v.review;
  static const Field<CompanyReviewFlag, CompanyReview> _f$review =
      Field('review', _$review, opt: true);

  @override
  final MappableFields<CompanyReviewFlag> fields = const {
    #id: _f$id,
    #flaggedAt: _f$flaggedAt,
    #company: _f$company,
    #review: _f$review,
  };

  static CompanyReviewFlag _instantiate(DecodingData data) {
    return CompanyReviewFlag(
        id: data.dec(_f$id),
        flaggedAt: data.dec(_f$flaggedAt),
        company: data.dec(_f$company),
        review: data.dec(_f$review));
  }

  @override
  final Function instantiate = _instantiate;

  static CompanyReviewFlag fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CompanyReviewFlag>(map);
  }

  static CompanyReviewFlag fromJson(String json) {
    return ensureInitialized().decodeJson<CompanyReviewFlag>(json);
  }
}

mixin CompanyReviewFlagMappable {
  String toJson() {
    return CompanyReviewFlagMapper.ensureInitialized()
        .encodeJson<CompanyReviewFlag>(this as CompanyReviewFlag);
  }

  Map<String, dynamic> toMap() {
    return CompanyReviewFlagMapper.ensureInitialized()
        .encodeMap<CompanyReviewFlag>(this as CompanyReviewFlag);
  }

  CompanyReviewFlagCopyWith<CompanyReviewFlag, CompanyReviewFlag,
          CompanyReviewFlag>
      get copyWith =>
          _CompanyReviewFlagCopyWithImpl<CompanyReviewFlag, CompanyReviewFlag>(
              this as CompanyReviewFlag, $identity, $identity);
  @override
  String toString() {
    return CompanyReviewFlagMapper.ensureInitialized()
        .stringifyValue(this as CompanyReviewFlag);
  }

  @override
  bool operator ==(Object other) {
    return CompanyReviewFlagMapper.ensureInitialized()
        .equalsValue(this as CompanyReviewFlag, other);
  }

  @override
  int get hashCode {
    return CompanyReviewFlagMapper.ensureInitialized()
        .hashValue(this as CompanyReviewFlag);
  }
}

extension CompanyReviewFlagValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CompanyReviewFlag, $Out> {
  CompanyReviewFlagCopyWith<$R, CompanyReviewFlag, $Out>
      get $asCompanyReviewFlag => $base
          .as((v, t, t2) => _CompanyReviewFlagCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CompanyReviewFlagCopyWith<$R, $In extends CompanyReviewFlag,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  CompanyCopyWith<$R, Company, Company>? get company;
  CompanyReviewCopyWith<$R, CompanyReview, CompanyReview>? get review;
  $R call(
      {String? id,
      DateTime? flaggedAt,
      Company? company,
      CompanyReview? review});
  CompanyReviewFlagCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CompanyReviewFlagCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CompanyReviewFlag, $Out>
    implements CompanyReviewFlagCopyWith<$R, CompanyReviewFlag, $Out> {
  _CompanyReviewFlagCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CompanyReviewFlag> $mapper =
      CompanyReviewFlagMapper.ensureInitialized();
  @override
  CompanyCopyWith<$R, Company, Company>? get company =>
      $value.company?.copyWith.$chain((v) => call(company: v));
  @override
  CompanyReviewCopyWith<$R, CompanyReview, CompanyReview>? get review =>
      $value.review?.copyWith.$chain((v) => call(review: v));
  @override
  $R call(
          {String? id,
          DateTime? flaggedAt,
          Object? company = $none,
          Object? review = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (flaggedAt != null) #flaggedAt: flaggedAt,
        if (company != $none) #company: company,
        if (review != $none) #review: review
      }));
  @override
  CompanyReviewFlag $make(CopyWithData data) => CompanyReviewFlag(
      id: data.get(#id, or: $value.id),
      flaggedAt: data.get(#flaggedAt, or: $value.flaggedAt),
      company: data.get(#company, or: $value.company),
      review: data.get(#review, or: $value.review));

  @override
  CompanyReviewFlagCopyWith<$R2, CompanyReviewFlag, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CompanyReviewFlagCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
