// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'auth.dart';

class AuthMapper extends ClassMapperBase<Auth> {
  AuthMapper._();

  static AuthMapper? _instance;
  static AuthMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthMapper._());
      SessionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Auth';

  static String? _$userId(Auth v) => v.userId;
  static const Field<Auth, String> _f$userId =
      Field('userId', _$userId, opt: true);
  static String? _$name(Auth v) => v.name;
  static const Field<Auth, String> _f$name = Field('name', _$name, opt: true);
  static String? _$phoneNumber(Auth v) => v.phoneNumber;
  static const Field<Auth, String> _f$phoneNumber =
      Field('phoneNumber', _$phoneNumber, opt: true);
  static String? _$userName(Auth v) => v.userName;
  static const Field<Auth, String> _f$userName =
      Field('userName', _$userName, opt: true);
  static String? _$email(Auth v) => v.email;
  static const Field<Auth, String> _f$email =
      Field('email', _$email, opt: true);
  static String? _$password(Auth v) => v.password;
  static const Field<Auth, String> _f$password =
      Field('password', _$password, opt: true);
  static String? _$oldPassword(Auth v) => v.oldPassword;
  static const Field<Auth, String> _f$oldPassword =
      Field('oldPassword', _$oldPassword, opt: true);
  static Session? _$session(Auth v) => v.session;
  static const Field<Auth, Session> _f$session =
      Field('session', _$session, opt: true);
  static String? _$image(Auth v) => v.image;
  static const Field<Auth, String> _f$image =
      Field('image', _$image, opt: true);
  static String? _$imageUrl(Auth v) => v.imageUrl;
  static const Field<Auth, String> _f$imageUrl =
      Field('imageUrl', _$imageUrl, opt: true);
  static String? _$countryCode(Auth v) => v.countryCode;
  static const Field<Auth, String> _f$countryCode =
      Field('countryCode', _$countryCode, opt: true);
  static String? _$imageId(Auth v) => v.imageId;
  static const Field<Auth, String> _f$imageId =
      Field('imageId', _$imageId, opt: true);
  static String? _$code(Auth v) => v.code;
  static const Field<Auth, String> _f$code = Field('code', _$code, opt: true);
  static String? _$channel(Auth v) => v.channel;
  static const Field<Auth, String> _f$channel =
      Field('channel', _$channel, opt: true);
  static String? _$otp(Auth v) => v.otp;
  static const Field<Auth, String> _f$otp = Field('otp', _$otp, opt: true);
  static String? _$platform(Auth v) => v.platform;
  static const Field<Auth, String> _f$platform =
      Field('platform', _$platform, opt: true);
  static bool? _$allDevices(Auth v) => v.allDevices;
  static const Field<Auth, bool> _f$allDevices =
      Field('allDevices', _$allDevices, opt: true);
  static String? _$refreshToken(Auth v) => v.refreshToken;
  static const Field<Auth, String> _f$refreshToken =
      Field('refreshToken', _$refreshToken, opt: true);
  static String? _$prefLang(Auth v) => v.prefLang;
  static const Field<Auth, String> _f$prefLang =
      Field('prefLang', _$prefLang, opt: true);

  @override
  final MappableFields<Auth> fields = const {
    #userId: _f$userId,
    #name: _f$name,
    #phoneNumber: _f$phoneNumber,
    #userName: _f$userName,
    #email: _f$email,
    #password: _f$password,
    #oldPassword: _f$oldPassword,
    #session: _f$session,
    #image: _f$image,
    #imageUrl: _f$imageUrl,
    #countryCode: _f$countryCode,
    #imageId: _f$imageId,
    #code: _f$code,
    #channel: _f$channel,
    #otp: _f$otp,
    #platform: _f$platform,
    #allDevices: _f$allDevices,
    #refreshToken: _f$refreshToken,
    #prefLang: _f$prefLang,
  };

  static Auth _instantiate(DecodingData data) {
    return Auth(
        userId: data.dec(_f$userId),
        name: data.dec(_f$name),
        phoneNumber: data.dec(_f$phoneNumber),
        userName: data.dec(_f$userName),
        email: data.dec(_f$email),
        password: data.dec(_f$password),
        oldPassword: data.dec(_f$oldPassword),
        session: data.dec(_f$session),
        image: data.dec(_f$image),
        imageUrl: data.dec(_f$imageUrl),
        countryCode: data.dec(_f$countryCode),
        imageId: data.dec(_f$imageId),
        code: data.dec(_f$code),
        channel: data.dec(_f$channel),
        otp: data.dec(_f$otp),
        platform: data.dec(_f$platform),
        allDevices: data.dec(_f$allDevices),
        refreshToken: data.dec(_f$refreshToken),
        prefLang: data.dec(_f$prefLang));
  }

  @override
  final Function instantiate = _instantiate;

  static Auth fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Auth>(map);
  }

  static Auth fromJson(String json) {
    return ensureInitialized().decodeJson<Auth>(json);
  }
}

mixin AuthMappable {
  String toJson() {
    return AuthMapper.ensureInitialized().encodeJson<Auth>(this as Auth);
  }

  Map<String, dynamic> toMap() {
    return AuthMapper.ensureInitialized().encodeMap<Auth>(this as Auth);
  }

  AuthCopyWith<Auth, Auth, Auth> get copyWith =>
      _AuthCopyWithImpl<Auth, Auth>(this as Auth, $identity, $identity);
  @override
  String toString() {
    return AuthMapper.ensureInitialized().stringifyValue(this as Auth);
  }

  @override
  bool operator ==(Object other) {
    return AuthMapper.ensureInitialized().equalsValue(this as Auth, other);
  }

  @override
  int get hashCode {
    return AuthMapper.ensureInitialized().hashValue(this as Auth);
  }
}

extension AuthValueCopy<$R, $Out> on ObjectCopyWith<$R, Auth, $Out> {
  AuthCopyWith<$R, Auth, $Out> get $asAuth =>
      $base.as((v, t, t2) => _AuthCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthCopyWith<$R, $In extends Auth, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  SessionCopyWith<$R, Session, Session>? get session;
  $R call(
      {String? userId,
      String? name,
      String? phoneNumber,
      String? userName,
      String? email,
      String? password,
      String? oldPassword,
      Session? session,
      String? image,
      String? imageUrl,
      String? countryCode,
      String? imageId,
      String? code,
      String? channel,
      String? otp,
      String? platform,
      bool? allDevices,
      String? refreshToken,
      String? prefLang});
  AuthCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AuthCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Auth, $Out>
    implements AuthCopyWith<$R, Auth, $Out> {
  _AuthCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Auth> $mapper = AuthMapper.ensureInitialized();
  @override
  SessionCopyWith<$R, Session, Session>? get session =>
      $value.session?.copyWith.$chain((v) => call(session: v));
  @override
  $R call(
          {Object? userId = $none,
          Object? name = $none,
          Object? phoneNumber = $none,
          Object? userName = $none,
          Object? email = $none,
          Object? password = $none,
          Object? oldPassword = $none,
          Object? session = $none,
          Object? image = $none,
          Object? imageUrl = $none,
          Object? countryCode = $none,
          Object? imageId = $none,
          Object? code = $none,
          Object? channel = $none,
          Object? otp = $none,
          Object? platform = $none,
          Object? allDevices = $none,
          Object? refreshToken = $none,
          Object? prefLang = $none}) =>
      $apply(FieldCopyWithData({
        if (userId != $none) #userId: userId,
        if (name != $none) #name: name,
        if (phoneNumber != $none) #phoneNumber: phoneNumber,
        if (userName != $none) #userName: userName,
        if (email != $none) #email: email,
        if (password != $none) #password: password,
        if (oldPassword != $none) #oldPassword: oldPassword,
        if (session != $none) #session: session,
        if (image != $none) #image: image,
        if (imageUrl != $none) #imageUrl: imageUrl,
        if (countryCode != $none) #countryCode: countryCode,
        if (imageId != $none) #imageId: imageId,
        if (code != $none) #code: code,
        if (channel != $none) #channel: channel,
        if (otp != $none) #otp: otp,
        if (platform != $none) #platform: platform,
        if (allDevices != $none) #allDevices: allDevices,
        if (refreshToken != $none) #refreshToken: refreshToken,
        if (prefLang != $none) #prefLang: prefLang
      }));
  @override
  Auth $make(CopyWithData data) => Auth(
      userId: data.get(#userId, or: $value.userId),
      name: data.get(#name, or: $value.name),
      phoneNumber: data.get(#phoneNumber, or: $value.phoneNumber),
      userName: data.get(#userName, or: $value.userName),
      email: data.get(#email, or: $value.email),
      password: data.get(#password, or: $value.password),
      oldPassword: data.get(#oldPassword, or: $value.oldPassword),
      session: data.get(#session, or: $value.session),
      image: data.get(#image, or: $value.image),
      imageUrl: data.get(#imageUrl, or: $value.imageUrl),
      countryCode: data.get(#countryCode, or: $value.countryCode),
      imageId: data.get(#imageId, or: $value.imageId),
      code: data.get(#code, or: $value.code),
      channel: data.get(#channel, or: $value.channel),
      otp: data.get(#otp, or: $value.otp),
      platform: data.get(#platform, or: $value.platform),
      allDevices: data.get(#allDevices, or: $value.allDevices),
      refreshToken: data.get(#refreshToken, or: $value.refreshToken),
      prefLang: data.get(#prefLang, or: $value.prefLang));

  @override
  AuthCopyWith<$R2, Auth, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AuthCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
