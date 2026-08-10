// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggested_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$suggestedCarHash() => r'90b92796d3668ae8eceb155ba9b10466fd893547';

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

abstract class _$SuggestedCar
    extends BuildlessAutoDisposeAsyncNotifier<List<Car>> {
  late final PostLocation? param;

  FutureOr<List<Car>> build([PostLocation? param]);
}

/// See also [SuggestedCar].
@ProviderFor(SuggestedCar)
const suggestedCarProvider = SuggestedCarFamily();

/// See also [SuggestedCar].
class SuggestedCarFamily extends Family<AsyncValue<List<Car>>> {
  /// See also [SuggestedCar].
  const SuggestedCarFamily();

  /// See also [SuggestedCar].
  SuggestedCarProvider call([PostLocation? param]) {
    return SuggestedCarProvider(param);
  }

  @override
  SuggestedCarProvider getProviderOverride(
    covariant SuggestedCarProvider provider,
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
  String? get name => r'suggestedCarProvider';
}

/// See also [SuggestedCar].
class SuggestedCarProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SuggestedCar, List<Car>> {
  /// See also [SuggestedCar].
  SuggestedCarProvider([PostLocation? param])
    : this._internal(
        () => SuggestedCar()..param = param,
        from: suggestedCarProvider,
        name: r'suggestedCarProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$suggestedCarHash,
        dependencies: SuggestedCarFamily._dependencies,
        allTransitiveDependencies:
            SuggestedCarFamily._allTransitiveDependencies,
        param: param,
      );

  SuggestedCarProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.param,
  }) : super.internal();

  final PostLocation? param;

  @override
  FutureOr<List<Car>> runNotifierBuild(covariant SuggestedCar notifier) {
    return notifier.build(param);
  }

  @override
  Override overrideWith(SuggestedCar Function() create) {
    return ProviderOverride(
      origin: this,
      override: SuggestedCarProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<SuggestedCar, List<Car>>
  createElement() {
    return _SuggestedCarProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SuggestedCarProvider && other.param == param;
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
mixin SuggestedCarRef on AutoDisposeAsyncNotifierProviderRef<List<Car>> {
  /// The parameter `param` of this provider.
  PostLocation? get param;
}

class _SuggestedCarProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SuggestedCar, List<Car>>
    with SuggestedCarRef {
  _SuggestedCarProviderElement(super.provider);

  @override
  PostLocation? get param => (origin as SuggestedCarProvider).param;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
