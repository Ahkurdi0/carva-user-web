import 'dart:async';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/core/utils/pagination.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/filter.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';
import 'package:kcars/features/car/presentation/riverpod/filters.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'filter_cars.g.dart';

@riverpod
class FiltersCars extends _$FiltersCars {
  late CarRepo _carRepo;
  @override
  PagingState<Car> build([String? id]) {
    _carRepo = sl<CarRepo>();

    Future.microtask(() => loadInitial());
    return PagingState.initial();
  }

  Future<void> loadInitial() async {
    final result = await _carRepo.filterCars(Filter(companyId: id));

    result.fold(
      (l) => state = state.copyWith(error: l.message, isLoading: false),
      (r) {
        final hasMore = r.isNotEmpty;

        state = state.copyWith(
          items: r,
          hasNextPage: hasMore,
          isLoading: false,
          error: null,
          isRefreshing: false,
          initalLoading: false,
        );
      },
    );
  }

  Future<void> filterCars(Filter param) async {
    state = state.copyWith(isLoading: true);
    final result = await _carRepo.filterCars(param);
    await result.fold<Future<void>>(
      (l) async => state = state.copyWith(error: l.message),
      (r) async => state = state.copyWith(items: r, isLoading: false),
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasNextPage) return;
    state = state.copyWith(isLoading: true);
    final filters = ref
        .watch(filtersProvider)
        .copyWith(cursor: state.items.last.id, companyId: id);
    final result = await _carRepo.filterCars(filters);

    result.fold((l) => state = state.copyWith(error: l.message), (r) {
      final hasMore = r.isNotEmpty;

      final updatedItems = [...state.items, ...r];
      state = state.copyWith(
        items: updatedItems,
        hasNextPage: hasMore,
        isLoading: false,
        error: null,
      );
    });
  }

  void favoriteCar(String id) {
    final newState = state.items.map((car) {
      return car.id == id ? car.copyWith(isFavorite: !car.isFavorite!) : car;
    }).toList();

    state = state.copyWith(items: newState, hasNextPage: true);
  }
}
