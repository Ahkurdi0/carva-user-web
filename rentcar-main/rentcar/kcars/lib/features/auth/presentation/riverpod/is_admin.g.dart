// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_admin.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hasPermossionHash() => r'a460ed4e0fd5b5d6c4ef3e0784e9bd74479181d4';

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

/// See also [hasPermossion].
@ProviderFor(hasPermossion)
const hasPermossionProvider = HasPermossionFamily();

/// See also [hasPermossion].
class HasPermossionFamily extends Family<bool> {
  /// See also [hasPermossion].
  const HasPermossionFamily();

  /// See also [hasPermossion].
  HasPermossionProvider call([Permissions? permission]) {
    return HasPermossionProvider(permission);
  }

  @override
  HasPermossionProvider getProviderOverride(
    covariant HasPermossionProvider provider,
  ) {
    return call(provider.permission);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'hasPermossionProvider';
}

/// See also [hasPermossion].
class HasPermossionProvider extends AutoDisposeProvider<bool> {
  /// See also [hasPermossion].
  HasPermossionProvider([Permissions? permission])
    : this._internal(
        (ref) => hasPermossion(ref as HasPermossionRef, permission),
        from: hasPermossionProvider,
        name: r'hasPermossionProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$hasPermossionHash,
        dependencies: HasPermossionFamily._dependencies,
        allTransitiveDependencies:
            HasPermossionFamily._allTransitiveDependencies,
        permission: permission,
      );

  HasPermossionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.permission,
  }) : super.internal();

  final Permissions? permission;

  @override
  Override overrideWith(bool Function(HasPermossionRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: HasPermossionProvider._internal(
        (ref) => create(ref as HasPermossionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        permission: permission,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _HasPermossionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HasPermossionProvider && other.permission == permission;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, permission.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HasPermossionRef on AutoDisposeProviderRef<bool> {
  /// The parameter `permission` of this provider.
  Permissions? get permission;
}

class _HasPermossionProviderElement extends AutoDisposeProviderElement<bool>
    with HasPermossionRef {
  _HasPermossionProviderElement(super.provider);

  @override
  Permissions? get permission => (origin as HasPermossionProvider).permission;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
