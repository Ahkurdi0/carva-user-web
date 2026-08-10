import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/features/app_settings/data/model/notifications.dart';
import 'package:kcars/features/app_settings/data/model/post_model.dart';
import 'package:kcars/features/app_settings/data/model/response_model.dart';
import 'package:kcars/features/app_settings/data/model/sliders.dart';
import 'package:kcars/features/app_settings/data/model/sort_model.dart';
import 'package:kcars/features/app_settings/data/model/statistics.dart';
import 'package:kcars/features/app_settings/data/model/suppprt.dart';
import 'package:kcars/features/car/data/model/car_type.dart';
import 'package:kcars/features/car/data/model/city.dart';
import 'package:kcars/features/car/data/model/town.dart';

abstract class AppSettingsRepo {
  Result<List<City>> cities();
  Result<String?> newCity(City param);
  Result<void> deleteCity(String id);
  Result<void> sortCity(List<SortModel> param);

  Result<String?> newTown(Town param);
  Result<void> deleteTown(String id);
  Result<void> sortTown(List<SortModel> param);

  Result<String?> newCarType(CarType param);
  Result<void> deleteCarType(String id);
  Result<void> sortCarType(List<SortModel> param);

  Result<ResponseData?> newBrand(PostModel param);
  Result<void> deleteBrand(String id);
  Result<void> sortBrand(List<SortModel> param);

  Result<String?> newNotification(Notifications param);
  Result<void> deleteNotification(String id);

  Result<List<Support>> supports();
  Result<ResponseData?> newSupport(PostModel param);
  Result<void> sortSupport(List<SortModel> param);
  Result<void> deleteSupport(String id);

  Result<Statistics> statistics([DateTime? date]);

  Result<List<Sliders>> sliders();
  Result<void> newSlider(Sliders param);
  Result<void> sortSlider(List<SortModel> param);
  Result<void> deleteSlider(String id);
  Result<String?> slider(String id);
}
