import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/features/auth/data/model/permission.dart';
import 'package:kcars/features/user/data/model/account_status.dart';
import 'package:kcars/features/user/data/model/post_role.dart';
import 'package:kcars/features/user/data/model/user_cursor.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/user/data/model/user_password.dart';

abstract class UserRepo {
  Result<List<Profile>> users([UserCursor? param]);
  Result<List<Profile>> bannedUsers([UserCursor? param]);
  Result<List<AccountStatus>> accountStatuses(UserCursor param);
  Result<String?> updateAccountStatus(AccountStatus param);
  Result<void> updateRole(PostRole role);
  Result<void> deleteBan(String id);
  Result<List<Permission>> permissions();
  Result<void> updateUserPassword(UserPassword param);
  Result<void> recoverAccount(String userId);
}
