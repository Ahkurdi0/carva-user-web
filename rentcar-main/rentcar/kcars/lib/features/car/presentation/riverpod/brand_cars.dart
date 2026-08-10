import 'dart:async';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/car/data/model/brand.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'brand_cars.g.dart';

@riverpod
class BrandCars extends _$BrandCars {
  late CarRepo _carRepo;
  @override
  FutureOr<List<Brand>> build() async {
    _carRepo = sl<CarRepo>();
    ref.keepAlive();

    final refreshTimeer = Timer.periodic(Duration(minutes: 5), (_) {
      ref.invalidateSelf();
    });
    ref.onDispose(() {
      refreshTimeer.cancel();
    });
    final result = await _carRepo.brandCars();
    return result.fold((l) => throw l.message, (r) => r);
  }

  void favoriteCar(String carId, String brandId) {
    final brands = state.value;
    if (brands == null) return;

    final updatedBrands = brands.map((brand) {
      if (brand.id != brandId) return brand;

      final updatedCars = brand.cars?.map((car) {
        if (car.id != carId) return car;

        return car.copyWith(
          isFavorite: car.isFavorite != null && !car.isFavorite!,
        );
      }).toList();

      return brand.copyWith(cars: updatedCars);
    }).toList();

    state = AsyncData(updatedBrands);
  }
}
