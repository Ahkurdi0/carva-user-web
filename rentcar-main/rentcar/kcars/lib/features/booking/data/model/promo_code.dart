import 'package:dart_mappable/dart_mappable.dart';
part 'promo_code.mapper.dart';

@MappableClass()
class PromoCode with PromoCodeMappable {
  PromoCode({
    required this.code,
    required this.carId,
    required this.companyId,
    required this.rentalPlanId,
    required this.planId,
    required this.startDate,
    required this.endDate,
  });
  final String code;
  final String carId;
  final String companyId;
  final String rentalPlanId;
  final String planId;
  final DateTime startDate;
  final DateTime endDate;
}
