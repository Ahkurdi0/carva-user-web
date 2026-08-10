// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_reviwes.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$companyReviewsHash() => r'5ad5f4c0df126556c75e2eee94277b977f417c96';

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

abstract class _$CompanyReviews
    extends BuildlessAutoDisposeNotifier<PagingState<CompanyReview>> {
  late final CursorReview param;

  PagingState<CompanyReview> build(CursorReview param);
}

/// See also [CompanyReviews].
@ProviderFor(CompanyReviews)
const companyReviewsProvider = CompanyReviewsFamily();

/// See also [CompanyReviews].
class CompanyReviewsFamily extends Family<PagingState<CompanyReview>> {
  /// See also [CompanyReviews].
  const CompanyReviewsFamily();

  /// See also [CompanyReviews].
  CompanyReviewsProvider call(CursorReview param) {
    return CompanyReviewsProvider(param);
  }

  @override
  CompanyReviewsProvider getProviderOverride(
    covariant CompanyReviewsProvider provider,
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
  String? get name => r'companyReviewsProvider';
}

/// See also [CompanyReviews].
class CompanyReviewsProvider
    extends
        AutoDisposeNotifierProviderImpl<
          CompanyReviews,
          PagingState<CompanyReview>
        > {
  /// See also [CompanyReviews].
  CompanyReviewsProvider(CursorReview param)
    : this._internal(
        () => CompanyReviews()..param = param,
        from: companyReviewsProvider,
        name: r'companyReviewsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$companyReviewsHash,
        dependencies: CompanyReviewsFamily._dependencies,
        allTransitiveDependencies:
            CompanyReviewsFamily._allTransitiveDependencies,
        param: param,
      );

  CompanyReviewsProvider._internal(
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
  PagingState<CompanyReview> runNotifierBuild(
    covariant CompanyReviews notifier,
  ) {
    return notifier.build(param);
  }

  @override
  Override overrideWith(CompanyReviews Function() create) {
    return ProviderOverride(
      origin: this,
      override: CompanyReviewsProvider._internal(
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
  AutoDisposeNotifierProviderElement<CompanyReviews, PagingState<CompanyReview>>
  createElement() {
    return _CompanyReviewsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CompanyReviewsProvider && other.param == param;
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
mixin CompanyReviewsRef
    on AutoDisposeNotifierProviderRef<PagingState<CompanyReview>> {
  /// The parameter `param` of this provider.
  CursorReview get param;
}

class _CompanyReviewsProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          CompanyReviews,
          PagingState<CompanyReview>
        >
    with CompanyReviewsRef {
  _CompanyReviewsProviderElement(super.provider);

  @override
  CursorReview get param => (origin as CompanyReviewsProvider).param;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
