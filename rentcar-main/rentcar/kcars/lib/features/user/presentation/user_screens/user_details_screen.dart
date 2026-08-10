import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/pagin_list_view.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/core/widget/profile_container.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/booking/data/model/book.dart';
import 'package:kcars/features/booking/data/model/book_cursor.dart';
import 'package:kcars/features/booking/presentation/riverpod/all_books.dart';
import 'package:kcars/features/booking/presentation/widget/book_details.dart';
import 'package:kcars/features/review/data/model/cursor_review.dart';
import 'package:kcars/features/review/presentation/riverpod/all_car_reviews.dart';
import 'package:kcars/features/review/presentation/riverpod/all_company_reviews.dart';
import 'package:kcars/features/review/presentation/screen/all_car_review_screen.dart';
import 'package:kcars/features/review/presentation/screen/all_company_review_screen.dart';
import 'package:kcars/features/user/presentation/view/account_status_view.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key, required this.profile});
  final Profile profile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(leading: CustomBackButton()),
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: [
                    ImageHolder(
                      image: profile.image,
                      width: 20.w,
                      height: 20.w,
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(100.w),
                    ),
                    SizedBox(height: 1.w),
                    Text(profile.name, style: context.labelSemiBold),
                    Text(profile.email, style: context.caption),
                    Text(profile.phoneNumber ?? "", style: context.caption),
                    SizedBox(height: 2.w),
                  ],
                ),
              ]),
            ),
          ],
          body: AccountStatusView(profile),
        ),
      ),
    );
  }
}

class UserBookedView extends ConsumerWidget {
  const UserBookedView({super.key, required this.profile});
  final Profile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final param = BookCursor(userId: profile.userId);
    final allboks = ref.watch(allBooksProvider(param));

    return PagingSliverList(
      padding: EdgeInsets.only(bottom: 40.w, top: 4.w),
      state: allboks,
      onRefresh: () => ref.read(allBooksProvider(param).notifier).loadInitial(),
      onLoadMore: () => ref.read(allBooksProvider(param).notifier).loadMore(),
      itemBuilder: (context, item, index) => BookedCarCard(book: item),
    );
  }
}

class BookedCarCard extends ConsumerWidget {
  final Book? book;
  final bool isSkeleton;
  final String? brandId;

  const BookedCarCard({
    super.key,
    this.book,
    this.isSkeleton = false,
    this.brandId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      child: Skeletonizer(
        enabled: isSkeleton,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 2.w,
          ).copyWith(bottom: 4.w, top: 2.w),
          margin: EdgeInsets.symmetric(horizontal: 4.w).copyWith(bottom: 8.w),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: context.surfaceContainerLow),
            borderRadius: BorderRadius.circular(6.w),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Row(
                    children: [
                      ProfileContainer(
                        child: ImageHolder(
                          image: isSkeleton ? null : book?.profile?.image,
                          width: 10.w,
                          height: 10.w,
                          isLoading: isSkeleton,
                          fit: BoxFit.cover,
                          borderRadius: BorderRadius.circular(100.w),
                        ),
                      ),
                      Gap(2.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book?.profile?.name ?? "",
                            style: context.label.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            book?.bookedAt.formatDate(context) ?? "",
                            style: context.overline,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Gap(2.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(4.w),
                          Text(
                            isSkeleton ? "Loading..." : book?.car?.title ?? "",
                            style: context.label2SemiBold,
                            maxLines: 2,
                          ),
                          Gap(4.w),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                BookStatusWidget(
                                  icon:
                                      "assets/icons/${book?.rentalPlan?.periodType.name}.svg",
                                  value: isSkeleton
                                      ? "10 Days"
                                      : "${book?.duration} ${book?.rentalPlan?.periodType.periodType()}",
                                  isLoading: isSkeleton,
                                ),
                                VerticalDivider(thickness: .1),
                                BookStatusWidget(
                                  icon: AppIcons.receipt,
                                  value: isSkeleton
                                      ? "50,000 IQD"
                                      : "${book?.finalPrice.forMatNumber()} ${LocaleKeys.labels_iqd.tr()}",
                                  isLoading: isSkeleton,
                                ),
                              ],
                            ),
                          ),
                          Gap(1.w),
                          Divider(
                            thickness: .1,
                            color: context.surfaceContainer,
                          ),
                          Gap(3.w),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    await Clipboard.setData(
                                      ClipboardData(text: book?.bookId ?? ""),
                                    );
                                    if (!context.mounted) return;
                                    showMessages(
                                      context,
                                      message: LocaleKeys.alertMessages_copied
                                          .tr(),
                                    );
                                  },
                                  child: Text(
                                    isSkeleton
                                        ? "#AABBCCDD"
                                        : "#${book?.bookId?.formatOrderId()}",
                                    style: context.body,
                                  ),
                                ),
                              ),
                              isSkeleton
                                  ? Bone(
                                      width: 50.w,
                                      height: 8.w,
                                      borderRadius: BorderRadius.circular(
                                        100.w,
                                      ),
                                    )
                                  : PrimaryButton(
                                      color: context.secondary,
                                      width: 50.w,
                                      height: 8.w,
                                      text: LocaleKeys.buttons_details.tr(),
                                      onPress: () {
                                        if (book != null) {
                                          showBookDetails(context, book!);
                                        }
                                      },
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookStatusWidget extends StatelessWidget {
  const BookStatusWidget({
    super.key,
    required this.value,
    required this.icon,
    required this.isLoading,
  });
  final String value;
  final String icon;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isLoading ? Bone.circle(size: 4.w) : IconLoadaer(icon, width: 4.w),
        Gap(2.w),
        Text(value, style: context.caption),
      ],
    );
  }
}

class UserCarReviewView extends ConsumerWidget {
  const UserCarReviewView({super.key, required this.profile});
  final Profile profile;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final param = AllCursorReview(userId: profile.userId);
    final allboks = ref.watch(allCarReviewsProvider(param));

    return PagingSliverList(
      padding: EdgeInsets.only(bottom: 40.w, top: 4.w),
      state: allboks,
      onRefresh: () async =>
          await ref.read(allCarReviewsProvider(param).notifier).loadInitial(),
      onLoadMore: () =>
          ref.read(allCarReviewsProvider(param).notifier).loadMore(),
      itemBuilder: (context, item, index) =>
          AdminCarReviewWidget(review: item, param: param),
    );
  }
}

class UserCompanyReviewView extends ConsumerWidget {
  const UserCompanyReviewView({super.key, required this.profile});
  final Profile profile;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final param = AllCursorReview(userId: profile.userId);
    final allboks = ref.watch(allCompanyReviewsProvider(param));

    return PagingSliverList(
      padding: EdgeInsets.only(bottom: 40.w, top: 4.w),
      state: allboks,
      onRefresh: () async => await ref
          .read(allCompanyReviewsProvider(param).notifier)
          .loadInitial(),
      onLoadMore: () =>
          ref.read(allCompanyReviewsProvider(param).notifier).loadMore(),
      itemBuilder: (context, item, index) =>
          AdminCompanyReviewWidget(review: item, param: param),
    );
  }
}
