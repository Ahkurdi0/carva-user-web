import 'package:flutter_test/flutter_test.dart';
import 'package:kcars/core/services/info.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/user/data/model/account_status.dart';
import 'package:kcars/features/user/data/remote/user_remote.dart';
import 'package:mockito/mockito.dart';
import '../../../../helper_tests.dart';
import '../../../../utils.dart';
import '../../../auth/data/remote/auth_remote.mocks.mocks.dart';
import '../../user_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockApiService mockApiService;
  late UserRemote userRemote;

  setUp(() {
    mockApiService = MockApiService();
    userRemote = UserRemoteImpl(mockApiService);
  });

  group("[User Remote Tets]", () {
    test("[Should Return Users]", () async {
      final expectedData = [UserData.profileWithCompany()];
      final url = "${Info.admin}/users";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap]
                as List<Profile> Function(dynamic);
        final users = await loadJsonData("users");
        final listUsers = List.from(users);
        return fromMap(listUsers).toList();
      });
      final param = UserData.userCursor();
      final result = await userRemote.users(param);
      expect(result, equals(expectedData));
      verify(
        mockApiService.post(
          url,
          data: param.cleanedMap(),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Fail when Retun Usees]", () async {
      final url = "${Info.admin}/users";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      final param = UserData.userCursor();
      expectApiException(() => userRemote.users(param));
      verify(
        mockApiService.post(
          url,
          data: param.cleanedMap(),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Return Banned Users]", () async {
      final expectedData = [UserData.profileWithCompany()];
      final url = "${Info.admin}/bannedUsers";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap]
                as List<Profile> Function(dynamic);
        final users = await loadJsonData("users");
        final listUsers = List.from(users);
        return fromMap(listUsers).toList();
      });
      final param = UserData.userCursor();
      final result = await userRemote.bannedUsers(param);
      expect(result, equals(expectedData));
      verify(
        mockApiService.post(
          url,
          data: param.cleanedMap(),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Fail when Retun Banned Users]", () async {
      final url = "${Info.admin}/bannedUsers";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      final param = UserData.userCursor();
      expectApiException(() => userRemote.bannedUsers(param));
      verify(
        mockApiService.post(
          url,
          data: param.cleanedMap(),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Return Account Statuses of User]", () async {
      final expectedData = [UserData.accountStatus()];
      final url = "${Info.admin}/accountStatuses";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap]
                as List<AccountStatus> Function(dynamic);
        final users = await loadJsonData("account_status");
        final listUsers = List.from(users);
        return fromMap(listUsers).toList();
      });
      final param = UserData.userCursor();
      final result = await userRemote.accountStatuses(param);
      expect(result, equals(expectedData));
      verify(
        mockApiService.post(
          url,
          data: param.cleanedMap(),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Fail when Retun Account Statuses of Users]", () async {
      final url = "${Info.admin}/accountStatuses";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      final param = UserData.userCursor();
      expectApiException(() => userRemote.accountStatuses(param));
      verify(
        mockApiService.post(
          url,
          data: param.cleanedMap(),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });
  });

  group("[Admin User Actions]", () {
    test("[Should Success When Ban User]", () async {
      final url = "${Info.admin}/updateAccountStatus";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((_) async => null);
      final param = UserData.accountStatus();
      await userRemote.updateAccountStatus(param);
      verify(
        mockApiService.post(
          url,
          data: param.cleanedMap(),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Fail When Ban User]", () async {
      final url = "${Info.admin}/updateAccountStatus";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      final param = UserData.accountStatus();
      expectApiException(() => userRemote.updateAccountStatus(param));
      verify(
        mockApiService.post(
          url,
          data: param.cleanedMap(),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Success Update User Role]", () async {
      final url = "${Info.admin}/updateRole";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((_) async => null);
      final param = UserData.postRole();
      await userRemote.updateRole(param);
      verify(
        mockApiService.post(
          url,
          data: {
            "userId": param.userId,
            "permissions": param.permissions
                .map((permission) => permission.permission.permissionId)
                .toList(),
            "role": param.role.roleName,
          },
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Fail when Update User Role]", () async {
      final url = "${Info.admin}/updateRole";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      final param = UserData.postRole();
      expectApiException(() => userRemote.updateRole(param));
      verify(
        mockApiService.post(
          url,
          data: {
            "userId": param.userId,
            "permissions": param.permissions
                .map((permission) => permission.permission.permissionId)
                .toList(),
            "role": param.role.roleName,
          },
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Success Delete A User Band]", () async {
      final url = "${Info.admin}/deleteBan";
      when(
        mockApiService.post(any, data: anyNamed("data")),
      ).thenAnswer((_) async => null);
      final param = "A";
      await userRemote.deleteBan(param);
      verify(mockApiService.post(url, data: {"id": param})).called(1);
    });

    test("[Should Fail when Delete User Ban]", () async {
      final url = "${Info.admin}/deleteBan";
      when(
        mockApiService.post(any, data: anyNamed("data")),
      ).thenThrow(apiException());
      final param = "A";
      expectApiException(() => userRemote.deleteBan(param));
      verify(mockApiService.post(url, data: {"id": param})).called(1);
    });
  });
}
