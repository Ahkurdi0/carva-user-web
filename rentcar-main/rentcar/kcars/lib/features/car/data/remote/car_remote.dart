import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:kcars/configs/error/exception.dart';
import 'package:kcars/core/services/api_service.dart';
import 'package:kcars/core/services/info.dart';
import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/features/app_settings/data/model/sort_model.dart';
import 'package:kcars/features/car/data/model/brand.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/car_cursor.dart';
import 'package:kcars/features/car/data/model/car_post.dart';
import 'package:kcars/features/car/data/model/car_type.dart';
import 'package:kcars/features/car/data/model/featured_cars.dart';
import 'package:kcars/features/car/data/model/filter.dart';
import 'package:kcars/features/car/data/model/filter_data.dart';
import 'package:kcars/features/car/data/model/image.dart';
import 'package:kcars/features/car/data/model/paginated.dart';
import 'package:kcars/features/car/data/model/paln.dart';
import 'package:kcars/features/car/data/model/post_location.dart';
import 'package:kcars/features/car/data/model/promotion.dart';

abstract class CarRemote {
  Future<void> listCar(CarPost car);
  Future<void> updateCar(CarPost car);
  Future<void> sortImages(List<Images> images);
  Future<void> deleteCar(String carId);
  Future<List<Car>> suggestedCars([PostLocation? param]);
  Future<List<Car>> nearBayCars([PostLocation? param]);
  Future<List<Brand>> brandCars([PostLocation? param]);
  Future<List<Car>> recentlyViewed();
  Future<List<Car>> filterCars([Filter? param]);
  Future<Car> detailCars(String carId);
  Future<String?> favoriteCar(String id);
  Future<List<Car>> favoriteCars([String? cursor]);
  Future<String> promotion(Promotion promotion);
  Future<void> updatePromotion(PromotionUpdate promotion);
  Future<void> deletePromotion(String promotionId);
  Future<List<Promotion>> promotions([PromotionPost? param]);
  Future<List<Car>> companyCars([CarsCursor? param]);
  Future<List<Car>> userCompanyCars(CarsCursor param);
  Future<List<Car>> allCars(CarsCursor param);
  Future<FilterData> filtersData();
  Future<List<CarType>> carTypes();
  Future<List<Brand>> brands();
  Future<List<Plan>> plans();
  Future<Paginated> cars([String? cursor]);
  Future<List<Car>> explorerMap([PostLocation? param]);
  Future<List<Car>> featuredCars();
  Future<String?> newFeaturedCar(FeaturedCars param);
  Future<void> sortFeaturedCar(List<SortModel> param);
  Future<void> deleteFeaturedCar(String id);
}

class CarRemoteImpl implements CarRemote {
  CarRemoteImpl(this._apiService);
  final ApiService _apiService;
  final userUrl = Info.user;
  final companyUrl = Info.company;
  final adminUrl = Info.admin;
  @override
  Future<List<Brand>> brandCars([PostLocation? param]) async {
    return await _apiService.post(
      "$userUrl/brands",
      data: {"location": param?.toMap()},
      fromMap: (data) =>
          List<Brand>.from(data.map((x) => BrandMapper.fromMap(x))),
    );
  }

  @override
  Future<Car> detailCars(String carId) async => await _apiService.post(
    "$userUrl/carDetails",
    data: {"id": carId},
    fromMap: (data) => CarMapper.fromMap(data),
  );

  @override
  Future<String?> favoriteCar(String id) async =>
      await _apiService.post("$userUrl/favoriteCar", data: {"id": id});

  @override
  Future<List<Car>> favoriteCars([String? cursor]) async {
    return await _apiService.post<List<Car>>(
      "$userUrl/favoriteCars",
      data: {"cursor": cursor},
      fromMap: (data) =>
          List.from(data).map((data) => CarMapper.fromMap(data)).toList(),
    );
  }

  @override
  Future<List<Car>> filterCars([Filter? param]) async {
    return await _apiService.post(
      "$userUrl/filterCars",
      data: param
          ?.copyWith(type: null, city: null, town: null, brand: null)
          .cleanedMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((car) => CarMapper.fromMap(car)).toList(),
    );
  }

  @override
  Future<List<Car>> nearBayCars([PostLocation? param]) async {
    return await _apiService.post(
      "$userUrl/nearBayCars",
      data: param?.toMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((car) => CarMapper.fromMap(car)).toList(),
    );
  }

  @override
  Future<List<Car>> recentlyViewed() async {
    return await _apiService.post(
      "$userUrl/recentlyViewed",
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((car) => CarMapper.fromMap(car)).toList(),
    );
  }

  @override
  Future<List<Car>> suggestedCars([PostLocation? param]) async {
    return await _apiService.post(
      "$userUrl/suggestedCars",
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((car) => CarMapper.fromMap(car)).toList(),
      data: {"location": param?.toMap()},
    );
  }

  @override
  Future<void> listCar(CarPost car) async {
    var formData = FormData();
    car.car.cleanedMap().forEach((k, v) {
      if (v is Map || v is List) {
        formData.fields.add(MapEntry(k, jsonEncode(v)));
      } else {
        formData.fields.add(MapEntry(k, v.toString()));
      }
    });

    if (car.images != null) {
      for (var imageFile in car.images!) {
        final mimeType = getMimeType(imageFile.path);
        final multipartFile = await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
          contentType: MediaType.parse(mimeType),
        );
        formData.files.add(MapEntry('images', multipartFile));
      }
    } else {
      throw ApiException(message: "No images", statusCode: 403);
    }

    await _apiService.post("$companyUrl/car/new", data: formData);
  }

  @override
  Future<void> updateCar(CarPost car) async {
    var formData = FormData();
    car.car.cleanedMap().forEach((k, v) {
      if (v is Map || v is List) {
        formData.fields.add(MapEntry(k, jsonEncode(v)));
      } else {
        formData.fields.add(MapEntry(k, v.toString()));
      }
    });

    if (car.deletedImages != null) {
      final deletedImagesJson = jsonEncode(
        car.deletedImages
            ?.map((image) => {"id": image.id, "image": image.image})
            .toList(),
      );
      formData.fields.add(MapEntry('deletedImages', deletedImagesJson));
    }

    if (car.deletedRentalPlans != null) {
      final deletedRentalPlansJson = jsonEncode(
        car.deletedRentalPlans?.map((rent) => {"id": rent.id}).toList(),
      );
      formData.fields.add(
        MapEntry('deletedRentalPlans', deletedRentalPlansJson),
      );
    }
    if (car.images != null) {
      for (var imageFile in car.images!) {
        final mimeType = getMimeType(imageFile.path);

        final multipartFile = await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
          contentType: MediaType.parse(mimeType),
        );
        formData.files.add(MapEntry('images', multipartFile));
      }
    }

    await _apiService.post("$companyUrl/car/update", data: formData);
  }

  @override
  Future<void> sortImages(List<Images> images) async {
    return await _apiService.post(
      "$companyUrl/car/sort",
      data: images.map((e) => e.toMap()).toList(),
    );
  }

  @override
  Future<void> deleteCar(String carId) async {
    return await _apiService.post(
      "$companyUrl/car/delete",
      data: {"id": carId},
    );
  }

  @override
  Future<void> deletePromotion(String promotionId) async {
    return await _apiService.post(
      "$companyUrl/promotion/delete",
      data: {"id": promotionId},
    );
  }

  @override
  Future<String> promotion(Promotion promotion) async {
    return await _apiService.post(
      "$companyUrl/promotion/new",
      data: promotion.cleanedMap(),
    );
  }

  @override
  Future<List<Promotion>> promotions([PromotionPost? param]) async {
    return await _apiService.post(
      "$companyUrl/promotions",
      data: param?.toMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((x) => PromotionMapper.fromMap(x)).toList(),
    );
  }

  @override
  Future<List<Car>> companyCars([CarsCursor? param]) async {
    return await _apiService.post(
      "$companyUrl/getCars",
      data: param?.cleanedMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((car) => CarMapper.fromMap(car)).toList(),
    );
  }

  @override
  Future<List<Car>> userCompanyCars(CarsCursor param) async {
    return await _apiService.post(
      "$userUrl/getCars",
      data: param.cleanedMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((car) => CarMapper.fromMap(car)).toList(),
    );
  }

  @override
  Future<List<Car>> allCars(CarsCursor param) async {
    return await _apiService.post(
      "$adminUrl/allCars",
      data: param.cleanedMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((car) => CarMapper.fromMap(car)).toList(),
    );
  }

  @override
  Future<FilterData> filtersData() async {
    return await _apiService.post(
      "$userUrl/filters",
      fromMap: (data) => FilterDataMapper.fromMap(data),
    );
  }

  @override
  Future<List<Brand>> brands() async {
    return await _apiService.post(
      "$companyUrl/brands",
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((brand) => BrandMapper.fromMap(brand)).toList(),
    );
  }

  @override
  Future<List<CarType>> carTypes() async {
    return await _apiService.post(
      "$companyUrl/carTypes",
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((types) => CarTypeMapper.fromMap(types)).toList(),
    );
  }

  @override
  Future<List<Plan>> plans() async {
    return await _apiService.post<List<Plan>>(
      "$companyUrl/plans",
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((brand) => PlanMapper.fromMap(brand)).toList(),
    );
  }

  @override
  Future<void> updatePromotion(PromotionUpdate promotion) async {
    return await _apiService.post(
      "$companyUrl/promotion/update",
      data: promotion.cleanedMap(),
    );
  }

  @override
  Future<Paginated> cars([String? cursor]) async {
    return await _apiService.post(
      "$userUrl/cars",
      data: {"cursor": cursor},
      fromMap: (data) => PaginatedMapper.fromMap(data),
    );
  }

  @override
  Future<List<Car>> explorerMap([PostLocation? param]) async {
    if (param?.west == null) return [];
    return await _apiService.post(
      "$userUrl/explorerMap",
      data: param?.cleanedMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((car) => CarMapper.fromMap(car)).toList(),
    );
  }

  @override
  Future<void> deleteFeaturedCar(String id) async {
    return await _apiService.post(
      "$adminUrl/deleteFeaturedCar",
      data: {"id": id},
    );
  }

  @override
  Future<List<Car>> featuredCars() async {
    return await _apiService.post(
      "$adminUrl/featuredCars",
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((car) => CarMapper.fromMap(car)).toList(),
    );
  }

  @override
  Future<String?> newFeaturedCar(FeaturedCars param) async {
    return await _apiService.post(
      "$adminUrl/newFeaturedCar",
      data: param.cleanedMap(),
    );
  }

  @override
  Future<void> sortFeaturedCar(List<SortModel> param) async {
    return await _apiService.post(
      "$adminUrl/sortFeaturedCar",
      data: param.map((e) => e.toMap()).toList(),
    );
  }
}
