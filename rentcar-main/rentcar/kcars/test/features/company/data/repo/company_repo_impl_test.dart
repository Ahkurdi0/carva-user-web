import 'package:flutter_test/flutter_test.dart';
import 'package:kcars/configs/error/exception.dart';
import 'package:kcars/features/company/data/model/contact.dart';
import 'package:kcars/features/company/data/model/post_company.dart';
import 'package:kcars/features/company/data/repo/company_repo_impl.dart';
import 'package:kcars/features/company/domain/company_repo.dart';
import 'package:mockito/mockito.dart';
import '../../../../helper_tests.dart';
import 'company_repo.mocks.mocks.dart';

void main() {
  late MockCompanyRemote mockCompanyRemote;
  late CompanyRepo companyRepo;

  setUp(() {
    mockCompanyRemote = MockCompanyRemote();
    companyRepo = CompanyRepoImpl(mockCompanyRemote);
  });
  group("[Company Action Tests]", () {
    test("[Should success when update company]", () async {
      final param = PostCompany();
      when(
        mockCompanyRemote.updateCompany(param),
      ).thenAnswer((_) async => Future.value(null));
      final result = await companyRepo.updateCompany(param);
      expectSuccess(result, null);
      verify(mockCompanyRemote.updateCompany(param)).called(1);
    });

    test("[Should fail when update company]", () async {
      final param = PostCompany();
      when(
        mockCompanyRemote.updateCompany(param),
      ).thenThrow(ApiException.exception());
      final result = await companyRepo.updateCompany(param);
      expectFailureWithStatusCode(result);
      verify(mockCompanyRemote.updateCompany(param)).called(1);
    });

    test("[Should success when sort contacts]", () async {
      final param = <Contact>[];
      when(
        mockCompanyRemote.sortContacts(param),
      ).thenAnswer((_) async => Future.value(null));
      final result = await companyRepo.sortContacts(param);
      expectSuccess(result, null);
      verify(mockCompanyRemote.sortContacts(param)).called(1);
    });

    test("[Should fail when sort contacts]", () async {
      final param = <Contact>[];
      when(
        mockCompanyRemote.sortContacts(param),
      ).thenThrow(ApiException.exception());
      final result = await companyRepo.sortContacts(param);
      expectFailureWithStatusCode(result);
      verify(mockCompanyRemote.sortContacts(param)).called(1);
    });
  });
}
