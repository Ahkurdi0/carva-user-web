import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/car/application/load_more_cars.dart';
import 'package:kcars/features/car/data/model/paginated.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cars.g.dart';

@riverpod
class Cars extends _$Cars {
  late CarRepo _repo;
  @override
  FutureOr<Paginated> build() async {
    _repo = sl<CarRepo>();
    final result = await _repo.cars();
    return result.fold((l) => throw l.message, (r) => r);
  }

  void loadMore(Paginated newData) async {
    state = AsyncData(
      state.value!.copyWith(
        cars: [...?state.value?.cars, ...newData.cars],
        hasMore: newData.hasMore,
        cursor: newData.cursor,
      ),
    );
  }

  void loadMoreCars() {
    if (state.value?.hasMore != true) return;
    ref.read(loadMoreCarsProvider.notifier).loadMore(state.value?.cursor);
  }

  void favoriteCar(String carId) {
    final newState = state.value?.cars.map((car) {
      if (car.id == carId) {
        return car.copyWith(
          isFavorite: car.isFavorite != null ? !car.isFavorite! : true,
        );
      }
      return car;
    }).toList();
    state = AsyncData(state.value!.copyWith(cars: [...?newState]));
  }
}
