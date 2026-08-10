// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'car_review_flag.dart';

class CarReviewFlagMapper extends ClassMapperBase<CarReviewFlag> {
  CarReviewFlagMapper._();

  static CarReviewFlagMapper? _instance;
  static CarReviewFlagMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CarReviewFlagMapper._());
      CarMapper.ensureInitialized();
      CompanyMapper.ensureInitialized();
      CarReviewMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CarReviewFlag';

  static String _$id(CarReviewFlag v) => v.id;
  static const Field<CarReviewFlag, String> _f$id = Field('id', _$id);
  static String _$reviewId(CarReviewFlag v) => v.reviewId;
  static const Field<CarReviewFlag, String> _f$reviewId =
      Field('reviewId', _$reviewId);
  static DateTime _$flaggedAt(CarReviewFlag v) => v.flaggedAt;
  static const Field<CarReviewFlag, DateTime> _f$flaggedAt =
      Field('flaggedAt', _$flaggedAt);
  static Car? _$car(CarReviewFlag v) => v.car;
  static const Field<CarReviewFlag, Car> _f$car =
      Field('car', _$car, opt: true);
  static Company? _$company(CarReviewFlag v) => v.company;
  static const Field<CarReviewFlag, Company> _f$company =
      Field('company', _$company, opt: true);
  static CarReview? _$review(CarReviewFlag v) => v.review;
  static const Field<CarReviewFlag, CarReview> _f$review =
      Field('review', _$review, opt: true);

  @override
  final MappableFields<CarReviewFlag> fields = const {
    #id: _f$id,
    #reviewId: _f$reviewId,
    #flaggedAt: _f$flaggedAt,
    #car: _f$car,
    #company: _f$company,
    #review: _f$review,
  };

  static CarReviewFlag _instantiate(DecodingData data) {
    return CarReviewFlag(
        id: data.dec(_f$id),
        reviewId: data.dec(_f$reviewId),
        flaggedAt: data.dec(_f$flaggedAt),
        car: data.dec(_f$car),
        company: data.dec(_f$company),
        review: data.dec(_f$review));
  }

  @override
  final Function instantiate = _instantiate;

  static CarReviewFlag fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CarReviewFlag>(map);
  }

  static CarReviewFlag fromJson(String json) {
    return ensureInitialized().decodeJson<CarReviewFlag>(json);
  }
}

mixin CarReviewFlagMappable {
  String toJson() {
    return CarReviewFlagMapper.ensureInitialized()
        .encodeJson<CarReviewFlag>(this as CarReviewFlag);
  }

  Map<String, dynamic> toMap() {
    return CarReviewFlagMapper.ensureInitialized()
        .encodeMap<CarReviewFlag>(this as CarReviewFlag);
  }

  CarReviewFlagCopyWith<CarReviewFlag, CarReviewFlag, CarReviewFlag>
      get copyWith => _CarReviewFlagCopyWithImpl<CarReviewFlag, CarReviewFlag>(
          this as CarReviewFlag, $identity, $identity);
  @override
  String toString() {
    return CarReviewFlagMapper.ensureInitialized()
        .stringifyValue(this as CarReviewFlag);
  }

  @override
  bool operator ==(Object other) {
    return CarReviewFlagMapper.ensureInitialized()
        .equalsValue(this as CarReviewFlag, other);
  }

  @override
  int get hashCode {
    return CarReviewFlagMapper.ensureInitialized()
        .hashValue(this as CarReviewFlag);
  }
}

extension CarReviewFlagValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CarReviewFlag, $Out> {
  CarReviewFlagCopyWith<$R, CarReviewFlag, $Out> get $asCarReviewFlag =>
      $base.as((v, t, t2) => _CarReviewFlagCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CarReviewFlagCopyWith<$R, $In extends CarReviewFlag, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CarCopyWith<$R, Car, Car>? get car;
  CompanyCopyWith<$R, Company, Company>? get company;
  CarReviewCopyWith<$R, CarReview, CarReview>? get review;
  $R call(
      {String? id,
      String? reviewId,
      DateTime? flaggedAt,
      Car? car,
      Company? company,
      CarReview? review});
  CarReviewFlagCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CarReviewFlagCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CarReviewFlag, $Out>
    implements CarReviewFlagCopyWith<$R, CarReviewFlag, $Out> {
  _CarReviewFlagCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CarReviewFlag> $mapper =
      CarReviewFlagMapper.ensureInitialized();
  @override
  CarCopyWith<$R, Car, Car>? get car =>
      $value.car?.copyWith.$chain((v) => call(car: v));
  @override
  CompanyCopyWith<$R, Company, Company>? get company =>
      $value.company?.copyWith.$chain((v) => call(company: v));
  @override
  CarReviewCopyWith<$R, CarReview, CarReview>? get review =>
      $value.review?.copyWith.$chain((v) => call(review: v));
  @override
  $R call(
          {String? id,
          String? reviewId,
          DateTime? flaggedAt,
          Object? car = $none,
          Object? company = $none,
          Object? review = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (reviewId != null) #reviewId: reviewId,
        if (flaggedAt != null) #flaggedAt: flaggedAt,
        if (car != $none) #car: car,
        if (company != $none) #company: company,
        if (review != $none) #review: review
      }));
  @override
  CarReviewFlag $make(CopyWithData data) => CarReviewFlag(
      id: data.get(#id, or: $value.id),
      reviewId: data.get(#reviewId, or: $value.reviewId),
      flaggedAt: data.get(#flaggedAt, or: $value.flaggedAt),
      car: data.get(#car, or: $value.car),
      company: data.get(#company, or: $value.company),
      review: data.get(#review, or: $value.review));

  @override
  CarReviewFlagCopyWith<$R2, CarReviewFlag, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CarReviewFlagCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
