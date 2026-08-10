// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'book.dart';

class BookMapper extends ClassMapperBase<Book> {
  BookMapper._();

  static BookMapper? _instance;
  static BookMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BookMapper._());
      ProfileMapper.ensureInitialized();
      CarMapper.ensureInitialized();
      CompanyMapper.ensureInitialized();
      RentalPlanMapper.ensureInitialized();
      BookStatusMapper.ensureInitialized();
      PromotionMapper.ensureInitialized();
      PromotionTypeMapper.ensureInitialized();
      PlanMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Book';

  static String _$id(Book v) => v.id;
  static const Field<Book, String> _f$id = Field('id', _$id);
  static String? _$bookId(Book v) => v.bookId;
  static const Field<Book, String> _f$bookId =
      Field('bookId', _$bookId, opt: true);
  static String? _$userId(Book v) => v.userId;
  static const Field<Book, String> _f$userId =
      Field('userId', _$userId, opt: true);
  static Profile? _$profile(Book v) => v.profile;
  static const Field<Book, Profile> _f$profile =
      Field('profile', _$profile, opt: true);
  static Car? _$car(Book v) => v.car;
  static const Field<Book, Car> _f$car = Field('car', _$car, opt: true);
  static Company? _$company(Book v) => v.company;
  static const Field<Book, Company> _f$company =
      Field('company', _$company, opt: true);
  static RentalPlan? _$rentalPlan(Book v) => v.rentalPlan;
  static const Field<Book, RentalPlan> _f$rentalPlan =
      Field('rentalPlan', _$rentalPlan, opt: true);
  static DateTime _$startDate(Book v) => v.startDate;
  static const Field<Book, DateTime> _f$startDate =
      Field('startDate', _$startDate);
  static DateTime _$endDate(Book v) => v.endDate;
  static const Field<Book, DateTime> _f$endDate = Field('endDate', _$endDate);
  static double _$basePrice(Book v) => v.basePrice;
  static const Field<Book, double> _f$basePrice =
      Field('basePrice', _$basePrice);
  static double _$totalPrice(Book v) => v.totalPrice;
  static const Field<Book, double> _f$totalPrice =
      Field('totalPrice', _$totalPrice);
  static double _$finalPrice(Book v) => v.finalPrice;
  static const Field<Book, double> _f$finalPrice =
      Field('finalPrice', _$finalPrice);
  static double? _$discountAmount(Book v) => v.discountAmount;
  static const Field<Book, double> _f$discountAmount =
      Field('discountAmount', _$discountAmount, opt: true);
  static BookStatus _$status(Book v) => v.status;
  static const Field<Book, BookStatus> _f$status = Field('status', _$status);
  static String? _$cancelReason(Book v) => v.cancelReason;
  static const Field<Book, String> _f$cancelReason =
      Field('cancelReason', _$cancelReason, opt: true);
  static int _$duration(Book v) => v.duration;
  static const Field<Book, int> _f$duration = Field('duration', _$duration);
  static Promotion? _$promotion(Book v) => v.promotion;
  static const Field<Book, Promotion> _f$promotion =
      Field('promotion', _$promotion, opt: true);
  static PromotionType? _$promotionType(Book v) => v.promotionType;
  static const Field<Book, PromotionType> _f$promotionType =
      Field('promotionType', _$promotionType, opt: true);
  static Plan? _$plan(Book v) => v.plan;
  static const Field<Book, Plan> _f$plan = Field('plan', _$plan, opt: true);
  static DateTime _$bookedAt(Book v) => v.bookedAt;
  static const Field<Book, DateTime> _f$bookedAt =
      Field('bookedAt', _$bookedAt);
  static DateTime? _$updatedAt(Book v) => v.updatedAt;
  static const Field<Book, DateTime> _f$updatedAt =
      Field('updatedAt', _$updatedAt);
  static String? _$contact(Book v) => v.contact;
  static const Field<Book, String> _f$contact =
      Field('contact', _$contact, opt: true);

  @override
  final MappableFields<Book> fields = const {
    #id: _f$id,
    #bookId: _f$bookId,
    #userId: _f$userId,
    #profile: _f$profile,
    #car: _f$car,
    #company: _f$company,
    #rentalPlan: _f$rentalPlan,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
    #basePrice: _f$basePrice,
    #totalPrice: _f$totalPrice,
    #finalPrice: _f$finalPrice,
    #discountAmount: _f$discountAmount,
    #status: _f$status,
    #cancelReason: _f$cancelReason,
    #duration: _f$duration,
    #promotion: _f$promotion,
    #promotionType: _f$promotionType,
    #plan: _f$plan,
    #bookedAt: _f$bookedAt,
    #updatedAt: _f$updatedAt,
    #contact: _f$contact,
  };

  static Book _instantiate(DecodingData data) {
    return Book(
        id: data.dec(_f$id),
        bookId: data.dec(_f$bookId),
        userId: data.dec(_f$userId),
        profile: data.dec(_f$profile),
        car: data.dec(_f$car),
        company: data.dec(_f$company),
        rentalPlan: data.dec(_f$rentalPlan),
        startDate: data.dec(_f$startDate),
        endDate: data.dec(_f$endDate),
        basePrice: data.dec(_f$basePrice),
        totalPrice: data.dec(_f$totalPrice),
        finalPrice: data.dec(_f$finalPrice),
        discountAmount: data.dec(_f$discountAmount),
        status: data.dec(_f$status),
        cancelReason: data.dec(_f$cancelReason),
        duration: data.dec(_f$duration),
        promotion: data.dec(_f$promotion),
        promotionType: data.dec(_f$promotionType),
        plan: data.dec(_f$plan),
        bookedAt: data.dec(_f$bookedAt),
        updatedAt: data.dec(_f$updatedAt),
        contact: data.dec(_f$contact));
  }

  @override
  final Function instantiate = _instantiate;

  static Book fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Book>(map);
  }

  static Book fromJson(String json) {
    return ensureInitialized().decodeJson<Book>(json);
  }
}

mixin BookMappable {
  String toJson() {
    return BookMapper.ensureInitialized().encodeJson<Book>(this as Book);
  }

  Map<String, dynamic> toMap() {
    return BookMapper.ensureInitialized().encodeMap<Book>(this as Book);
  }

  BookCopyWith<Book, Book, Book> get copyWith =>
      _BookCopyWithImpl<Book, Book>(this as Book, $identity, $identity);
  @override
  String toString() {
    return BookMapper.ensureInitialized().stringifyValue(this as Book);
  }

  @override
  bool operator ==(Object other) {
    return BookMapper.ensureInitialized().equalsValue(this as Book, other);
  }

  @override
  int get hashCode {
    return BookMapper.ensureInitialized().hashValue(this as Book);
  }
}

extension BookValueCopy<$R, $Out> on ObjectCopyWith<$R, Book, $Out> {
  BookCopyWith<$R, Book, $Out> get $asBook =>
      $base.as((v, t, t2) => _BookCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BookCopyWith<$R, $In extends Book, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ProfileCopyWith<$R, Profile, Profile>? get profile;
  CarCopyWith<$R, Car, Car>? get car;
  CompanyCopyWith<$R, Company, Company>? get company;
  RentalPlanCopyWith<$R, RentalPlan, RentalPlan>? get rentalPlan;
  PromotionCopyWith<$R, Promotion, Promotion>? get promotion;
  PlanCopyWith<$R, Plan, Plan>? get plan;
  $R call(
      {String? id,
      String? bookId,
      String? userId,
      Profile? profile,
      Car? car,
      Company? company,
      RentalPlan? rentalPlan,
      DateTime? startDate,
      DateTime? endDate,
      double? basePrice,
      double? totalPrice,
      double? finalPrice,
      double? discountAmount,
      BookStatus? status,
      String? cancelReason,
      int? duration,
      Promotion? promotion,
      PromotionType? promotionType,
      Plan? plan,
      DateTime? bookedAt,
      DateTime? updatedAt,
      String? contact});
  BookCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BookCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Book, $Out>
    implements BookCopyWith<$R, Book, $Out> {
  _BookCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Book> $mapper = BookMapper.ensureInitialized();
  @override
  ProfileCopyWith<$R, Profile, Profile>? get profile =>
      $value.profile?.copyWith.$chain((v) => call(profile: v));
  @override
  CarCopyWith<$R, Car, Car>? get car =>
      $value.car?.copyWith.$chain((v) => call(car: v));
  @override
  CompanyCopyWith<$R, Company, Company>? get company =>
      $value.company?.copyWith.$chain((v) => call(company: v));
  @override
  RentalPlanCopyWith<$R, RentalPlan, RentalPlan>? get rentalPlan =>
      $value.rentalPlan?.copyWith.$chain((v) => call(rentalPlan: v));
  @override
  PromotionCopyWith<$R, Promotion, Promotion>? get promotion =>
      $value.promotion?.copyWith.$chain((v) => call(promotion: v));
  @override
  PlanCopyWith<$R, Plan, Plan>? get plan =>
      $value.plan?.copyWith.$chain((v) => call(plan: v));
  @override
  $R call(
          {String? id,
          Object? bookId = $none,
          Object? userId = $none,
          Object? profile = $none,
          Object? car = $none,
          Object? company = $none,
          Object? rentalPlan = $none,
          DateTime? startDate,
          DateTime? endDate,
          double? basePrice,
          double? totalPrice,
          double? finalPrice,
          Object? discountAmount = $none,
          BookStatus? status,
          Object? cancelReason = $none,
          int? duration,
          Object? promotion = $none,
          Object? promotionType = $none,
          Object? plan = $none,
          DateTime? bookedAt,
          Object? updatedAt = $none,
          Object? contact = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (bookId != $none) #bookId: bookId,
        if (userId != $none) #userId: userId,
        if (profile != $none) #profile: profile,
        if (car != $none) #car: car,
        if (company != $none) #company: company,
        if (rentalPlan != $none) #rentalPlan: rentalPlan,
        if (startDate != null) #startDate: startDate,
        if (endDate != null) #endDate: endDate,
        if (basePrice != null) #basePrice: basePrice,
        if (totalPrice != null) #totalPrice: totalPrice,
        if (finalPrice != null) #finalPrice: finalPrice,
        if (discountAmount != $none) #discountAmount: discountAmount,
        if (status != null) #status: status,
        if (cancelReason != $none) #cancelReason: cancelReason,
        if (duration != null) #duration: duration,
        if (promotion != $none) #promotion: promotion,
        if (promotionType != $none) #promotionType: promotionType,
        if (plan != $none) #plan: plan,
        if (bookedAt != null) #bookedAt: bookedAt,
        if (updatedAt != $none) #updatedAt: updatedAt,
        if (contact != $none) #contact: contact
      }));
  @override
  Book $make(CopyWithData data) => Book(
      id: data.get(#id, or: $value.id),
      bookId: data.get(#bookId, or: $value.bookId),
      userId: data.get(#userId, or: $value.userId),
      profile: data.get(#profile, or: $value.profile),
      car: data.get(#car, or: $value.car),
      company: data.get(#company, or: $value.company),
      rentalPlan: data.get(#rentalPlan, or: $value.rentalPlan),
      startDate: data.get(#startDate, or: $value.startDate),
      endDate: data.get(#endDate, or: $value.endDate),
      basePrice: data.get(#basePrice, or: $value.basePrice),
      totalPrice: data.get(#totalPrice, or: $value.totalPrice),
      finalPrice: data.get(#finalPrice, or: $value.finalPrice),
      discountAmount: data.get(#discountAmount, or: $value.discountAmount),
      status: data.get(#status, or: $value.status),
      cancelReason: data.get(#cancelReason, or: $value.cancelReason),
      duration: data.get(#duration, or: $value.duration),
      promotion: data.get(#promotion, or: $value.promotion),
      promotionType: data.get(#promotionType, or: $value.promotionType),
      plan: data.get(#plan, or: $value.plan),
      bookedAt: data.get(#bookedAt, or: $value.bookedAt),
      updatedAt: data.get(#updatedAt, or: $value.updatedAt),
      contact: data.get(#contact, or: $value.contact));

  @override
  BookCopyWith<$R2, Book, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BookCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
