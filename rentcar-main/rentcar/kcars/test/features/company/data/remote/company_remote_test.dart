import 'package:flutter_test/flutter_test.dart';
import 'package:kcars/core/services/info.dart';
import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/company/data/model/contact.dart';
import 'package:kcars/features/company/data/model/post_company.dart';
import 'package:kcars/features/company/data/remote/company_remote.dart';
import 'package:mockito/mockito.dart';
import '../../../../helper_tests.dart';
import '../../../../utils.dart';
import '../../../api_service_mocks.mocks.dart';
import '../../company_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockApiService mockApiService;
  late CompanyRemote companyRemoete;

  setUp(() {
    mockApiService = MockApiService();
    companyRemoete = CompanyRemoteImpl(mockApiService);
  });
  group("[CompanyRemote Tests]", () {
    test("Should success when update company", () async {
      final url = "${Info.company}/updateCompany";
      when(
        mockApiService.post(url, data: anyNamed('data')),
      ).thenAnswer((_) async => url);
      final param = CompanyData.postCompany();
      await companyRemoete.updateCompany(param);

      verify(mockApiService.post(url, data: anyNamed('data'))).called(1);
    });

    test("Should fail when update company", () async {
      final url = "${Info.company}/updateCompany";
      when(
        mockApiService.post(url, data: anyNamed('data')),
      ).thenThrow(apiException());
      final param = PostCompany(
        company: Company(id: "", name: "TEst"),
      );
      expectApiException(() => companyRemoete.updateCompany(param));

      verify(mockApiService.post(url, data: anyNamed('data'))).called(1);
    });

    test("Should success when sort contacts", () async {
      final url = "${Info.company}/sortContacts";
      when(
        mockApiService.post(url, data: anyNamed('data')),
      ).thenAnswer((_) async => null);
      final param = <Contact>[];
      await companyRemoete.sortContacts(param);
      verify(mockApiService.post(url, data: anyNamed('data'))).called(1);
    });

    test("Should fail when sort contacts", () async {
      final url = "${Info.company}/sortContacts";
      when(
        mockApiService.post(url, data: anyNamed('data')),
      ).thenThrow(apiException());
      final param = <Contact>[Contact(id: "A"), Contact(id: "B")];
      expectApiException(() => companyRemoete.sortContacts(param));
      verify(mockApiService.post(url, data: anyNamed('data'))).called(1);
    });
  });

  group("Companies Data", () {
    test("[Should Return List Companues]", () async {
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap]
                as List<Company> Function(dynamic);

        final companies = await loadJsonData("company");
        final listCompany = List<DataMap>.from(companies);
        return fromMap(listCompany).toList();
      });
      final url = "${Info.admin}/companies";
      final expectedData = [CompanyData.company()];
      final param = CompanyData.companyCursor();
      final result = await companyRemoete.companies(param);
      expect(result, equals(expectedData));
      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      );
    });

    test("[Should Fail when Return Compnayes]", () async {
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      final url = "${Info.admin}/companies";
      final param = CompanyData.companyCursor();
      expectApiException(() => companyRemoete.companies(param));
      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      );
    });

    test("[Should Success When Create New Company]", () async {
      final url = "${Info.admin}/newCompany";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((_) async {});
      final param = CompanyData.company().copyWith(profile: null);
      await companyRemoete.newCompany(param);
      verify(mockApiService.post(url, data: anyNamed("data"))).called(1);
    });

    test("[Should Fail When Create New Company]", () async {
      final url = "${Info.admin}/newCompany";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      final param = CompanyData.company().copyWith(profile: null);
      expectApiException(() => companyRemoete.newCompany(param));
      verify(mockApiService.post(url, data: anyNamed("data"))).called(1);
    });
  });
}
