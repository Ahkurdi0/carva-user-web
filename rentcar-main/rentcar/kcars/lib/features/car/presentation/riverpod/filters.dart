import 'package:kcars/core/utils/debouncer.dart';
import 'package:kcars/features/car/data/model/filter.dart';
import 'package:kcars/features/car/presentation/riverpod/filter_cars.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filters.g.dart';

@riverpod
class Filters extends _$Filters {
  @override
  Filter build() {
    return Filter();
  }

  void setFilter(Filter filter) {
    state = filter;
    AppDebounce.debounce("filters", Duration(seconds: 1), () {
      ref
          .read(filtersCarsProvider(filter.companyId).notifier)
          .filterCars(filter);
    });
  }

  void clearFilter([String? id]) {
    state = Filter();
    ref.read(filtersCarsProvider(id).notifier).filterCars(Filter());
  }
}
