// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'account_status.dart';

class AccountStatusMapper extends ClassMapperBase<AccountStatus> {
  AccountStatusMapper._();

  static AccountStatusMapper? _instance;
  static AccountStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AccountStatusMapper._());
      ProfileMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AccountStatus';

  static String? _$id(AccountStatus v) => v.id;
  static const Field<AccountStatus, String> _f$id =
      Field('id', _$id, opt: true);
  static String? _$userId(AccountStatus v) => v.userId;
  static const Field<AccountStatus, String> _f$userId =
      Field('userId', _$userId, opt: true);
  static Profile? _$profile(AccountStatus v) => v.profile;
  static const Field<AccountStatus, Profile> _f$profile =
      Field('profile', _$profile, opt: true);
  static String? _$title(AccountStatus v) => v.title;
  static const Field<AccountStatus, String> _f$title =
      Field('title', _$title, opt: true);
  static String? _$description(AccountStatus v) => v.description;
  static const Field<AccountStatus, String> _f$description =
      Field('description', _$description, opt: true);
  static DateTime? _$bannedAt(AccountStatus v) => v.bannedAt;
  static const Field<AccountStatus, DateTime> _f$bannedAt =
      Field('bannedAt', _$bannedAt, opt: true);
  static DateTime? _$bannedUntil(AccountStatus v) => v.bannedUntil;
  static const Field<AccountStatus, DateTime> _f$bannedUntil =
      Field('bannedUntil', _$bannedUntil, opt: true);

  @override
  final MappableFields<AccountStatus> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #profile: _f$profile,
    #title: _f$title,
    #description: _f$description,
    #bannedAt: _f$bannedAt,
    #bannedUntil: _f$bannedUntil,
  };

  static AccountStatus _instantiate(DecodingData data) {
    return AccountStatus(
        id: data.dec(_f$id),
        userId: data.dec(_f$userId),
        profile: data.dec(_f$profile),
        title: data.dec(_f$title),
        description: data.dec(_f$description),
        bannedAt: data.dec(_f$bannedAt),
        bannedUntil: data.dec(_f$bannedUntil));
  }

  @override
  final Function instantiate = _instantiate;

  static AccountStatus fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AccountStatus>(map);
  }

  static AccountStatus fromJson(String json) {
    return ensureInitialized().decodeJson<AccountStatus>(json);
  }
}

mixin AccountStatusMappable {
  String toJson() {
    return AccountStatusMapper.ensureInitialized()
        .encodeJson<AccountStatus>(this as AccountStatus);
  }

  Map<String, dynamic> toMap() {
    return AccountStatusMapper.ensureInitialized()
        .encodeMap<AccountStatus>(this as AccountStatus);
  }

  AccountStatusCopyWith<AccountStatus, AccountStatus, AccountStatus>
      get copyWith => _AccountStatusCopyWithImpl<AccountStatus, AccountStatus>(
          this as AccountStatus, $identity, $identity);
  @override
  String toString() {
    return AccountStatusMapper.ensureInitialized()
        .stringifyValue(this as AccountStatus);
  }

  @override
  bool operator ==(Object other) {
    return AccountStatusMapper.ensureInitialized()
        .equalsValue(this as AccountStatus, other);
  }

  @override
  int get hashCode {
    return AccountStatusMapper.ensureInitialized()
        .hashValue(this as AccountStatus);
  }
}

extension AccountStatusValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AccountStatus, $Out> {
  AccountStatusCopyWith<$R, AccountStatus, $Out> get $asAccountStatus =>
      $base.as((v, t, t2) => _AccountStatusCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AccountStatusCopyWith<$R, $In extends AccountStatus, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ProfileCopyWith<$R, Profile, Profile>? get profile;
  $R call(
      {String? id,
      String? userId,
      Profile? profile,
      String? title,
      String? description,
      DateTime? bannedAt,
      DateTime? bannedUntil});
  AccountStatusCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AccountStatusCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AccountStatus, $Out>
    implements AccountStatusCopyWith<$R, AccountStatus, $Out> {
  _AccountStatusCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AccountStatus> $mapper =
      AccountStatusMapper.ensureInitialized();
  @override
  ProfileCopyWith<$R, Profile, Profile>? get profile =>
      $value.profile?.copyWith.$chain((v) => call(profile: v));
  @override
  $R call(
          {Object? id = $none,
          Object? userId = $none,
          Object? profile = $none,
          Object? title = $none,
          Object? description = $none,
          Object? bannedAt = $none,
          Object? bannedUntil = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (userId != $none) #userId: userId,
        if (profile != $none) #profile: profile,
        if (title != $none) #title: title,
        if (description != $none) #description: description,
        if (bannedAt != $none) #bannedAt: bannedAt,
        if (bannedUntil != $none) #bannedUntil: bannedUntil
      }));
  @override
  AccountStatus $make(CopyWithData data) => AccountStatus(
      id: data.get(#id, or: $value.id),
      userId: data.get(#userId, or: $value.userId),
      profile: data.get(#profile, or: $value.profile),
      title: data.get(#title, or: $value.title),
      description: data.get(#description, or: $value.description),
      bannedAt: data.get(#bannedAt, or: $value.bannedAt),
      bannedUntil: data.get(#bannedUntil, or: $value.bannedUntil));

  @override
  AccountStatusCopyWith<$R2, AccountStatus, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AccountStatusCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
