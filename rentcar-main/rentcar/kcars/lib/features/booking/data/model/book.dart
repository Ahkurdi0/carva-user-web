import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/booking/data/model/enums.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:kcars/features/car/data/model/paln.dart';
import 'package:kcars/features/car/data/model/promotion.dart';
import 'package:kcars/features/car/data/model/rental_plan.dart';
import 'package:kcars/features/company/data/model/company.dart';
part 'book.mapper.dart';

@MappableClass()
class Book with BookMappable {
  final String id;
  final String? bookId;
  final String? userId;
  final Profile? profile;
  final Car? car;
  final Company? company;
  final RentalPlan? rentalPlan;
  final DateTime startDate;
  final DateTime endDate;
  final double basePrice;
  final double totalPrice;
  final double finalPrice;
  final double? discountAmount;
  final BookStatus status;
  final String? cancelReason;
  final int duration;
  final Promotion? promotion;
  final PromotionType? promotionType;
  final Plan? plan;
  final DateTime bookedAt;
  final DateTime? updatedAt;
  final String? contact;

  Book({
    required this.id,
    this.bookId,
    this.userId,
    this.profile,
    this.car,
    this.company,
    this.rentalPlan,
    required this.startDate,
    required this.endDate,
    required this.basePrice,
    required this.totalPrice,
    required this.finalPrice,
    this.discountAmount,
    required this.status,
    this.cancelReason,
    required this.duration,
    this.promotion,
    this.promotionType,
    this.plan,
    required this.bookedAt,
    required this.updatedAt,
    this.contact,
  });
}
