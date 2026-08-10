// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'new_booking.dart';

class NewBookingMapper extends ClassMapperBase<NewBooking> {
  NewBookingMapper._();

  static NewBookingMapper? _instance;
  static NewBookingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NewBookingMapper._());
      BookStatusMapper.ensureInitialized();
      RentalPeriodTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'NewBooking';

  static String? _$carId(NewBooking v) => v.carId;
  static const Field<NewBooking, String> _f$carId =
      Field('carId', _$carId, opt: true);
  static String? _$bookId(NewBooking v) => v.bookId;
  static const Field<NewBooking, String> _f$bookId =
      Field('bookId', _$bookId, opt: true);
  static String? _$companyId(NewBooking v) => v.companyId;
  static const Field<NewBooking, String> _f$companyId =
      Field('companyId', _$companyId, opt: true);
  static String? _$planId(NewBooking v) => v.planId;
  static const Field<NewBooking, String> _f$planId =
      Field('planId', _$planId, opt: true);
  static String? _$rentalPlanId(NewBooking v) => v.rentalPlanId;
  static const Field<NewBooking, String> _f$rentalPlanId =
      Field('rentalPlanId', _$rentalPlanId, opt: true);
  static String? _$code(NewBooking v) => v.code;
  static const Field<NewBooking, String> _f$code =
      Field('code', _$code, opt: true);
  static BookStatus? _$status(NewBooking v) => v.status;
  static const Field<NewBooking, BookStatus> _f$status =
      Field('status', _$status, opt: true);
  static String? _$cancelReason(NewBooking v) => v.cancelReason;
  static const Field<NewBooking, String> _f$cancelReason =
      Field('cancelReason', _$cancelReason, opt: true);
  static DateTime? _$startDate(NewBooking v) => v.startDate;
  static const Field<NewBooking, DateTime> _f$startDate =
      Field('startDate', _$startDate, opt: true);
  static DateTime? _$endDate(NewBooking v) => v.endDate;
  static const Field<NewBooking, DateTime> _f$endDate =
      Field('endDate', _$endDate, opt: true);
  static int? _$duration(NewBooking v) => v.duration;
  static const Field<NewBooking, int> _f$duration =
      Field('duration', _$duration, opt: true);
  static RentalPeriodType? _$periodType(NewBooking v) => v.periodType;
  static const Field<NewBooking, RentalPeriodType> _f$periodType =
      Field('periodType', _$periodType, opt: true);
  static double? _$basePrice(NewBooking v) => v.basePrice;
  static const Field<NewBooking, double> _f$basePrice =
      Field('basePrice', _$basePrice, opt: true);
  static double? _$totalPrice(NewBooking v) => v.totalPrice;
  static const Field<NewBooking, double> _f$totalPrice =
      Field('totalPrice', _$totalPrice, opt: true);
  static double? _$finalPrice(NewBooking v) => v.finalPrice;
  static const Field<NewBooking, double> _f$finalPrice =
      Field('finalPrice', _$finalPrice, opt: true);
  static String? _$contact(NewBooking v) => v.contact;
  static const Field<NewBooking, String> _f$contact =
      Field('contact', _$contact, opt: true);

  @override
  final MappableFields<NewBooking> fields = const {
    #carId: _f$carId,
    #bookId: _f$bookId,
    #companyId: _f$companyId,
    #planId: _f$planId,
    #rentalPlanId: _f$rentalPlanId,
    #code: _f$code,
    #status: _f$status,
    #cancelReason: _f$cancelReason,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
    #duration: _f$duration,
    #periodType: _f$periodType,
    #basePrice: _f$basePrice,
    #totalPrice: _f$totalPrice,
    #finalPrice: _f$finalPrice,
    #contact: _f$contact,
  };

  static NewBooking _instantiate(DecodingData data) {
    return NewBooking(
        carId: data.dec(_f$carId),
        bookId: data.dec(_f$bookId),
        companyId: data.dec(_f$companyId),
        planId: data.dec(_f$planId),
        rentalPlanId: data.dec(_f$rentalPlanId),
        code: data.dec(_f$code),
        status: data.dec(_f$status),
        cancelReason: data.dec(_f$cancelReason),
        startDate: data.dec(_f$startDate),
        endDate: data.dec(_f$endDate),
        duration: data.dec(_f$duration),
        periodType: data.dec(_f$periodType),
        basePrice: data.dec(_f$basePrice),
        totalPrice: data.dec(_f$totalPrice),
        finalPrice: data.dec(_f$finalPrice),
        contact: data.dec(_f$contact));
  }

  @override
  final Function instantiate = _instantiate;

  static NewBooking fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NewBooking>(map);
  }

  static NewBooking fromJson(String json) {
    return ensureInitialized().decodeJson<NewBooking>(json);
  }
}

mixin NewBookingMappable {
  String toJson() {
    return NewBookingMapper.ensureInitialized()
        .encodeJson<NewBooking>(this as NewBooking);
  }

  Map<String, dynamic> toMap() {
    return NewBookingMapper.ensureInitialized()
        .encodeMap<NewBooking>(this as NewBooking);
  }

  NewBookingCopyWith<NewBooking, NewBooking, NewBooking> get copyWith =>
      _NewBookingCopyWithImpl<NewBooking, NewBooking>(
          this as NewBooking, $identity, $identity);
  @override
  String toString() {
    return NewBookingMapper.ensureInitialized()
        .stringifyValue(this as NewBooking);
  }

  @override
  bool operator ==(Object other) {
    return NewBookingMapper.ensureInitialized()
        .equalsValue(this as NewBooking, other);
  }

  @override
  int get hashCode {
    return NewBookingMapper.ensureInitialized().hashValue(this as NewBooking);
  }
}

extension NewBookingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NewBooking, $Out> {
  NewBookingCopyWith<$R, NewBooking, $Out> get $asNewBooking =>
      $base.as((v, t, t2) => _NewBookingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class NewBookingCopyWith<$R, $In extends NewBooking, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? carId,
      String? bookId,
      String? companyId,
      String? planId,
      String? rentalPlanId,
      String? code,
      BookStatus? status,
      String? cancelReason,
      DateTime? startDate,
      DateTime? endDate,
      int? duration,
      RentalPeriodType? periodType,
      double? basePrice,
      double? totalPrice,
      double? finalPrice,
      String? contact});
  NewBookingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NewBookingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NewBooking, $Out>
    implements NewBookingCopyWith<$R, NewBooking, $Out> {
  _NewBookingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NewBooking> $mapper =
      NewBookingMapper.ensureInitialized();
  @override
  $R call(
          {Object? carId = $none,
          Object? bookId = $none,
          Object? companyId = $none,
          Object? planId = $none,
          Object? rentalPlanId = $none,
          Object? code = $none,
          Object? status = $none,
          Object? cancelReason = $none,
          Object? startDate = $none,
          Object? endDate = $none,
          Object? duration = $none,
          Object? periodType = $none,
          Object? basePrice = $none,
          Object? totalPrice = $none,
          Object? finalPrice = $none,
          Object? contact = $none}) =>
      $apply(FieldCopyWithData({
        if (carId != $none) #carId: carId,
        if (bookId != $none) #bookId: bookId,
        if (companyId != $none) #companyId: companyId,
        if (planId != $none) #planId: planId,
        if (rentalPlanId != $none) #rentalPlanId: rentalPlanId,
        if (code != $none) #code: code,
        if (status != $none) #status: status,
        if (cancelReason != $none) #cancelReason: cancelReason,
        if (startDate != $none) #startDate: startDate,
        if (endDate != $none) #endDate: endDate,
        if (duration != $none) #duration: duration,
        if (periodType != $none) #periodType: periodType,
        if (basePrice != $none) #basePrice: basePrice,
        if (totalPrice != $none) #totalPrice: totalPrice,
        if (finalPrice != $none) #finalPrice: finalPrice,
        if (contact != $none) #contact: contact
      }));
  @override
  NewBooking $make(CopyWithData data) => NewBooking(
      carId: data.get(#carId, or: $value.carId),
      bookId: data.get(#bookId, or: $value.bookId),
      companyId: data.get(#companyId, or: $value.companyId),
      planId: data.get(#planId, or: $value.planId),
      rentalPlanId: data.get(#rentalPlanId, or: $value.rentalPlanId),
      code: data.get(#code, or: $value.code),
      status: data.get(#status, or: $value.status),
      cancelReason: data.get(#cancelReason, or: $value.cancelReason),
      startDate: data.get(#startDate, or: $value.startDate),
      endDate: data.get(#endDate, or: $value.endDate),
      duration: data.get(#duration, or: $value.duration),
      periodType: data.get(#periodType, or: $value.periodType),
      basePrice: data.get(#basePrice, or: $value.basePrice),
      totalPrice: data.get(#totalPrice, or: $value.totalPrice),
      finalPrice: data.get(#finalPrice, or: $value.finalPrice),
      contact: data.get(#contact, or: $value.contact));

  @override
  NewBookingCopyWith<$R2, NewBooking, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NewBookingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
