import 'dart:async';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/app_settings/application/app_settigngs_controller.dart';
import 'package:kcars/features/app_settings/data/model/sort_model.dart';
import 'package:kcars/features/car/data/model/car_type.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'car_types.g.dart';

@riverpod
class CarTypes extends _$CarTypes {
  late CarRepo _carRepo;
  @override
  FutureOr<List<CarType>> build() async {
    _carRepo = sl();

    ref.keepAlive();

    final refreshTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      ref.invalidateSelf();
    });

    ref.onDispose(() {
      refreshTimer.cancel();
    });

    final result = await _carRepo.carTypes();

    return result.fold((l) => throw l.message, (r) => r);
  }

  void reorderItems(List<CarType> items, int oldIndex, int newIndex) {
    final List<CarType> updatedList = [...items];

    final CarType movedItem = updatedList.removeAt(oldIndex);

    updatedList.insert(newIndex, movedItem);

    for (int i = 0; i < updatedList.length; i++) {
      updatedList[i] = updatedList[i].copyWith(sort: i + 1);
    }

    state = AsyncData([...updatedList]);
    sortItems(updatedList);
  }

  sortItems(List<CarType> items) {
    ref
        .read(appSettingsControllerProvider.notifier)
        .sortCarType(
          items.map((e) => SortModel(id: e.id!, sort: e.sort!)).toList(),
        );
  }

  void newCarType(CarType param) async {
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

  void deleteCarType(String id) {
    state = AsyncData([...state.value?.where((brand) => brand.id != id) ?? []]);
  }
}
