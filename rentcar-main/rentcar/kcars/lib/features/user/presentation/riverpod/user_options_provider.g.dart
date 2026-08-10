// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_options_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adminuUserSettingsHash() =>
    r'33cdb88a21fd9c07ae5ad3ceeb299aebb241a3a6';

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

/// See also [adminuUserSettings].
@ProviderFor(adminuUserSettings)
const adminuUserSettingsProvider = AdminuUserSettingsFamily();

/// See also [adminuUserSettings].
class AdminuUserSettingsFamily extends Family<List<AdminUserOptions>> {
  /// See also [adminuUserSettings].
  const AdminuUserSettingsFamily();

  /// See also [adminuUserSettings].
  AdminuUserSettingsProvider call(Profile profile) {
    return AdminuUserSettingsProvider(profile);
  }

  @override
  AdminuUserSettingsProvider getProviderOverride(
    covariant AdminuUserSettingsProvider provider,
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
  String? get name => r'adminuUserSettingsProvider';
}

/// See also [adminuUserSettings].
class AdminuUserSettingsProvider
    extends AutoDisposeProvider<List<AdminUserOptions>> {
  /// See also [adminuUserSettings].
  AdminuUserSettingsProvider(Profile profile)
    : this._internal(
        (ref) => adminuUserSettings(ref as AdminuUserSettingsRef, profile),
        from: adminuUserSettingsProvider,
        name: r'adminuUserSettingsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$adminuUserSettingsHash,
        dependencies: AdminuUserSettingsFamily._dependencies,
        allTransitiveDependencies:
            AdminuUserSettingsFamily._allTransitiveDependencies,
        profile: profile,
      );

  AdminuUserSettingsProvider._internal(
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
    List<AdminUserOptions> Function(AdminuUserSettingsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AdminuUserSettingsProvider._internal(
        (ref) => create(ref as AdminuUserSettingsRef),
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
  AutoDisposeProviderElement<List<AdminUserOptions>> createElement() {
    return _AdminuUserSettingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminuUserSettingsProvider && other.profile == profile;
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
mixin AdminuUserSettingsRef on AutoDisposeProviderRef<List<AdminUserOptions>> {
  /// The parameter `profile` of this provider.
  Profile get profile;
}

class _AdminuUserSettingsProviderElement
    extends AutoDisposeProviderElement<List<AdminUserOptions>>
    with AdminuUserSettingsRef {
  _AdminuUserSettingsProviderElement(super.provider);

  @override
  Profile get profile => (origin as AdminuUserSettingsProvider).profile;
}

String _$adminUserOptionsScreenHash() =>
    r'6d5d3856c41e7fe56aa857799df10eeb24a30d9b';

/// See also [adminUserOptionsScreen].
@ProviderFor(adminUserOptionsScreen)
const adminUserOptionsScreenProvider = AdminUserOptionsScreenFamily();

/// See also [adminUserOptionsScreen].
class AdminUserOptionsScreenFamily extends Family<List<AdminUserOptions>> {
  /// See also [adminUserOptionsScreen].
  const AdminUserOptionsScreenFamily();

  /// See also [adminUserOptionsScreen].
  AdminUserOptionsScreenProvider call(Profile profile) {
    return AdminUserOptionsScreenProvider(profile);
  }

  @override
  AdminUserOptionsScreenProvider getProviderOverride(
    covariant AdminUserOptionsScreenProvider provider,
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
  String? get name => r'adminUserOptionsScreenProvider';
}

/// See also [adminUserOptionsScreen].
class AdminUserOptionsScreenProvider
    extends AutoDisposeProvider<List<AdminUserOptions>> {
  /// See also [adminUserOptionsScreen].
  AdminUserOptionsScreenProvider(Profile profile)
    : this._internal(
        (ref) =>
            adminUserOptionsScreen(ref as AdminUserOptionsScreenRef, profile),
        from: adminUserOptionsScreenProvider,
        name: r'adminUserOptionsScreenProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$adminUserOptionsScreenHash,
        dependencies: AdminUserOptionsScreenFamily._dependencies,
        allTransitiveDependencies:
            AdminUserOptionsScreenFamily._allTransitiveDependencies,
        profile: profile,
      );

  AdminUserOptionsScreenProvider._internal(
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
    List<AdminUserOptions> Function(AdminUserOptionsScreenRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AdminUserOptionsScreenProvider._internal(
        (ref) => create(ref as AdminUserOptionsScreenRef),
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
  AutoDisposeProviderElement<List<AdminUserOptions>> createElement() {
    return _AdminUserOptionsScreenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminUserOptionsScreenProvider && other.profile == profile;
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
mixin AdminUserOptionsScreenRef
    on AutoDisposeProviderRef<List<AdminUserOptions>> {
  /// The parameter `profile` of this provider.
  Profile get profile;
}

class _AdminUserOptionsScreenProviderElement
    extends AutoDisposeProviderElement<List<AdminUserOptions>>
    with AdminUserOptionsScreenRef {
  _AdminUserOptionsScreenProviderElement(super.provider);

  @override
  Profile get profile => (origin as AdminUserOptionsScreenProvider).profile;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
