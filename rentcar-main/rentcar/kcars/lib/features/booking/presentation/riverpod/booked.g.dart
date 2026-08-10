// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booked.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookedHash() => r'9824fd0b02e54d8de74cfd07220ec6aa290f30fd';

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

abstract class _$Booked
    extends BuildlessAutoDisposeNotifier<PagingState<Book>> {
  late final BookCursor? param;

  PagingState<Book> build([BookCursor? param]);
}

/// See also [Booked].
@ProviderFor(Booked)
const bookedProvider = BookedFamily();

/// See also [Booked].
class BookedFamily extends Family<PagingState<Book>> {
  /// See also [Booked].
  const BookedFamily();

  /// See also [Booked].
  BookedProvider call([BookCursor? param]) {
    return BookedProvider(param);
  }

  @override
  BookedProvider getProviderOverride(covariant BookedProvider provider) {
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
  String? get name => r'bookedProvider';
}

/// See also [Booked].
class BookedProvider
    extends AutoDisposeNotifierProviderImpl<Booked, PagingState<Book>> {
  /// See also [Booked].
  BookedProvider([BookCursor? param])
    : this._internal(
        () => Booked()..param = param,
        from: bookedProvider,
        name: r'bookedProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$bookedHash,
        dependencies: BookedFamily._dependencies,
        allTransitiveDependencies: BookedFamily._allTransitiveDependencies,
        param: param,
      );

  BookedProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.param,
  }) : super.internal();

  final BookCursor? param;

  @override
  PagingState<Book> runNotifierBuild(covariant Booked notifier) {
    return notifier.build(param);
  }

  @override
  Override overrideWith(Booked Function() create) {
    return ProviderOverride(
      origin: this,
      override: BookedProvider._internal(
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
  AutoDisposeNotifierProviderElement<Booked, PagingState<Book>>
  createElement() {
    return _BookedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BookedProvider && other.param == param;
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
mixin BookedRef on AutoDisposeNotifierProviderRef<PagingState<Book>> {
  /// The parameter `param` of this provider.
  BookCursor? get param;
}

class _BookedProviderElement
    extends AutoDisposeNotifierProviderElement<Booked, PagingState<Book>>
    with BookedRef {
  _BookedProviderElement(super.provider);

  @override
  BookCursor? get param => (origin as BookedProvider).param;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
