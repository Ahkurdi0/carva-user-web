import 'dart:async';

import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/post_location.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'nearby_cars.g.dart';

@riverpod
class NearbayCars extends _$NearbayCars {
  late CarRepo _carRepo;
  @override
  FutureOr<List<Car>> build([PostLocation? param]) async {
    _carRepo = sl<CarRepo>();
    ref.keepAlive();
    final timer = Timer.periodic(Duration(minutes: 5), (_) {
      ref.invalidateSelf();
    });
    ref.onDispose(() {
      timer.cancel();
    });
    final result = await _carRepo.nearBayCars(param);
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
