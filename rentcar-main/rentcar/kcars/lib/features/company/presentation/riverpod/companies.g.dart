// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companies.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$companiesHash() => r'120b6bcd0c74f50e687e17488c5e1a042e8bc4ba';

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

abstract class _$Companies
    extends BuildlessAutoDisposeNotifier<PagingState<Company>> {
  late final bool expired;

  PagingState<Company> build(bool expired);
}

/// See also [Companies].
@ProviderFor(Companies)
const companiesProvider = CompaniesFamily();

/// See also [Companies].
class CompaniesFamily extends Family<PagingState<Company>> {
  /// See also [Companies].
  const CompaniesFamily();

  /// See also [Companies].
  CompaniesProvider call(bool expired) {
    return CompaniesProvider(expired);
  }

  @override
  CompaniesProvider getProviderOverride(covariant CompaniesProvider provider) {
    return call(provider.expired);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'companiesProvider';
}

/// See also [Companies].
class CompaniesProvider
    extends AutoDisposeNotifierProviderImpl<Companies, PagingState<Company>> {
  /// See also [Companies].
  CompaniesProvider(bool expired)
    : this._internal(
        () => Companies()..expired = expired,
        from: companiesProvider,
        name: r'companiesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$companiesHash,
        dependencies: CompaniesFamily._dependencies,
        allTransitiveDependencies: CompaniesFamily._allTransitiveDependencies,
        expired: expired,
      );

  CompaniesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.expired,
  }) : super.internal();

  final bool expired;

  @override
  PagingState<Company> runNotifierBuild(covariant Companies notifier) {
    return notifier.build(expired);
  }

  @override
  Override overrideWith(Companies Function() create) {
    return ProviderOverride(
      origin: this,
      override: CompaniesProvider._internal(
        () => create()..expired = expired,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        expired: expired,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<Companies, PagingState<Company>>
  createElement() {
    return _CompaniesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CompaniesProvider && other.expired == expired;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, expired.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CompaniesRef on AutoDisposeNotifierProviderRef<PagingState<Company>> {
  /// The parameter `expired` of this provider.
  bool get expired;
}

class _CompaniesProviderElement
    extends AutoDisposeNotifierProviderElement<Companies, PagingState<Company>>
    with CompaniesRef {
  _CompaniesProviderElement(super.provider);

  @override
  bool get expired => (origin as CompaniesProvider).expired;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
