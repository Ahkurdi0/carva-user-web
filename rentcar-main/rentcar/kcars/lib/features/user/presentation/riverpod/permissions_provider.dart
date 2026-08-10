import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/auth/data/model/permission.dart';
import 'package:kcars/features/user/domain/repo/user_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'permissions_provider.g.dart';

@riverpod
class AllPermissions extends _$AllPermissions {
  late UserRepo _userRepo;
  @override
  FutureOr<List<Permission>> build() async {
    _userRepo = sl<UserRepo>();
    final result = await _userRepo.permissions();
    return result.fold((l) => throw l.message, (r) => r);
  }
}
