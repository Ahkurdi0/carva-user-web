import 'dart:async';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/app_settings/application/app_settigngs_controller.dart';
import 'package:kcars/features/app_settings/data/model/sliders.dart';
import 'package:kcars/features/app_settings/data/model/sort_model.dart';
import 'package:kcars/features/app_settings/domain/repo/app_settings_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sliders.g.dart';

@riverpod
class AllSliders extends _$AllSliders {
  late AppSettingsRepo _repo;
  @override
  FutureOr<List<Sliders>> build() async {
    _repo = sl();

    ref.keepAlive();

    final refreshTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      ref.invalidateSelf();
    });

    ref.onDispose(() {
      refreshTimer.cancel();
    });

    final result = await _repo.sliders();

    return result.fold((l) => throw l.message, (r) => r);
  }

  void sortSliders(List<Sliders> items, int oldIndex, int newIndex) {
    final List<Sliders> updatedList = [...items];

    final Sliders movedItem = updatedList.removeAt(oldIndex);

    updatedList.insert(newIndex, movedItem);

    for (int i = 0; i < updatedList.length; i++) {
      updatedList[i] = updatedList[i].copyWith(sort: i + 1);
    }

    state = AsyncData([...updatedList]);
    sortItems(updatedList);
  }

  sortItems(List<Sliders> items) {
    ref
        .read(appSettingsControllerProvider.notifier)
        .sortSlider(
          items.map((e) => SortModel(id: e.id!, sort: e.sort!)).toList(),
        );
  }

  // void newCarType(Sliders param) async {
  //   final exist =
  //       state.value?.indexWhere((carType) => carType.id == param.id) ?? -1;

  //   if (exist == -1) {
  //     state = AsyncData([...state.value ?? [], param]);
  //   } else {
  //     final updatedList =
  //         state.value?.map((brand) {
  //           return brand.id == param.id ? param : brand;
  //         }).toList() ??
  //         [];
  //     state = AsyncData(updatedList);
  //   }
  // }

  void deleteSlider(String id) {
    state = AsyncData([...state.value?.where((brand) => brand.id != id) ?? []]);
  }
}
