import 'dart:async';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/core/utils/pagination.dart';
import 'package:kcars/features/user/data/model/account_status.dart';
import 'package:kcars/features/user/data/model/user_cursor.dart';
import 'package:kcars/features/user/domain/repo/user_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'account_statuses.g.dart';

@riverpod
class AccountStatuses extends _$AccountStatuses {
  late UserRepo _carRepo;
  @override
  PagingState<AccountStatus> build(String userId) {
    _carRepo = sl();

    ref.keepAlive();

    final refreshTimer = Timer.periodic(const Duration(minutes: 15), (_) {
      loadInitial();
    });

    ref.onDispose(() {
      refreshTimer.cancel();
    });
    Future.microtask(() => loadInitial());
    return PagingState.initial();
  }

  Future<void> loadInitial() async {
    final cursor = UserCursor(userId: userId);
    final result = await _carRepo.accountStatuses(cursor);

    result.fold(
      (l) => state = state.copyWith(error: l.message, isLoading: false),
      (r) {
        final hasMore = r.isNotEmpty;
        state = state.copyWith(
          items: r,
          hasNextPage: hasMore,
          isLoading: false,
          error: null,
          isRefreshing: false,
          initalLoading: false,
        );
      },
    );
  }

  Future<void> loadMore(String? lastId) async {
    if (state.isLoading || !state.hasNextPage) return;
    state = state.copyWith(isLoading: true);
    final cursor = UserCursor(userId: userId, cursor: state.items.last.id);
    final result = await _carRepo.accountStatuses(cursor);

    result.fold(
      (l) => state = state.copyWith(
        error: l.message,
        isLoading: false,
        initalLoading: false,
      ),
      (r) {
        final hasMore = r.isNotEmpty;

        final updatedItems = [...state.items, ...r]; // ← append
        state = state.copyWith(
          items: updatedItems,
          hasNextPage: hasMore,
          isLoading: false,
          error: null,
        );
      },
    );
  }

  void update(AccountStatus accountStatus) {
    final newState = state.items
        .map((user) => user.id == accountStatus.id ? accountStatus : user)
        .toList();
    state = state.copyWith(items: newState);
  }

  void remove(String id) {
    final newState = state.items.where((user) => user.id != id).toList();
    state = state.copyWith(items: newState);
  }

  void add(AccountStatus accountStatus) {
    state = state.copyWith(items: [accountStatus, ...state.items]);
  }
}
