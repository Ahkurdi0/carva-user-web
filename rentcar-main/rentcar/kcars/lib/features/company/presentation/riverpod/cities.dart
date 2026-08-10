import 'dart:async';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/app_settings/application/app_settigngs_controller.dart';
import 'package:kcars/features/app_settings/data/model/sort_model.dart';
import 'package:kcars/features/car/data/model/city.dart';
import 'package:kcars/features/car/data/model/town.dart';
import 'package:kcars/features/company/domain/company_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'cities.g.dart';

@riverpod
class Cities extends _$Cities {
  late CompanyRepo _companyRepo;
  @override
  FutureOr<List<City>> build() async {
    _companyRepo = sl<CompanyRepo>();
    ref.keepAlive();
    final timer = Timer.periodic(Duration(minutes: 5), (_) {
      ref.invalidateSelf();
    });
    ref.onDispose(() {
      timer.cancel();
    });
    final result = await _companyRepo.cities();
    return result.fold((l) => throw l.message, (r) => r);
  }

  void reorderItems(
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
    sortItems(updatedList);
  }

  sortItems(List<Town> items) {
    ref
        .read(appSettingsControllerProvider.notifier)
        .sortCarType(
          items.map((e) => SortModel(id: e.id!, sort: e.sort!)).toList(),
        );
  }
}
