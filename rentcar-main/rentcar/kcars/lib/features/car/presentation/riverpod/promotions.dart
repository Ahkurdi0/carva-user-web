import 'dart:async';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/car/data/model/promotion.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'promotions.g.dart';

@riverpod
class Promotions extends _$Promotions {
  late CarRepo _carRepo;
  @override
  FutureOr<List<Promotion>> build([PromotionPost? param]) async {
    _carRepo = sl();

    ref.keepAlive();

    final refreshTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      ref.invalidateSelf();
    });

    ref.onDispose(() {
      refreshTimer.cancel();
    });

    final result = await _carRepo.promotions(param!);

    return result.fold((l) => throw l.message, (r) => r);
  }

  void newPromotion(Promotion promotion) {
    state = AsyncValue.data([promotion, ...?state.value]);
  }

  void updatePromotion(Promotion promotion) {
    final newState = state.value
        ?.map((p) => p.id == promotion.id ? promotion : p)
        .toList();
    state = AsyncValue.data(newState ?? []);
  }

  void deletePromotion(String id) {
    state = AsyncValue.data(
      state.value!.where((element) => element.id != id).toList(),
    );
  }
}
