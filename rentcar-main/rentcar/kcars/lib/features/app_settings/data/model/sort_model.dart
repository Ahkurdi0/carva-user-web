import 'package:dart_mappable/dart_mappable.dart';
part 'sort_model.mapper.dart';

@MappableClass()
class SortModel with SortModelMappable {
  final String id;
  final int sort;

  const SortModel({required this.id, required this.sort});
}
