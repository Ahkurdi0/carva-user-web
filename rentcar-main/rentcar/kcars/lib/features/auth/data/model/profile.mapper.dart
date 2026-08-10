// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'profile.dart';

class ProfileMapper extends ClassMapperBase<Profile> {
  ProfileMapper._();

  static ProfileMapper? _instance;
  static ProfileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProfileMapper._());
      RoleMapper.ensureInitialized();
      PermissionsMapper.ensureInitialized();
      CompanyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Profile';

  static String? _$id(Profile v) => v.id;
  static const Field<Profile, String> _f$id = Field('id', _$id, opt: true);
  static int? _$serial(Profile v) => v.serial;
  static const Field<Profile, int> _f$serial =
      Field('serial', _$serial, opt: true);
  static String _$userId(Profile v) => v.userId;
  static const Field<Profile, String> _f$userId = Field('userId', _$userId);
  static String _$name(Profile v) => v.name;
  static const Field<Profile, String> _f$name = Field('name', _$name);
  static String? _$userName(Profile v) => v.userName;
  static const Field<Profile, String> _f$userName =
      Field('userName', _$userName, opt: true);
  static String _$email(Profile v) => v.email;
  static const Field<Profile, String> _f$email = Field('email', _$email);
  static DateTime? _$joinedAt(Profile v) => v.joinedAt;
  static const Field<Profile, DateTime> _f$joinedAt =
      Field('joinedAt', _$joinedAt, opt: true);
  static DateTime? _$emailVerifiedAt(Profile v) => v.emailVerifiedAt;
  static const Field<Profile, DateTime> _f$emailVerifiedAt =
      Field('emailVerifiedAt', _$emailVerifiedAt, opt: true);
  static DateTime? _$phoneVerifiedAt(Profile v) => v.phoneVerifiedAt;
  static const Field<Profile, DateTime> _f$phoneVerifiedAt =
      Field('phoneVerifiedAt', _$phoneVerifiedAt, opt: true);
  static String? _$phoneNumber(Profile v) => v.phoneNumber;
  static const Field<Profile, String> _f$phoneNumber =
      Field('phoneNumber', _$phoneNumber);
  static String? _$image(Profile v) => v.image;
  static const Field<Profile, String> _f$image =
      Field('image', _$image, opt: true);
  static Role _$role(Profile v) => v.role;
  static const Field<Profile, Role> _f$role = Field('role', _$role);
  static String? _$countryCode(Profile v) => v.countryCode;
  static const Field<Profile, String> _f$countryCode =
      Field('countryCode', _$countryCode);
  static List<Permissions> _$permissions(Profile v) => v.permissions;
  static const Field<Profile, List<Permissions>> _f$permissions =
      Field('permissions', _$permissions);
  static Company? _$company(Profile v) => v.company;
  static const Field<Profile, Company> _f$company =
      Field('company', _$company, opt: true);
  static String? _$accessToken(Profile v) => v.accessToken;
  static const Field<Profile, String> _f$accessToken =
      Field('accessToken', _$accessToken, opt: true);
  static String? _$refreshToken(Profile v) => v.refreshToken;
  static const Field<Profile, String> _f$refreshToken =
      Field('refreshToken', _$refreshToken, opt: true);

  @override
  final MappableFields<Profile> fields = const {
    #id: _f$id,
    #serial: _f$serial,
    #userId: _f$userId,
    #name: _f$name,
    #userName: _f$userName,
    #email: _f$email,
    #joinedAt: _f$joinedAt,
    #emailVerifiedAt: _f$emailVerifiedAt,
    #phoneVerifiedAt: _f$phoneVerifiedAt,
    #phoneNumber: _f$phoneNumber,
    #image: _f$image,
    #role: _f$role,
    #countryCode: _f$countryCode,
    #permissions: _f$permissions,
    #company: _f$company,
    #accessToken: _f$accessToken,
    #refreshToken: _f$refreshToken,
  };

  static Profile _instantiate(DecodingData data) {
    return Profile(
        id: data.dec(_f$id),
        serial: data.dec(_f$serial),
        userId: data.dec(_f$userId),
        name: data.dec(_f$name),
        userName: data.dec(_f$userName),
        email: data.dec(_f$email),
        joinedAt: data.dec(_f$joinedAt),
        emailVerifiedAt: data.dec(_f$emailVerifiedAt),
        phoneVerifiedAt: data.dec(_f$phoneVerifiedAt),
        phoneNumber: data.dec(_f$phoneNumber),
        image: data.dec(_f$image),
        role: data.dec(_f$role),
        countryCode: data.dec(_f$countryCode),
        permissions: data.dec(_f$permissions),
        company: data.dec(_f$company),
        accessToken: data.dec(_f$accessToken),
        refreshToken: data.dec(_f$refreshToken));
  }

  @override
  final Function instantiate = _instantiate;

  static Profile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Profile>(map);
  }

  static Profile fromJson(String json) {
    return ensureInitialized().decodeJson<Profile>(json);
  }
}

mixin ProfileMappable {
  String toJson() {
    return ProfileMapper.ensureInitialized()
        .encodeJson<Profile>(this as Profile);
  }

  Map<String, dynamic> toMap() {
    return ProfileMapper.ensureInitialized()
        .encodeMap<Profile>(this as Profile);
  }

  ProfileCopyWith<Profile, Profile, Profile> get copyWith =>
      _ProfileCopyWithImpl<Profile, Profile>(
          this as Profile, $identity, $identity);
  @override
  String toString() {
    return ProfileMapper.ensureInitialized().stringifyValue(this as Profile);
  }

  @override
  bool operator ==(Object other) {
    return ProfileMapper.ensureInitialized()
        .equalsValue(this as Profile, other);
  }

  @override
  int get hashCode {
    return ProfileMapper.ensureInitialized().hashValue(this as Profile);
  }
}

extension ProfileValueCopy<$R, $Out> on ObjectCopyWith<$R, Profile, $Out> {
  ProfileCopyWith<$R, Profile, $Out> get $asProfile =>
      $base.as((v, t, t2) => _ProfileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProfileCopyWith<$R, $In extends Profile, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  RoleCopyWith<$R, Role, Role> get role;
  ListCopyWith<$R, Permissions,
      PermissionsCopyWith<$R, Permissions, Permissions>> get permissions;
  CompanyCopyWith<$R, Company, Company>? get company;
  $R call(
      {String? id,
      int? serial,
      String? userId,
      String? name,
      String? userName,
      String? email,
      DateTime? joinedAt,
      DateTime? emailVerifiedAt,
      DateTime? phoneVerifiedAt,
      String? phoneNumber,
      String? image,
      Role? role,
      String? countryCode,
      List<Permissions>? permissions,
      Company? company,
      String? accessToken,
      String? refreshToken});
  ProfileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProfileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Profile, $Out>
    implements ProfileCopyWith<$R, Profile, $Out> {
  _ProfileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Profile> $mapper =
      ProfileMapper.ensureInitialized();
  @override
  RoleCopyWith<$R, Role, Role> get role =>
      $value.role.copyWith.$chain((v) => call(role: v));
  @override
  ListCopyWith<$R, Permissions,
          PermissionsCopyWith<$R, Permissions, Permissions>>
      get permissions => ListCopyWith($value.permissions,
          (v, t) => v.copyWith.$chain(t), (v) => call(permissions: v));
  @override
  CompanyCopyWith<$R, Company, Company>? get company =>
      $value.company?.copyWith.$chain((v) => call(company: v));
  @override
  $R call(
          {Object? id = $none,
          Object? serial = $none,
          String? userId,
          String? name,
          Object? userName = $none,
          String? email,
          Object? joinedAt = $none,
          Object? emailVerifiedAt = $none,
          Object? phoneVerifiedAt = $none,
          Object? phoneNumber = $none,
          Object? image = $none,
          Role? role,
          Object? countryCode = $none,
          List<Permissions>? permissions,
          Object? company = $none,
          Object? accessToken = $none,
          Object? refreshToken = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (serial != $none) #serial: serial,
        if (userId != null) #userId: userId,
        if (name != null) #name: name,
        if (userName != $none) #userName: userName,
        if (email != null) #email: email,
        if (joinedAt != $none) #joinedAt: joinedAt,
        if (emailVerifiedAt != $none) #emailVerifiedAt: emailVerifiedAt,
        if (phoneVerifiedAt != $none) #phoneVerifiedAt: phoneVerifiedAt,
        if (phoneNumber != $none) #phoneNumber: phoneNumber,
        if (image != $none) #image: image,
        if (role != null) #role: role,
        if (countryCode != $none) #countryCode: countryCode,
        if (permissions != null) #permissions: permissions,
        if (company != $none) #company: company,
        if (accessToken != $none) #accessToken: accessToken,
        if (refreshToken != $none) #refreshToken: refreshToken
      }));
  @override
  Profile $make(CopyWithData data) => Profile(
      id: data.get(#id, or: $value.id),
      serial: data.get(#serial, or: $value.serial),
      userId: data.get(#userId, or: $value.userId),
      name: data.get(#name, or: $value.name),
      userName: data.get(#userName, or: $value.userName),
      email: data.get(#email, or: $value.email),
      joinedAt: data.get(#joinedAt, or: $value.joinedAt),
      emailVerifiedAt: data.get(#emailVerifiedAt, or: $value.emailVerifiedAt),
      phoneVerifiedAt: data.get(#phoneVerifiedAt, or: $value.phoneVerifiedAt),
      phoneNumber: data.get(#phoneNumber, or: $value.phoneNumber),
      image: data.get(#image, or: $value.image),
      role: data.get(#role, or: $value.role),
      countryCode: data.get(#countryCode, or: $value.countryCode),
      permissions: data.get(#permissions, or: $value.permissions),
      company: data.get(#company, or: $value.company),
      accessToken: data.get(#accessToken, or: $value.accessToken),
      refreshToken: data.get(#refreshToken, or: $value.refreshToken));

  @override
  ProfileCopyWith<$R2, Profile, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ProfileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
