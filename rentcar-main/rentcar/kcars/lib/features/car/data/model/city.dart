import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
import 'package:kcars/features/car/data/model/town.dart';
part 'city.mapper.dart';

@MappableClass()
class City with CityMappable, CleanMapMixin {
  final String? id;
  final String en;
  final String? ku;
  final String? ar;
  final double? lat;
  final double? long;
  final int? sort;
  final int? radiusKm;
  final bool? available;
  final List<Town>? towns;

  City({
    this.id,
    required this.en,
    this.ku,
    this.ar,
    this.lat,
    this.long,
    this.sort,
    this.radiusKm,
    this.available,
    this.towns,
  });
  String getTitle(String locale) {
    switch (locale) {
      case 'ku':
        return ku ?? en;
      case 'ar':
        return ar ?? en;
      default:
        return en;
    }
  }

  City toDiffer(City? city) {
    return City(
      id: city?.id == id ? city?.id : null,
      en: en == city?.en ? "" : en,
      ku: ku == city?.ku ? null : ku,
      ar: ar == city?.ar ? null : ar,
      lat: lat == city?.lat ? null : lat,
      long: long == city?.long ? null : long,
      sort: null,
      radiusKm: null,
      available: available == city?.available ? null : available,
      towns: null,
    );
  }
}
