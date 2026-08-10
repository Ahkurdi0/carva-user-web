import 'dart:async';

import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/car/data/model/filter_data.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'filters_data.g.dart';

@riverpod
class FiltersData extends _$FiltersData {
  late CarRepo _carRepo;
  @override
  FutureOr<FilterData> build() async {
    _carRepo = sl<CarRepo>();
    ref.keepAlive();
    final timer = Timer.periodic(Duration(minutes: 5), (_) {
      ref.invalidateSelf();
    });

    ref.onDispose(() {
      timer.cancel();
    });
    final result = await _carRepo.filtersData();
    return result.fold((l) => throw l.message, (r) => r);
  }
}
