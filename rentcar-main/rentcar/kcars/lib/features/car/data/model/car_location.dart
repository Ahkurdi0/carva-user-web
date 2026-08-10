import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/car/data/model/city.dart';
import 'package:kcars/features/car/data/model/town.dart';

part 'car_location.mapper.dart';

@MappableClass()
class CarLocation with CarLocationMappable {
  final String? id;
  final double? lat;
  final double? long;
  final String? companyId;
  final String? townId;
  final int? radiusKm;
  final City? city;
  final Town? town;
  final String? cityId;

  CarLocation({
    this.id,
    this.lat,
    this.long,
    this.companyId,
    this.townId,
    this.radiusKm,
    this.city,
    this.town,
    this.cityId,
  });
}
