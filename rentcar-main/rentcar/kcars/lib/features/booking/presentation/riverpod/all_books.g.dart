// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_books.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allBooksHash() => r'6899f100e21a781917232c2444252c861f269486';

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

abstract class _$AllBooks
    extends BuildlessAutoDisposeNotifier<PagingState<Book>> {
  late final BookCursor param;

  PagingState<Book> build(BookCursor param);
}

/// See also [AllBooks].
@ProviderFor(AllBooks)
const allBooksProvider = AllBooksFamily();

/// See also [AllBooks].
class AllBooksFamily extends Family<PagingState<Book>> {
  /// See also [AllBooks].
  const AllBooksFamily();

  /// See also [AllBooks].
  AllBooksProvider call(BookCursor param) {
    return AllBooksProvider(param);
  }

  @override
  AllBooksProvider getProviderOverride(covariant AllBooksProvider provider) {
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
  String? get name => r'allBooksProvider';
}

/// See also [AllBooks].
class AllBooksProvider
    extends AutoDisposeNotifierProviderImpl<AllBooks, PagingState<Book>> {
  /// See also [AllBooks].
  AllBooksProvider(BookCursor param)
    : this._internal(
        () => AllBooks()..param = param,
        from: allBooksProvider,
        name: r'allBooksProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$allBooksHash,
        dependencies: AllBooksFamily._dependencies,
        allTransitiveDependencies: AllBooksFamily._allTransitiveDependencies,
        param: param,
      );

  AllBooksProvider._internal(
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
  PagingState<Book> runNotifierBuild(covariant AllBooks notifier) {
    return notifier.build(param);
  }

  @override
  Override overrideWith(AllBooks Function() create) {
    return ProviderOverride(
      origin: this,
      override: AllBooksProvider._internal(
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
  AutoDisposeNotifierProviderElement<AllBooks, PagingState<Book>>
  createElement() {
    return _AllBooksProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AllBooksProvider && other.param == param;
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
mixin AllBooksRef on AutoDisposeNotifierProviderRef<PagingState<Book>> {
  /// The parameter `param` of this provider.
  BookCursor get param;
}

class _AllBooksProviderElement
    extends AutoDisposeNotifierProviderElement<AllBooks, PagingState<Book>>
    with AllBooksRef {
  _AllBooksProviderElement(super.provider);

  @override
  BookCursor get param => (origin as AllBooksProvider).param;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
