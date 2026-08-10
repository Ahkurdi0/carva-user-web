import 'package:dart_mappable/dart_mappable.dart';
part 'statistic.mapper.dart';

@MappableClass()
class Statistic with StatisticMappable {
  final int? year;
  final int? month;
  final double total;

  Statistic({this.year, this.month, required this.total});
}
