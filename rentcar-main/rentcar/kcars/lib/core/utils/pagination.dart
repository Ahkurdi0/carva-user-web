import 'package:kcars/features/car/data/model/paginated.dart';

class PagingState<T> {
  final List<T> items;
  final bool hasNextPage;
  final bool isLoading;
  final bool isRefreshing;
  final String? error;
  final bool initalLoading;

  const PagingState({
    required this.items,
    required this.hasNextPage,
    required this.isLoading,
    this.isRefreshing = false,
    this.error,
    this.initalLoading = true,
  });

  factory PagingState.initial() => PagingState<T>(
    items: List<T>.empty(),
    hasNextPage: true,
    isLoading: false,
    error: null,
    isRefreshing: false,
    initalLoading: true,
  );

  PagingState<T> copyWith({
    List<T>? items,
    bool? hasNextPage,
    bool? isLoading,
    bool? initalLoading,
    bool? isRefreshing,
    String? error,
  }) {
    return PagingState<T>(
      items: items ?? this.items,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      error: error,
      initalLoading: initalLoading ?? this.initalLoading,
    );
  }

  bool get isEmpty => items.isEmpty && !isLoading && error == null;
}

class GPagingState<T> {
  final T? data; // e.g., Paginated<T>
  final List<T>? items; // optional, can be extracted from data
  final bool? hasNextPage; // optional, can be extracted from data
  final bool isLoading;
  final bool isRefreshing;
  final String? error;
  final bool initialLoading;

  const GPagingState({
    this.data,
    this.items,
    this.hasNextPage,
    required this.isLoading,
    this.isRefreshing = false,
    this.error,
    this.initialLoading = true,
  });

  factory GPagingState.initial({List<T>? items, bool? hasNextPage, T? data}) =>
      GPagingState<T>(
        data: data,
        items: items ?? const [],
        hasNextPage: hasNextPage ?? true,
        isLoading: false,
        initialLoading: true,
      );

  GPagingState<T> copyWith({
    T? data,
    List<T>? items,
    bool? hasNextPage,
    bool? isLoading,
    bool? isRefreshing,
    String? error,
    bool? initialLoading,
  }) {
    return GPagingState<T>(
      data: data ?? this.data,
      items: items ?? this.items,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      error: error,
      initialLoading: initialLoading ?? this.initialLoading,
    );
  }

  bool get isEmpty {
    if (items != null && items!.isEmpty) return true;
    if (data is Paginated && (data as Paginated).cars.isEmpty) return true;
    return false;
  }
}
