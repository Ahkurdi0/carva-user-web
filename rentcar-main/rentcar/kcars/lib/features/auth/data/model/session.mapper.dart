// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'session.dart';

class SessionMapper extends ClassMapperBase<Session> {
  SessionMapper._();

  static SessionMapper? _instance;
  static SessionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SessionMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Session';

  static String? _$id(Session v) => v.id;
  static const Field<Session, String> _f$id = Field('id', _$id, opt: true);
  static String? _$sessionId(Session v) => v.sessionId;
  static const Field<Session, String> _f$sessionId =
      Field('sessionId', _$sessionId, opt: true);
  static dynamic _$systemName(Session v) => v.systemName;
  static const Field<Session, dynamic> _f$systemName =
      Field('systemName', _$systemName, opt: true);
  static dynamic _$isPhysicalDevice(Session v) => v.isPhysicalDevice;
  static const Field<Session, dynamic> _f$isPhysicalDevice =
      Field('isPhysicalDevice', _$isPhysicalDevice, opt: true);
  static dynamic _$model(Session v) => v.model;
  static const Field<Session, dynamic> _f$model =
      Field('model', _$model, opt: true);
  static dynamic _$localizedModel(Session v) => v.localizedModel;
  static const Field<Session, dynamic> _f$localizedModel =
      Field('localizedModel', _$localizedModel, opt: true);
  static dynamic _$systemVersion(Session v) => v.systemVersion;
  static const Field<Session, dynamic> _f$systemVersion =
      Field('systemVersion', _$systemVersion, opt: true);
  static dynamic _$name(Session v) => v.name;
  static const Field<Session, dynamic> _f$name =
      Field('name', _$name, opt: true);
  static dynamic _$identifierForVendor(Session v) => v.identifierForVendor;
  static const Field<Session, dynamic> _f$identifierForVendor =
      Field('identifierForVendor', _$identifierForVendor, opt: true);
  static DateTime? _$lastLogin(Session v) => v.lastLogin;
  static const Field<Session, DateTime> _f$lastLogin =
      Field('lastLogin', _$lastLogin, opt: true);
  static dynamic _$platform(Session v) => v.platform;
  static const Field<Session, dynamic> _f$platform =
      Field('platform', _$platform, opt: true);

  @override
  final MappableFields<Session> fields = const {
    #id: _f$id,
    #sessionId: _f$sessionId,
    #systemName: _f$systemName,
    #isPhysicalDevice: _f$isPhysicalDevice,
    #model: _f$model,
    #localizedModel: _f$localizedModel,
    #systemVersion: _f$systemVersion,
    #name: _f$name,
    #identifierForVendor: _f$identifierForVendor,
    #lastLogin: _f$lastLogin,
    #platform: _f$platform,
  };

  static Session _instantiate(DecodingData data) {
    return Session(
        id: data.dec(_f$id),
        sessionId: data.dec(_f$sessionId),
        systemName: data.dec(_f$systemName),
        isPhysicalDevice: data.dec(_f$isPhysicalDevice),
        model: data.dec(_f$model),
        localizedModel: data.dec(_f$localizedModel),
        systemVersion: data.dec(_f$systemVersion),
        name: data.dec(_f$name),
        identifierForVendor: data.dec(_f$identifierForVendor),
        lastLogin: data.dec(_f$lastLogin),
        platform: data.dec(_f$platform));
  }

  @override
  final Function instantiate = _instantiate;

  static Session fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Session>(map);
  }

  static Session fromJson(String json) {
    return ensureInitialized().decodeJson<Session>(json);
  }
}

mixin SessionMappable {
  String toJson() {
    return SessionMapper.ensureInitialized()
        .encodeJson<Session>(this as Session);
  }

  Map<String, dynamic> toMap() {
    return SessionMapper.ensureInitialized()
        .encodeMap<Session>(this as Session);
  }

  SessionCopyWith<Session, Session, Session> get copyWith =>
      _SessionCopyWithImpl<Session, Session>(
          this as Session, $identity, $identity);
  @override
  String toString() {
    return SessionMapper.ensureInitialized().stringifyValue(this as Session);
  }

  @override
  bool operator ==(Object other) {
    return SessionMapper.ensureInitialized()
        .equalsValue(this as Session, other);
  }

  @override
  int get hashCode {
    return SessionMapper.ensureInitialized().hashValue(this as Session);
  }
}

extension SessionValueCopy<$R, $Out> on ObjectCopyWith<$R, Session, $Out> {
  SessionCopyWith<$R, Session, $Out> get $asSession =>
      $base.as((v, t, t2) => _SessionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SessionCopyWith<$R, $In extends Session, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? sessionId,
      dynamic systemName,
      dynamic isPhysicalDevice,
      dynamic model,
      dynamic localizedModel,
      dynamic systemVersion,
      dynamic name,
      dynamic identifierForVendor,
      DateTime? lastLogin,
      dynamic platform});
  SessionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SessionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Session, $Out>
    implements SessionCopyWith<$R, Session, $Out> {
  _SessionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Session> $mapper =
      SessionMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          Object? sessionId = $none,
          Object? systemName = $none,
          Object? isPhysicalDevice = $none,
          Object? model = $none,
          Object? localizedModel = $none,
          Object? systemVersion = $none,
          Object? name = $none,
          Object? identifierForVendor = $none,
          Object? lastLogin = $none,
          Object? platform = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (sessionId != $none) #sessionId: sessionId,
        if (systemName != $none) #systemName: systemName,
        if (isPhysicalDevice != $none) #isPhysicalDevice: isPhysicalDevice,
        if (model != $none) #model: model,
        if (localizedModel != $none) #localizedModel: localizedModel,
        if (systemVersion != $none) #systemVersion: systemVersion,
        if (name != $none) #name: name,
        if (identifierForVendor != $none)
          #identifierForVendor: identifierForVendor,
        if (lastLogin != $none) #lastLogin: lastLogin,
        if (platform != $none) #platform: platform
      }));
  @override
  Session $make(CopyWithData data) => Session(
      id: data.get(#id, or: $value.id),
      sessionId: data.get(#sessionId, or: $value.sessionId),
      systemName: data.get(#systemName, or: $value.systemName),
      isPhysicalDevice:
          data.get(#isPhysicalDevice, or: $value.isPhysicalDevice),
      model: data.get(#model, or: $value.model),
      localizedModel: data.get(#localizedModel, or: $value.localizedModel),
      systemVersion: data.get(#systemVersion, or: $value.systemVersion),
      name: data.get(#name, or: $value.name),
      identifierForVendor:
          data.get(#identifierForVendor, or: $value.identifierForVendor),
      lastLogin: data.get(#lastLogin, or: $value.lastLogin),
      platform: data.get(#platform, or: $value.platform));

  @override
  SessionCopyWith<$R2, Session, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SessionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
