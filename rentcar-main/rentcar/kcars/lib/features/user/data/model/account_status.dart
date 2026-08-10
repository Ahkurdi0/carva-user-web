import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
part 'account_status.mapper.dart';

@MappableClass()
class AccountStatus with AccountStatusMappable, CleanMapMixin {
  String? id;
  String? userId;
  Profile? profile;
  String? title;
  String? description;
  DateTime? bannedAt;
  DateTime? bannedUntil;

  AccountStatus({
    this.id,
    this.userId,
    this.profile,
    this.title,
    this.description,
    this.bannedAt,
    this.bannedUntil,
  });
}
