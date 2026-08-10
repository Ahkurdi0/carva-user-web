import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/company/data/model/company.dart';
part 'featured_cars.mapper.dart';

@MappableClass()
class FeaturedCars with FeaturedCarsMappable, CleanMapMixin {
  final String? id;
  final String? carId;
  final Car? car;
  final int? sort;
  final String? companyId;
  final Company? company;
  final DateTime? startAt;
  final DateTime? until;
  final DateTime? deletedAt;
  final bool? available;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  FeaturedCars({
    this.id,
    this.carId,
    this.car,
    this.sort,
    this.companyId,
    this.company,
    this.startAt,
    this.until,
    this.deletedAt,
    this.available,
    this.createdAt,
    this.updatedAt,
  });
}
