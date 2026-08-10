import 'package:kcars/core/utils/pagination.dart';
import 'package:kcars/features/user/data/model/account_status.dart';
import 'package:kcars/features/user/presentation/riverpod/account_statuses.dart';

class FakeAccountStatusesProvider extends AccountStatuses {
  @override
  PagingState<AccountStatus> build(String userId) {
    return PagingState.initial();
  }

  @override
  void update(AccountStatus accountStatus) {
    final newState = state.items
        .map((user) => user.id == accountStatus.id ? accountStatus : user)
        .toList();
    state = state.copyWith(items: newState);
  }

  @override
  void remove(String id) {
    final newState = state.items.where((user) => user.id != id).toList();
    state = state.copyWith(items: newState);
  }

  @override
  void add(AccountStatus accountStatus) {
    state = state.copyWith(items: [accountStatus, ...state.items]);
  }
}
