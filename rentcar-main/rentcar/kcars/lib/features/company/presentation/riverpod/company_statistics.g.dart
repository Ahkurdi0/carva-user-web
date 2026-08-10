// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_statistics.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$companyStatisticsHash() => r'77572757acda8d5f554a8efc2d4ed6f9b9b3efd6';

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

abstract class _$CompanyStatistics
    extends BuildlessAutoDisposeAsyncNotifier<List<CompanyStatistic>> {
  late final DateTime? date;

  FutureOr<List<CompanyStatistic>> build([DateTime? date]);
}

/// See also [CompanyStatistics].
@ProviderFor(CompanyStatistics)
const companyStatisticsProvider = CompanyStatisticsFamily();

/// See also [CompanyStatistics].
class CompanyStatisticsFamily
    extends Family<AsyncValue<List<CompanyStatistic>>> {
  /// See also [CompanyStatistics].
  const CompanyStatisticsFamily();

  /// See also [CompanyStatistics].
  CompanyStatisticsProvider call([DateTime? date]) {
    return CompanyStatisticsProvider(date);
  }

  @override
  CompanyStatisticsProvider getProviderOverride(
    covariant CompanyStatisticsProvider provider,
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
  String? get name => r'companyStatisticsProvider';
}

/// See also [CompanyStatistics].
class CompanyStatisticsProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          CompanyStatistics,
          List<CompanyStatistic>
        > {
  /// See also [CompanyStatistics].
  CompanyStatisticsProvider([DateTime? date])
    : this._internal(
        () => CompanyStatistics()..date = date,
        from: companyStatisticsProvider,
        name: r'companyStatisticsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$companyStatisticsHash,
        dependencies: CompanyStatisticsFamily._dependencies,
        allTransitiveDependencies:
            CompanyStatisticsFamily._allTransitiveDependencies,
        date: date,
      );

  CompanyStatisticsProvider._internal(
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
  FutureOr<List<CompanyStatistic>> runNotifierBuild(
    covariant CompanyStatistics notifier,
  ) {
    return notifier.build(date);
  }

  @override
  Override overrideWith(CompanyStatistics Function() create) {
    return ProviderOverride(
      origin: this,
      override: CompanyStatisticsProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<
    CompanyStatistics,
    List<CompanyStatistic>
  >
  createElement() {
    return _CompanyStatisticsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CompanyStatisticsProvider && other.date == date;
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
mixin CompanyStatisticsRef
    on AutoDisposeAsyncNotifierProviderRef<List<CompanyStatistic>> {
  /// The parameter `date` of this provider.
  DateTime? get date;
}

class _CompanyStatisticsProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          CompanyStatistics,
          List<CompanyStatistic>
        >
    with CompanyStatisticsRef {
  _CompanyStatisticsProviderElement(super.provider);

  @override
  DateTime? get date => (origin as CompanyStatisticsProvider).date;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
