import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
import 'package:kcars/features/car/data/model/car.dart';
part 'brand.mapper.dart';

@MappableClass()
class Brand with BrandMappable, CleanMapMixin {
  final String? id;
  final String en;
  final String? ar;
  final String? ku;
  final String? image;
  final int? sort;
  final bool? available;
  final List<Car>? cars;

  Brand({
    this.id,
    required this.en,
    this.ar,
    this.ku,
    this.image,
    this.sort,
    this.cars,
    this.available,
  });

  String getTitle(String locale) => switch (locale) {
    'ar' => ar ?? en,
    'ku' => ku ?? en,
    _ => en,
  };

  Brand toDiffer(Brand? brand) {
    return Brand(
      id: brand?.id == id ? brand?.id : null,
      en: en == brand?.en ? "" : en,
      ar: ar == brand?.ar ? null : ar,
      ku: ku == brand?.ku ? null : ku,
      available: available == brand?.available ? null : available,
      image: null,
      sort: null,
      cars: null,
    );
  }
}
