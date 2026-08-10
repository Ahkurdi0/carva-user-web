// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_companies.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allCompaniesHash() => r'42d726c3614484fbd0591db5653797f0a2c6fd00';

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

abstract class _$AllCompanies
    extends BuildlessAutoDisposeNotifier<PagingState<Company>> {
  late final bool inl;

  PagingState<Company> build(bool inl);
}

/// See also [AllCompanies].
@ProviderFor(AllCompanies)
const allCompaniesProvider = AllCompaniesFamily();

/// See also [AllCompanies].
class AllCompaniesFamily extends Family<PagingState<Company>> {
  /// See also [AllCompanies].
  const AllCompaniesFamily();

  /// See also [AllCompanies].
  AllCompaniesProvider call(bool inl) {
    return AllCompaniesProvider(inl);
  }

  @override
  AllCompaniesProvider getProviderOverride(
    covariant AllCompaniesProvider provider,
  ) {
    return call(provider.inl);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'allCompaniesProvider';
}

/// See also [AllCompanies].
class AllCompaniesProvider
    extends
        AutoDisposeNotifierProviderImpl<AllCompanies, PagingState<Company>> {
  /// See also [AllCompanies].
  AllCompaniesProvider(bool inl)
    : this._internal(
        () => AllCompanies()..inl = inl,
        from: allCompaniesProvider,
        name: r'allCompaniesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$allCompaniesHash,
        dependencies: AllCompaniesFamily._dependencies,
        allTransitiveDependencies:
            AllCompaniesFamily._allTransitiveDependencies,
        inl: inl,
      );

  AllCompaniesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.inl,
  }) : super.internal();

  final bool inl;

  @override
  PagingState<Company> runNotifierBuild(covariant AllCompanies notifier) {
    return notifier.build(inl);
  }

  @override
  Override overrideWith(AllCompanies Function() create) {
    return ProviderOverride(
      origin: this,
      override: AllCompaniesProvider._internal(
        () => create()..inl = inl,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        inl: inl,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<AllCompanies, PagingState<Company>>
  createElement() {
    return _AllCompaniesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AllCompaniesProvider && other.inl == inl;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, inl.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AllCompaniesRef on AutoDisposeNotifierProviderRef<PagingState<Company>> {
  /// The parameter `inl` of this provider.
  bool get inl;
}

class _AllCompaniesProviderElement
    extends
        AutoDisposeNotifierProviderElement<AllCompanies, PagingState<Company>>
    with AllCompaniesRef {
  _AllCompaniesProviderElement(super.provider);

  @override
  bool get inl => (origin as AllCompaniesProvider).inl;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
