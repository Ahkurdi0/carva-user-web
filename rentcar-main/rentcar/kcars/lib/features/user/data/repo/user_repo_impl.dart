import 'package:fpdart/fpdart.dart';
import 'package:kcars/configs/error/exception.dart';
import 'package:kcars/configs/error/failure.dart';
import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/features/auth/data/model/permission.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/user/data/model/account_status.dart';
import 'package:kcars/features/user/data/model/post_role.dart';
import 'package:kcars/features/user/data/model/user_cursor.dart';
import 'package:kcars/features/user/data/model/user_password.dart';
import 'package:kcars/features/user/data/remote/user_remote.dart';
import 'package:kcars/features/user/domain/repo/user_repo.dart';

class UserRepoImpl implements UserRepo {
  const UserRepoImpl(this._userRemote);
  final UserRemote _userRemote;

  @override
  Result<List<AccountStatus>> accountStatuses(UserCursor param) async {
    try {
      final result = await _userRemote.accountStatuses(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Profile>> bannedUsers([UserCursor? param]) async {
    try {
      final result = await _userRemote.bannedUsers(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> deleteBan(String id) async {
    try {
      final result = await _userRemote.deleteBan(id);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> updateRole(PostRole role) async {
    try {
      final result = await _userRemote.updateRole(role);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<String?> updateAccountStatus(AccountStatus param) async {
    try {
      final result = await _userRemote.updateAccountStatus(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Profile>> users([UserCursor? param]) async {
    try {
      final result = await _userRemote.users(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Permission>> permissions() async {
    try {
      final result = await _userRemote.permissions();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> updateUserPassword(UserPassword param) async {
    try {
      final result = await _userRemote.updateUserPassword(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> recoverAccount(String param) async {
    try {
      final result = await _userRemote.recoverAccount(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }
}
