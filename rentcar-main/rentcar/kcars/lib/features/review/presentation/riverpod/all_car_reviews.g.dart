// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_car_reviews.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allCarReviewsHash() => r'fdfbe43a6d3c36db4c7ff623c257de3226aa8fea';

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

abstract class _$AllCarReviews
    extends BuildlessAutoDisposeNotifier<PagingState<CarReview>> {
  late final AllCursorReview param;

  PagingState<CarReview> build(AllCursorReview param);
}

/// See also [AllCarReviews].
@ProviderFor(AllCarReviews)
const allCarReviewsProvider = AllCarReviewsFamily();

/// See also [AllCarReviews].
class AllCarReviewsFamily extends Family<PagingState<CarReview>> {
  /// See also [AllCarReviews].
  const AllCarReviewsFamily();

  /// See also [AllCarReviews].
  AllCarReviewsProvider call(AllCursorReview param) {
    return AllCarReviewsProvider(param);
  }

  @override
  AllCarReviewsProvider getProviderOverride(
    covariant AllCarReviewsProvider provider,
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
  String? get name => r'allCarReviewsProvider';
}

/// See also [AllCarReviews].
class AllCarReviewsProvider
    extends
        AutoDisposeNotifierProviderImpl<AllCarReviews, PagingState<CarReview>> {
  /// See also [AllCarReviews].
  AllCarReviewsProvider(AllCursorReview param)
    : this._internal(
        () => AllCarReviews()..param = param,
        from: allCarReviewsProvider,
        name: r'allCarReviewsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$allCarReviewsHash,
        dependencies: AllCarReviewsFamily._dependencies,
        allTransitiveDependencies:
            AllCarReviewsFamily._allTransitiveDependencies,
        param: param,
      );

  AllCarReviewsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.param,
  }) : super.internal();

  final AllCursorReview param;

  @override
  PagingState<CarReview> runNotifierBuild(covariant AllCarReviews notifier) {
    return notifier.build(param);
  }

  @override
  Override overrideWith(AllCarReviews Function() create) {
    return ProviderOverride(
      origin: this,
      override: AllCarReviewsProvider._internal(
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
  AutoDisposeNotifierProviderElement<AllCarReviews, PagingState<CarReview>>
  createElement() {
    return _AllCarReviewsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AllCarReviewsProvider && other.param == param;
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
mixin AllCarReviewsRef
    on AutoDisposeNotifierProviderRef<PagingState<CarReview>> {
  /// The parameter `param` of this provider.
  AllCursorReview get param;
}

class _AllCarReviewsProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          AllCarReviews,
          PagingState<CarReview>
        >
    with AllCarReviewsRef {
  _AllCarReviewsProviderElement(super.provider);

  @override
  AllCursorReview get param => (origin as AllCarReviewsProvider).param;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
