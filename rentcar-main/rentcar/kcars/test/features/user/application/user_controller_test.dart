import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kcars/features/company/presentation/riverpod/companies.dart';
import 'package:kcars/features/user/application/user_controller.dart';
import 'package:kcars/features/user/application/user_states.dart';
import 'package:kcars/features/user/data/model/account_status.dart';
import 'package:kcars/features/user/presentation/riverpod/account_statuses.dart';
import 'package:kcars/features/user/presentation/riverpod/banned_users.dart';
import 'package:kcars/features/user/presentation/riverpod/search_user.dart';
import 'package:kcars/features/user/presentation/riverpod/users.dart';
import 'package:mockito/mockito.dart';
import '../../../helper_tests.dart';
import '../../company/application/company_controller_test.dart';
import '../fake_privders/fake_account_statuses.dart';
import '../fake_privders/fake_users.dart'
    hide FakeUsersProvidr, FakeSearchUsrsProvider;
import '../user_data.dart';
import 'user_repo_mocks.mocks.dart';

void main() {
  late MockUserRepo mockUserRepo;
  late ProviderContainer container;

  setUpAll(() {
    registerEitherVoidFallback();
    registerEitherFallback<String?>();
  });
  setUp(() {
    mockUserRepo = MockUserRepo();
    container = ProviderContainer(
      overrides: [
        userControllerProvider.overrideWith(() {
          return UserController.test(userRepo: mockUserRepo);
        }),
        usersProvider("user").overrideWith(() => FakeUsersProvidr()),
        searchUsersProvider.overrideWith(() => FakeSearchUsrsProvider()),
        companiesProvider(false).overrideWith(() => FakeCompaniesProvider()),
        companiesProvider(true).overrideWith(() => FakeCompaniesProvider()),
        bannedUsersProvider.overrideWith(() => FakeBannedUserProvider()),
        accountStatusesProvider(
          "A",
        ).overrideWith(() => FakeAccountStatusesProvider()),
      ],
    );
  });

  group("[User Action Tests]", () {
    test("[Should Success when update user role]", () async {
      final param = UserData.postRole();
      final profile = UserData.profile();
      when(mockUserRepo.updateRole(any)).thenAnswer((_) async => Right(null));
      final controller = container.read(userControllerProvider.notifier);
      expect(controller.state, isA<UserInitialState>());
      final future = controller.updateRole(param, profile);
      expect(controller.state, isA<UpdateUserRoleLoading>());
      await future;
      expect(controller.state, isA<UpdateUserRoleCompleted>());
      verify(mockUserRepo.updateRole(param)).called(1);
    });

    test("[Should Fail when update user role]", () async {
      final param = UserData.postRole();
      final profile = UserData.profile();
      when(mockUserRepo.updateRole(any)).thenAnswer(failureAnswer());
      final controller = container.read(userControllerProvider.notifier);
      expect(controller.state, isA<UserInitialState>());
      final future = controller.updateRole(param, profile);
      expect(controller.state, isA<UpdateUserRoleLoading>());
      await future;
      expect(controller.state, isA<UpdateUserRoleFailed>());
      verify(mockUserRepo.updateRole(param)).called(1);
    });

    test("[Should Success When BanUser]", () async {
      final param = UserData.accountStatus().copyWith(
        profile: UserData.profile().copyWith(),
      );
      when(
        mockUserRepo.updateAccountStatus(any),
      ).thenAnswer((_) async => Right(null));
      final controller = container.read(userControllerProvider.notifier);
      expect(controller.state, isA<UserInitialState>());
      final future = controller.updateAccountStatus(param);
      expect(controller.state, isA<UpdateAccountStatusLoading>());
      await future;
      expect(controller.state, isA<UpdateAccountStatusCompleted>());
      verify(mockUserRepo.updateAccountStatus(param)).called(1);
    });

    test("[Should Fail When BanUser]", () async {
      final param = UserData.accountStatus().copyWith(
        profile: UserData.profile(),
      );
      when(mockUserRepo.updateAccountStatus(any)).thenAnswer(failureAnswer());
      final controller = container.read(userControllerProvider.notifier);
      expect(controller.state, isA<UserInitialState>());
      final future = controller.updateAccountStatus(param);
      expect(controller.state, isA<UpdateAccountStatusLoading>());
      await future;
      expect(controller.state, isA<UpdateAccountStatusFailed>());
      verify(mockUserRepo.updateAccountStatus(param)).called(1);
    });

    test("[Should Success When Delete BanUser]", () async {
      final param = AccountStatus(id: "A", userId: "A");
      when(mockUserRepo.deleteBan(any)).thenAnswer((_) async => Right(null));
      final controller = container.read(userControllerProvider.notifier);
      expect(controller.state, isA<UserInitialState>());
      final future = controller.deleteBan(param);
      expect(controller.state, isA<DeleteBanLoading>());
      await future;
      expect(controller.state, isA<DeleteBanCompleted>());
      verify(mockUserRepo.deleteBan(param.id)).called(1);
    });

    test("[Should Fail When Delete BanUser]", () async {
      final param = AccountStatus(id: "A");
      when(mockUserRepo.deleteBan(any)).thenAnswer(failureAnswer());
      final controller = container.read(userControllerProvider.notifier);
      expect(controller.state, isA<UserInitialState>());
      final future = controller.deleteBan(param);
      expect(controller.state, isA<DeleteBanLoading>());
      await future;
      expect(controller.state, isA<DeleteBanFailed>());
      verify(mockUserRepo.deleteBan(param.id)).called(1);
    });
  });
}
