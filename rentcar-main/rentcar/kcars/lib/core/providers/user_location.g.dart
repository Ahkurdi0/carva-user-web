// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userLocationHash() => r'1b3f66d82812be8c1ada8069dd09ea44dea5c90b';

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

abstract class _$UserLocation
    extends BuildlessAutoDisposeNotifier<PostLocation> {
  late final bool? explorer;

  PostLocation build([bool? explorer]);
}

/// See also [UserLocation].
@ProviderFor(UserLocation)
const userLocationProvider = UserLocationFamily();

/// See also [UserLocation].
class UserLocationFamily extends Family<PostLocation> {
  /// See also [UserLocation].
  const UserLocationFamily();

  /// See also [UserLocation].
  UserLocationProvider call([bool? explorer]) {
    return UserLocationProvider(explorer);
  }

  @override
  UserLocationProvider getProviderOverride(
    covariant UserLocationProvider provider,
  ) {
    return call(provider.explorer);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userLocationProvider';
}

/// See also [UserLocation].
class UserLocationProvider
    extends AutoDisposeNotifierProviderImpl<UserLocation, PostLocation> {
  /// See also [UserLocation].
  UserLocationProvider([bool? explorer])
    : this._internal(
        () => UserLocation()..explorer = explorer,
        from: userLocationProvider,
        name: r'userLocationProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userLocationHash,
        dependencies: UserLocationFamily._dependencies,
        allTransitiveDependencies:
            UserLocationFamily._allTransitiveDependencies,
        explorer: explorer,
      );

  UserLocationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.explorer,
  }) : super.internal();

  final bool? explorer;

  @override
  PostLocation runNotifierBuild(covariant UserLocation notifier) {
    return notifier.build(explorer);
  }

  @override
  Override overrideWith(UserLocation Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserLocationProvider._internal(
        () => create()..explorer = explorer,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        explorer: explorer,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<UserLocation, PostLocation>
  createElement() {
    return _UserLocationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserLocationProvider && other.explorer == explorer;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, explorer.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserLocationRef on AutoDisposeNotifierProviderRef<PostLocation> {
  /// The parameter `explorer` of this provider.
  bool? get explorer;
}

class _UserLocationProviderElement
    extends AutoDisposeNotifierProviderElement<UserLocation, PostLocation>
    with UserLocationRef {
  _UserLocationProviderElement(super.provider);

  @override
  bool? get explorer => (origin as UserLocationProvider).explorer;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
