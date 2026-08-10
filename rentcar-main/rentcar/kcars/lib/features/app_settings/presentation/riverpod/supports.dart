import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/app_settings/application/app_settigngs_controller.dart';
import 'package:kcars/features/app_settings/data/model/sort_model.dart';
import 'package:kcars/features/app_settings/data/model/suppprt.dart';
import 'package:kcars/features/app_settings/domain/repo/app_settings_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'supports.g.dart';

@riverpod
class Supports extends _$Supports {
  late AppSettingsRepo _appSettingsRepo;
  @override
  FutureOr<List<Support>> build() async {
    _appSettingsRepo = sl<AppSettingsRepo>();
    final result = await _appSettingsRepo.supports();
    return result.fold((l) => throw l.message, (r) => r);
  }

  void newSupport(Support param) async {
    final exist =
        state.value?.indexWhere((support) => support.id == param.id) ?? -1;

    if (exist == -1 || param.id == null || param.id!.isEmpty) {
      // Add new brand to the beginning of the list
      state = AsyncData([...state.value ?? [], param]);
    } else {
      // Update existing brand
      final updatedList =
          state.value?.map((support) {
            return support.id == param.id ? param : support;
          }).toList() ??
          [];
      state = AsyncData(updatedList);
    }
  }

  void deleteSupport(String id) {
    state = AsyncData([
      ...state.value?.where((support) => support.id != id) ?? [],
    ]);
  }

  void reorderItems(List<Support> items, int oldIndex, int newIndex) {
    final List<Support> updatedList = [...items];

    final Support movedItem = updatedList.removeAt(oldIndex);

    updatedList.insert(newIndex, movedItem);

    for (int i = 0; i < updatedList.length; i++) {
      updatedList[i] = updatedList[i].copyWith(sort: i + 1);
    }

    state = AsyncData([...updatedList]);
    sortItems(updatedList);
  }

  sortItems(List<Support> items) {
    ref
        .read(appSettingsControllerProvider.notifier)
        .sortSupport(
          items.map((e) => SortModel(id: e.id!, sort: e.sort!)).toList(),
        );
  }
}
