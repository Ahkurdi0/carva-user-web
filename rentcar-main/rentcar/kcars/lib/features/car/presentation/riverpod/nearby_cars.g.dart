// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_cars.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nearbayCarsHash() => r'f20cad4e033ea39be2d0360d66867af9851643bf';

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

abstract class _$NearbayCars
    extends BuildlessAutoDisposeAsyncNotifier<List<Car>> {
  late final PostLocation? param;

  FutureOr<List<Car>> build([PostLocation? param]);
}

/// See also [NearbayCars].
@ProviderFor(NearbayCars)
const nearbayCarsProvider = NearbayCarsFamily();

/// See also [NearbayCars].
class NearbayCarsFamily extends Family<AsyncValue<List<Car>>> {
  /// See also [NearbayCars].
  const NearbayCarsFamily();

  /// See also [NearbayCars].
  NearbayCarsProvider call([PostLocation? param]) {
    return NearbayCarsProvider(param);
  }

  @override
  NearbayCarsProvider getProviderOverride(
    covariant NearbayCarsProvider provider,
  ) {
    return call(provider.param);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'nearbayCarsProvider';
}

/// See also [NearbayCars].
class NearbayCarsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<NearbayCars, List<Car>> {
  /// See also [NearbayCars].
  NearbayCarsProvider([PostLocation? param])
    : this._internal(
        () => NearbayCars()..param = param,
        from: nearbayCarsProvider,
        name: r'nearbayCarsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$nearbayCarsHash,
        dependencies: NearbayCarsFamily._dependencies,
        allTransitiveDependencies: NearbayCarsFamily._allTransitiveDependencies,
        param: param,
      );

  NearbayCarsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.param,
  }) : super.internal();

  final PostLocation? param;

  @override
  FutureOr<List<Car>> runNotifierBuild(covariant NearbayCars notifier) {
    return notifier.build(param);
  }

  @override
  Override overrideWith(NearbayCars Function() create) {
    return ProviderOverride(
      origin: this,
      override: NearbayCarsProvider._internal(
        () => create()..param = param,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        param: param,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<NearbayCars, List<Car>>
  createElement() {
    return _NearbayCarsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NearbayCarsProvider && other.param == param;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, param.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin NearbayCarsRef on AutoDisposeAsyncNotifierProviderRef<List<Car>> {
  /// The parameter `param` of this provider.
  PostLocation? get param;
}

class _NearbayCarsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<NearbayCars, List<Car>>
    with NearbayCarsRef {
  _NearbayCarsProviderElement(super.provider);

  @override
  PostLocation? get param => (origin as NearbayCarsProvider).param;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
