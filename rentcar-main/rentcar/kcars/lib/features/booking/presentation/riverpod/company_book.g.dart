// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_book.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$companyBookedHash() => r'de575f9637b3bb3f1ad4db6632fa3107c6d502bd';

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

abstract class _$CompanyBooked
    extends BuildlessAutoDisposeNotifier<PagingState<Book>> {
  late final BookCursor param;

  PagingState<Book> build(BookCursor param);
}

/// See also [CompanyBooked].
@ProviderFor(CompanyBooked)
const companyBookedProvider = CompanyBookedFamily();

/// See also [CompanyBooked].
class CompanyBookedFamily extends Family<PagingState<Book>> {
  /// See also [CompanyBooked].
  const CompanyBookedFamily();

  /// See also [CompanyBooked].
  CompanyBookedProvider call(BookCursor param) {
    return CompanyBookedProvider(param);
  }

  @override
  CompanyBookedProvider getProviderOverride(
    covariant CompanyBookedProvider provider,
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
  String? get name => r'companyBookedProvider';
}

/// See also [CompanyBooked].
class CompanyBookedProvider
    extends AutoDisposeNotifierProviderImpl<CompanyBooked, PagingState<Book>> {
  /// See also [CompanyBooked].
  CompanyBookedProvider(BookCursor param)
    : this._internal(
        () => CompanyBooked()..param = param,
        from: companyBookedProvider,
        name: r'companyBookedProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$companyBookedHash,
        dependencies: CompanyBookedFamily._dependencies,
        allTransitiveDependencies:
            CompanyBookedFamily._allTransitiveDependencies,
        param: param,
      );

  CompanyBookedProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.param,
  }) : super.internal();

  final BookCursor param;

  @override
  PagingState<Book> runNotifierBuild(covariant CompanyBooked notifier) {
    return notifier.build(param);
  }

  @override
  Override overrideWith(CompanyBooked Function() create) {
    return ProviderOverride(
      origin: this,
      override: CompanyBookedProvider._internal(
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
  AutoDisposeNotifierProviderElement<CompanyBooked, PagingState<Book>>
  createElement() {
    return _CompanyBookedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CompanyBookedProvider && other.param == param;
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
mixin CompanyBookedRef on AutoDisposeNotifierProviderRef<PagingState<Book>> {
  /// The parameter `param` of this provider.
  BookCursor get param;
}

class _CompanyBookedProviderElement
    extends AutoDisposeNotifierProviderElement<CompanyBooked, PagingState<Book>>
    with CompanyBookedRef {
  _CompanyBookedProviderElement(super.provider);

  @override
  BookCursor get param => (origin as CompanyBookedProvider).param;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
