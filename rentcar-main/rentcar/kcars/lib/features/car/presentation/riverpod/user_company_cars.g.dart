// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_company_cars.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userCompanyCarsHash() => r'93dcfd3538092c7662c6eb9da07f20e7789f9ef9';

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

abstract class _$UserCompanyCars
    extends BuildlessAutoDisposeAsyncNotifier<List<Car>> {
  late final CarsCursor param;

  FutureOr<List<Car>> build(CarsCursor param);
}

/// See also [UserCompanyCars].
@ProviderFor(UserCompanyCars)
const userCompanyCarsProvider = UserCompanyCarsFamily();

/// See also [UserCompanyCars].
class UserCompanyCarsFamily extends Family<AsyncValue<List<Car>>> {
  /// See also [UserCompanyCars].
  const UserCompanyCarsFamily();

  /// See also [UserCompanyCars].
  UserCompanyCarsProvider call(CarsCursor param) {
    return UserCompanyCarsProvider(param);
  }

  @override
  UserCompanyCarsProvider getProviderOverride(
    covariant UserCompanyCarsProvider provider,
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
  String? get name => r'userCompanyCarsProvider';
}

/// See also [UserCompanyCars].
class UserCompanyCarsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<UserCompanyCars, List<Car>> {
  /// See also [UserCompanyCars].
  UserCompanyCarsProvider(CarsCursor param)
    : this._internal(
        () => UserCompanyCars()..param = param,
        from: userCompanyCarsProvider,
        name: r'userCompanyCarsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userCompanyCarsHash,
        dependencies: UserCompanyCarsFamily._dependencies,
        allTransitiveDependencies:
            UserCompanyCarsFamily._allTransitiveDependencies,
        param: param,
      );

  UserCompanyCarsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.param,
  }) : super.internal();

  final CarsCursor param;

  @override
  FutureOr<List<Car>> runNotifierBuild(covariant UserCompanyCars notifier) {
    return notifier.build(param);
  }

  @override
  Override overrideWith(UserCompanyCars Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserCompanyCarsProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<UserCompanyCars, List<Car>>
  createElement() {
    return _UserCompanyCarsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserCompanyCarsProvider && other.param == param;
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
mixin UserCompanyCarsRef on AutoDisposeAsyncNotifierProviderRef<List<Car>> {
  /// The parameter `param` of this provider.
  CarsCursor get param;
}

class _UserCompanyCarsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UserCompanyCars, List<Car>>
    with UserCompanyCarsRef {
  _UserCompanyCarsProviderElement(super.provider);

  @override
  CarsCursor get param => (origin as UserCompanyCarsProvider).param;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
