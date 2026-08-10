import 'package:kcars/core/providers/user_location.dart';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/app_settings/data/model/sort_model.dart';
import 'package:kcars/features/auth/presentation/riverpod/is_admin.dart';
import 'package:kcars/features/car/application/car_states.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/car_post.dart';
import 'package:kcars/features/car/data/model/image.dart';
import 'package:kcars/features/car/data/model/post_location.dart';
import 'package:kcars/features/car/data/model/promotion.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';
import 'package:kcars/features/car/presentation/riverpod/all_cars.dart';
import 'package:kcars/features/car/presentation/riverpod/brand_cars.dart';
import 'package:kcars/features/car/presentation/riverpod/cars.dart';
import 'package:kcars/features/car/presentation/riverpod/company_cars.dart';
import 'package:kcars/features/car/presentation/riverpod/favorite_cars.dart';
import 'package:kcars/features/car/presentation/riverpod/featuerd_cars.dart'
    hide FeaturedCars;
import 'package:kcars/features/car/presentation/riverpod/filter_cars.dart';
import 'package:kcars/features/car/presentation/riverpod/nearby_cars.dart';
import 'package:kcars/features/car/presentation/riverpod/promotions.dart';
import 'package:kcars/features/car/presentation/riverpod/recently_viewed.dart';
import 'package:kcars/features/car/presentation/riverpod/suggested_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'car_controller.g.dart';

@riverpod
class CarController extends _$CarController {
  late CarRepo _carRepo;
  CarController._(this._carRepo);
  factory CarController.test({required CarRepo carRepo}) {
    return CarController._(carRepo);
  }

  CarController() : _carRepo = sl<CarRepo>();

  @override
  CarStates build() {
    return const InitialCarState();
  }

  Future<void> listCar(CarPost car) async {
    state = const NewCarLoading();
    final result = await _carRepo.listCar(car);
    result.fold<Future<void>>((l) async => state = NewCarFailed(l.message), (
      r,
    ) async {
      state = const NewCarCompleted();
      ref.invalidate(companyCarsProvider);
    });
  }

  Future<void> updateCar(CarPost car, [Car? orginal]) async {
    state = const NewCarLoading();
    final hasUpdarePermssion = ref.watch(hasPermossionProvider());
    final result = await _carRepo.updateCar(car);
    await result.fold<Future<void>>(
      (l) async => state = NewCarFailed(l.message),
      (r) async {
        if (hasUpdarePermssion && orginal == null) {
          await ref.read(allCarsProvider.notifier).loadInitial();
        } else if (orginal != null) {
          ref.read(companyCarsProvider.notifier).updateCar(orginal);
        } else {
          await ref.read(companyCarsProvider.notifier).loadInitial();
        }
        state = const NewCarCompleted();
      },
    );
  }

  Future<void> adminUpdateCar(CarPost car) async {
    state = const NewCarLoading();
    final result = await _carRepo.updateCar(car);
    result.fold<Future<void>>((l) async => state = NewCarFailed(l.message), (
      r,
    ) async {
      await ref.read(allCarsProvider.notifier).loadInitial();

      state = const NewCarCompleted();
    });
  }

  Future<void> deleteCar(String id) async {
    state = const DeleteCarLoading();
    final result = await _carRepo.deleteCar(id);
    result.fold<Future<void>>((l) async => state = DeleteCarFailed(l.message), (
      r,
    ) async {
      ref.read(companyCarsProvider.notifier).deleteCar(id);
      state = const DeleteCarCompleted();
    });
  }

  Future<void> newPromotion(Promotion param, PromotionPost post) async {
    state = const NewPromotionLoading();
    final result = await _carRepo.promotion(param);

    await result.fold<Future<void>>(
      (l) async => state = NewPromotionFailed(l.message),
      (r) async {
        ref
            .read(promotionsProvider(post).notifier)
            .newPromotion(param.copyWith(id: r));
        state = const NewPromotionCompleted();
      },
    );
  }

  Future<void> updatePromotion(
    PromotionUpdate param,
    PromotionPost post,
    Promotion promo,
  ) async {
    state = const NewPromotionLoading();
    final result = await _carRepo.updatePromotion(param);
    await result.fold<Future<void>>(
      (l) async => state = NewPromotionFailed(l.message),
      (r) async {
        ref.read(promotionsProvider(post).notifier).updatePromotion(promo);
        state = const NewPromotionCompleted();
      },
    );
  }

  Future<void> deletePromotion(String id, [PromotionPost? param]) async {
    state = const DeletePromotionLoading();
    final result = await _carRepo.deletePromotion(id);
    await result.fold<Future<void>>(
      (l) async => state = DeletePromotionFailed(l.message),
      (r) async {
        if (param != null) {
          ref.read(promotionsProvider(param).notifier).deletePromotion(id);
        }
        state = const DeletePromotionCompleted();
      },
    );
  }

  Future<void> sortImages(List<Images> images, String carId) async {
    state = const SortImagesLoading();
    final result = await _carRepo.sortImages(images);
    final hasUpdarePermssion = ref.read(hasPermossionProvider());
    await result.fold<Future<void>>(
      (l) async => state = SortImagesFailed(l.message),
      (r) async {
        if (hasUpdarePermssion) {
          ref.read(allCarsProvider.notifier).sortedImages(images, carId);
        }
        ref.read(companyCarsProvider.notifier).sortedImages(images, carId);
        state = const SortImagesCompleted();
      },
    );
  }

  Future<void> favoriteCar(
    Car car,
    String? brandId, [
    PostLocation? param,
  ]) async {
    state = const FavoriteCarCompleted();
    final result = await _carRepo.favoriteCar(car.id);
    await result.fold<Future<void>>(
      (l) async => state = FavoriteCarFailed(l.message),
      (r) async {
        final location = ref.watch(userLocationProvider());
        ref.read(suggestedCarProvider().notifier).favoriteCar(car.id);
        ref.read(recentlyViwedCarProvider.notifier).favoriteCar(car.id);
        ref.read(carsProvider.notifier).favoriteCar(car.id);
        if (brandId != null) {
          ref.read(brandCarsProvider.notifier).favoriteCar(car.id, brandId);
        }
        ref.read(filtersCarsProvider().notifier).favoriteCar(car.id);
        ref
            .read(filtersCarsProvider(car.company?.id).notifier)
            .favoriteCar(car.id);
        ref.read(nearbayCarsProvider(location).notifier).favoriteCar(car.id);
        ref
            .read(favoriteCarsProvider.notifier)
            .toggleCars(
              car.copyWith(
                isFavorite: car.isFavorite != null ? !car.isFavorite! : true,
              ),
            );
      },
    );
  }

  Future<void> newFaturedCar(Car car) async {
    state = const NewFeatureCarLoading();
    final result = await _carRepo.newFeaturedCar(car.featuredCars!);
    await result.fold<Future<void>>(
      (l) async => state = NewFeatureCarFailed(l.message),
      (r) async {
        ref.invalidate(featuredCarsProvider);
        state = const NewFeatureCarCompleted();
      },
    );
  }

  Future<void> deleteFaturedCar(Car car) async {
    state = const DeleteFeatureCarLoading();
    final result = await _carRepo.deleteFeaturedCar(car.featuredCars!.id!);
    await result.fold<Future<void>>(
      (l) async => state = DeleteFeatureCarFailed(l.message),
      (r) async {
        ref.invalidate(featuredCarsProvider);
        state = const DeleteFeatureCarCompleted();
      },
    );
  }

  Future<void> sortFeaturdCars(List<SortModel> param) async {
    final result = await _carRepo.sortFeaturedCar(param);
    await result.fold<Future<void>>(
      (l) async => state = SortItemFailed(l.message),
      (r) async {
        state = const SortItemCompleted();
      },
    );
  }
}
