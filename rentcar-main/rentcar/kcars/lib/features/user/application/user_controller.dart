import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/user/application/user_states.dart';
import 'package:kcars/features/user/data/model/account_status.dart';
import 'package:kcars/features/user/data/model/post_role.dart';
import 'package:kcars/features/user/data/model/user_password.dart';
import 'package:kcars/features/user/domain/repo/user_repo.dart';
import 'package:kcars/features/user/presentation/riverpod/account_statuses.dart';
import 'package:kcars/features/user/presentation/riverpod/banned_users.dart';
import 'package:kcars/features/user/presentation/riverpod/search_user.dart';
import 'package:kcars/features/user/presentation/riverpod/users.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user_controller.g.dart';

@riverpod
class UserController extends _$UserController {
  late UserRepo _userRepo;

  UserController._(this._userRepo);

  factory UserController.test({required UserRepo userRepo}) =>
      UserController._(userRepo);

  UserController() : _userRepo = sl<UserRepo>();

  @override
  UserStates build() {
    return const UserInitialState();
  }

  Future<void> updateRole(PostRole param, Profile profile) async {
    state = const UpdateUserRoleLoading();
    final result = await _userRepo.updateRole(param);
    await result.fold((l) async => state = UpdateUserRoleFailed(l.message), (
      r,
    ) async {
      ref
          .read(usersProvider(profile.role.roleName).notifier)
          .removeRole(profile.id ?? "");
      ref
          .read(usersProvider(param.role.roleName).notifier)
          .addRole(
            profile.copyWith(role: param.role, permissions: param.permissions),
          );
      ref
          .read(searchUsersProvider.notifier)
          .upadateRole(
            profile.copyWith(role: param.role, permissions: param.permissions),
          );
      state = const UpdateUserRoleCompleted();
    });
  }

  Future<void> updateAccountStatus(AccountStatus param) async {
    state = const UpdateAccountStatusLoading();
    final result = await _userRepo.updateAccountStatus(param);
    await result.fold(
      (l) async => state = UpdateAccountStatusFailed(l.message),
      (r) async {
        if (param.id == null) {
          ref.read(bannedUsersProvider.notifier).add(param.profile!);
        }
        ref.read(accountStatusesProvider(param.userId!).notifier).update(param);
        state = const UpdateAccountStatusCompleted();
      },
    );
  }

  Future<void> deleteBan(AccountStatus param) async {
    state = const DeleteBanLoading();
    final result = await _userRepo.deleteBan(param.id ?? "");
    await result.fold((l) async => state = DeleteBanFailed(l.message), (
      r,
    ) async {
      ref.read(bannedUsersProvider.notifier).remove(param.id!);
      ref
          .read(accountStatusesProvider(param.userId!).notifier)
          .remove(param.id!);
      state = const DeleteBanCompleted();
    });
  }

  Future<void> updateUserPassword(UserPassword param) async {
    state = const UpdateUserPasswordLoading();
    final result = await _userRepo.updateUserPassword(param);
    await result.fold(
      (l) async => state = UpdateUserPasswordFailed(l.message),
      (r) async => state = const UpdateUserPasswordCompleted(),
    );
  }

  Future<void> recoverAccount(String userId) async {
    state = const RecoverAccountLoading();
    final result = await _userRepo.recoverAccount(userId);
    await result.fold(
      (l) async => state = RecoverAccountFailed(l.message),
      (r) async => state = const RecoverAccountCompleted(),
    );
  }
}
