import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:kcars/configs/image_type.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/core/widget/profile_container.dart';
import 'package:kcars/features/review/data/model/car_review.dart';
import 'package:kcars/features/review/data/model/company_review.dart';
import 'package:kcars/features/review/presentation/application/review_controller.dart';
import 'package:kcars/features/review/presentation/application/review_states.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

class ReviewWidget extends ConsumerWidget {
  const ReviewWidget({super.key, required this.review, this.deletable = false});
  final CarReview review;
  final bool deletable;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(reviewControllerProvider, (prev, next) {
      if (next is DeleteCarReviewFailed) {
        showMessages(context, message: next.message);
      }
      if (next is DeleteCarReviewCompleted) {
        showMessages(context, message: LocaleKeys.alertMessages_deleted.tr());
      }
    });
    return Container(
      width: 100.w,
      margin: EdgeInsets.only(bottom: 4.w),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileContainer(
            child: ImageHolder(
              type: ImageType.profile,
              width: 10.w,
              height: 10.w,
              borderRadius: BorderRadius.circular(100.w),
              image: review.profile?.image,
              fit: BoxFit.cover,
            ),
          ),
          Gap(2.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        review.profile?.name ?? "Some user",
                        style: context.caption,
                      ),
                    ),
                    if (deletable)
                      GestureDetector(
                        child: IconLoadaer(AppIcons.cancel, width: 5.w),
                        onTap: () {
                          showCustomAlert(
                            context,
                            content: LocaleKeys.alertMessages_deleteReview.tr(),
                            isDeleting: true,
                            primaryAction: () {
                              ref
                                  .read(reviewControllerProvider.notifier)
                                  .deleteCarReview(review.id, review.car!.id);
                            },
                          );
                        },
                      ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: List.generate(
                        review.rate,
                        (index) => IconLoadaer(
                          AppIcons.starFill,
                          width: 2.5.w,
                          color: context.primary,
                        ),
                      ),
                    ),
                    Gap(1.w),
                    Text(
                      review.reviewedAt.formatDate2(context),
                      style: context.overline.copyWith(color: context.outline),
                    ),
                  ],
                ),

                Text(
                  review.desc,
                  style: context.caption.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CompanyReviewWidget extends ConsumerWidget {
  const CompanyReviewWidget({
    super.key,
    required this.review,
    this.deletable = false,
  });
  final CompanyReview review;
  final bool deletable;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(reviewControllerProvider, (prev, next) {
      if (next is DeleteCarReviewFailed) {
        showMessages(context, message: next.message);
      }
      if (next is DeleteCarReviewCompleted) {
        showMessages(context, message: LocaleKeys.alertMessages_deleted.tr());
      }
    });
    return SizedBox(
      width: 100.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileContainer(
            child: ImageHolder(
              type: ImageType.profile,
              width: 10.w,
              height: 10.w,
              borderRadius: BorderRadius.circular(100.w),
              image: review.profile?.image,
              fit: BoxFit.cover,
            ),
          ),
          Gap(2.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        review.profile?.name ?? "Some user",
                        style: context.caption,
                      ),
                    ),
                    if (deletable)
                      GestureDetector(
                        child: IconLoadaer(AppIcons.cancel, width: 5.w),
                        onTap: () {
                          showCustomAlert(
                            context,
                            content: LocaleKeys.alertMessages_deleteReview.tr(),
                            isDeleting: true,
                            primaryAction: () {
                              if (review.company?.id != null) {
                                ref
                                    .read(reviewControllerProvider.notifier)
                                    .deleteCompanyReview(
                                      review.company!.id,
                                      review.id,
                                    );
                              }
                            },
                          );
                        },
                      ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: List.generate(
                        review.rate,
                        (index) => IconLoadaer(
                          AppIcons.starFill,
                          width: 2.5.w,
                          color: context.primary,
                        ),
                      ),
                    ),
                    Gap(1.w),
                    Text(
                      review.reviewedAt.formatDate2(context),
                      style: context.overline,
                    ),
                  ],
                ),

                Text(review.desc, style: context.baseText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
