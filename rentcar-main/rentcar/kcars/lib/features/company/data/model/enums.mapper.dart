// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'enums.dart';

class ContactTypesMapper extends EnumMapper<ContactTypes> {
  ContactTypesMapper._();

  static ContactTypesMapper? _instance;
  static ContactTypesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContactTypesMapper._());
    }
    return _instance!;
  }

  static ContactTypes fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ContactTypes decode(dynamic value) {
    switch (value) {
      case r'phone':
        return ContactTypes.phone;
      case r'email':
        return ContactTypes.email;
      case r'whatsapp':
        return ContactTypes.whatsapp;
      case r'viber':
        return ContactTypes.viber;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ContactTypes self) {
    switch (self) {
      case ContactTypes.phone:
        return r'phone';
      case ContactTypes.email:
        return r'email';
      case ContactTypes.whatsapp:
        return r'whatsapp';
      case ContactTypes.viber:
        return r'viber';
    }
  }
}

extension ContactTypesMapperExtension on ContactTypes {
  String toValue() {
    ContactTypesMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ContactTypes>(this) as String;
  }
}
