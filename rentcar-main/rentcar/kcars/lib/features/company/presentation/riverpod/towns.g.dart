// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'towns.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$townsHash() => r'ba3c7527c767c8c8fbbcb311a56bcc464b661065';

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

/// See also [towns].
@ProviderFor(towns)
const townsProvider = TownsFamily();

/// See also [towns].
class TownsFamily extends Family<List<Town>?> {
  /// See also [towns].
  const TownsFamily();

  /// See also [towns].
  TownsProvider call(String? cityId) {
    return TownsProvider(cityId);
  }

  @override
  TownsProvider getProviderOverride(covariant TownsProvider provider) {
    return call(provider.cityId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'townsProvider';
}

/// See also [towns].
class TownsProvider extends AutoDisposeProvider<List<Town>?> {
  /// See also [towns].
  TownsProvider(String? cityId)
    : this._internal(
        (ref) => towns(ref as TownsRef, cityId),
        from: townsProvider,
        name: r'townsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$townsHash,
        dependencies: TownsFamily._dependencies,
        allTransitiveDependencies: TownsFamily._allTransitiveDependencies,
        cityId: cityId,
      );

  TownsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cityId,
  }) : super.internal();

  final String? cityId;

  @override
  Override overrideWith(List<Town>? Function(TownsRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: TownsProvider._internal(
        (ref) => create(ref as TownsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cityId: cityId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<Town>?> createElement() {
    return _TownsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TownsProvider && other.cityId == cityId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cityId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TownsRef on AutoDisposeProviderRef<List<Town>?> {
  /// The parameter `cityId` of this provider.
  String? get cityId;
}

class _TownsProviderElement extends AutoDisposeProviderElement<List<Town>?>
    with TownsRef {
  _TownsProviderElement(super.provider);

  @override
  String? get cityId => (origin as TownsProvider).cityId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
