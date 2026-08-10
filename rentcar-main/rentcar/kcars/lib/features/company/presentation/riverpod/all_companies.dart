import 'dart:async';

import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/core/utils/pagination.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/company/data/model/company_cursor.dart';
import 'package:kcars/features/company/domain/company_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'all_companies.g.dart';

@riverpod
class AllCompanies extends _$AllCompanies {
  late CompanyRepo _companyRepo;
  @override
  PagingState<Company> build(bool inl) {
    _companyRepo = sl();

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
    final param = CompanyCursor(inl: inl);
    final result = await _companyRepo.allCompanies(param);

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

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasNextPage) return;
    state = state.copyWith(isLoading: true);
    final param = CompanyCursor(cursor: state.items.last.id, inl: inl);
    final result = await _companyRepo.allCompanies(param);

    result.fold(
      (l) => state = state.copyWith(
        error: l.message,
        isLoading: false,
        initalLoading: false,
      ),
      (r) {
        final hasMore = r.isNotEmpty;

        final updatedItems = [...state.items, ...r];
        state = state.copyWith(
          items: updatedItems,
          hasNextPage: hasMore,
          isLoading: false,
          error: null,
        );
      },
    );
  }
}
