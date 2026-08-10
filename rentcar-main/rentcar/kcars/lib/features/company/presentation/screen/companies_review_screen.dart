import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/pagin_list_view.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/core/widget/profile_container.dart';
import 'package:kcars/features/review/data/model/company_review.dart';
import 'package:kcars/features/review/data/model/enums.dart';
import 'package:kcars/features/review/data/model/review_flag.dart';
import 'package:kcars/features/review/presentation/application/review_controller.dart';
import 'package:kcars/features/review/presentation/application/review_states.dart';
import 'package:kcars/features/review/presentation/riverpod/comapnies_review.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class CompaniesReviewScreen extends ConsumerWidget {
  const CompaniesReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyBooked = ref.watch(companiesReviewsProvider);
    ref.listen(reviewControllerProvider, (prev, next) {
      if (next is FlagCompanyReviewFailed) {
        showCustomAlert(context, content: next.message);
      }
      if (next is FlagCompanyReviewCompleted) {
        showMessages(context, message: LocaleKeys.alertMessages_success.tr());
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.screens_companyReviews.tr()),
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
      ),
      body: PagingSliverList(
        onRefresh: () async {
          ref.read(companiesReviewsProvider.notifier).loadInitial();
        },
        onLoadMore: () {
          ref.read(companiesReviewsProvider.notifier).loadMore();
        },
        state: companyBooked,
        itemBuilder: (itemBuilder, review, index) {
          return CompanyCarReviewWidget(review: review);
        },
      ),
    );
  }
}

class CompanyCarReviewWidget extends ConsumerWidget {
  const CompanyCarReviewWidget({
    super.key,
    this.review,
    this.isSkeleton = false,
  });
  final CompanyReview? review;
  final bool isSkeleton;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 2.w,
      ).copyWith(bottom: 4.w, top: 2.w),
      margin: EdgeInsets.symmetric(horizontal: 4.w).copyWith(bottom: 4.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: context.surfaceContainerLow),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    ProfileContainer(
                      child: ImageHolder(
                        image: review?.profile?.image,
                        width: 10.w,
                        height: 10.w,
                        fit: BoxFit.cover,
                        borderRadius: BorderRadius.circular(100.w),
                      ),
                    ),
                    Gap(2.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review?.profile?.name ?? "",
                          style: context.label.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          review?.reviewedAt.formatDate(context) ?? "",
                          style: context.overline,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(1.w),
              if (review?.status != ReviewStatus.flagged &&
                  review?.flaggedAt == null)
                GestureDetector(
                  onTap: () {
                    showCustomAlert(
                      context,
                      content: LocaleKeys.alertMessages_flagReview.tr(),
                      primaryButtonText: LocaleKeys.buttons_yes.tr(),
                      closeButton: true,
                      primaryAction: () {
                        ref
                            .read(reviewControllerProvider.notifier)
                            .flagCompanyReview(
                              ReviewFlag(reviewId: review!.id),
                            );
                      },
                    );
                  },
                  child: IconLoadaer(AppIcons.cancel),
                ),
              if (review?.flaggedAt != null)
                Icon(Icons.flag_circle, color: context.error),
            ],
          ),
          Gap(2.w),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(
                    review?.rate ?? 0,
                    (_) => IconLoadaer(
                      AppIcons.starFill,
                      width: 3.w,
                      color: context.primary,
                    ),
                  ),
                ),
                Text(review?.desc ?? "", style: context.baseText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
