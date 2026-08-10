import 'package:dart_mappable/dart_mappable.dart';
part 'update_company.mapper.dart';

@MappableClass()
class UpdateCompany with UpdateCompanyMappable {
  final String? image;
  final String? coverImage;

  UpdateCompany({this.image, this.coverImage});
}
