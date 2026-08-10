import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/car/data/model/brand.dart';
import 'package:kcars/features/car/data/model/car_type.dart';
import 'package:kcars/features/car/data/model/city.dart';
import 'package:kcars/features/car/data/model/paln.dart';
part 'filter_data.mapper.dart';

@MappableClass()
class FilterData with FilterDataMappable {
  final List<Brand>? brands;
  final List<CarType>? types;
  final List<City>? cities;
  final List<Plan>? plans;

  FilterData({this.brands, this.types, this.cities, this.plans});
}
