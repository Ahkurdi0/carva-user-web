import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/core/utils/debouncer.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/car_cursor.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'search_cars.g.dart';

@riverpod
class SearchCar extends _$SearchCar {
  late CarRepo _repo;
  @override
  FutureOr<List<Car>> build() {
    _repo = sl<CarRepo>();
    return [];
  }

  void searchForCars(search) async {
    state = AsyncLoading();
    AppDebounce.debounce("searching_books", Duration(seconds: 1), () async {
      final result = await _repo.allCars(CarsCursor(id: search));
      result.fold(
        (l) => state = AsyncError(l.message, StackTrace.empty),
        (r) => state = AsyncData(r),
      );
    });
  }

  void deleteCar(String id) {
    final newState = state.value?.where((car) => car.id != id).toList();

    state = AsyncData(newState ?? []);
  }
}
