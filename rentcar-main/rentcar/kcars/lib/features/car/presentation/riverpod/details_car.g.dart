// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_car.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$detailsCarHash() => r'94f5d98be1f0eacff398739cf64a60b9be7b84d2';

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

abstract class _$DetailsCar extends BuildlessAutoDisposeAsyncNotifier<Car> {
  late final String carId;

  FutureOr<Car> build(String carId);
}

/// See also [DetailsCar].
@ProviderFor(DetailsCar)
const detailsCarProvider = DetailsCarFamily();

/// See also [DetailsCar].
class DetailsCarFamily extends Family<AsyncValue<Car>> {
  /// See also [DetailsCar].
  const DetailsCarFamily();

  /// See also [DetailsCar].
  DetailsCarProvider call(String carId) {
    return DetailsCarProvider(carId);
  }

  @override
  DetailsCarProvider getProviderOverride(
    covariant DetailsCarProvider provider,
  ) {
    return call(provider.carId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'detailsCarProvider';
}

/// See also [DetailsCar].
class DetailsCarProvider
    extends AutoDisposeAsyncNotifierProviderImpl<DetailsCar, Car> {
  /// See also [DetailsCar].
  DetailsCarProvider(String carId)
    : this._internal(
        () => DetailsCar()..carId = carId,
        from: detailsCarProvider,
        name: r'detailsCarProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$detailsCarHash,
        dependencies: DetailsCarFamily._dependencies,
        allTransitiveDependencies: DetailsCarFamily._allTransitiveDependencies,
        carId: carId,
      );

  DetailsCarProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.carId,
  }) : super.internal();

  final String carId;

  @override
  FutureOr<Car> runNotifierBuild(covariant DetailsCar notifier) {
    return notifier.build(carId);
  }

  @override
  Override overrideWith(DetailsCar Function() create) {
    return ProviderOverride(
      origin: this,
      override: DetailsCarProvider._internal(
        () => create()..carId = carId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        carId: carId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DetailsCar, Car> createElement() {
    return _DetailsCarProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DetailsCarProvider && other.carId == carId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, carId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DetailsCarRef on AutoDisposeAsyncNotifierProviderRef<Car> {
  /// The parameter `carId` of this provider.
  String get carId;
}

class _DetailsCarProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DetailsCar, Car>
    with DetailsCarRef {
  _DetailsCarProviderElement(super.provider);

  @override
  String get carId => (origin as DetailsCarProvider).carId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
