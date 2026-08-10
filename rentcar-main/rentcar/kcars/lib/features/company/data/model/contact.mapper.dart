// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'contact.dart';

class ContactMapper extends ClassMapperBase<Contact> {
  ContactMapper._();

  static ContactMapper? _instance;
  static ContactMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContactMapper._());
      ContactTypesMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Contact';

  static String? _$id(Contact v) => v.id;
  static const Field<Contact, String> _f$id = Field('id', _$id, opt: true);
  static String? _$countrCode(Contact v) => v.countrCode;
  static const Field<Contact, String> _f$countrCode =
      Field('countrCode', _$countrCode, opt: true);
  static String? _$value(Contact v) => v.value;
  static const Field<Contact, String> _f$value =
      Field('value', _$value, opt: true);
  static ContactTypes? _$type(Contact v) => v.type;
  static const Field<Contact, ContactTypes> _f$type =
      Field('type', _$type, opt: true);
  static bool? _$available(Contact v) => v.available;
  static const Field<Contact, bool> _f$available =
      Field('available', _$available, opt: true);
  static int? _$sort(Contact v) => v.sort;
  static const Field<Contact, int> _f$sort = Field('sort', _$sort, opt: true);

  @override
  final MappableFields<Contact> fields = const {
    #id: _f$id,
    #countrCode: _f$countrCode,
    #value: _f$value,
    #type: _f$type,
    #available: _f$available,
    #sort: _f$sort,
  };

  static Contact _instantiate(DecodingData data) {
    return Contact(
        id: data.dec(_f$id),
        countrCode: data.dec(_f$countrCode),
        value: data.dec(_f$value),
        type: data.dec(_f$type),
        available: data.dec(_f$available),
        sort: data.dec(_f$sort));
  }

  @override
  final Function instantiate = _instantiate;

  static Contact fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Contact>(map);
  }

  static Contact fromJson(String json) {
    return ensureInitialized().decodeJson<Contact>(json);
  }
}

mixin ContactMappable {
  String toJson() {
    return ContactMapper.ensureInitialized()
        .encodeJson<Contact>(this as Contact);
  }

  Map<String, dynamic> toMap() {
    return ContactMapper.ensureInitialized()
        .encodeMap<Contact>(this as Contact);
  }

  ContactCopyWith<Contact, Contact, Contact> get copyWith =>
      _ContactCopyWithImpl<Contact, Contact>(
          this as Contact, $identity, $identity);
  @override
  String toString() {
    return ContactMapper.ensureInitialized().stringifyValue(this as Contact);
  }

  @override
  bool operator ==(Object other) {
    return ContactMapper.ensureInitialized()
        .equalsValue(this as Contact, other);
  }

  @override
  int get hashCode {
    return ContactMapper.ensureInitialized().hashValue(this as Contact);
  }
}

extension ContactValueCopy<$R, $Out> on ObjectCopyWith<$R, Contact, $Out> {
  ContactCopyWith<$R, Contact, $Out> get $asContact =>
      $base.as((v, t, t2) => _ContactCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ContactCopyWith<$R, $In extends Contact, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? countrCode,
      String? value,
      ContactTypes? type,
      bool? available,
      int? sort});
  ContactCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ContactCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Contact, $Out>
    implements ContactCopyWith<$R, Contact, $Out> {
  _ContactCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Contact> $mapper =
      ContactMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          Object? countrCode = $none,
          Object? value = $none,
          Object? type = $none,
          Object? available = $none,
          Object? sort = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (countrCode != $none) #countrCode: countrCode,
        if (value != $none) #value: value,
        if (type != $none) #type: type,
        if (available != $none) #available: available,
        if (sort != $none) #sort: sort
      }));
  @override
  Contact $make(CopyWithData data) => Contact(
      id: data.get(#id, or: $value.id),
      countrCode: data.get(#countrCode, or: $value.countrCode),
      value: data.get(#value, or: $value.value),
      type: data.get(#type, or: $value.type),
      available: data.get(#available, or: $value.available),
      sort: data.get(#sort, or: $value.sort));

  @override
  ContactCopyWith<$R2, Contact, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ContactCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
