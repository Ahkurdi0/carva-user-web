import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/pagin_list_view.dart';
import 'package:kcars/features/car/presentation/views/write_car_review.dart';
import 'package:kcars/features/car/presentation/widget/review_widget.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/review/data/model/cursor_review.dart';
import 'package:kcars/features/review/presentation/riverpod/company_reviwes.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

class CompanyReviewsView extends ConsumerWidget {
  const CompanyReviewsView({super.key, required this.company});
  final Company company;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cursor = CursorReview(id: company.id);
    final companyReview = ref.watch(companyReviewsProvider(cursor));

    return PagingSliverList(
      padding: EdgeInsets.symmetric(horizontal: 4.w).copyWith(top: 4.w),
      emptyWidget: company.reviews == null && companyReview.items.isEmpty
          ? Center(child: Text(LocaleKeys.empty_noReviews.tr()))
          : company.reviews != null
          ? Text("")
          : null,
      suffixWidget: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (company.reviewCompany == true) ...[
              Gap(4.w),
              GestureDetector(
                onTap: () {
                  showReviewInput(
                    context,
                    CompanyReviewContent(company: company, param: cursor),
                  );
                },
                child: Container(
                  width: 90.w,
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.5,
                      color: context.surfaceContainer,
                    ),
                    borderRadius: BorderRadius.circular(1.5.w),
                  ),
                  child: Text(
                    LocaleKeys.inputHintText_writeReview.tr(),
                    style: context.caption.copyWith(
                      color: context.surfaceContainer,
                    ),
                  ),
                ),
              ),
            ],
            if (company.reviews != null) ...[
              Gap(4.w),
              CompanyReviewWidget(
                review: company.reviews!.copyWith(company: company),
                deletable: true,
              ),
            ],
          ],
        ),
      ),
      state: companyReview,
      itemBuilder: (context, review, index) =>
          CompanyReviewWidget(review: review),
    );
  }
}
