import 'package:kcars/core/providers/explorer_location.dart';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'explorer_map.g.dart';

@riverpod
class ExplorerMap extends _$ExplorerMap {
  late CarRepo _carRepo;
  @override
  FutureOr<List<Car>> build() async {
    _carRepo = sl<CarRepo>();

    final location = ref.watch(explorerLocationProvider);

    if (location.east != null) [];

    final result = await _carRepo.explorerMap(location);
    return result.fold((l) => throw l.message, (r) => r);
  }
}
