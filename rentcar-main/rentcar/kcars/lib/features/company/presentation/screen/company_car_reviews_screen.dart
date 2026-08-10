import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/pagin_list_view.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/core/widget/profile_container.dart';
import 'package:kcars/features/review/data/model/car_review.dart';
import 'package:kcars/features/review/data/model/enums.dart';
import 'package:kcars/features/review/data/model/review_flag.dart';
import 'package:kcars/features/review/presentation/application/review_controller.dart';
import 'package:kcars/features/review/presentation/application/review_states.dart';
import 'package:kcars/features/review/presentation/riverpod/company_cars_review.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class CompanyCarReviewsScreen extends ConsumerWidget {
  const CompanyCarReviewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyBooked = ref.watch(companyCarsReviewProvider);
    ref.listen(reviewControllerProvider, (previous, next) {
      if (next is FlagCarReviewFailed) {
        showCustomAlert(context, content: next.message);
      }
      if (next is FlagCarReviewCompleted) {
        showMessages(context, message: LocaleKeys.alertMessages_success.tr());
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.screens_carReviews.tr()),
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: PagingSliverList(
          onRefresh: () =>
              ref.read(companyCarsReviewProvider.notifier).loadInitial(),
          onLoadMore: () {
            ref.read(companyCarsReviewProvider.notifier).loadMore();
          },
          state: companyBooked,
          itemBuilder: (itemBuilder, book, index) {
            return CompanyCarReviewWidget(review: book);
          },
        ),
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
  final CarReview? review;
  final bool isSkeleton;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (review?.car != null) {
          context.router.push(CarDetailsRoute(carId: review!.car!.id));
        }
      },
      child: Container(
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
                              .flagCarReview(
                                ReviewFlag(
                                  reviewId: review!.id,
                                  carId: review!.car!.id,
                                ),
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
                  Text(review?.car?.title ?? "", style: context.baseText),
                  Gap(1.w),
                  Text(review?.desc ?? "", style: context.baseText),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
