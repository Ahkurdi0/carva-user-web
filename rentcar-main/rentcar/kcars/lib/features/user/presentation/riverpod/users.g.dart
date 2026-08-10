// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$usersHash() => r'22a65439931bdf2f649a5a5c79cba8c72bb36319';

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

abstract class _$Users
    extends BuildlessAutoDisposeNotifier<PagingState<Profile>> {
  late final String role;

  PagingState<Profile> build(String role);
}

/// See also [Users].
@ProviderFor(Users)
const usersProvider = UsersFamily();

/// See also [Users].
class UsersFamily extends Family<PagingState<Profile>> {
  /// See also [Users].
  const UsersFamily();

  /// See also [Users].
  UsersProvider call(String role) {
    return UsersProvider(role);
  }

  @override
  UsersProvider getProviderOverride(covariant UsersProvider provider) {
    return call(provider.role);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'usersProvider';
}

/// See also [Users].
class UsersProvider
    extends AutoDisposeNotifierProviderImpl<Users, PagingState<Profile>> {
  /// See also [Users].
  UsersProvider(String role)
    : this._internal(
        () => Users()..role = role,
        from: usersProvider,
        name: r'usersProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$usersHash,
        dependencies: UsersFamily._dependencies,
        allTransitiveDependencies: UsersFamily._allTransitiveDependencies,
        role: role,
      );

  UsersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.role,
  }) : super.internal();

  final String role;

  @override
  PagingState<Profile> runNotifierBuild(covariant Users notifier) {
    return notifier.build(role);
  }

  @override
  Override overrideWith(Users Function() create) {
    return ProviderOverride(
      origin: this,
      override: UsersProvider._internal(
        () => create()..role = role,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        role: role,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<Users, PagingState<Profile>>
  createElement() {
    return _UsersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UsersProvider && other.role == role;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, role.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UsersRef on AutoDisposeNotifierProviderRef<PagingState<Profile>> {
  /// The parameter `role` of this provider.
  String get role;
}

class _UsersProviderElement
    extends AutoDisposeNotifierProviderElement<Users, PagingState<Profile>>
    with UsersRef {
  _UsersProviderElement(super.provider);

  @override
  String get role => (origin as UsersProvider).role;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
