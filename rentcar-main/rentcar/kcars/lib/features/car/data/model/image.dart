import 'package:dart_mappable/dart_mappable.dart';
part 'image.mapper.dart';

@MappableClass()
class Images with ImagesMappable {
  final String? id;
  final String image;
  final String? carId;
  final String? companyId;
  final int? sort;

  Images({this.id, required this.image, this.companyId, this.sort, this.carId});
}
