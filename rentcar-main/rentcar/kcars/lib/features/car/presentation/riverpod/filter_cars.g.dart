// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_cars.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filtersCarsHash() => r'ee18b5adcffa952d57bde5c8cc5bd0b123bcfc77';

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

abstract class _$FiltersCars
    extends BuildlessAutoDisposeNotifier<PagingState<Car>> {
  late final String? id;

  PagingState<Car> build([String? id]);
}

/// See also [FiltersCars].
@ProviderFor(FiltersCars)
const filtersCarsProvider = FiltersCarsFamily();

/// See also [FiltersCars].
class FiltersCarsFamily extends Family<PagingState<Car>> {
  /// See also [FiltersCars].
  const FiltersCarsFamily();

  /// See also [FiltersCars].
  FiltersCarsProvider call([String? id]) {
    return FiltersCarsProvider(id);
  }

  @override
  FiltersCarsProvider getProviderOverride(
    covariant FiltersCarsProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'filtersCarsProvider';
}

/// See also [FiltersCars].
class FiltersCarsProvider
    extends AutoDisposeNotifierProviderImpl<FiltersCars, PagingState<Car>> {
  /// See also [FiltersCars].
  FiltersCarsProvider([String? id])
    : this._internal(
        () => FiltersCars()..id = id,
        from: filtersCarsProvider,
        name: r'filtersCarsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$filtersCarsHash,
        dependencies: FiltersCarsFamily._dependencies,
        allTransitiveDependencies: FiltersCarsFamily._allTransitiveDependencies,
        id: id,
      );

  FiltersCarsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String? id;

  @override
  PagingState<Car> runNotifierBuild(covariant FiltersCars notifier) {
    return notifier.build(id);
  }

  @override
  Override overrideWith(FiltersCars Function() create) {
    return ProviderOverride(
      origin: this,
      override: FiltersCarsProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<FiltersCars, PagingState<Car>>
  createElement() {
    return _FiltersCarsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FiltersCarsProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FiltersCarsRef on AutoDisposeNotifierProviderRef<PagingState<Car>> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _FiltersCarsProviderElement
    extends AutoDisposeNotifierProviderElement<FiltersCars, PagingState<Car>>
    with FiltersCarsRef {
  _FiltersCarsProviderElement(super.provider);

  @override
  String? get id => (origin as FiltersCarsProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
