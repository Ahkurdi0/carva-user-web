import 'dart:async';

import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/company/domain/company_repo.dart';
import 'package:kcars/features/review/data/model/company_review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'details_company.g.dart';

@riverpod
class DetailCompany extends _$DetailCompany {
  late CompanyRepo _companyRepo;
  @override
  FutureOr<Company> build(String companyId) async {
    _companyRepo = sl<CompanyRepo>();
    ref.keepAlive();
    final timer = Timer.periodic(Duration(minutes: 5), (_) {
      ref.invalidateSelf();
    });
    ref.onDispose(() {
      timer.cancel();
    });
    final result = await _companyRepo.company(companyId);
    return result.fold((l) => throw l.message, (r) => r);
  }

  void deleteReview() {
    final newState = state.value?.copyWith(reviews: null, reviewCompany: true);
    if (newState == null) return;
    state = AsyncData(newState);
  }

  void newReview(CompanyReview review) {
    final newState = state.value?.copyWith(
      reviews: review,
      reviewCompany: false,
    );
    if (newState == null) return;
    state = AsyncData(newState);
  }
}
