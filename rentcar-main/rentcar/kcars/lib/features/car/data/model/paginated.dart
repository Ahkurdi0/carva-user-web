import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/car/data/model/car.dart';
part 'paginated.mapper.dart';

@MappableClass()
class Paginated with PaginatedMappable {
  final String? cursor;
  final List<Car> cars;
  final bool? hasMore;

  Paginated({this.cursor, required this.cars, this.hasMore});
}
