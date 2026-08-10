import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/company/data/model/company_statistic.dart';
import 'package:kcars/features/company/domain/company_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'company_statistics.g.dart';

@riverpod
class CompanyStatistics extends _$CompanyStatistics {
  late CompanyRepo _repo;
  @override
  FutureOr<List<CompanyStatistic>> build([DateTime? date]) async {
    _repo = sl<CompanyRepo>();
    final result = await _repo.companyStatistic(date);
    return result.fold((l) => throw l.message, (r) => r);
  }
}
