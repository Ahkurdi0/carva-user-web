import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/car/data/model/city.dart';
import 'package:kcars/features/car/data/model/town.dart';
part 'location.mapper.dart';

@MappableClass()
class Location with LocationMappable {
  final String? id;
  final double lat;
  final double long;
  final City? city;
  final String? cityId;
  final Town? town;
  final String? townId;
  final int? radiusKm;
  final DateTime? createdAt;

  Location({
    this.id,
    required this.lat,
    required this.long,
    this.createdAt,
    this.city,
    this.cityId,
    this.town,
    this.townId,
    this.radiusKm,
  });
}
