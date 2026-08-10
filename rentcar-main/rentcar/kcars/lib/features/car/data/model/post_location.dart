import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';

part 'post_location.mapper.dart';

@MappableClass()
class PostLocation with PostLocationMappable, CleanMapMixin {
  final double? long;
  final double? lat;
  final double? west;
  final double? east;
  final double? north;
  final double? south;
  final int? radiusKm;
  PostLocation({
    this.long,
    this.lat,
    this.west,
    this.east,
    this.north,
    this.south,
    this.radiusKm,
  });
}
