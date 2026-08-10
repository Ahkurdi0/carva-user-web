// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_statuses.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accountStatusesHash() => r'f55045fdeb6e352ed2395fcccea06590e09aa83b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$AccountStatuses
    extends BuildlessAutoDisposeNotifier<PagingState<AccountStatus>> {
  late final String userId;

  PagingState<AccountStatus> build(String userId);
}

/// See also [AccountStatuses].
@ProviderFor(AccountStatuses)
const accountStatusesProvider = AccountStatusesFamily();

/// See also [AccountStatuses].
class AccountStatusesFamily extends Family<PagingState<AccountStatus>> {
  /// See also [AccountStatuses].
  const AccountStatusesFamily();

  /// See also [AccountStatuses].
  AccountStatusesProvider call(String userId) {
    return AccountStatusesProvider(userId);
  }

  @override
  AccountStatusesProvider getProviderOverride(
    covariant AccountStatusesProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'accountStatusesProvider';
}

/// See also [AccountStatuses].
class AccountStatusesProvider
    extends
        AutoDisposeNotifierProviderImpl<
          AccountStatuses,
          PagingState<AccountStatus>
        > {
  /// See also [AccountStatuses].
  AccountStatusesProvider(String userId)
    : this._internal(
        () => AccountStatuses()..userId = userId,
        from: accountStatusesProvider,
        name: r'accountStatusesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$accountStatusesHash,
        dependencies: AccountStatusesFamily._dependencies,
        allTransitiveDependencies:
            AccountStatusesFamily._allTransitiveDependencies,
        userId: userId,
      );

  AccountStatusesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  PagingState<AccountStatus> runNotifierBuild(
    covariant AccountStatuses notifier,
  ) {
    return notifier.build(userId);
  }

  @override
  Override overrideWith(AccountStatuses Function() create) {
    return ProviderOverride(
      origin: this,
      override: AccountStatusesProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<
    AccountStatuses,
    PagingState<AccountStatus>
  >
  createElement() {
    return _AccountStatusesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AccountStatusesProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AccountStatusesRef
    on AutoDisposeNotifierProviderRef<PagingState<AccountStatus>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _AccountStatusesProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          AccountStatuses,
          PagingState<AccountStatus>
        >
    with AccountStatusesRef {
  _AccountStatusesProviderElement(super.provider);

  @override
  String get userId => (origin as AccountStatusesProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
