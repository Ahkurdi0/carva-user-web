// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adminStatisticsHash() => r'bd7ef804733309e5e5e5c64d15f804bbf8b27d7f';

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

abstract class _$AdminStatistics
    extends BuildlessAutoDisposeAsyncNotifier<Statistics> {
  late final DateTime? date;

  FutureOr<Statistics> build([DateTime? date]);
}

/// See also [AdminStatistics].
@ProviderFor(AdminStatistics)
const adminStatisticsProvider = AdminStatisticsFamily();

/// See also [AdminStatistics].
class AdminStatisticsFamily extends Family<AsyncValue<Statistics>> {
  /// See also [AdminStatistics].
  const AdminStatisticsFamily();

  /// See also [AdminStatistics].
  AdminStatisticsProvider call([DateTime? date]) {
    return AdminStatisticsProvider(date);
  }

  @override
  AdminStatisticsProvider getProviderOverride(
    covariant AdminStatisticsProvider provider,
  ) {
    return call(provider.date);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'adminStatisticsProvider';
}

/// See also [AdminStatistics].
class AdminStatisticsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AdminStatistics, Statistics> {
  /// See also [AdminStatistics].
  AdminStatisticsProvider([DateTime? date])
    : this._internal(
        () => AdminStatistics()..date = date,
        from: adminStatisticsProvider,
        name: r'adminStatisticsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$adminStatisticsHash,
        dependencies: AdminStatisticsFamily._dependencies,
        allTransitiveDependencies:
            AdminStatisticsFamily._allTransitiveDependencies,
        date: date,
      );

  AdminStatisticsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime? date;

  @override
  FutureOr<Statistics> runNotifierBuild(covariant AdminStatistics notifier) {
    return notifier.build(date);
  }

  @override
  Override overrideWith(AdminStatistics Function() create) {
    return ProviderOverride(
      origin: this,
      override: AdminStatisticsProvider._internal(
        () => create()..date = date,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AdminStatistics, Statistics>
  createElement() {
    return _AdminStatisticsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminStatisticsProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AdminStatisticsRef on AutoDisposeAsyncNotifierProviderRef<Statistics> {
  /// The parameter `date` of this provider.
  DateTime? get date;
}

class _AdminStatisticsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AdminStatistics, Statistics>
    with AdminStatisticsRef {
  _AdminStatisticsProviderElement(super.provider);

  @override
  DateTime? get date => (origin as AdminStatisticsProvider).date;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
