import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/company/domain/company_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'my_company.g.dart';

@riverpod
class MyCompany extends _$MyCompany {
  late CompanyRepo _companyRepo;
  @override
  FutureOr<Company> build() async {
    _companyRepo = sl<CompanyRepo>();

    final result = await _companyRepo.myCompany();
    return result.fold((l) => throw l.message, (r) => r);
  }
}
