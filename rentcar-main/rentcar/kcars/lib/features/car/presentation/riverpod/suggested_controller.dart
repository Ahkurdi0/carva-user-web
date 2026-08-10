import 'dart:async';

import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/post_location.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'suggested_controller.g.dart';

@riverpod
class SuggestedCar extends _$SuggestedCar {
  late CarRepo _carRepo;
  @override
  FutureOr<List<Car>> build([PostLocation? param]) async {
    _carRepo = sl();

    ref.keepAlive();

    final refreshTimer = Timer.periodic(const Duration(minutes: 10), (_) {
      ref.invalidateSelf();
    });

    ref.onDispose(() {
      refreshTimer.cancel();
    });

    final result = await _carRepo.suggestedCars();

    return result.fold((l) => throw l.message, (r) => r);
  }

  void favoriteCar(String id) {
    final newState = state.value
        ?.map(
          (car) =>
              car.id == id ? car.copyWith(isFavorite: !car.isFavorite!) : car,
        )
        .toList();

    state = AsyncData(newState ?? []);
  }
}
