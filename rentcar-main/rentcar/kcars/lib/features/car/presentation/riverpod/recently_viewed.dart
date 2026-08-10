import 'dart:async';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'recently_viewed.g.dart';

@riverpod
class RecentlyViwedCar extends _$RecentlyViwedCar {
  late CarRepo _carRepo;
  @override
  FutureOr<List<Car>> build() async {
    _carRepo = sl<CarRepo>();
    ref.keepAlive();
    final refresher = Timer.periodic(Duration(minutes: 5), (_) {
      ref.invalidateSelf();
    });
    ref.onDispose(() {
      refresher.cancel();
    });
    final result = await _carRepo.recentlyViewed();

    return result.fold((l) => throw l.message, (r) => r);
  }

  void newCar(Car car) {
    final states = state.value;
    state = AsyncData([...?states, car]);
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
