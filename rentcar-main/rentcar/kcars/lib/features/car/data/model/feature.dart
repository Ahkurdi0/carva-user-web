import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/car/data/model/car_type.dart';
import 'package:kcars/features/car/data/model/enums.dart';
part 'feature.mapper.dart';

@MappableClass()
class Feature with FeatureMappable {
  final String? id;
  final String? carId;
  final int? year;
  final int? maxYear;
  final int? seat;
  final int? hp;
  final int? speed;
  final int? odometer;
  final int? cylinders;
  final double? engCC;
  final Transmission? transmission;
  final Fuel? fuel;
  final CarType? type;

  Feature({
    this.id,
    this.carId,
    this.year,
    this.maxYear,
    this.seat,
    this.hp,
    this.speed,
    this.odometer,
    this.transmission,
    this.fuel,
    this.type,
    this.cylinders,
    this.engCC,
  });
}
