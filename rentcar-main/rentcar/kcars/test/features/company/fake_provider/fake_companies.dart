import 'package:kcars/core/utils/pagination.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/company/presentation/riverpod/companies.dart';

class FakeCompaniesProvider extends Companies {
  @override
  PagingState<Company> build(bool expired) {
    return PagingState.initial();
  }

  @override
  void add(Company company) {
    state = state.copyWith(items: [company, ...state.items]);
  }

  @override
  void updateCompany(Company param) {
    final newState = state.items
        .map((c) => c.id == param.id ? param : c)
        .toList();
    state = state.copyWith(items: newState);
  }
}
