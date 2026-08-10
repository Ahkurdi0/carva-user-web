import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
part 'town.mapper.dart';

@MappableClass()
class Town with TownMappable, CleanMapMixin {
  final String? id;
  final String en;
  final String? ku;
  final String? ar;
  final double? lat;
  final double? long;
  final int? sort;
  final int? radiusKm;
  final String? cityId;
  final bool? available;

  Town({
    this.id,
    required this.en,
    this.ku,
    this.ar,
    this.lat,
    this.long,
    this.sort,
    this.radiusKm,
    this.cityId,
    this.available,
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

  Town toDiffer(Town? town) {
    return Town(
      id: town?.id == id ? town?.id : null,
      en: en == town?.en ? "" : en,
      ku: ku == town?.ku ? null : ku,
      ar: ar == town?.ar ? null : ar,
      lat: lat == town?.lat ? null : lat,
      long: long == town?.long ? null : long,
      sort: null,
      radiusKm: null,
      available: available == town?.available ? null : available,
      cityId: cityId,
    );
  }
}
