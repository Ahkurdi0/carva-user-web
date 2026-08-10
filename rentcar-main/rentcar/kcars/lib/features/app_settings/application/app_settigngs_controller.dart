import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/app_settings/application/states.dart';
import 'package:kcars/features/app_settings/data/model/notifications.dart';
import 'package:kcars/features/app_settings/data/model/post_model.dart';
import 'package:kcars/features/app_settings/data/model/sliders.dart';
import 'package:kcars/features/app_settings/data/model/sort_model.dart';
import 'package:kcars/features/app_settings/data/model/suppprt.dart';
import 'package:kcars/features/app_settings/domain/repo/app_settings_repo.dart';
import 'package:kcars/features/app_settings/presentation/riverpod/all_cites.dart';
import 'package:kcars/features/app_settings/presentation/riverpod/sliders.dart';
import 'package:kcars/features/app_settings/presentation/riverpod/supports.dart';
import 'package:kcars/features/car/data/model/brand.dart';
import 'package:kcars/features/car/data/model/car_type.dart';
import 'package:kcars/features/car/data/model/city.dart';
import 'package:kcars/features/car/data/model/town.dart';
import 'package:kcars/features/car/presentation/riverpod/brands.dart';
import 'package:kcars/features/car/presentation/riverpod/car_types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'app_settigngs_controller.g.dart';

@riverpod
class AppSettingsController extends _$AppSettingsController {
  late AppSettingsRepo _appSettingsRepo;
  @override
  AppSettingsStates build() {
    _appSettingsRepo = sl<AppSettingsRepo>();
    return AppSettingsInitialState();
  }

  Future<void> newCity(City param, [City? city]) async {
    state = const NewCityLoading();
    final result = await _appSettingsRepo.newCity(param.toDiffer(city));
    result.fold((l) => state = NewCityFailed(l.message), (r) {
      ref
          .read(allCitiesProvider.notifier)
          .newEditCity(param.copyWith(id: r ?? param.id));

      state = const NewCityCompleted();
    });
  }

  Future<void> deleteCity(String id) async {
    state = const DeleteCityLoading();
    final result = await _appSettingsRepo.deleteCity(id);
    result.fold((l) => state = DeleteCityFailed(l.message), (r) {
      ref.read(allCitiesProvider.notifier).deleteCity(id);
      state = const DeleteCityCompleted();
    });
  }

  Future<void> sortCity(List<SortModel> param) async {
    state = const SortingLoading();
    final result = await _appSettingsRepo.sortCity(param);
    result.fold(
      (l) => state = SortingFailed(l.message),
      (r) => state = const SortingCompleted(),
    );
  }

  Future<void> newTown(Town param, [Town? orginal]) async {
    state = const NewTownLoading();
    final result = await _appSettingsRepo.newTown(param.toDiffer(orginal));
    result.fold((l) => state = NewTownFailed(l.message), (r) {
      ref
          .read(allCitiesProvider.notifier)
          .newEditTown(param.copyWith(id: r ?? param.id), param.cityId!);
      state = const NewTownCompleted();
    });
  }

  Future<void> deleteTown(Town town) async {
    state = const DeleteTownLoading();
    final result = await _appSettingsRepo.deleteTown(town.id!);
    result.fold((l) => state = DeleteTownFailed(l.message), (r) {
      ref.read(allCitiesProvider.notifier).deleteTown(town);
      state = const DeleteTownCompleted();
    });
  }

  Future<void> sortTown(List<SortModel> param) async {
    state = const SortingLoading();
    final result = await _appSettingsRepo.sortTown(param);
    result.fold(
      (l) => state = SortingFailed(l.message),
      (r) => state = const SortingCompleted(),
    );
  }

  Future<void> newSupport(PostModel param, [Support? orginal]) async {
    state = const NewSupportLoading();
    final result = await _appSettingsRepo.newSupport(
      param.copyWith(suppprt: param.suppprt?.toDiffer(orginal)),
    );
    result.fold((l) => state = NewSupportFailed(l.message), (r) {
      ref
          .read(supportsProvider.notifier)
          .newSupport(param.suppprt!.copyWith(id: r?.id ?? orginal?.id));
      state = const NewSupportCompleted();
    });
  }

  Future<void> sortSupport(List<SortModel> param) async {
    state = const SortingLoading();
    final result = await _appSettingsRepo.sortSupport(param);
    result.fold(
      (l) => state = SortingFailed(l.message),
      (r) => state = const SortingCompleted(),
    );
  }

  Future<void> deleteSupport(String id) async {
    state = const DeleteSupportLoading();
    final result = await _appSettingsRepo.deleteSupport(id);
    result.fold((l) => state = DeleteSupportFailed(l.message), (r) {
      ref.read(supportsProvider.notifier).deleteSupport(id);
      state = const DeleteSupportCompleted();
    });
  }

  Future<void> newBrand(PostModel param, [Brand? orginal]) async {
    state = const NewBrandLoading();
    final result = await _appSettingsRepo.newBrand(
      param.copyWith(brand: param.brand?.toDiffer(orginal)),
    );
    result.fold((l) => state = NewBrandFailed(l.message), (r) {
      ref
          .read(brandsProvider.notifier)
          .newBrand(param.brand!.copyWith(id: r?.id ?? orginal?.id));
      state = const NewBrandCompleted();
    });
  }

  Future<void> deleteBrand(String id) async {
    state = const DeleteBrandLoading();
    final result = await _appSettingsRepo.deleteBrand(id);
    result.fold((l) => state = DeleteBrandFailed(l.message), (r) {
      ref.read(brandsProvider.notifier).deleteBrand(id);
      state = const DeleteBrandCompleted();
    });
  }

  Future<void> sortBrand(List<SortModel> param) async {
    state = const SortingLoading();
    final result = await _appSettingsRepo.sortBrand(param);
    result.fold(
      (l) => state = SortingFailed(l.message),
      (r) => state = const SortingCompleted(),
    );
  }

  Future<void> newCarType(CarType param, [CarType? orginal]) async {
    state = const NewCarTypeLoading();
    final result = await _appSettingsRepo.newCarType(param.toDiffer(orginal));
    result.fold((l) => state = NewCarTypeFailed(l.message), (r) {
      ref
          .read(carTypesProvider.notifier)
          .newCarType(param.copyWith(id: r ?? orginal?.id));
      state = const NewCarTypeCompleted();
    });
  }

  Future<void> deleteCarType(String id) async {
    state = const DeleteCarTypeLoading();
    final result = await _appSettingsRepo.deleteCarType(id);
    result.fold((l) => state = DeleteCarTypeFailed(l.message), (r) {
      ref.read(carTypesProvider.notifier).deleteCarType(id);
      state = const DeleteCarTypeCompleted();
    });
  }

  Future<void> sortCarType(List<SortModel> param) async {
    state = const SortingLoading();
    final result = await _appSettingsRepo.sortCarType(param);
    result.fold(
      (l) => state = SortingFailed(l.message),
      (r) => state = const SortingCompleted(),
    );
  }

  Future<void> newNotification(Notifications param) async {
    state = const NewNotificationLoading();
    final result = await _appSettingsRepo.newNotification(param);
    result.fold(
      (l) => state = NewNotificationFailed(l.message),
      (r) => state = const NewNotificationCompleted(),
    );
  }

  Future<void> deleteMotification(String id) async {
    state = const DeleteNotificationLoading();
    final result = await _appSettingsRepo.deleteBrand(id);
    result.fold(
      (l) => state = DeleteNotificationFailed(l.message),
      (r) => state = const DeleteNotificationCompleted(),
    );
  }

  Future<void> newSlider(Sliders param, [Sliders? orginal]) async {
    state = const NewSliderLoading();
    final result = await _appSettingsRepo.newSlider(param.toDiffer(orginal));

    result.fold((l) => state = NewSliderFailed(l.message), (r) {
      state = const NewSliderCompleted();
      ref.invalidate(allSlidersProvider);
    });
  }

  Future<void> deleteSlider(String id) async {
    state = const DeleteSliderLoading();
    final result = await _appSettingsRepo.deleteSlider(id);
    result.fold((l) => state = DeleteSliderFailed(l.message), (r) {
      ref.read(allSlidersProvider.notifier).deleteSlider(id);
      state = const DeleteSliderCompleted();
    });
  }

  Future<void> sortSlider(List<SortModel> param) async {
    state = const SortingLoading();
    final result = await _appSettingsRepo.sortSlider(param);
    result.fold(
      (l) => state = SortingFailed(l.message),
      (r) => state = const SortingCompleted(),
    );
  }

  Future<void> slider(String id) async {
    state = const SliderLoading();
    final result = await _appSettingsRepo.slider(id);
    result.fold((l) => state = SliderFailed(l.message), (r) {
      state = SliderCompleted(r);
    });
  }
}
