import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kcars/core/utils/pagination.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/company/application/company_controller.dart';
import 'package:kcars/features/company/application/company_states.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/company/data/model/contact.dart';
import 'package:kcars/features/company/data/model/post_company.dart';
import 'package:kcars/features/company/presentation/riverpod/companies.dart';
import 'package:kcars/features/user/presentation/riverpod/search_user.dart';
import 'package:kcars/features/user/presentation/riverpod/users.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../helper_tests.dart';
import '../company_data.dart';
import '../company_repo_mocks.mocks.dart';

class FakeUsersProvidr extends Users {
  @override
  PagingState<Profile> build(String role) {
    return PagingState.initial();
  }

  @override
  void removeRole(String id) {
    final newState = state.items.where((user) => user.id != id).toList();
    state = state.copyWith(items: newState);
  }

  @override
  void addRole(Profile profile) {
    state = state.copyWith(items: [profile, ...state.items]);
  }

  @override
  void updateCompany(Company company) {
    final newState = state.items
        .map(
          (user) => user.userId == company.profile?.userId
              ? user.copyWith(company: company)
              : user,
        )
        .toList();
    state = state.copyWith(items: newState);
  }
}

class FakeSearchUsrsProvider extends SearchUsers {
  @override
  FutureOr<List<Profile>> build() {
    return [];
  }

  @override
  void searchForUsers(search) async {}
  @override
  void upadateRole(Profile profile) {
    final newState = state.value
        ?.map((user) => user.userId == profile.userId ? profile : user)
        .toList();
    state = AsyncData(newState ?? []);
  }

  @override
  void updateCompany(Company company) {
    final newState = state.value
        ?.map(
          (user) => user.userId == company.profile?.userId
              ? user.copyWith(company: company)
              : user,
        )
        .toList();
    state = AsyncData(newState ?? []);
  }
}

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

void main() {
  late MockCompanyRepo mockCompanyRepo;
  late ProviderContainer container;

  setUpAll(() {
    registerEitherFallback<String?>();
    registerEitherVoidFallback();
  });
  setUp(() {
    mockCompanyRepo = MockCompanyRepo();
    container = ProviderContainer(
      overrides: [
        companyControllerProvider.overrideWith(() {
          return CompanyController.test(companyRepo: mockCompanyRepo);
        }),
        usersProvider("user").overrideWith(() => FakeUsersProvidr()),
        searchUsersProvider.overrideWith(() => FakeSearchUsrsProvider()),
        companiesProvider(false).overrideWith(() => FakeCompaniesProvider()),
        companiesProvider(true).overrideWith(() => FakeCompaniesProvider()),
      ],
    );
  });
  group("Company Controller Test", () {
    test("[Should Success  When Update company]", () async {
      when(
        mockCompanyRepo.updateCompany(any),
      ).thenAnswer((_) async => Right(null));
      final controller = container.read(companyControllerProvider.notifier);
      final file = File("test/assets/car.png");
      expect(controller.state, isA<CompanyInitial>());
      final param = PostCompany(
        deletedContacts: [Contact(id: "id")],
        newContacts: [Contact(id: "id")],
        company: CompanyData.company(),
        image: file,
      );
      final future = controller.updateCompany(param);
      expect(controller.state, isA<UpdateCompanyLoading>());
      await future;
      expect(controller.state, isA<UpdateCompanyCompleted>());
      verify(mockCompanyRepo.updateCompany(param)).called(1);
    });
    test("[Should Fail  When Update company]", () async {
      when(mockCompanyRepo.updateCompany(any)).thenAnswer(failureAnswer());
      final controller = container.read(companyControllerProvider.notifier);
      final file = File("test/assets/car.png");
      expect(controller.state, isA<CompanyInitial>());
      final param = PostCompany(
        deletedContacts: [Contact(id: "id")],
        newContacts: [Contact(id: "id")],
        company: CompanyData.company(),
        image: file,
      );
      final future = controller.updateCompany(param);
      expect(controller.state, isA<UpdateCompanyLoading>());
      await future;
      expect(controller.state, isA<UpdateCompanyFailed>());
      verify(mockCompanyRepo.updateCompany(param)).called(1);
    });

    test("[Should Success When Sort Contacts]", () async {
      when(
        mockCompanyRepo.sortContacts(any),
      ).thenAnswer((_) async => Right(null));
      final controller = container.read(companyControllerProvider.notifier);
      expect(controller.state, isA<CompanyInitial>());
      final param = [CompanyData.contact()];
      final future = controller.sortContacts(param);
      expect(controller.state, isA<SortContactsLoading>());
      await future;
      expect(controller.state, isA<SortContactsCompleted>());
      verify(mockCompanyRepo.sortContacts(param)).called(1);
    });

    test("[Should Fail When Sort Contacts]", () async {
      when(mockCompanyRepo.sortContacts(any)).thenAnswer(failureAnswer());
      final controller = container.read(companyControllerProvider.notifier);
      expect(controller.state, isA<CompanyInitial>());
      final param = [CompanyData.contact()];
      final future = controller.sortContacts(param);
      expect(controller.state, isA<SortContactsLoading>());
      await future;
      expect(controller.state, isA<SortContactsFailed>());
      verify(mockCompanyRepo.sortContacts(param)).called(1);
    });
  });

  group("[Admin Company Tests]", () {
    test("Should Success When Create new Company", () async {
      when(
        mockCompanyRepo.newCompany(any),
      ).thenAnswer((_) async => Right(null));
      final controller = container.read(companyControllerProvider.notifier);
      expect(controller.state, isA<CompanyInitial>());
      final param = CompanyData.company();
      final future = controller.newCompany(param);
      expect(controller.state, isA<NewCompanyLoading>());
      await future;
      expect(controller.state, isA<NewCompanyCompleted>());
      verify(mockCompanyRepo.newCompany(param)).called(1);
    });

    test("Should Fail When Create new Company", () async {
      when(mockCompanyRepo.newCompany(any)).thenAnswer(failureAnswer());
      final controller = container.read(companyControllerProvider.notifier);
      expect(controller.state, isA<CompanyInitial>());
      final param = CompanyData.company();
      final future = controller.newCompany(param);
      expect(controller.state, isA<NewCompanyLoading>());
      await future;
      expect(controller.state, isA<NewCompanyFailed>());
      verify(mockCompanyRepo.newCompany(param)).called(1);
    });
  });
}
