import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcars/features/car/data/model/town.dart';
import 'package:kcars/features/company/presentation/riverpod/cities.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:collection/collection.dart';
part 'towns.g.dart';

@riverpod
List<Town>? towns(Ref ref, String? cityId) {
  final citiesAsync = ref.watch(citiesProvider);

  return citiesAsync.when(
    data: (cities) {
      if (cityId == null) return null;

      final matchingGov = cities.firstWhereOrNull((city) => city.id == cityId);

      return matchingGov?.towns;
    },
    loading: () => null,
    error: (err, stack) {
      return null;
    },
  );
}
