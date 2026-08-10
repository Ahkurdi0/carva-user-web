import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
import 'package:kcars/features/car/data/model/booked_dates.dart';
import 'package:kcars/features/car/data/model/brand.dart';
import 'package:kcars/features/car/data/model/car_location.dart';
import 'package:kcars/features/car/data/model/car_type.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:kcars/features/car/data/model/feature.dart';
import 'package:kcars/features/car/data/model/featured_cars.dart';
import 'package:kcars/features/car/data/model/image.dart';
import 'package:kcars/features/car/data/model/promotion.dart';
import 'package:kcars/features/car/data/model/rental_plan.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/review/data/model/car_review.dart';
part 'car.mapper.dart';

@MappableClass()
class Car with CarMappable, CleanMapMixin {
  final String id;
  final String title;
  final double? rate;
  final int? review;
  final int? trips;
  final DateTime listedAt;
  final List<Images>? images;
  final Brand? brand;
  final CarType? type;
  final Feature? feature;
  final Company? company;
  final CarLocation? location;
  final bool? isViwed;
  final bool? isFavorite;
  final Promotion? promotion;
  final List<RentalPlan>? rentalPlan;
  final List<BookedDates>? bookings;
  final CarReview? reviews;
  final bool? reviewCar;
  final bool? available;
  final String? brandId;
  final String? typeId;
  final int? serial;
  final String? carId;
  final int? viewed;
  final RentalPeriodType? displayPlan;
  final FeaturedCars? featuredCars;
  final DateTime? deletedAt;

  Car({
    required this.id,
    required this.title,
    this.rate,
    this.review,
    this.trips,
    required this.listedAt,
    this.images,
    this.brand,
    this.type,
    this.feature,
    this.company,
    this.location,
    this.isViwed,
    this.isFavorite,
    this.promotion,
    this.rentalPlan,
    this.bookings,
    this.reviews,
    this.reviewCar,
    this.available,
    this.brandId,
    this.typeId,
    this.serial,
    this.carId,
    this.viewed,
    this.displayPlan,
    this.featuredCars,
    this.deletedAt,
  });
}

@MappableClass()
class CarUpdate with CarUpdateMappable, CleanMapMixin {
  final String? id;
  final String? title;
  final Brand? brand;
  final CarType? type;
  final Feature? feature;
  final CarLocation? location;
  final List<RentalPlan>? rentalPlan;
  final String? typeId;
  final String? brandId;
  final bool? available;
  final RentalPeriodType? displayPlan;

  CarUpdate({
    this.id,
    this.title,
    this.brand,
    this.type,
    this.feature,
    this.location,
    this.rentalPlan,
    this.typeId,
    this.brandId,
    this.available,
    this.displayPlan,
  });
}

extension CarUpdateDiffExtension on CarUpdate {
  CarUpdate toDiff(Car original) {
    return CarUpdate(
      id: id,
      title: title == original.title ? null : title,
      available: available == original.available ? null : available,
      brand: null,
      type: null,
      displayPlan: original.displayPlan == displayPlan ? null : displayPlan,
      brandId: brand?.id == original.brand?.id ? null : brand?.id,
      typeId: typeId == original.type?.id ? null : typeId,
      feature: feature?.copyWith(
        type: null,
        seat: feature?.seat == original.feature?.seat ? null : feature?.seat,
        fuel: feature?.fuel == original.feature?.fuel ? null : feature?.fuel,
        transmission: feature?.transmission == original.feature?.transmission
            ? null
            : feature?.transmission,
        id: null,
        speed: feature?.speed == original.feature?.speed
            ? null
            : feature?.speed,
        hp: feature?.hp == original.feature?.hp ? null : feature?.hp,
        engCC: feature?.engCC == original.feature?.engCC
            ? null
            : feature?.engCC,
        year: feature?.year == original.feature?.year ? null : feature?.year,
        odometer: feature?.odometer == original.feature?.odometer
            ? null
            : feature?.odometer,
        cylinders: feature?.cylinders == original.feature?.odometer
            ? null
            : feature?.cylinders,
        carId: null,
      ),
      location: location?.copyWith(
        id: null,
        lat: original.location?.lat == location?.lat ? null : location?.lat,
        long: original.location?.long == location?.long ? null : location?.long,
        cityId: original.location?.cityId == location?.cityId
            ? null
            : location?.cityId,
        townId: original.location?.townId == location?.townId
            ? null
            : location?.townId,
        city: original.location?.city?.id == location?.city?.id
            ? null
            : location?.city,
        town: original.location?.town?.id == location?.town?.id
            ? null
            : location?.town,
      ),
      rentalPlan: _rentalPlansEqual(rentalPlan, original.rentalPlan)
          ? null
          : rentalPlan,
    );
  }

  bool _rentalPlansEqual(List<RentalPlan>? a, List<RentalPlan>? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;

    for (int i = 0; i < a.length; i++) {
      if (a[i].id != b[i].id) return false;
    }
    return true;
  }

  Car toCar() {
    return Car(
      title: title!,
      id: '',
      feature: feature,
      brand: null,
      location: location,
      rentalPlan: rentalPlan,
      type: null,
      rate: 0,
      brandId: brandId,
      typeId: typeId,
      review: 0,
      trips: 0,
      available: available,
      listedAt: DateTime.now(),
    );
  }
}
