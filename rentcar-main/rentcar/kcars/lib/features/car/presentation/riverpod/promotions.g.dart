// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotions.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$promotionsHash() => r'2b4f7c12ac1845ca0acd52fab0ef5a6d338e3fcf';

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

abstract class _$Promotions
    extends BuildlessAutoDisposeAsyncNotifier<List<Promotion>> {
  late final PromotionPost? param;

  FutureOr<List<Promotion>> build([PromotionPost? param]);
}

/// See also [Promotions].
@ProviderFor(Promotions)
const promotionsProvider = PromotionsFamily();

/// See also [Promotions].
class PromotionsFamily extends Family<AsyncValue<List<Promotion>>> {
  /// See also [Promotions].
  const PromotionsFamily();

  /// See also [Promotions].
  PromotionsProvider call([PromotionPost? param]) {
    return PromotionsProvider(param);
  }

  @override
  PromotionsProvider getProviderOverride(
    covariant PromotionsProvider provider,
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
  String? get name => r'promotionsProvider';
}

/// See also [Promotions].
class PromotionsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Promotions, List<Promotion>> {
  /// See also [Promotions].
  PromotionsProvider([PromotionPost? param])
    : this._internal(
        () => Promotions()..param = param,
        from: promotionsProvider,
        name: r'promotionsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$promotionsHash,
        dependencies: PromotionsFamily._dependencies,
        allTransitiveDependencies: PromotionsFamily._allTransitiveDependencies,
        param: param,
      );

  PromotionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.param,
  }) : super.internal();

  final PromotionPost? param;

  @override
  FutureOr<List<Promotion>> runNotifierBuild(covariant Promotions notifier) {
    return notifier.build(param);
  }

  @override
  Override overrideWith(Promotions Function() create) {
    return ProviderOverride(
      origin: this,
      override: PromotionsProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<Promotions, List<Promotion>>
  createElement() {
    return _PromotionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PromotionsProvider && other.param == param;
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
mixin PromotionsRef on AutoDisposeAsyncNotifierProviderRef<List<Promotion>> {
  /// The parameter `param` of this provider.
  PromotionPost? get param;
}

class _PromotionsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Promotions, List<Promotion>>
    with PromotionsRef {
  _PromotionsProviderElement(super.provider);

  @override
  PromotionPost? get param => (origin as PromotionsProvider).param;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
