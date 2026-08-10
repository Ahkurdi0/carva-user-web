import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
import 'package:kcars/features/car/data/model/car.dart';
part 'car_type.mapper.dart';

@MappableClass()
class CarType with CarTypeMappable,CleanMapMixin {
  final String? id;
  final String en;
  final String? ar;
  final String? ku;
  final int? sort;
  final List<Car>? car;
  final bool? available;

  CarType({
    this.id,
    required this.en,
    this.ar,
    this.ku,
    this.sort,
    this.car,
    this.available,
  });

  String getTitle(String locale) => switch (locale) {
    'ar' => ar ?? en,
    'ku' => ku ?? en,
    _ => en,
  };

  CarType toDiffer(CarType? carType) {
    return CarType(
      id: carType?.id == id ? carType?.id : null,
      en: en == carType?.en ? "" : en,
      ar: ar == carType?.ar ? null : ar,
      ku: ku == carType?.ku ? null : ku,
      sort: null,
      available: available == carType?.available ? null : available,
      car: null,
    );
  }
}
