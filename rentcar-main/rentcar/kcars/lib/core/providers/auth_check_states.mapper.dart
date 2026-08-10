// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'auth_check_states.dart';

class AuthStateMapper extends ClassMapperBase<AuthState> {
  AuthStateMapper._();

  static AuthStateMapper? _instance;
  static AuthStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthStateMapper._());
      ProfileMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthState';

  static Profile? _$user(AuthState v) => v.user;
  static const Field<AuthState, Profile> _f$user =
      Field('user', _$user, opt: true);
  static bool _$updateAvailable(AuthState v) => v.updateAvailable;
  static const Field<AuthState, bool> _f$updateAvailable =
      Field('updateAvailable', _$updateAvailable, opt: true, def: false);
  static bool _$isInitialized(AuthState v) => v.isInitialized;
  static const Field<AuthState, bool> _f$isInitialized =
      Field('isInitialized', _$isInitialized, opt: true, def: true);
  static bool? _$onBoarding(AuthState v) => v.onBoarding;
  static const Field<AuthState, bool> _f$onBoarding =
      Field('onBoarding', _$onBoarding, opt: true, def: false);
  static bool _$isLoading(AuthState v) => v.isLoading;
  static const Field<AuthState, bool> _f$isLoading =
      Field('isLoading', _$isLoading, opt: true, def: true);

  @override
  final MappableFields<AuthState> fields = const {
    #user: _f$user,
    #updateAvailable: _f$updateAvailable,
    #isInitialized: _f$isInitialized,
    #onBoarding: _f$onBoarding,
    #isLoading: _f$isLoading,
  };

  static AuthState _instantiate(DecodingData data) {
    return AuthState(
        user: data.dec(_f$user),
        updateAvailable: data.dec(_f$updateAvailable),
        isInitialized: data.dec(_f$isInitialized),
        onBoarding: data.dec(_f$onBoarding),
        isLoading: data.dec(_f$isLoading));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthState>(map);
  }

  static AuthState fromJson(String json) {
    return ensureInitialized().decodeJson<AuthState>(json);
  }
}

mixin AuthStateMappable {
  String toJson() {
    return AuthStateMapper.ensureInitialized()
        .encodeJson<AuthState>(this as AuthState);
  }

  Map<String, dynamic> toMap() {
    return AuthStateMapper.ensureInitialized()
        .encodeMap<AuthState>(this as AuthState);
  }

  AuthStateCopyWith<AuthState, AuthState, AuthState> get copyWith =>
      _AuthStateCopyWithImpl<AuthState, AuthState>(
          this as AuthState, $identity, $identity);
  @override
  String toString() {
    return AuthStateMapper.ensureInitialized()
        .stringifyValue(this as AuthState);
  }

  @override
  bool operator ==(Object other) {
    return AuthStateMapper.ensureInitialized()
        .equalsValue(this as AuthState, other);
  }

  @override
  int get hashCode {
    return AuthStateMapper.ensureInitialized().hashValue(this as AuthState);
  }
}

extension AuthStateValueCopy<$R, $Out> on ObjectCopyWith<$R, AuthState, $Out> {
  AuthStateCopyWith<$R, AuthState, $Out> get $asAuthState =>
      $base.as((v, t, t2) => _AuthStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthStateCopyWith<$R, $In extends AuthState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ProfileCopyWith<$R, Profile, Profile>? get user;
  $R call(
      {Profile? user,
      bool? updateAvailable,
      bool? isInitialized,
      bool? onBoarding,
      bool? isLoading});
  AuthStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AuthStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthState, $Out>
    implements AuthStateCopyWith<$R, AuthState, $Out> {
  _AuthStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthState> $mapper =
      AuthStateMapper.ensureInitialized();
  @override
  ProfileCopyWith<$R, Profile, Profile>? get user =>
      $value.user?.copyWith.$chain((v) => call(user: v));
  @override
  $R call(
          {Object? user = $none,
          bool? updateAvailable,
          bool? isInitialized,
          Object? onBoarding = $none,
          bool? isLoading}) =>
      $apply(FieldCopyWithData({
        if (user != $none) #user: user,
        if (updateAvailable != null) #updateAvailable: updateAvailable,
        if (isInitialized != null) #isInitialized: isInitialized,
        if (onBoarding != $none) #onBoarding: onBoarding,
        if (isLoading != null) #isLoading: isLoading
      }));
  @override
  AuthState $make(CopyWithData data) => AuthState(
      user: data.get(#user, or: $value.user),
      updateAvailable: data.get(#updateAvailable, or: $value.updateAvailable),
      isInitialized: data.get(#isInitialized, or: $value.isInitialized),
      onBoarding: data.get(#onBoarding, or: $value.onBoarding),
      isLoading: data.get(#isLoading, or: $value.isLoading));

  @override
  AuthStateCopyWith<$R2, AuthState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
