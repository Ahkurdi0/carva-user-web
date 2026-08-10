import 'dart:async';

import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/car_cursor.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_company_cars.g.dart';

@riverpod
class UserCompanyCars extends _$UserCompanyCars {
  late CarRepo _carRepo;
  @override
  FutureOr<List<Car>> build(CarsCursor param) async {
    _carRepo = sl();

    ref.keepAlive();

    final refreshTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      ref.invalidateSelf();
    });

    ref.onDispose(() {
      refreshTimer.cancel();
    });

    final result = await _carRepo.userCompanyCars(param);

    return result.fold((l) => throw l.message, (r) => r);
  }
}
