import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/pagin_list_view.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/core/widget/profile_container.dart';
import 'package:kcars/features/review/data/model/company_review.dart';
import 'package:kcars/features/review/data/model/cursor_review.dart';
import 'package:kcars/features/review/data/model/enums.dart';
import 'package:kcars/features/review/data/model/updare_review.dart';
import 'package:kcars/features/review/presentation/application/review_controller.dart';
import 'package:kcars/features/review/presentation/riverpod/all_company_reviews.dart';
import 'package:kcars/features/review/presentation/screen/all_car_review_screen.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class AllCompanyReviewScreen extends ConsumerWidget {
  const AllCompanyReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final param = AllCursorReview();
    final state = ref.watch(allCompanyReviewsProvider(param));
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              title: Text(LocaleKeys.screens_companyReviews.tr()),
              leading: CustomBackButton(),
            ),
          ],
          body: PagingSliverList(
            padding: EdgeInsets.symmetric(
              horizontal: 4.w,
            ).copyWith(top: 4.w, bottom: 20.w),
            onRefresh: () async => await ref
                .read(allCompanyReviewsProvider(param).notifier)
                .loadInitial(),
            onLoadMore: () =>
                ref.read(allCompanyReviewsProvider(param).notifier).loadMore(),
            state: state,
            itemBuilder: (context, item, index) =>
                AdminCompanyReviewWidget(review: item, param: param),
          ),
        ),
      ),
    );
  }
}

class AdminCompanyReviewWidget extends ConsumerWidget {
  const AdminCompanyReviewWidget({
    super.key,
    required this.review,
    required this.param,
  });
  final CompanyReview review;
  final AllCursorReview param;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        showCustomBottomSheet(
          context,
          ReviewOptions(
            status: review.status,
            onCancel: () {
              ref
                  .read(reviewControllerProvider.notifier)
                  .updateCompanyReview(
                    UpdateReview(id: review.id, status: ReviewStatus.deleted),
                    param,
                  );
              Navigator.pop(context);
            },
            onComplete: () {
              ref
                  .read(reviewControllerProvider.notifier)
                  .updateCompanyReview(
                    UpdateReview(id: review.id, status: ReviewStatus.accepted),
                    param,
                  );
              Navigator.pop(context);
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.secondaryContainer,
          borderRadius: BorderRadius.circular(4.w),
        ),
        margin: EdgeInsets.only(bottom: 2.w),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
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
                          image: review.profile?.image,
                          width: 12.w,
                          height: 12.w,
                          fit: BoxFit.cover,
                          borderRadius: BorderRadius.circular(100.w),
                        ),
                      ),
                      Gap(4.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.profile?.name ?? "",
                            style: context.labelSemiBold,
                          ),
                          Text(
                            review.reviewedAt.formatDate(context) ?? "",
                            style: context.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(review.serial?.forMatNumber() ?? ""),
                    Text(review.reviewId?.formatOrderId() ?? ""),
                  ],
                ),
              ],
            ),
            Gap(2.w),
            Row(
              children: List.generate(
                review.rate,
                (index) => Icon(Icons.star, color: context.primary, size: 4.w),
              ),
            ),

            Gap(1.w),
            Text(review.desc, style: context.caption),
            Gap(2.w),
            Divider(thickness: 0.1, color: context.outline),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      ImageHolder(
                        image: review.company?.image,
                        width: 6.w,
                        height: 6.w,
                        borderRadius: BorderRadius.circular(100.w),
                        fit: BoxFit.cover,
                      ),
                      Gap(2.w),
                      Text(review.company?.name ?? "", style: context.caption),
                    ],
                  ),
                ),
                Text(review.status.getStatus(), style: context.label),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
