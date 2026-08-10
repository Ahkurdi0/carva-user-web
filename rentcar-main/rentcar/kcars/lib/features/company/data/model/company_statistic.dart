import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/company/data/model/enums.dart';
part 'company_statistic.mapper.dart';

@MappableClass()
class CompanyStatistic with CompanyStatisticMappable {
  final Company? company;
  final List<ContactedType>? types;

  CompanyStatistic({this.company, this.types});
}

@MappableClass()
class ContactedType with ContactedTypeMappable {
  final ContactTypes type;
  final int? total;
  final List<ContactTypesData> data;

  ContactedType({required this.type, required this.data, this.total});
}

@MappableClass()
class ContactTypesData with ContactTypesDataMappable {
  final int? month;
  final int? year;
  final int? count;

  ContactTypesData({this.month, this.year, this.count});
}
