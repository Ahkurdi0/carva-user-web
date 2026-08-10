import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/core/utils/debouncer.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/user/data/model/user_cursor.dart';
import 'package:kcars/features/user/domain/repo/user_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'search_user.g.dart';

@riverpod
class SearchUsers extends _$SearchUsers {
  late UserRepo _userRepo;
  @override
  FutureOr<List<Profile>> build() {
    _userRepo = sl<UserRepo>();
    return [];
  }

  void searchForUsers(search) async {
    state = AsyncLoading();
    AppDebounce.debounce("searching_users", Duration(seconds: 1), () async {
      final result = await _userRepo.users(UserCursor(search: search));
      result.fold(
        (l) => state = AsyncError(l.message, StackTrace.empty),
        (r) => state = AsyncData(r),
      );
    });
  }

  void upadateRole(Profile profile) {
    final newState = state.value
        ?.map((user) => user.userId == profile.userId ? profile : user)
        .toList();
    state = AsyncData(newState ?? []);
  }

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
