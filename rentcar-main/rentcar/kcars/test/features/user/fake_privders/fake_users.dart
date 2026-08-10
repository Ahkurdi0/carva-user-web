import 'package:kcars/core/utils/pagination.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/user/presentation/riverpod/banned_users.dart';
import 'package:kcars/features/user/presentation/riverpod/search_user.dart';
import 'package:kcars/features/user/presentation/riverpod/users.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

class FakeBannedUserProvider extends BannedUsers {
  @override
  PagingState<Profile> build() {
    return PagingState.initial();
  }

  @override
  void remove(String id) {
    final newState = state.items.where((user) => user.id != id).toList();
    state = state.copyWith(items: newState);
  }

  @override
  void add(Profile profile) {
    state = state.copyWith(items: [profile, ...state.items]);
  }
}
