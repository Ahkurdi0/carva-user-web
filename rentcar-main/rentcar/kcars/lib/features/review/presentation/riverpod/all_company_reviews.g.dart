// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_company_reviews.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allCompanyReviewsHash() => r'744c2bd8d9ec8b600a155a9a9fa99308b4b62103';

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

abstract class _$AllCompanyReviews
    extends BuildlessAutoDisposeNotifier<PagingState<CompanyReview>> {
  late final AllCursorReview param;

  PagingState<CompanyReview> build(AllCursorReview param);
}

/// See also [AllCompanyReviews].
@ProviderFor(AllCompanyReviews)
const allCompanyReviewsProvider = AllCompanyReviewsFamily();

/// See also [AllCompanyReviews].
class AllCompanyReviewsFamily extends Family<PagingState<CompanyReview>> {
  /// See also [AllCompanyReviews].
  const AllCompanyReviewsFamily();

  /// See also [AllCompanyReviews].
  AllCompanyReviewsProvider call(AllCursorReview param) {
    return AllCompanyReviewsProvider(param);
  }

  @override
  AllCompanyReviewsProvider getProviderOverride(
    covariant AllCompanyReviewsProvider provider,
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
  String? get name => r'allCompanyReviewsProvider';
}

/// See also [AllCompanyReviews].
class AllCompanyReviewsProvider
    extends
        AutoDisposeNotifierProviderImpl<
          AllCompanyReviews,
          PagingState<CompanyReview>
        > {
  /// See also [AllCompanyReviews].
  AllCompanyReviewsProvider(AllCursorReview param)
    : this._internal(
        () => AllCompanyReviews()..param = param,
        from: allCompanyReviewsProvider,
        name: r'allCompanyReviewsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$allCompanyReviewsHash,
        dependencies: AllCompanyReviewsFamily._dependencies,
        allTransitiveDependencies:
            AllCompanyReviewsFamily._allTransitiveDependencies,
        param: param,
      );

  AllCompanyReviewsProvider._internal(
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
  PagingState<CompanyReview> runNotifierBuild(
    covariant AllCompanyReviews notifier,
  ) {
    return notifier.build(param);
  }

  @override
  Override overrideWith(AllCompanyReviews Function() create) {
    return ProviderOverride(
      origin: this,
      override: AllCompanyReviewsProvider._internal(
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
  AutoDisposeNotifierProviderElement<
    AllCompanyReviews,
    PagingState<CompanyReview>
  >
  createElement() {
    return _AllCompanyReviewsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AllCompanyReviewsProvider && other.param == param;
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
mixin AllCompanyReviewsRef
    on AutoDisposeNotifierProviderRef<PagingState<CompanyReview>> {
  /// The parameter `param` of this provider.
  AllCursorReview get param;
}

class _AllCompanyReviewsProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          AllCompanyReviews,
          PagingState<CompanyReview>
        >
    with AllCompanyReviewsRef {
  _AllCompanyReviewsProviderElement(super.provider);

  @override
  AllCursorReview get param => (origin as AllCompanyReviewsProvider).param;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
