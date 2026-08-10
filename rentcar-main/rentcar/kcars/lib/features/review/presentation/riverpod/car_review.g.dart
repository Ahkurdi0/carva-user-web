// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_review.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$carReviewsHash() => r'fe432925833fbe4d0a8f133bfd4aee7c29c8d001';

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

abstract class _$CarReviews
    extends BuildlessAutoDisposeNotifier<PagingState<CarReview>> {
  late final CursorReview param;

  PagingState<CarReview> build(CursorReview param);
}

/// See also [CarReviews].
@ProviderFor(CarReviews)
const carReviewsProvider = CarReviewsFamily();

/// See also [CarReviews].
class CarReviewsFamily extends Family<PagingState<CarReview>> {
  /// See also [CarReviews].
  const CarReviewsFamily();

  /// See also [CarReviews].
  CarReviewsProvider call(CursorReview param) {
    return CarReviewsProvider(param);
  }

  @override
  CarReviewsProvider getProviderOverride(
    covariant CarReviewsProvider provider,
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
  String? get name => r'carReviewsProvider';
}

/// See also [CarReviews].
class CarReviewsProvider
    extends
        AutoDisposeNotifierProviderImpl<CarReviews, PagingState<CarReview>> {
  /// See also [CarReviews].
  CarReviewsProvider(CursorReview param)
    : this._internal(
        () => CarReviews()..param = param,
        from: carReviewsProvider,
        name: r'carReviewsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$carReviewsHash,
        dependencies: CarReviewsFamily._dependencies,
        allTransitiveDependencies: CarReviewsFamily._allTransitiveDependencies,
        param: param,
      );

  CarReviewsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.param,
  }) : super.internal();

  final CursorReview param;

  @override
  PagingState<CarReview> runNotifierBuild(covariant CarReviews notifier) {
    return notifier.build(param);
  }

  @override
  Override overrideWith(CarReviews Function() create) {
    return ProviderOverride(
      origin: this,
      override: CarReviewsProvider._internal(
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
  AutoDisposeNotifierProviderElement<CarReviews, PagingState<CarReview>>
  createElement() {
    return _CarReviewsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CarReviewsProvider && other.param == param;
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
mixin CarReviewsRef on AutoDisposeNotifierProviderRef<PagingState<CarReview>> {
  /// The parameter `param` of this provider.
  CursorReview get param;
}

class _CarReviewsProviderElement
    extends
        AutoDisposeNotifierProviderElement<CarReviews, PagingState<CarReview>>
    with CarReviewsRef {
  _CarReviewsProviderElement(super.provider);

  @override
  CursorReview get param => (origin as CarReviewsProvider).param;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
