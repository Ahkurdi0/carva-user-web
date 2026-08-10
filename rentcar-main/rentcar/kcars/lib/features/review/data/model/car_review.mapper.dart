// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'car_review.dart';

class CarReviewMapper extends ClassMapperBase<CarReview> {
  CarReviewMapper._();

  static CarReviewMapper? _instance;
  static CarReviewMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CarReviewMapper._());
      CarMapper.ensureInitialized();
      ProfileMapper.ensureInitialized();
      CompanyMapper.ensureInitialized();
      ReviewStatusMapper.ensureInitialized();
      BookMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CarReview';

  static String _$id(CarReview v) => v.id;
  static const Field<CarReview, String> _f$id = Field('id', _$id);
  static String _$desc(CarReview v) => v.desc;
  static const Field<CarReview, String> _f$desc = Field('desc', _$desc);
  static int _$rate(CarReview v) => v.rate;
  static const Field<CarReview, int> _f$rate = Field('rate', _$rate);
  static Car? _$car(CarReview v) => v.car;
  static const Field<CarReview, Car> _f$car = Field('car', _$car, opt: true);
  static Profile? _$profile(CarReview v) => v.profile;
  static const Field<CarReview, Profile> _f$profile =
      Field('profile', _$profile, opt: true);
  static Company? _$company(CarReview v) => v.company;
  static const Field<CarReview, Company> _f$company =
      Field('company', _$company, opt: true);
  static ReviewStatus _$status(CarReview v) => v.status;
  static const Field<CarReview, ReviewStatus> _f$status =
      Field('status', _$status, opt: true, def: ReviewStatus.pending);
  static Book? _$book(CarReview v) => v.book;
  static const Field<CarReview, Book> _f$book =
      Field('book', _$book, opt: true);
  static DateTime _$reviewedAt(CarReview v) => v.reviewedAt;
  static const Field<CarReview, DateTime> _f$reviewedAt =
      Field('reviewedAt', _$reviewedAt);
  static String? _$updatedAt(CarReview v) => v.updatedAt;
  static const Field<CarReview, String> _f$updatedAt =
      Field('updatedAt', _$updatedAt, opt: true);
  static DateTime? _$flaggedAt(CarReview v) => v.flaggedAt;
  static const Field<CarReview, DateTime> _f$flaggedAt =
      Field('flaggedAt', _$flaggedAt, opt: true);
  static int? _$serial(CarReview v) => v.serial;
  static const Field<CarReview, int> _f$serial =
      Field('serial', _$serial, opt: true);
  static String? _$reviewId(CarReview v) => v.reviewId;
  static const Field<CarReview, String> _f$reviewId =
      Field('reviewId', _$reviewId, opt: true);

  @override
  final MappableFields<CarReview> fields = const {
    #id: _f$id,
    #desc: _f$desc,
    #rate: _f$rate,
    #car: _f$car,
    #profile: _f$profile,
    #company: _f$company,
    #status: _f$status,
    #book: _f$book,
    #reviewedAt: _f$reviewedAt,
    #updatedAt: _f$updatedAt,
    #flaggedAt: _f$flaggedAt,
    #serial: _f$serial,
    #reviewId: _f$reviewId,
  };

  static CarReview _instantiate(DecodingData data) {
    return CarReview(
        id: data.dec(_f$id),
        desc: data.dec(_f$desc),
        rate: data.dec(_f$rate),
        car: data.dec(_f$car),
        profile: data.dec(_f$profile),
        company: data.dec(_f$company),
        status: data.dec(_f$status),
        book: data.dec(_f$book),
        reviewedAt: data.dec(_f$reviewedAt),
        updatedAt: data.dec(_f$updatedAt),
        flaggedAt: data.dec(_f$flaggedAt),
        serial: data.dec(_f$serial),
        reviewId: data.dec(_f$reviewId));
  }

  @override
  final Function instantiate = _instantiate;

  static CarReview fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CarReview>(map);
  }

  static CarReview fromJson(String json) {
    return ensureInitialized().decodeJson<CarReview>(json);
  }
}

mixin CarReviewMappable {
  String toJson() {
    return CarReviewMapper.ensureInitialized()
        .encodeJson<CarReview>(this as CarReview);
  }

  Map<String, dynamic> toMap() {
    return CarReviewMapper.ensureInitialized()
        .encodeMap<CarReview>(this as CarReview);
  }

  CarReviewCopyWith<CarReview, CarReview, CarReview> get copyWith =>
      _CarReviewCopyWithImpl<CarReview, CarReview>(
          this as CarReview, $identity, $identity);
  @override
  String toString() {
    return CarReviewMapper.ensureInitialized()
        .stringifyValue(this as CarReview);
  }

  @override
  bool operator ==(Object other) {
    return CarReviewMapper.ensureInitialized()
        .equalsValue(this as CarReview, other);
  }

  @override
  int get hashCode {
    return CarReviewMapper.ensureInitialized().hashValue(this as CarReview);
  }
}

extension CarReviewValueCopy<$R, $Out> on ObjectCopyWith<$R, CarReview, $Out> {
  CarReviewCopyWith<$R, CarReview, $Out> get $asCarReview =>
      $base.as((v, t, t2) => _CarReviewCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CarReviewCopyWith<$R, $In extends CarReview, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CarCopyWith<$R, Car, Car>? get car;
  ProfileCopyWith<$R, Profile, Profile>? get profile;
  CompanyCopyWith<$R, Company, Company>? get company;
  BookCopyWith<$R, Book, Book>? get book;
  $R call(
      {String? id,
      String? desc,
      int? rate,
      Car? car,
      Profile? profile,
      Company? company,
      ReviewStatus? status,
      Book? book,
      DateTime? reviewedAt,
      String? updatedAt,
      DateTime? flaggedAt,
      int? serial,
      String? reviewId});
  CarReviewCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CarReviewCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CarReview, $Out>
    implements CarReviewCopyWith<$R, CarReview, $Out> {
  _CarReviewCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CarReview> $mapper =
      CarReviewMapper.ensureInitialized();
  @override
  CarCopyWith<$R, Car, Car>? get car =>
      $value.car?.copyWith.$chain((v) => call(car: v));
  @override
  ProfileCopyWith<$R, Profile, Profile>? get profile =>
      $value.profile?.copyWith.$chain((v) => call(profile: v));
  @override
  CompanyCopyWith<$R, Company, Company>? get company =>
      $value.company?.copyWith.$chain((v) => call(company: v));
  @override
  BookCopyWith<$R, Book, Book>? get book =>
      $value.book?.copyWith.$chain((v) => call(book: v));
  @override
  $R call(
          {String? id,
          String? desc,
          int? rate,
          Object? car = $none,
          Object? profile = $none,
          Object? company = $none,
          ReviewStatus? status,
          Object? book = $none,
          DateTime? reviewedAt,
          Object? updatedAt = $none,
          Object? flaggedAt = $none,
          Object? serial = $none,
          Object? reviewId = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (desc != null) #desc: desc,
        if (rate != null) #rate: rate,
        if (car != $none) #car: car,
        if (profile != $none) #profile: profile,
        if (company != $none) #company: company,
        if (status != null) #status: status,
        if (book != $none) #book: book,
        if (reviewedAt != null) #reviewedAt: reviewedAt,
        if (updatedAt != $none) #updatedAt: updatedAt,
        if (flaggedAt != $none) #flaggedAt: flaggedAt,
        if (serial != $none) #serial: serial,
        if (reviewId != $none) #reviewId: reviewId
      }));
  @override
  CarReview $make(CopyWithData data) => CarReview(
      id: data.get(#id, or: $value.id),
      desc: data.get(#desc, or: $value.desc),
      rate: data.get(#rate, or: $value.rate),
      car: data.get(#car, or: $value.car),
      profile: data.get(#profile, or: $value.profile),
      company: data.get(#company, or: $value.company),
      status: data.get(#status, or: $value.status),
      book: data.get(#book, or: $value.book),
      reviewedAt: data.get(#reviewedAt, or: $value.reviewedAt),
      updatedAt: data.get(#updatedAt, or: $value.updatedAt),
      flaggedAt: data.get(#flaggedAt, or: $value.flaggedAt),
      serial: data.get(#serial, or: $value.serial),
      reviewId: data.get(#reviewId, or: $value.reviewId));

  @override
  CarReviewCopyWith<$R2, CarReview, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CarReviewCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
