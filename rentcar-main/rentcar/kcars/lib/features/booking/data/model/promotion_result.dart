import 'package:dart_mappable/dart_mappable.dart';
part 'promotion_result.mapper.dart';

@MappableClass()
class PromotionResult with PromotionResultMappable {
  final double finalPrice;
  final double discount;
  final double totalPrice;
  final double? basePrice;
  final double? periods;

  PromotionResult({
    required this.finalPrice,
    required this.discount,
    required this.totalPrice,
    this.basePrice,
    this.periods,
  });
}
