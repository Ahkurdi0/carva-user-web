import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/company/application/company_states.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/company/data/model/contact.dart';
import 'package:kcars/features/company/data/model/post_company.dart';
import 'package:kcars/features/company/domain/company_repo.dart';
import 'package:kcars/features/company/presentation/riverpod/companies.dart';
import 'package:kcars/features/user/presentation/riverpod/search_user.dart';
import 'package:kcars/features/user/presentation/riverpod/users.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'company_controller.g.dart';

@riverpod
class CompanyController extends _$CompanyController {
  late CompanyRepo _companyRepo;
  CompanyController._(this._companyRepo);

  factory CompanyController.test({required CompanyRepo companyRepo}) {
    return CompanyController._(companyRepo);
  }

  CompanyController() : _companyRepo = sl<CompanyRepo>();
  @override
  CompanyStates build() {
    return CompanyInitial();
  }

  Future<void> updateCompany(PostCompany param) async {
    state = const UpdateCompanyLoading();
    final result = await _companyRepo.updateCompany(param);
    await result.fold((l) async => state = UpdateCompanyFailed(l.message), (
      r,
    ) async {
      state = const UpdateCompanyCompleted();
    });
  }

  Future<void> newCompany(Company param, {Company? orginal}) async {
    state = const NewCompanyLoading();
    final result = await _companyRepo.newCompany(
      orginal != null ? param.toDiff(orginal) : param,
    );

    await result.fold((l) async => state = NewCompanyFailed(l.message), (
      r,
    ) async {
      if (param.id == "") {
        ref.read(companiesProvider(false).notifier).add(param.copyWith(id: r));
      } else {
        ref
            .read(companiesProvider(param.available ?? true).notifier)
            .updateCompany(param);
      }
      ref
          .read(usersProvider(param.profile?.role.roleName ?? "user").notifier)
          .updateCompany(param);

      ref
          .read(searchUsersProvider.notifier)
          .updateCompany(param.copyWith(id: r ?? param.id));
      state = const NewCompanyCompleted();
    });
  }

  Future<void> sortContacts(List<Contact> param) async {
    state = const SortContactsLoading();
    final result = await _companyRepo.sortContacts(param);
    await result.fold((l) async => state = SortContactsFailed(l.message), (
      r,
    ) async {
      state = const SortContactsCompleted();
    });
  }
}
