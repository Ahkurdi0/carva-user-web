import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/core/utils/pagination.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:collection/collection.dart';
part 'favorite_cars.g.dart';

@riverpod
class FavoriteCars extends _$FavoriteCars {
  late CarRepo _carRepo;
  @override
  PagingState<Car> build() {
    _carRepo = sl();

    ref.keepAlive();

    final refreshTimer = Timer.periodic(const Duration(minutes: 15), (_) {
      loadInitial();
    });

    ref.onDispose(() {
      refreshTimer.cancel();
    });
    Future.microtask(() => loadInitial());
    return PagingState.initial();
  }

  Future<void> loadInitial() async {
    final result = await _carRepo.favoriteCars();

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

  Future<void> loadMore(String? lastId) async {
    if (state.isLoading || !state.hasNextPage) return;
    state = state.copyWith(isLoading: true);
    final result = await _carRepo.favoriteCars(lastId);

    result.fold(
      (l) => state = state.copyWith(
        error: l.message,
        isLoading: false,
        initalLoading: false,
      ),
      (r) {
        final hasMore = r.isNotEmpty;

        final updatedItems = [...state.items, ...r]; // ← append
        state = state.copyWith(
          items: updatedItems,
          hasNextPage: hasMore,
          isLoading: false,
          error: null,
        );
      },
    );
  }

  void toggleCars(Car car) {
    final isExist = state.items.firstWhereOrNull((c) => c.id == car.id);
    if (isExist != null) {
      state = state.copyWith(
        items: state.items.filter((c) => c.id != car.id).toList(),
      );
      return;
    }

    state = state.copyWith(items: [...state.items, car], hasNextPage: true);
  }
}
