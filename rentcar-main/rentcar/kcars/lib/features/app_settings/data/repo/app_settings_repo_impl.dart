import 'package:fpdart/fpdart.dart';
import 'package:kcars/configs/error/exception.dart';
import 'package:kcars/configs/error/failure.dart';
import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/features/app_settings/data/model/notifications.dart';
import 'package:kcars/features/app_settings/data/model/post_model.dart';
import 'package:kcars/features/app_settings/data/model/response_model.dart';
import 'package:kcars/features/app_settings/data/model/sliders.dart';
import 'package:kcars/features/app_settings/data/model/sort_model.dart';
import 'package:kcars/features/app_settings/data/model/statistics.dart';
import 'package:kcars/features/app_settings/data/model/suppprt.dart';
import 'package:kcars/features/app_settings/data/remote/app_settings_remote.dart';
import 'package:kcars/features/app_settings/domain/repo/app_settings_repo.dart';
import 'package:kcars/features/car/data/model/car_type.dart';
import 'package:kcars/features/car/data/model/city.dart';
import 'package:kcars/features/car/data/model/town.dart';

class AppSettingsRepoImpl implements AppSettingsRepo {
  final AppSettingsRemote _appSettingsRemote;

  AppSettingsRepoImpl(this._appSettingsRemote);

  @override
  Result<void> deleteBrand(String id) async {
    try {
      await _appSettingsRemote.deleteBrand(id);
      return Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> deleteCity(String id) async {
    try {
      await _appSettingsRemote.deleteCity(id);
      return Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> deleteNotification(String id) async {
    try {
      await _appSettingsRemote.deleteNotification(id);
      return Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> deleteSupport(String id) async {
    try {
      await _appSettingsRemote.deleteSupport(id);
      return Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> deleteTown(String id) async {
    try {
      await _appSettingsRemote.deleteTown(id);
      return Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<ResponseData?> newBrand(PostModel param) async {
    try {
      final result = await _appSettingsRemote.newBrand(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<String?> newCity(City param) async {
    try {
      final result = await _appSettingsRemote.newCity(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<String?> newNotification(Notifications param) async {
    try {
      final result = await _appSettingsRemote.newNotification(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<ResponseData?> newSupport(PostModel param) async {
    try {
      final result = await _appSettingsRemote.newSupport(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<String?> newTown(Town param) async {
    try {
      final result = await _appSettingsRemote.newTown(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> sortBrand(List<SortModel> param) async {
    try {
      await _appSettingsRemote.sortBrand(param);
      return Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> sortCity(List<SortModel> param) async {
    try {
      await _appSettingsRemote.sortCity(param);
      return Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> sortTown(List<SortModel> param) async {
    try {
      await _appSettingsRemote.sortTown(param);
      return Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Support>> supports() async {
    try {
      final result = await _appSettingsRemote.supports();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> deleteCarType(String id) async {
    try {
      await _appSettingsRemote.deleteCarType(id);
      return Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<String?> newCarType(CarType param) async {
    try {
      final result = await _appSettingsRemote.newCarType(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> sortCarType(List<SortModel> param) async {
    try {
      await _appSettingsRemote.sortCarType(param);
      return Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<City>> cities() async {
    try {
      final result = await _appSettingsRemote.cities();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> sortSupport(List<SortModel> param) async {
    try {
      final result = await _appSettingsRemote.sortSupport(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<Statistics> statistics([DateTime? date]) async {
    try {
      final result = await _appSettingsRemote.statistics(date);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> deleteSlider(String id) async {
    try {
      final result = await _appSettingsRemote.deleteSlider(id);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> newSlider(Sliders param) async {
    try {
      final result = await _appSettingsRemote.newSlider(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Sliders>> sliders() async {
    try {
      final result = await _appSettingsRemote.sliders();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> sortSlider(List<SortModel> param) async {
    try {
      final result = await _appSettingsRemote.sortSlider(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<String?> slider(String id) async {
    try {
      final result = await _appSettingsRemote.slider(id);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }
}
