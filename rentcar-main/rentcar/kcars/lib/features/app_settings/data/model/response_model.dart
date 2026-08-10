import 'package:dart_mappable/dart_mappable.dart';
part 'response_model.mapper.dart';

@MappableClass()
class ResponseData with ResponseDataMappable {
  final String? id;
  final String? image;

  const ResponseData({this.id, this.image});
}
