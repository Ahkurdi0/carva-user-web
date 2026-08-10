// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_password.dart';

class UserPasswordMapper extends ClassMapperBase<UserPassword> {
  UserPasswordMapper._();

  static UserPasswordMapper? _instance;
  static UserPasswordMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserPasswordMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserPassword';

  static String _$password(UserPassword v) => v.password;
  static const Field<UserPassword, String> _f$password =
      Field('password', _$password);
  static String _$userId(UserPassword v) => v.userId;
  static const Field<UserPassword, String> _f$userId =
      Field('userId', _$userId);

  @override
  final MappableFields<UserPassword> fields = const {
    #password: _f$password,
    #userId: _f$userId,
  };

  static UserPassword _instantiate(DecodingData data) {
    return UserPassword(
        password: data.dec(_f$password), userId: data.dec(_f$userId));
  }

  @override
  final Function instantiate = _instantiate;

  static UserPassword fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserPassword>(map);
  }

  static UserPassword fromJson(String json) {
    return ensureInitialized().decodeJson<UserPassword>(json);
  }
}

mixin UserPasswordMappable {
  String toJson() {
    return UserPasswordMapper.ensureInitialized()
        .encodeJson<UserPassword>(this as UserPassword);
  }

  Map<String, dynamic> toMap() {
    return UserPasswordMapper.ensureInitialized()
        .encodeMap<UserPassword>(this as UserPassword);
  }

  UserPasswordCopyWith<UserPassword, UserPassword, UserPassword> get copyWith =>
      _UserPasswordCopyWithImpl<UserPassword, UserPassword>(
          this as UserPassword, $identity, $identity);
  @override
  String toString() {
    return UserPasswordMapper.ensureInitialized()
        .stringifyValue(this as UserPassword);
  }

  @override
  bool operator ==(Object other) {
    return UserPasswordMapper.ensureInitialized()
        .equalsValue(this as UserPassword, other);
  }

  @override
  int get hashCode {
    return UserPasswordMapper.ensureInitialized()
        .hashValue(this as UserPassword);
  }
}

extension UserPasswordValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserPassword, $Out> {
  UserPasswordCopyWith<$R, UserPassword, $Out> get $asUserPassword =>
      $base.as((v, t, t2) => _UserPasswordCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserPasswordCopyWith<$R, $In extends UserPassword, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? password, String? userId});
  UserPasswordCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserPasswordCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserPassword, $Out>
    implements UserPasswordCopyWith<$R, UserPassword, $Out> {
  _UserPasswordCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserPassword> $mapper =
      UserPasswordMapper.ensureInitialized();
  @override
  $R call({String? password, String? userId}) => $apply(FieldCopyWithData({
        if (password != null) #password: password,
        if (userId != null) #userId: userId
      }));
  @override
  UserPassword $make(CopyWithData data) => UserPassword(
      password: data.get(#password, or: $value.password),
      userId: data.get(#userId, or: $value.userId));

  @override
  UserPasswordCopyWith<$R2, UserPassword, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UserPasswordCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
