import 'package:dio/dio.dart';
import 'package:kcars/core/services/api_service.dart';
import 'package:kcars/core/services/info.dart';
import 'package:kcars/core/utils/extensions.dart';
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
import 'package:http_parser/http_parser.dart';

abstract class AppSettingsRemote {
  Future<List<City>> cities();
  Future<String?> newCity(City param);
  Future<void> deleteCity(String id);
  Future<void> sortCity(List<SortModel> param);

  Future<String?> newTown(Town param);
  Future<void> deleteTown(String id);
  Future<void> sortTown(List<SortModel> param);

  Future<String?> newCarType(CarType param);
  Future<void> deleteCarType(String id);
  Future<void> sortCarType(List<SortModel> param);

  Future<ResponseData?> newBrand(PostModel param);
  Future<void> deleteBrand(String id);
  Future<void> sortBrand(List<SortModel> param);

  Future<String?> newNotification(Notifications param);
  Future<void> deleteNotification(String id);

  Future<List<Support>> supports();
  Future<ResponseData?> newSupport(PostModel param);
  Future<void> sortSupport(List<SortModel> param);
  Future<void> deleteSupport(String id);

  Future<Statistics> statistics([DateTime? date]);
  Future<List<Sliders>> sliders();
  Future<void> newSlider(Sliders param);
  Future<void> sortSlider(List<SortModel> param);
  Future<void> deleteSlider(String id);
  Future<String?> slider(String id);
}

class AppSettingsRemoteImpl implements AppSettingsRemote {
  final ApiService _apiService;
  AppSettingsRemoteImpl(this._apiService);

  final adminUrl = Info.admin;
  final userUrl = Info.user;

  @override
  Future<void> deleteBrand(String id) async {
    return await _apiService.post("$adminUrl/deleteBrand", data: {"id": id});
  }

  @override
  Future<void> deleteCity(String id) async {
    return await _apiService.post("$adminUrl/deleteCity", data: {"id": id});
  }

  @override
  Future<void> deleteNotification(String id) async {
    return await _apiService.post(
      "$adminUrl/deleteNotification",
      data: {"id": id},
    );
  }

  @override
  Future<void> deleteTown(String id) async {
    return await _apiService.post("$adminUrl/deleteTown", data: {"id": id});
  }

  @override
  Future<ResponseData?> newBrand(PostModel param) async {
    final formData = FormData();
    if (param.image != null) {
      final mimeType = getMimeType(param.image!.path);
      formData.files.add(
        MapEntry(
          "image",
          await MultipartFile.fromFile(
            param.image!.path,
            filename: param.image!.path.split("/").last,
            contentType: MediaType.parse(mimeType),
          ),
        ),
      );
    }
    param.brand?.cleanedMap().forEach((key, value) {
      formData.fields.add(MapEntry(key, value.toString()));
    });
    return await _apiService.post(
      "$adminUrl/newBrand",
      data: formData,
      fromMap: (data) => ResponseDataMapper.fromMap(data),
    );
  }

  @override
  Future<String?> newCity(City param) async {
    return await _apiService.post(
      "$adminUrl/newCity",
      data: param.cleanedMap(),
    );
  }

  @override
  Future<String?> newNotification(Notifications param) async {
    return await _apiService.post(
      "$adminUrl/newNotification",
      data: param.toMap(),
    );
  }

  @override
  Future<String?> newTown(Town param) async {
    return await _apiService.post(
      "$adminUrl/newTown",
      data: param.cleanedMap(),
    );
  }

  @override
  Future<void> sortBrand(List<SortModel> param) async {
    await _apiService.post(
      "$adminUrl/sortBrand",
      data: param.map((e) => e.toMap()).toList(),
    );
  }

  @override
  Future<void> sortCity(List<SortModel> param) async {
    await _apiService.post(
      "$adminUrl/sortCity",
      data: param.map((e) => e.toMap()).toList(),
    );
  }

  @override
  Future<void> sortTown(List<SortModel> param) async {
    await _apiService.post(
      "$adminUrl/sortTown",
      data: param.map((e) => e.toMap()).toList(),
    );
  }

  @override
  Future<void> deleteSupport(String id) async {
    return await _apiService.post("$adminUrl/deleteSupport", data: {"id": id});
  }

  @override
  Future<ResponseData?> newSupport(PostModel param) async {
    final data = FormData();
    if (param.image != null) {
      final mimeType = getMimeType(param.image!.path);
      data.files.add(
        MapEntry(
          "image",
          await MultipartFile.fromFile(
            param.image!.path,
            filename: param.image!.path.split("/").last,
            contentType: MediaType.parse(mimeType),
          ),
        ),
      );
    }
    param.suppprt?.cleanedMap().forEach((key, value) {
      data.fields.add(MapEntry(key, value.toString()));
    });
    return await _apiService.post(
      "$adminUrl/newSupport",
      data: data,
      fromMap: (data) => ResponseDataMapper.fromMap(data),
    );
  }

  @override
  Future<List<Support>> supports() async {
    return await _apiService.post(
      "$userUrl/supports",
      fromMap: (data) =>
          List<Support>.from(data.map((x) => SupportMapper.fromMap(x))),
    );
  }

  @override
  Future<void> deleteCarType(String id) async {
    return await _apiService.post("$adminUrl/deleteCarType", data: {"id": id});
  }

  @override
  Future<String?> newCarType(CarType param) async {
    return await _apiService.post(
      "$adminUrl/newCarType",
      data: param.cleanedMap(),
    );
  }

  @override
  Future<void> sortCarType(List<SortModel> param) async {
    await _apiService.post(
      "$adminUrl/sortCarType",
      data: param.map((e) => e.toMap()).toList(),
    );
  }

  @override
  Future<List<City>> cities() async {
    return await _apiService.post(
      "$adminUrl/cities",
      fromMap: (data) =>
          List<City>.from(data.map((x) => CityMapper.fromMap(x))),
    );
  }

  @override
  Future<void> sortSupport(List<SortModel> param) async {
    return await _apiService.post(
      "$adminUrl/sortSupport",
      data: param.map((e) => e.toMap()).toList(),
    );
  }

  @override
  Future<Statistics> statistics([DateTime? date]) async {
    return await _apiService.post(
      "$adminUrl/statistics",
      data: {"date": date?.toUtc().toIso8601String()},
      fromMap: (data) => StatisticsMapper.fromMap(data),
    );
  }

  @override
  Future<void> deleteSlider(String id) async {
    return await _apiService.post("$adminUrl/deleteSlider", data: {"id": id});
  }

  @override
  Future<void> newSlider(Sliders param) async {
    final formData = FormData();
    param.cleanedMap().forEach((key, value) {
      if (key != "image") {
        formData.fields.add(MapEntry(key, value.toString()));
      }
    });
    if (param.image != null) {
      final mimeType = getMimeType(param.image!);
      formData.files.add(
        MapEntry(
          "image",
          await MultipartFile.fromFile(
            param.image!,
            filename: param.image!.split("/").last,
            contentType: MediaType.parse(mimeType),
          ),
        ),
      );
    }

    return _apiService.post("$adminUrl/newslider", data: formData);
  }

  @override
  Future<List<Sliders>> sliders() async {
    return _apiService.post(
      "$userUrl/sliders",
      fromMap: (data) =>
          List<Sliders>.from(data.map((x) => SlidersMapper.fromMap(x))),
    );
  }

  @override
  Future<void> sortSlider(List<SortModel> param) {
    return _apiService.post(
      "$adminUrl/sortSlider",
      data: param.map((e) => e.toMap()).toList(),
    );
  }

  @override
  Future<String?> slider(String id) async {
    return _apiService.post("$userUrl/slider", data: {"id": id});
  }
}
