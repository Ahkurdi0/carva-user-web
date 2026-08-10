// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_company.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$detailCompanyHash() => r'db81ffe54b4587416059138e8ee93b0314c39568';

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

abstract class _$DetailCompany
    extends BuildlessAutoDisposeAsyncNotifier<Company> {
  late final String companyId;

  FutureOr<Company> build(String companyId);
}

/// See also [DetailCompany].
@ProviderFor(DetailCompany)
const detailCompanyProvider = DetailCompanyFamily();

/// See also [DetailCompany].
class DetailCompanyFamily extends Family<AsyncValue<Company>> {
  /// See also [DetailCompany].
  const DetailCompanyFamily();

  /// See also [DetailCompany].
  DetailCompanyProvider call(String companyId) {
    return DetailCompanyProvider(companyId);
  }

  @override
  DetailCompanyProvider getProviderOverride(
    covariant DetailCompanyProvider provider,
  ) {
    return call(provider.companyId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'detailCompanyProvider';
}

/// See also [DetailCompany].
class DetailCompanyProvider
    extends AutoDisposeAsyncNotifierProviderImpl<DetailCompany, Company> {
  /// See also [DetailCompany].
  DetailCompanyProvider(String companyId)
    : this._internal(
        () => DetailCompany()..companyId = companyId,
        from: detailCompanyProvider,
        name: r'detailCompanyProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$detailCompanyHash,
        dependencies: DetailCompanyFamily._dependencies,
        allTransitiveDependencies:
            DetailCompanyFamily._allTransitiveDependencies,
        companyId: companyId,
      );

  DetailCompanyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.companyId,
  }) : super.internal();

  final String companyId;

  @override
  FutureOr<Company> runNotifierBuild(covariant DetailCompany notifier) {
    return notifier.build(companyId);
  }

  @override
  Override overrideWith(DetailCompany Function() create) {
    return ProviderOverride(
      origin: this,
      override: DetailCompanyProvider._internal(
        () => create()..companyId = companyId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        companyId: companyId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DetailCompany, Company>
  createElement() {
    return _DetailCompanyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DetailCompanyProvider && other.companyId == companyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, companyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DetailCompanyRef on AutoDisposeAsyncNotifierProviderRef<Company> {
  /// The parameter `companyId` of this provider.
  String get companyId;
}

class _DetailCompanyProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DetailCompany, Company>
    with DetailCompanyRef {
  _DetailCompanyProviderElement(super.provider);

  @override
  String get companyId => (origin as DetailCompanyProvider).companyId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
