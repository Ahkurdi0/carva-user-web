// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details_tab.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userDetailsScreensHash() =>
    r'30c86917c8a2861cbb1239ff7eb3fba8a9c39a7f';

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

/// See also [userDetailsScreens].
@ProviderFor(userDetailsScreens)
const userDetailsScreensProvider = UserDetailsScreensFamily();

/// See also [userDetailsScreens].
class UserDetailsScreensFamily extends Family<List<UserDetailsTabs>> {
  /// See also [userDetailsScreens].
  const UserDetailsScreensFamily();

  /// See also [userDetailsScreens].
  UserDetailsScreensProvider call(Profile profile) {
    return UserDetailsScreensProvider(profile);
  }

  @override
  UserDetailsScreensProvider getProviderOverride(
    covariant UserDetailsScreensProvider provider,
  ) {
    return call(provider.profile);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userDetailsScreensProvider';
}

/// See also [userDetailsScreens].
class UserDetailsScreensProvider
    extends AutoDisposeProvider<List<UserDetailsTabs>> {
  /// See also [userDetailsScreens].
  UserDetailsScreensProvider(Profile profile)
    : this._internal(
        (ref) => userDetailsScreens(ref as UserDetailsScreensRef, profile),
        from: userDetailsScreensProvider,
        name: r'userDetailsScreensProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userDetailsScreensHash,
        dependencies: UserDetailsScreensFamily._dependencies,
        allTransitiveDependencies:
            UserDetailsScreensFamily._allTransitiveDependencies,
        profile: profile,
      );

  UserDetailsScreensProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.profile,
  }) : super.internal();

  final Profile profile;

  @override
  Override overrideWith(
    List<UserDetailsTabs> Function(UserDetailsScreensRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserDetailsScreensProvider._internal(
        (ref) => create(ref as UserDetailsScreensRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        profile: profile,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<UserDetailsTabs>> createElement() {
    return _UserDetailsScreensProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserDetailsScreensProvider && other.profile == profile;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, profile.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserDetailsScreensRef on AutoDisposeProviderRef<List<UserDetailsTabs>> {
  /// The parameter `profile` of this provider.
  Profile get profile;
}

class _UserDetailsScreensProviderElement
    extends AutoDisposeProviderElement<List<UserDetailsTabs>>
    with UserDetailsScreensRef {
  _UserDetailsScreensProviderElement(super.provider);

  @override
  Profile get profile => (origin as UserDetailsScreensProvider).profile;
}

String _$userDetailsTabsHash() => r'97329bb2225f7e9b6f926195207b057834c75822';

/// See also [userDetailsTabs].
@ProviderFor(userDetailsTabs)
const userDetailsTabsProvider = UserDetailsTabsFamily();

/// See also [userDetailsTabs].
class UserDetailsTabsFamily extends Family<List<UserDetailsTabs>> {
  /// See also [userDetailsTabs].
  const UserDetailsTabsFamily();

  /// See also [userDetailsTabs].
  UserDetailsTabsProvider call(Profile profile) {
    return UserDetailsTabsProvider(profile);
  }

  @override
  UserDetailsTabsProvider getProviderOverride(
    covariant UserDetailsTabsProvider provider,
  ) {
    return call(provider.profile);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userDetailsTabsProvider';
}

/// See also [userDetailsTabs].
class UserDetailsTabsProvider
    extends AutoDisposeProvider<List<UserDetailsTabs>> {
  /// See also [userDetailsTabs].
  UserDetailsTabsProvider(Profile profile)
    : this._internal(
        (ref) => userDetailsTabs(ref as UserDetailsTabsRef, profile),
        from: userDetailsTabsProvider,
        name: r'userDetailsTabsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userDetailsTabsHash,
        dependencies: UserDetailsTabsFamily._dependencies,
        allTransitiveDependencies:
            UserDetailsTabsFamily._allTransitiveDependencies,
        profile: profile,
      );

  UserDetailsTabsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.profile,
  }) : super.internal();

  final Profile profile;

  @override
  Override overrideWith(
    List<UserDetailsTabs> Function(UserDetailsTabsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserDetailsTabsProvider._internal(
        (ref) => create(ref as UserDetailsTabsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        profile: profile,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<UserDetailsTabs>> createElement() {
    return _UserDetailsTabsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserDetailsTabsProvider && other.profile == profile;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, profile.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserDetailsTabsRef on AutoDisposeProviderRef<List<UserDetailsTabs>> {
  /// The parameter `profile` of this provider.
  Profile get profile;
}

class _UserDetailsTabsProviderElement
    extends AutoDisposeProviderElement<List<UserDetailsTabs>>
    with UserDetailsTabsRef {
  _UserDetailsTabsProviderElement(super.provider);

  @override
  Profile get profile => (origin as UserDetailsTabsProvider).profile;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
