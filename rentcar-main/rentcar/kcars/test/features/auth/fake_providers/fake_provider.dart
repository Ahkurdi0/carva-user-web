import 'dart:async';

import 'package:kcars/features/car/data/model/brand.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/post_location.dart';
import 'package:kcars/features/car/presentation/riverpod/brand_cars.dart';
import 'package:kcars/features/car/presentation/riverpod/recently_viewed.dart';
import 'package:kcars/features/car/presentation/riverpod/suggested_controller.dart';

import '../../car/utils/car_test_data.dart';

class FakeSuggestionProvider extends SuggestedCar {
  @override
  FutureOr<List<Car>> build([PostLocation? param]) async {
    return [CarTestData.car()];
  }
}

class FakeRecentlyViewedProvider extends RecentlyViwedCar {
  @override
  FutureOr<List<Car>> build([PostLocation? param]) async {
    return [CarTestData.car()];
  }
}

class FakeBrandCarsProvider extends BrandCars {
  @override
  FutureOr<List<Brand>> build([PostLocation? param]) async {
    return [CarTestData.brandCars()];
  }
}
