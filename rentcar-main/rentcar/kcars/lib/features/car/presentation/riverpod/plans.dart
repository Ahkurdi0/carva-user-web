import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/car/data/model/paln.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'plans.g.dart';

@Riverpod(keepAlive: true)
class Plans extends _$Plans {
  late CarRepo _carRepo;
  @override
  FutureOr<List<Plan>> build() async {
    _carRepo = sl();

    final result = await _carRepo.plans();

    return result.fold((l) => throw l.message, (r) => r);
  }
}
