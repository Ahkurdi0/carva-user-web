import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';
import 'package:kcars/features/review/data/model/car_review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'details_car.g.dart';

@riverpod
class DetailsCar extends _$DetailsCar {
  late CarRepo _carRepo;
  @override
  FutureOr<Car> build(String carId) async {
    _carRepo = sl<CarRepo>();

    final result = await _carRepo.detailCars(carId);
    return result.fold((l) => throw l.message, (r) => r);
  }

  List<DateTime> getBlackoutDates() {
    final List<DateTime> blackoutDates = [];
    if (state.value?.bookings == null ||
        state.value!.bookings == null ||
        state.value!.bookings!.isEmpty) {
      return [];
    }
    for (final booked in state.value!.bookings!) {
      DateTime day = booked.startDate;
      while (!day.isAfter(booked.endDate)) {
        blackoutDates.add(day);
        day = day.add(Duration(days: 1));
      }
    }

    return blackoutDates;
  }

  void deleteReview() {
    final newState = state.value?.copyWith(reviews: null, reviewCar: true);
    if (newState == null) return;
    state = AsyncData(newState);
  }

  void newReview(CarReview review) {
    final newState = state.value?.copyWith(reviews: review, reviewCar: false);
    if (newState == null) return;
    state = AsyncData(newState);
  }
}
