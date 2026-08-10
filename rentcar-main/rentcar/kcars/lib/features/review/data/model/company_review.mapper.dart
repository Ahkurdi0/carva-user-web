// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'company_review.dart';

class CompanyReviewMapper extends ClassMapperBase<CompanyReview> {
  CompanyReviewMapper._();

  static CompanyReviewMapper? _instance;
  static CompanyReviewMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CompanyReviewMapper._());
      CompanyMapper.ensureInitialized();
      ProfileMapper.ensureInitialized();
      ReviewStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CompanyReview';

  static String _$id(CompanyReview v) => v.id;
  static const Field<CompanyReview, String> _f$id = Field('id', _$id);
  static String _$desc(CompanyReview v) => v.desc;
  static const Field<CompanyReview, String> _f$desc = Field('desc', _$desc);
  static int _$rate(CompanyReview v) => v.rate;
  static const Field<CompanyReview, int> _f$rate = Field('rate', _$rate);
  static Company? _$company(CompanyReview v) => v.company;
  static const Field<CompanyReview, Company> _f$company =
      Field('company', _$company, opt: true);
  static Profile? _$profile(CompanyReview v) => v.profile;
  static const Field<CompanyReview, Profile> _f$profile =
      Field('profile', _$profile, opt: true);
  static ReviewStatus _$status(CompanyReview v) => v.status;
  static const Field<CompanyReview, ReviewStatus> _f$status =
      Field('status', _$status);
  static DateTime _$reviewedAt(CompanyReview v) => v.reviewedAt;
  static const Field<CompanyReview, DateTime> _f$reviewedAt =
      Field('reviewedAt', _$reviewedAt);
  static DateTime? _$updatedAt(CompanyReview v) => v.updatedAt;
  static const Field<CompanyReview, DateTime> _f$updatedAt =
      Field('updatedAt', _$updatedAt, opt: true);
  static DateTime? _$flaggedAt(CompanyReview v) => v.flaggedAt;
  static const Field<CompanyReview, DateTime> _f$flaggedAt =
      Field('flaggedAt', _$flaggedAt, opt: true);
  static int? _$serial(CompanyReview v) => v.serial;
  static const Field<CompanyReview, int> _f$serial =
      Field('serial', _$serial, opt: true);
  static String? _$reviewId(CompanyReview v) => v.reviewId;
  static const Field<CompanyReview, String> _f$reviewId =
      Field('reviewId', _$reviewId, opt: true);

  @override
  final MappableFields<CompanyReview> fields = const {
    #id: _f$id,
    #desc: _f$desc,
    #rate: _f$rate,
    #company: _f$company,
    #profile: _f$profile,
    #status: _f$status,
    #reviewedAt: _f$reviewedAt,
    #updatedAt: _f$updatedAt,
    #flaggedAt: _f$flaggedAt,
    #serial: _f$serial,
    #reviewId: _f$reviewId,
  };

  static CompanyReview _instantiate(DecodingData data) {
    return CompanyReview(
        id: data.dec(_f$id),
        desc: data.dec(_f$desc),
        rate: data.dec(_f$rate),
        company: data.dec(_f$company),
        profile: data.dec(_f$profile),
        status: data.dec(_f$status),
        reviewedAt: data.dec(_f$reviewedAt),
        updatedAt: data.dec(_f$updatedAt),
        flaggedAt: data.dec(_f$flaggedAt),
        serial: data.dec(_f$serial),
        reviewId: data.dec(_f$reviewId));
  }

  @override
  final Function instantiate = _instantiate;

  static CompanyReview fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CompanyReview>(map);
  }

  static CompanyReview fromJson(String json) {
    return ensureInitialized().decodeJson<CompanyReview>(json);
  }
}

mixin CompanyReviewMappable {
  String toJson() {
    return CompanyReviewMapper.ensureInitialized()
        .encodeJson<CompanyReview>(this as CompanyReview);
  }

  Map<String, dynamic> toMap() {
    return CompanyReviewMapper.ensureInitialized()
        .encodeMap<CompanyReview>(this as CompanyReview);
  }

  CompanyReviewCopyWith<CompanyReview, CompanyReview, CompanyReview>
      get copyWith => _CompanyReviewCopyWithImpl<CompanyReview, CompanyReview>(
          this as CompanyReview, $identity, $identity);
  @override
  String toString() {
    return CompanyReviewMapper.ensureInitialized()
        .stringifyValue(this as CompanyReview);
  }

  @override
  bool operator ==(Object other) {
    return CompanyReviewMapper.ensureInitialized()
        .equalsValue(this as CompanyReview, other);
  }

  @override
  int get hashCode {
    return CompanyReviewMapper.ensureInitialized()
        .hashValue(this as CompanyReview);
  }
}

extension CompanyReviewValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CompanyReview, $Out> {
  CompanyReviewCopyWith<$R, CompanyReview, $Out> get $asCompanyReview =>
      $base.as((v, t, t2) => _CompanyReviewCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CompanyReviewCopyWith<$R, $In extends CompanyReview, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CompanyCopyWith<$R, Company, Company>? get company;
  ProfileCopyWith<$R, Profile, Profile>? get profile;
  $R call(
      {String? id,
      String? desc,
      int? rate,
      Company? company,
      Profile? profile,
      ReviewStatus? status,
      DateTime? reviewedAt,
      DateTime? updatedAt,
      DateTime? flaggedAt,
      int? serial,
      String? reviewId});
  CompanyReviewCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CompanyReviewCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CompanyReview, $Out>
    implements CompanyReviewCopyWith<$R, CompanyReview, $Out> {
  _CompanyReviewCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CompanyReview> $mapper =
      CompanyReviewMapper.ensureInitialized();
  @override
  CompanyCopyWith<$R, Company, Company>? get company =>
      $value.company?.copyWith.$chain((v) => call(company: v));
  @override
  ProfileCopyWith<$R, Profile, Profile>? get profile =>
      $value.profile?.copyWith.$chain((v) => call(profile: v));
  @override
  $R call(
          {String? id,
          String? desc,
          int? rate,
          Object? company = $none,
          Object? profile = $none,
          ReviewStatus? status,
          DateTime? reviewedAt,
          Object? updatedAt = $none,
          Object? flaggedAt = $none,
          Object? serial = $none,
          Object? reviewId = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (desc != null) #desc: desc,
        if (rate != null) #rate: rate,
        if (company != $none) #company: company,
        if (profile != $none) #profile: profile,
        if (status != null) #status: status,
        if (reviewedAt != null) #reviewedAt: reviewedAt,
        if (updatedAt != $none) #updatedAt: updatedAt,
        if (flaggedAt != $none) #flaggedAt: flaggedAt,
        if (serial != $none) #serial: serial,
        if (reviewId != $none) #reviewId: reviewId
      }));
  @override
  CompanyReview $make(CopyWithData data) => CompanyReview(
      id: data.get(#id, or: $value.id),
      desc: data.get(#desc, or: $value.desc),
      rate: data.get(#rate, or: $value.rate),
      company: data.get(#company, or: $value.company),
      profile: data.get(#profile, or: $value.profile),
      status: data.get(#status, or: $value.status),
      reviewedAt: data.get(#reviewedAt, or: $value.reviewedAt),
      updatedAt: data.get(#updatedAt, or: $value.updatedAt),
      flaggedAt: data.get(#flaggedAt, or: $value.flaggedAt),
      serial: data.get(#serial, or: $value.serial),
      reviewId: data.get(#reviewId, or: $value.reviewId));

  @override
  CompanyReviewCopyWith<$R2, CompanyReview, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CompanyReviewCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CompanyReviewDataMapper extends ClassMapperBase<CompanyReviewData> {
  CompanyReviewDataMapper._();

  static CompanyReviewDataMapper? _instance;
  static CompanyReviewDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CompanyReviewDataMapper._());
      CompanyReviewMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CompanyReviewData';

  static List<CompanyReview> _$reviews(CompanyReviewData v) => v.reviews;
  static const Field<CompanyReviewData, List<CompanyReview>> _f$reviews =
      Field('reviews', _$reviews);
  static CompanyReview? _$userReview(CompanyReviewData v) => v.userReview;
  static const Field<CompanyReviewData, CompanyReview> _f$userReview =
      Field('userReview', _$userReview, opt: true);

  @override
  final MappableFields<CompanyReviewData> fields = const {
    #reviews: _f$reviews,
    #userReview: _f$userReview,
  };

  static CompanyReviewData _instantiate(DecodingData data) {
    return CompanyReviewData(
        reviews: data.dec(_f$reviews), userReview: data.dec(_f$userReview));
  }

  @override
  final Function instantiate = _instantiate;

  static CompanyReviewData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CompanyReviewData>(map);
  }

  static CompanyReviewData fromJson(String json) {
    return ensureInitialized().decodeJson<CompanyReviewData>(json);
  }
}

mixin CompanyReviewDataMappable {
  String toJson() {
    return CompanyReviewDataMapper.ensureInitialized()
        .encodeJson<CompanyReviewData>(this as CompanyReviewData);
  }

  Map<String, dynamic> toMap() {
    return CompanyReviewDataMapper.ensureInitialized()
        .encodeMap<CompanyReviewData>(this as CompanyReviewData);
  }

  CompanyReviewDataCopyWith<CompanyReviewData, CompanyReviewData,
          CompanyReviewData>
      get copyWith =>
          _CompanyReviewDataCopyWithImpl<CompanyReviewData, CompanyReviewData>(
              this as CompanyReviewData, $identity, $identity);
  @override
  String toString() {
    return CompanyReviewDataMapper.ensureInitialized()
        .stringifyValue(this as CompanyReviewData);
  }

  @override
  bool operator ==(Object other) {
    return CompanyReviewDataMapper.ensureInitialized()
        .equalsValue(this as CompanyReviewData, other);
  }

  @override
  int get hashCode {
    return CompanyReviewDataMapper.ensureInitialized()
        .hashValue(this as CompanyReviewData);
  }
}

extension CompanyReviewDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CompanyReviewData, $Out> {
  CompanyReviewDataCopyWith<$R, CompanyReviewData, $Out>
      get $asCompanyReviewData => $base
          .as((v, t, t2) => _CompanyReviewDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CompanyReviewDataCopyWith<$R, $In extends CompanyReviewData,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, CompanyReview,
      CompanyReviewCopyWith<$R, CompanyReview, CompanyReview>> get reviews;
  CompanyReviewCopyWith<$R, CompanyReview, CompanyReview>? get userReview;
  $R call({List<CompanyReview>? reviews, CompanyReview? userReview});
  CompanyReviewDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CompanyReviewDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CompanyReviewData, $Out>
    implements CompanyReviewDataCopyWith<$R, CompanyReviewData, $Out> {
  _CompanyReviewDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CompanyReviewData> $mapper =
      CompanyReviewDataMapper.ensureInitialized();
  @override
  ListCopyWith<$R, CompanyReview,
          CompanyReviewCopyWith<$R, CompanyReview, CompanyReview>>
      get reviews => ListCopyWith($value.reviews,
          (v, t) => v.copyWith.$chain(t), (v) => call(reviews: v));
  @override
  CompanyReviewCopyWith<$R, CompanyReview, CompanyReview>? get userReview =>
      $value.userReview?.copyWith.$chain((v) => call(userReview: v));
  @override
  $R call({List<CompanyReview>? reviews, Object? userReview = $none}) =>
      $apply(FieldCopyWithData({
        if (reviews != null) #reviews: reviews,
        if (userReview != $none) #userReview: userReview
      }));
  @override
  CompanyReviewData $make(CopyWithData data) => CompanyReviewData(
      reviews: data.get(#reviews, or: $value.reviews),
      userReview: data.get(#userReview, or: $value.userReview));

  @override
  CompanyReviewDataCopyWith<$R2, CompanyReviewData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CompanyReviewDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
