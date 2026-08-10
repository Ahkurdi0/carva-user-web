import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/app_settings/data/model/statistics.dart';
import 'package:kcars/features/app_settings/domain/repo/app_settings_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'statistics.g.dart';

@riverpod
class AdminStatistics extends _$AdminStatistics {
  late AppSettingsRepo _settingsRepo;
  @override
  FutureOr<Statistics> build([DateTime? date]) async {
    _settingsRepo = sl<AppSettingsRepo>();
    final result = await _settingsRepo.statistics(date);

    return result.fold((l) => throw l.message, (r) => r);
  }
}
