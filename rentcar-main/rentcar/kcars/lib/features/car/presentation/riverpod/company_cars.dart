import 'dart:async';

import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/core/utils/pagination.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/car_cursor.dart';
import 'package:kcars/features/car/data/model/image.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'company_cars.g.dart';

@riverpod
class CompanyCars extends _$CompanyCars {
  late CarRepo _carRepo;
  @override
  PagingState<Car> build() {
    _carRepo = sl<CarRepo>();
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
    final result = await _carRepo.companyCars();

    result.fold(
      (l) => state = state.copyWith(
        error: l.message,
        initalLoading: false,
        isLoading: false,
      ),
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

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasNextPage) return;
    state = state.copyWith(isLoading: true);
    final cursor = CarsCursor(cursor: state.items.last.id);
    final result = await _carRepo.companyCars(cursor);
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

  void sortedImages(List<Images> images, String carId) {
    state = state.copyWith(
      items: state.items
          .map((car) => car.id == carId ? car.copyWith(images: images) : car)
          .toList(),
    );
  }

  void deleteCar(String carId) {
    final newState = state.items.where((car) => car.id != carId).toList();
    state = state.copyWith(items: newState);
  }

  void updateCar(Car car) {
    final newState = state.items
        .map((c) => c.id == car.id ? c.copyWith(available: car.available) : c)
        .toList();

    state = state.copyWith(items: newState);
  }
}
