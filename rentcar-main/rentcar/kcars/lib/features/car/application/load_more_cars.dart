import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/car/application/car_states.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';
import 'package:kcars/features/car/presentation/riverpod/cars.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'load_more_cars.g.dart';

@riverpod
class LoadMoreCars extends _$LoadMoreCars {
  late CarRepo _carRepo;
  @override
  CarStates build() {
    _carRepo = sl<CarRepo>();
    return InitialCarState();
  }

  Future<void> loadMore([String? cursor]) async {
    state = LoadMoreCarsLoading();
    final result = await _carRepo.cars(cursor);

    await result.fold<Future<void>>(
      (l) async => state = LoadMoreCarsFailed(l.message),
      (r) async {
        ref.read(carsProvider.notifier).loadMore(r);
        state = LoadMoreCarsCompleted();
      },
    );
  }

  reset() {
    state = InitialCarState();
  }
}
