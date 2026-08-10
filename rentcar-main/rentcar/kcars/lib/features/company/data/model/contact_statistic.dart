import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
import 'package:kcars/features/company/data/model/enums.dart';
part 'contact_statistic.mapper.dart';

@MappableClass()
class ContactStatistic with ContactStatisticMappable, CleanMapMixin {
  final ContactTypes? type;
  final String? id;
  final String? contactId;
  final String? userId;
  final String? companyId;
  final String? carId;
  final String? value;
  final DateTime? createdAt;

  ContactStatistic({
    this.type,
    this.id,
    this.contactId,
    this.userId,
    this.companyId,
    this.carId,
    this.value,
    this.createdAt,
  });
}
