// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'notifications.dart';

class NotificationsMapper extends ClassMapperBase<Notifications> {
  NotificationsMapper._();

  static NotificationsMapper? _instance;
  static NotificationsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NotificationsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Notifications';

  static String _$id(Notifications v) => v.id;
  static const Field<Notifications, String> _f$id = Field('id', _$id);
  static String _$kuTitle(Notifications v) => v.kuTitle;
  static const Field<Notifications, String> _f$kuTitle =
      Field('kuTitle', _$kuTitle);
  static String _$arTitle(Notifications v) => v.arTitle;
  static const Field<Notifications, String> _f$arTitle =
      Field('arTitle', _$arTitle);
  static String _$enTitle(Notifications v) => v.enTitle;
  static const Field<Notifications, String> _f$enTitle =
      Field('enTitle', _$enTitle);
  static String _$kuDescription(Notifications v) => v.kuDescription;
  static const Field<Notifications, String> _f$kuDescription =
      Field('kuDescription', _$kuDescription);
  static String _$arDescription(Notifications v) => v.arDescription;
  static const Field<Notifications, String> _f$arDescription =
      Field('arDescription', _$arDescription);
  static String _$enDescription(Notifications v) => v.enDescription;
  static const Field<Notifications, String> _f$enDescription =
      Field('enDescription', _$enDescription);
  static DateTime? _$postedAt(Notifications v) => v.postedAt;
  static const Field<Notifications, DateTime> _f$postedAt =
      Field('postedAt', _$postedAt, opt: true);

  @override
  final MappableFields<Notifications> fields = const {
    #id: _f$id,
    #kuTitle: _f$kuTitle,
    #arTitle: _f$arTitle,
    #enTitle: _f$enTitle,
    #kuDescription: _f$kuDescription,
    #arDescription: _f$arDescription,
    #enDescription: _f$enDescription,
    #postedAt: _f$postedAt,
  };

  static Notifications _instantiate(DecodingData data) {
    return Notifications(
        id: data.dec(_f$id),
        kuTitle: data.dec(_f$kuTitle),
        arTitle: data.dec(_f$arTitle),
        enTitle: data.dec(_f$enTitle),
        kuDescription: data.dec(_f$kuDescription),
        arDescription: data.dec(_f$arDescription),
        enDescription: data.dec(_f$enDescription),
        postedAt: data.dec(_f$postedAt));
  }

  @override
  final Function instantiate = _instantiate;

  static Notifications fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Notifications>(map);
  }

  static Notifications fromJson(String json) {
    return ensureInitialized().decodeJson<Notifications>(json);
  }
}

mixin NotificationsMappable {
  String toJson() {
    return NotificationsMapper.ensureInitialized()
        .encodeJson<Notifications>(this as Notifications);
  }

  Map<String, dynamic> toMap() {
    return NotificationsMapper.ensureInitialized()
        .encodeMap<Notifications>(this as Notifications);
  }

  NotificationsCopyWith<Notifications, Notifications, Notifications>
      get copyWith => _NotificationsCopyWithImpl<Notifications, Notifications>(
          this as Notifications, $identity, $identity);
  @override
  String toString() {
    return NotificationsMapper.ensureInitialized()
        .stringifyValue(this as Notifications);
  }

  @override
  bool operator ==(Object other) {
    return NotificationsMapper.ensureInitialized()
        .equalsValue(this as Notifications, other);
  }

  @override
  int get hashCode {
    return NotificationsMapper.ensureInitialized()
        .hashValue(this as Notifications);
  }
}

extension NotificationsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Notifications, $Out> {
  NotificationsCopyWith<$R, Notifications, $Out> get $asNotifications =>
      $base.as((v, t, t2) => _NotificationsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class NotificationsCopyWith<$R, $In extends Notifications, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? kuTitle,
      String? arTitle,
      String? enTitle,
      String? kuDescription,
      String? arDescription,
      String? enDescription,
      DateTime? postedAt});
  NotificationsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NotificationsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Notifications, $Out>
    implements NotificationsCopyWith<$R, Notifications, $Out> {
  _NotificationsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Notifications> $mapper =
      NotificationsMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? kuTitle,
          String? arTitle,
          String? enTitle,
          String? kuDescription,
          String? arDescription,
          String? enDescription,
          Object? postedAt = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (kuTitle != null) #kuTitle: kuTitle,
        if (arTitle != null) #arTitle: arTitle,
        if (enTitle != null) #enTitle: enTitle,
        if (kuDescription != null) #kuDescription: kuDescription,
        if (arDescription != null) #arDescription: arDescription,
        if (enDescription != null) #enDescription: enDescription,
        if (postedAt != $none) #postedAt: postedAt
      }));
  @override
  Notifications $make(CopyWithData data) => Notifications(
      id: data.get(#id, or: $value.id),
      kuTitle: data.get(#kuTitle, or: $value.kuTitle),
      arTitle: data.get(#arTitle, or: $value.arTitle),
      enTitle: data.get(#enTitle, or: $value.enTitle),
      kuDescription: data.get(#kuDescription, or: $value.kuDescription),
      arDescription: data.get(#arDescription, or: $value.arDescription),
      enDescription: data.get(#enDescription, or: $value.enDescription),
      postedAt: data.get(#postedAt, or: $value.postedAt));

  @override
  NotificationsCopyWith<$R2, Notifications, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NotificationsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
