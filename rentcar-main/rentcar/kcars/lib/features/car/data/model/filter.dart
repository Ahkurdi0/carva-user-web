import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
import 'package:kcars/features/car/data/model/brand.dart';
import 'package:kcars/features/car/data/model/car_location.dart';
import 'package:kcars/features/car/data/model/car_type.dart';
import 'package:kcars/features/car/data/model/feature.dart';
import 'package:kcars/features/car/data/model/city.dart';
import 'package:kcars/features/car/data/model/paln.dart';
import 'package:kcars/features/car/data/model/rental_plan.dart';
import 'package:kcars/features/car/data/model/town.dart';
part 'filter.mapper.dart';

@MappableClass()
class Filter with FilterMappable, CleanMapMixin {
  final String? typeId;
  final String? brandId;
  final String? cityId;
  final String? townId;
  final int? minPrice;
  final int? maxPrice;
  final int? minYear;
  final int? maxYear;
  final Feature? feature;
  final FilterRentalPlan? rentalPlan;
  final CarLocation? location;
  final Brand? brand;
  final CarType? type;
  final City? city;
  final Plan? plan;
  final Town? town;
  final String? cursor;
  final String? companyId;

  Filter({
    this.typeId,
    this.brandId,
    this.cityId,
    this.townId,
    this.minPrice,
    this.maxPrice,
    this.minYear,
    this.maxYear,
    this.feature,
    this.rentalPlan,
    this.location,
    this.brand,
    this.type,
    this.city,
    this.plan,
    this.town,
    this.cursor,
    this.companyId,
  });
}
