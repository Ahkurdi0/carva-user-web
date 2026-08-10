import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
part 'notifications.mapper.dart';

@MappableClass()
class Notifications with NotificationsMappable, CleanMapMixin {
  final String id;
  final String kuTitle;
  final String arTitle;
  final String enTitle;
  final String kuDescription;
  final String arDescription;
  final String enDescription;
  final DateTime? postedAt;

  const Notifications({
    required this.id,
    required this.kuTitle,
    required this.arTitle,
    required this.enTitle,
    required this.kuDescription,
    required this.arDescription,
    required this.enDescription,
    this.postedAt,
  });
  Notifications toDiffer(Notifications? notification) {
    return Notifications(
      id: notification?.id == id ? "" : id,
      kuTitle: kuTitle == notification?.kuTitle ? "" : kuTitle,
      arTitle: arTitle == notification?.arTitle ? "" : arTitle,
      enTitle: enTitle == notification?.enTitle ? "" : enTitle,
      kuDescription: kuDescription == notification?.kuDescription
          ? ""
          : kuDescription,
      arDescription: arDescription == notification?.arDescription
          ? ""
          : arDescription,
      enDescription: enDescription == notification?.enDescription
          ? ""
          : enDescription,
      postedAt: null,
    );
  }
}
