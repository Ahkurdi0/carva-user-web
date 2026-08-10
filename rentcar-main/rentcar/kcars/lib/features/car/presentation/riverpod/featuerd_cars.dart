import 'dart:async';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/app_settings/data/model/sort_model.dart';
import 'package:kcars/features/car/application/car_controller.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'featuerd_cars.g.dart';

@riverpod
class FeaturedCars extends _$FeaturedCars {
  late CarRepo _carRepo;
  @override
  FutureOr<List<Car>> build() async {
    _carRepo = sl();

    ref.keepAlive();

    final refreshTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      ref.invalidateSelf();
    });

    ref.onDispose(() {
      refreshTimer.cancel();
    });

    final result = await _carRepo.featuredCars();

    return result.fold((l) => throw l.message, (r) => r);
  }

  void reorderItems(List<Car> items, int oldIndex, int newIndex) {
    final List<Car> updatedList = [...items];

    final Car movedItem = updatedList.removeAt(oldIndex);

    updatedList.insert(newIndex, movedItem);

    for (int i = 0; i < updatedList.length; i++) {
      updatedList[i] = updatedList[i].copyWith(
        featuredCars: updatedList[i].featuredCars?.copyWith(sort: i + 1),
      );
    }

    state = AsyncData([...updatedList]);
    sortItems(updatedList);
  }

  sortItems(List<Car> items) {
    ref
        .read(carControllerProvider.notifier)
        .sortFeaturdCars(
          items
              .map(
                (e) => SortModel(
                  id: e.featuredCars!.id!,
                  sort: e.featuredCars!.sort!,
                ),
              )
              .toList(),
        );
  }

  void newCar(Car param) async {
    final exist =
        state.value?.indexWhere((carType) => carType.id == param.id) ?? -1;

    if (exist == -1) {
      state = AsyncData([...state.value ?? [], param]);
    } else {
      final updatedList =
          state.value?.map((brand) {
            return brand.id == param.id ? param : brand;
          }).toList() ??
          [];
      state = AsyncData(updatedList);
    }
  }

  void deleteCar(String id) {
    final newState = state.value?.where((c) => c.id != id).toList() ?? [];
    state = AsyncData(newState);
  }
}
