import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:kcars/features/car/data/model/paln.dart';
import 'package:kcars/features/car/data/model/promotion.dart';
part 'rental_plan.mapper.dart';

@MappableClass()
class RentalPlan with RentalPlanMappable {
  final String id;
  final String? carId;
  final Car? car;
  final double price;
  final int? max;
  final int? min;
  final Plan? plan;
  final RentalPeriodType periodType;
  final bool available;
  final List<Promotion>? promotions;
  final String? planId;
  final Currency? currency;

  RentalPlan({
    required this.id,
    this.carId,
    this.car,
    required this.price,
    this.max,
    this.min,
    this.plan,
    this.periodType = RentalPeriodType.hourly,
    this.available = true,
    this.promotions,
    this.planId,
    this.currency,
  });
}

@MappableClass()
class FilterRentalPlan with FilterRentalPlanMappable {
  final String? id;
  final int? maxPrice;
  final int? minPrice;
  final Plan? plan;
  final String? planId;

  FilterRentalPlan({
    this.id,
    this.maxPrice,
    this.minPrice,
    this.plan,
    this.planId,
  });
}
