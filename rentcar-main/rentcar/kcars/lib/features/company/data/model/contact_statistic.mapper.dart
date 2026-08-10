// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'contact_statistic.dart';

class ContactStatisticMapper extends ClassMapperBase<ContactStatistic> {
  ContactStatisticMapper._();

  static ContactStatisticMapper? _instance;
  static ContactStatisticMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContactStatisticMapper._());
      ContactTypesMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ContactStatistic';

  static ContactTypes? _$type(ContactStatistic v) => v.type;
  static const Field<ContactStatistic, ContactTypes> _f$type =
      Field('type', _$type, opt: true);
  static String? _$id(ContactStatistic v) => v.id;
  static const Field<ContactStatistic, String> _f$id =
      Field('id', _$id, opt: true);
  static String? _$contactId(ContactStatistic v) => v.contactId;
  static const Field<ContactStatistic, String> _f$contactId =
      Field('contactId', _$contactId, opt: true);
  static String? _$userId(ContactStatistic v) => v.userId;
  static const Field<ContactStatistic, String> _f$userId =
      Field('userId', _$userId, opt: true);
  static String? _$companyId(ContactStatistic v) => v.companyId;
  static const Field<ContactStatistic, String> _f$companyId =
      Field('companyId', _$companyId, opt: true);
  static String? _$carId(ContactStatistic v) => v.carId;
  static const Field<ContactStatistic, String> _f$carId =
      Field('carId', _$carId, opt: true);
  static String? _$value(ContactStatistic v) => v.value;
  static const Field<ContactStatistic, String> _f$value =
      Field('value', _$value, opt: true);
  static DateTime? _$createdAt(ContactStatistic v) => v.createdAt;
  static const Field<ContactStatistic, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, opt: true);

  @override
  final MappableFields<ContactStatistic> fields = const {
    #type: _f$type,
    #id: _f$id,
    #contactId: _f$contactId,
    #userId: _f$userId,
    #companyId: _f$companyId,
    #carId: _f$carId,
    #value: _f$value,
    #createdAt: _f$createdAt,
  };

  static ContactStatistic _instantiate(DecodingData data) {
    return ContactStatistic(
        type: data.dec(_f$type),
        id: data.dec(_f$id),
        contactId: data.dec(_f$contactId),
        userId: data.dec(_f$userId),
        companyId: data.dec(_f$companyId),
        carId: data.dec(_f$carId),
        value: data.dec(_f$value),
        createdAt: data.dec(_f$createdAt));
  }

  @override
  final Function instantiate = _instantiate;

  static ContactStatistic fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ContactStatistic>(map);
  }

  static ContactStatistic fromJson(String json) {
    return ensureInitialized().decodeJson<ContactStatistic>(json);
  }
}

mixin ContactStatisticMappable {
  String toJson() {
    return ContactStatisticMapper.ensureInitialized()
        .encodeJson<ContactStatistic>(this as ContactStatistic);
  }

  Map<String, dynamic> toMap() {
    return ContactStatisticMapper.ensureInitialized()
        .encodeMap<ContactStatistic>(this as ContactStatistic);
  }

  ContactStatisticCopyWith<ContactStatistic, ContactStatistic, ContactStatistic>
      get copyWith =>
          _ContactStatisticCopyWithImpl<ContactStatistic, ContactStatistic>(
              this as ContactStatistic, $identity, $identity);
  @override
  String toString() {
    return ContactStatisticMapper.ensureInitialized()
        .stringifyValue(this as ContactStatistic);
  }

  @override
  bool operator ==(Object other) {
    return ContactStatisticMapper.ensureInitialized()
        .equalsValue(this as ContactStatistic, other);
  }

  @override
  int get hashCode {
    return ContactStatisticMapper.ensureInitialized()
        .hashValue(this as ContactStatistic);
  }
}

extension ContactStatisticValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ContactStatistic, $Out> {
  ContactStatisticCopyWith<$R, ContactStatistic, $Out>
      get $asContactStatistic => $base
          .as((v, t, t2) => _ContactStatisticCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ContactStatisticCopyWith<$R, $In extends ContactStatistic, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {ContactTypes? type,
      String? id,
      String? contactId,
      String? userId,
      String? companyId,
      String? carId,
      String? value,
      DateTime? createdAt});
  ContactStatisticCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ContactStatisticCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ContactStatistic, $Out>
    implements ContactStatisticCopyWith<$R, ContactStatistic, $Out> {
  _ContactStatisticCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ContactStatistic> $mapper =
      ContactStatisticMapper.ensureInitialized();
  @override
  $R call(
          {Object? type = $none,
          Object? id = $none,
          Object? contactId = $none,
          Object? userId = $none,
          Object? companyId = $none,
          Object? carId = $none,
          Object? value = $none,
          Object? createdAt = $none}) =>
      $apply(FieldCopyWithData({
        if (type != $none) #type: type,
        if (id != $none) #id: id,
        if (contactId != $none) #contactId: contactId,
        if (userId != $none) #userId: userId,
        if (companyId != $none) #companyId: companyId,
        if (carId != $none) #carId: carId,
        if (value != $none) #value: value,
        if (createdAt != $none) #createdAt: createdAt
      }));
  @override
  ContactStatistic $make(CopyWithData data) => ContactStatistic(
      type: data.get(#type, or: $value.type),
      id: data.get(#id, or: $value.id),
      contactId: data.get(#contactId, or: $value.contactId),
      userId: data.get(#userId, or: $value.userId),
      companyId: data.get(#companyId, or: $value.companyId),
      carId: data.get(#carId, or: $value.carId),
      value: data.get(#value, or: $value.value),
      createdAt: data.get(#createdAt, or: $value.createdAt));

  @override
  ContactStatisticCopyWith<$R2, ContactStatistic, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ContactStatisticCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
