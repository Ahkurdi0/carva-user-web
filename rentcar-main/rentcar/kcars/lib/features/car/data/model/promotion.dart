import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/enums.dart';

part 'promotion.mapper.dart';

@MappableClass()
class Promotion with PromotionMappable, CleanMapMixin {
  final String id;
  final String? code;
  final String? name;
  final String? description;
  final PromotionPriceType priceType;
  final PromotionType type;
  final double? value;
  final double? minOrderValue;
  final double? maxDiscountAmount;
  final DateTime startDate;
  final DateTime endDate;
  final int? maxUses;
  final int? usesCount;
  final int? maxUsePerUser;
  final String? companyId;
  final String? carId;
  final String? rentalPlanId;
  final bool? available;
  final String? planId;
  final Car? car;

  Promotion({
    required this.id,
    this.code,
    this.name,
    this.description,
    required this.priceType,
    required this.type,
    this.value,
    this.minOrderValue,
    this.maxDiscountAmount,
    required this.startDate,
    required this.endDate,
    this.maxUses,
    this.usesCount,
    this.maxUsePerUser,
    this.companyId,
    this.carId,
    this.rentalPlanId,
    this.available,
    this.planId,
    this.car,
  });
}

@MappableClass()
class PromotionUpdate with PromotionUpdateMappable, CleanMapMixin {
  final String? id;
  final String? code;
  final String? name;
  final String? description;
  final PromotionPriceType? priceType;
  final PromotionType? type;
  final double? value;
  final double? minOrderValue;
  final double? maxDiscountAmount;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? maxUses;
  final int? usesCount;
  final int? maxUsePerUser;
  final String? companyId;
  final String carId;
  final String? rentalPlanId;
  final bool? available;
  final String? planId;
  final Car? car;

  PromotionUpdate({
    this.id,
    this.code,
    this.name,
    this.description,
    this.priceType,
    this.type,
    this.value,
    this.minOrderValue,
    this.maxDiscountAmount,
    this.startDate,
    this.endDate,
    this.maxUses,
    this.usesCount,
    this.maxUsePerUser,
    this.companyId,
    required this.carId,
    this.rentalPlanId,
    this.available,
    this.planId,
    this.car,
  });

  PromotionUpdate toDiffe(Promotion original) {
    return PromotionUpdate(
      id: id == original.id ? null : id,
      planId: planId == original.planId ? null : planId,
      code: code == original.code ? null : code,
      maxUses: maxUses == original.maxUses ? null : maxUses,
      maxUsePerUser: maxUsePerUser == original.maxUsePerUser
          ? null
          : maxUsePerUser,
      maxDiscountAmount: maxDiscountAmount == original.maxDiscountAmount
          ? null
          : maxDiscountAmount,
      minOrderValue: minOrderValue == original.minOrderValue
          ? null
          : minOrderValue,
      value: value == original.value ? null : value,
      priceType: priceType == original.priceType ? null : priceType,
      type: type == original.type ? null : type,
      available: available == original.available ? null : available,
      startDate:
          (startDate != null &&
              !startDate!.isAtSameMomentAs(original.startDate))
          ? startDate
          : null,

      endDate: (endDate != null && !endDate!.isAtSameMomentAs(original.endDate))
          ? endDate
          : null,
      carId: carId,
      rentalPlanId: rentalPlanId == original.rentalPlanId ? null : rentalPlanId,
      name: name == original.name ? null : name,
      description: description == original.description ? null : description,
    );
  }
}

extension PromotionUpdateExtension on PromotionUpdate {
  PromotionUpdate toDiff(Promotion original) {
    return PromotionUpdate(
      id: id,
      planId: planId == original.planId ? null : planId,
      code: code == original.code ? null : code,
      maxUses: maxUses == original.maxUses ? null : maxUses,
      maxUsePerUser: maxUsePerUser == original.maxUsePerUser
          ? null
          : maxUsePerUser,
      maxDiscountAmount: maxDiscountAmount == original.maxDiscountAmount
          ? null
          : maxDiscountAmount,
      minOrderValue: minOrderValue == original.minOrderValue
          ? null
          : minOrderValue,
      value: value == original.value ? null : value,
      priceType: priceType == original.priceType ? null : priceType,
      type: type == original.type ? null : type,
      available: available == original.available ? null : available,
      startDate:
          (startDate != null && isSameDate(startDate!, original.startDate))
          ? null
          : startDate,
      endDate: (endDate != null && isSameDate(endDate!, original.endDate))
          ? null
          : endDate,
      carId: carId,
      rentalPlanId: rentalPlanId == original.rentalPlanId ? null : rentalPlanId,
      name: name == original.name ? null : name,
      description: description == original.description ? null : description,
    );
  }

  bool isSameDate(DateTime a, DateTime b) =>
      a.toUtc().isAtSameMomentAs(b.toUtc());
}

extension PromotionUpdateExt on PromotionUpdate {
  Promotion toPromotion() {
    return Promotion(
      id: id ?? '',
      startDate: startDate ?? DateTime.now(),
      endDate: endDate ?? DateTime.now().add(Duration(hours: 1)),
      priceType: priceType ?? PromotionPriceType.fixed,
      type: type ?? PromotionType.car,
      available: available ?? true,
      carId: carId,
      code: code,
      maxUsePerUser: maxUsePerUser,
      maxUses: maxUses,
      maxDiscountAmount: maxDiscountAmount,
      minOrderValue: minOrderValue,
      planId: planId,
      rentalPlanId: rentalPlanId,
      value: value,
      name: name,
      description: description,
    );
  }
}

@MappableClass()
class PromotionPost with PromotionPostMappable {
  final String? cursor;
  final String? companyId;
  final String? carId;

  PromotionPost({this.cursor, this.companyId, this.carId});
}
