import 'package:flutter_test/flutter_test.dart';
import 'package:kcars/configs/error/exception.dart';
import 'package:kcars/features/user/data/repo/user_repo_impl.dart';
import 'package:kcars/features/user/domain/repo/user_repo.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper_tests.dart';
import '../../user_data.dart';
import 'user_remote_mocks.mocks.dart';

void main() {
  late MockUserRemote mockUserRemote;
  late UserRepo userRepo;

  setUp(() {
    mockUserRemote = MockUserRemote();
    userRepo = UserRepoImpl(mockUserRemote);
  });
  group("user_repo_impl", () {
    test("[Should Return List Of Users]", () async {
      final expectedData = [UserData.profileWithCompany()];
      when(mockUserRemote.users(any)).thenAnswer((_) async => expectedData);
      final param = UserData.userCursor();
      final result = await userRepo.users(param);
      expectSuccess(result, expectedData);
      verify(mockUserRemote.users(param)).called(1);
    });

    test("[Should Fail when Return List Of Users]", () async {
      when(mockUserRemote.users(any)).thenThrow(ApiException.exception());
      final param = UserData.userCursor();
      final result = await userRepo.users(param);
      expectFailureWithStatusCode(result, 400);
      verify(mockUserRemote.users(param)).called(1);
    });

    test("[Should Return List Of Banned Users]", () async {
      final expectedData = [UserData.profile()];
      when(
        mockUserRemote.bannedUsers(any),
      ).thenAnswer((_) async => expectedData);
      final param = UserData.userCursor();
      final result = await userRepo.bannedUsers(param);
      expectSuccess(result, expectedData);
      verify(mockUserRemote.bannedUsers(param)).called(1);
    });

    test("[Should Fail Whenn Return List Of Banned Users]", () async {
      when(mockUserRemote.bannedUsers(any)).thenThrow(ApiException.exception());
      final param = UserData.userCursor();
      final result = await userRepo.bannedUsers(param);
      expectFailureWithStatusCode(result, 400);
      verify(mockUserRemote.bannedUsers(param)).called(1);
    });

    test("[Should Return List Of Account Statuses]", () async {
      final expectedData = [UserData.accountStatus()];
      when(
        mockUserRemote.accountStatuses(any),
      ).thenAnswer((_) async => expectedData);
      final param = UserData.userCursor();
      final result = await userRepo.accountStatuses(param);
      expectSuccess(result, expectedData);
      verify(mockUserRemote.accountStatuses(param)).called(1);
    });

    test("[Should Fail When Return List Of Account Statuses]", () async {
      when(
        mockUserRemote.accountStatuses(any),
      ).thenThrow(ApiException.exception());
      final param = UserData.userCursor();
      final result = await userRepo.accountStatuses(param);
      expectFailureWithStatusCode(result, 400);
      verify(mockUserRemote.accountStatuses(param)).called(1);
    });
  });

  group("[Admin User Actions]", () {
    test("[Should Success When Ban A User]", () async {
      when(
        mockUserRemote.updateAccountStatus(any),
      ).thenAnswer((_) async => "A");
      final param = UserData.accountStatus();
      final result = await userRepo.updateAccountStatus(param);
      expectSuccess(result, "A");
      verify(mockUserRemote.updateAccountStatus(param)).called(1);
    });

    test("[Should Failed When Ban A User]", () async {
      when(
        mockUserRemote.updateAccountStatus(any),
      ).thenThrow(ApiException.exception());
      final param = UserData.accountStatus();
      final result = await userRepo.updateAccountStatus(param);
      expectFailureWithStatusCode(result, 400);
      verify(mockUserRemote.updateAccountStatus(param)).called(1);
    });

    test("[Should Success When Update User Role]", () async {
      when(mockUserRemote.updateRole(any)).thenAnswer((_) async {});
      final param = UserData.postRole();
      final result = await userRepo.updateRole(param);
      expectSuccess(result, null);
      verify(mockUserRemote.updateRole(param)).called(1);
    });
    test("[Should Fail When Update User Role]", () async {
      when(mockUserRemote.updateRole(any)).thenThrow(ApiException.exception());
      final param = UserData.postRole();
      final result = await userRepo.updateRole(param);
      expectFailureWithStatusCode(result, 400);
      verify(mockUserRemote.updateRole(param)).called(1);
    });

    test("[Should Success When Delete Ban]", () async {
      when(mockUserRemote.deleteBan(any)).thenAnswer((_) async {});
      final param = "A";
      final result = await userRepo.deleteBan(param);
      expectSuccess(result, null);
      verify(mockUserRemote.deleteBan(param)).called(1);
    });
    test("[Should Fail When Delete Ban]", () async {
      when(mockUserRemote.deleteBan(any)).thenThrow(ApiException.exception());
      final param = "A";
      final result = await userRepo.deleteBan(param);
      expectFailureWithStatusCode(result, 400);
      verify(mockUserRemote.deleteBan(param)).called(1);
    });
  });
}
