import 'package:kcars/core/services/api_service.dart';
import 'package:kcars/core/services/info.dart';
import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/features/auth/data/model/permission.dart';
import 'package:kcars/features/user/data/model/account_status.dart';
import 'package:kcars/features/user/data/model/post_role.dart';
import 'package:kcars/features/user/data/model/user_cursor.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/user/data/model/user_password.dart';

abstract class UserRemote {
  Future<List<Profile>> users([UserCursor? param]);
  Future<List<Profile>> bannedUsers([UserCursor? param]);
  Future<List<AccountStatus>> accountStatuses(UserCursor param);
  Future<String?> updateAccountStatus(AccountStatus param);
  Future<void> updateRole(PostRole role);
  Future<void> deleteBan(String id);
  Future<List<Permission>> permissions();
  Future<void> updateUserPassword(UserPassword param);
  Future<void> recoverAccount(String userId);
}

class UserRemoteImpl implements UserRemote {
  UserRemoteImpl(this._apiService);
  final ApiService _apiService;

  final url = Info.admin;
  @override
  Future<List<Profile>> bannedUsers([UserCursor? param]) async {
    return await _apiService.post<List<Profile>>(
      "$url/bannedUsers",
      data: param?.cleanedMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((profile) => ProfileMapper.fromMap(profile)).toList(),
    );
  }

  @override
  Future<void> deleteBan(String id) async {
    await _apiService.post("$url/deleteBan", data: {"id": id});
  }

  @override
  Future<void> updateRole(PostRole role) async {
    await _apiService.post(
      "$url/updateRole",
      data: {
        "userId": role.userId,
        "permissions": role.permissions
            .map((permission) => permission.permission.permissionId)
            .toList(),
        "role": role.role.roleName,
      },
    );
  }

  @override
  Future<String?> updateAccountStatus(AccountStatus param) async {
    return await _apiService.post(
      "$url/updateAccountStatus",
      data: param.cleanedMap(),
    );
  }

  @override
  Future<List<Profile>> users([UserCursor? param]) async {
    return await _apiService.post(
      "$url/users",
      data: param?.cleanedMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((profile) => ProfileMapper.fromMap(profile)).toList(),
    );
  }

  @override
  Future<List<AccountStatus>> accountStatuses(UserCursor param) async {
    return await _apiService.post(
      "$url/accountStatuses",
      data: param.cleanedMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((status) => AccountStatusMapper.fromMap(status)).toList(),
    );
  }

  @override
  Future<List<Permission>> permissions() async {
    return await _apiService.post(
      "$url/permissions",
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((status) => PermissionMapper.fromMap(status)).toList(),
    );
  }

  @override
  Future<void> updateUserPassword(UserPassword param) async {
    return await _apiService.post(
      "$url/updateUserPassword",
      data: param.toMap(),
    );
  }

  @override
  Future<void> recoverAccount(String userId) async {
    return await _apiService.post(
      "$url/recoverAccount",
      data: {"userId": userId},
    );
  }
}
