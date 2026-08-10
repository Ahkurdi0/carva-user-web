import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
import 'package:kcars/features/company/data/model/enums.dart';
part 'contact.mapper.dart';

@MappableClass()
class Contact with ContactMappable, CleanMapMixin {
  final String? id;
  final String? countrCode;
  final String? value;
  final ContactTypes? type;
  final bool? available;
  final int? sort;

  Contact({
    this.id,
    this.countrCode,
    this.value,
    this.type,
    this.available,
    this.sort,
  });
}
