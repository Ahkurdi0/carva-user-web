import 'package:fpdart/fpdart.dart';
import 'package:kcars/configs/error/exception.dart';
import 'package:kcars/configs/error/failure.dart';
import 'package:kcars/core/services/type_defs.dart';
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
import 'package:kcars/features/car/data/remote/car_remote.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';

class CarRepoImpl implements CarRepo {
  CarRepoImpl(this._carRemote);
  final CarRemote _carRemote;
  @override
  Result<List<Brand>> brandCars([PostLocation? param]) async {
    try {
      final result = await _carRemote.brandCars(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> deleteCar(String carId) async {
    try {
      final result = await _carRemote.deleteCar(carId);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> deletePromotion(String promotionId) async {
    try {
      final result = await _carRemote.deletePromotion(promotionId);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<Car> detailCars(String carId) async {
    try {
      final result = await _carRemote.detailCars(carId);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<String?> favoriteCar(String id) async {
    try {
      final result = await _carRemote.favoriteCar(id);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Car>> favoriteCars([String? cursor]) async {
    try {
      final result = await _carRemote.favoriteCars(cursor);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Car>> filterCars([Filter? param]) async {
    try {
      final result = await _carRemote.filterCars(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> listCar(CarPost car) async {
    try {
      final result = await _carRemote.listCar(car);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Car>> nearBayCars([PostLocation? param]) async {
    try {
      final result = await _carRemote.nearBayCars(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<String> promotion(Promotion promotion) async {
    try {
      final result = await _carRemote.promotion(promotion);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> updatePromotion(PromotionUpdate promotion) async {
    try {
      final result = await _carRemote.updatePromotion(promotion);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Promotion>> promotions([PromotionPost? param]) async {
    try {
      final result = await _carRemote.promotions(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Car>> recentlyViewed() async {
    try {
      final result = await _carRemote.recentlyViewed();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> sortImages(List<Images> images) async {
    try {
      final result = await _carRemote.sortImages(images);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Car>> suggestedCars([PostLocation? param]) async {
    try {
      final result = await _carRemote.suggestedCars(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> updateCar(CarPost car) async {
    try {
      await _carRemote.updateCar(car);
      return Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Car>> companyCars([CarsCursor? param]) async {
    try {
      final result = await _carRemote.companyCars(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Car>> userCompanyCars(CarsCursor param) async {
    try {
      final result = await _carRemote.userCompanyCars(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Car>> allCars(CarsCursor param) async {
    try {
      final result = await _carRemote.allCars(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<FilterData> filtersData() async {
    try {
      final result = await _carRemote.filtersData();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Brand>> brands() async {
    try {
      final result = await _carRemote.brandCars();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<CarType>> carTypes() async {
    try {
      final result = await _carRemote.carTypes();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Plan>> plans() async {
    try {
      final result = await _carRemote.plans();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<Paginated> cars([String? cursor]) async {
    try {
      final result = await _carRemote.cars(cursor);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Car>> explorerMap([PostLocation? param]) async {
    try {
      final result = await _carRemote.explorerMap(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> deleteFeaturedCar(String id) async {
    try {
      final result = await _carRemote.deleteFeaturedCar(id);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Car>> featuredCars() async {
    try {
      final result = await _carRemote.featuredCars();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<String?> newFeaturedCar(FeaturedCars param) async {
    try {
      final result = await _carRemote.newFeaturedCar(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> sortFeaturedCar(List<SortModel> param) async {
    try {
      final result = await _carRemote.sortFeaturedCar(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }
}
