import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:kcars/features/car/data/model/promotion.dart';
import 'package:kcars/features/car/data/model/rental_plan.dart';

part 'paln.mapper.dart';

@MappableClass()
class Plan with PlanMappable {
  final String? id;
  final String? en;
  final String? ku;
  final String? ar;
  final RentalPeriodType? periodType;
  final int? sort;
  final List<RentalPlan>? rentalPlan;
  final List<Promotion>? promotions;

  Plan({
    this.id,
    this.en,
    this.ku,
    this.ar,
    this.periodType,
    this.sort,
    this.rentalPlan,
    this.promotions,
  });

  String getTile(String locale) => switch (locale) {
    "ku" => ku ?? "",
    "ar" => ar ?? "",
    _ => en ?? "",
  };
}
