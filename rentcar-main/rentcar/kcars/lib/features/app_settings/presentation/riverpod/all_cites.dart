import 'dart:async';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/app_settings/application/app_settigngs_controller.dart';
import 'package:kcars/features/app_settings/data/model/sort_model.dart';
import 'package:kcars/features/app_settings/domain/repo/app_settings_repo.dart';
import 'package:kcars/features/car/data/model/city.dart';
import 'package:kcars/features/car/data/model/town.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'all_cites.g.dart';

@riverpod
class AllCities extends _$AllCities {
  late AppSettingsRepo _appSettingsRepo;
  @override
  FutureOr<List<City>> build() async {
    _appSettingsRepo = sl<AppSettingsRepo>();
    ref.keepAlive();
    final timer = Timer.periodic(Duration(minutes: 5), (_) {
      ref.invalidateSelf();
    });
    ref.onDispose(() {
      timer.cancel();
    });
    final result = await _appSettingsRepo.cities();
    return result.fold((l) => throw l.message, (r) => r);
  }

  newEditCity(City param) async {
    final exist = state.value?.indexWhere((element) => element.id == param.id);
    if (exist == -1) {
      state = AsyncData([...(state.value ?? []), param]);
      return;
    }

    final newState = state.value
        ?.map((e) => e.id == param.id ? param : e)
        .toList();
    state = AsyncData(newState ?? []);
  }

  newEditTown(Town param, String cityId) async {
    final exist = state.value
        ?.firstWhere((element) => element.id == cityId)
        .towns
        ?.indexWhere((element) => element.id == param.id);
    if (param.id == null || param.id!.isEmpty || exist == -1) {
      state = AsyncData([
        ...state.value?.map(
              (city) => city.id == cityId
                  ? city.copyWith(towns: [...(city.towns ?? []), param])
                  : city,
            ) ??
            [],
      ]);
      return;
    }

    final newState = state.value?.map((e) {
      if (e.id != cityId) return e;
      final towns = e.towns?.map((t) => t.id == param.id ? param : t).toList();
      return e.copyWith(towns: towns);
    }).toList();
    state = AsyncData(newState ?? []);
  }

  void deleteCity(String id) {
    final newState = state.value?.where((e) => e.id != id).toList();
    state = AsyncData(newState ?? []);
  }

  void deleteTown(Town town) {
    final newState = state.value?.map((e) {
      if (e.id != town.cityId) return e;
      final towns = e.towns?.where((t) => t.id != town.id).toList();
      return e.copyWith(towns: towns);
    }).toList();
    state = AsyncData(newState ?? []);
  }

  void reorderCities(List<City> items, int oldIndex, int newIndex) {
    final List<City> updatedList = [...items];

    final City movedItem = updatedList.removeAt(oldIndex);

    updatedList.insert(newIndex, movedItem);

    for (int i = 0; i < updatedList.length; i++) {
      updatedList[i] = updatedList[i].copyWith(sort: i + 1);
    }

    state = AsyncData(updatedList);
    sortCity(updatedList);
  }

  sortCity(List<City> items) {
    ref
        .read(appSettingsControllerProvider.notifier)
        .sortCity(
          items.map((e) => SortModel(id: e.id!, sort: e.sort!)).toList(),
        );
  }

  void reorderTowns(
    List<Town> items,
    int oldIndex,
    int newIndex,
    String cityId,
  ) {
    final List<Town> updatedList = [...items];

    final Town movedItem = updatedList.removeAt(oldIndex);

    updatedList.insert(newIndex, movedItem);

    for (int i = 0; i < updatedList.length; i++) {
      updatedList[i] = updatedList[i].copyWith(sort: i + 1);
    }

    state = AsyncData([
      ...state.value?.map(
            (city) =>
                city.id == cityId ? city.copyWith(towns: updatedList) : city,
          ) ??
          [],
    ]);
    sortTowns(updatedList);
  }

  sortTowns(List<Town> items) {
    ref
        .read(appSettingsControllerProvider.notifier)
        .sortTown(
          items.map((e) => SortModel(id: e.id!, sort: e.sort!)).toList(),
        );
  }
}
