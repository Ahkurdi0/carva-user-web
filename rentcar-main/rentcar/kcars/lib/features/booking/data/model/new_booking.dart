import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
import 'package:kcars/features/booking/data/model/enums.dart';
import 'package:kcars/features/car/data/model/enums.dart';
part 'new_booking.mapper.dart';

@MappableClass()
class NewBooking with CleanMapMixin, NewBookingMappable {
  final String? carId;
  final String? bookId;
  final String? companyId;
  final String? planId;
  final String? rentalPlanId;
  final String? code;
  final BookStatus? status;
  final String? cancelReason;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? duration;
  final RentalPeriodType? periodType;
  final double? basePrice;
  final double? totalPrice;
  final double? finalPrice;
  final String? contact;

  NewBooking({
    this.carId,
    this.bookId,
    this.companyId,
    this.planId,
    this.rentalPlanId,
    this.code,
    this.status,
    this.cancelReason,
    this.startDate,
    this.endDate,
    this.duration,
    this.periodType,
    this.basePrice,
    this.totalPrice,
    this.finalPrice,
    this.contact,
  });
}
