import 'package:auto_route/auto_route.dart';
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
import 'package:kcars/core/widget/custom_tabbar.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/core/widget/profile_container.dart';
import 'package:kcars/features/booking/data/model/book.dart';
import 'package:kcars/features/booking/data/model/book_cursor.dart';
import 'package:kcars/features/booking/data/model/enums.dart';
import 'package:kcars/features/booking/presentation/riverpod/all_books.dart';
import 'package:kcars/features/booking/presentation/widget/book_details.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class AllBooksScreen extends ConsumerWidget {
  const AllBooksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              title: Text(LocaleKeys.screens_reservations.tr()),
              leading: CustomBackButton(),
            ),
          ],
          body: DefaultTabController(
            length: 4,
            child: Column(
              children: [
                CustomTabbar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  tabs: [
                    Tab(text: LocaleKeys.bookStatus_pending.tr()),
                    Tab(text: LocaleKeys.bookStatus_ongoing.tr()),
                    Tab(text: LocaleKeys.bookStatus_completed.tr()),
                    Tab(text: LocaleKeys.bookStatus_canceled.tr()),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      AllBookView(status: BookStatus.pending),
                      AllBookView(status: BookStatus.ongoing),
                      AllBookView(status: BookStatus.completed),
                      AllBookView(status: BookStatus.canceled),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AllBookView extends ConsumerWidget {
  const AllBookView({super.key, required this.status});
  final BookStatus status;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final param = BookCursor(status: status);
    final state = ref.watch(allBooksProvider(param));
    return PagingSliverList(
      padding: EdgeInsets.only(bottom: 20.w, top: 4.w),
      onRefresh: () => ref.read(allBooksProvider(param).notifier).loadInitial(),
      onLoadMore: () => ref.read(allBooksProvider(param).notifier).loadMore(),
      state: state,
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
                                      text: LocaleKeys.buttons_update.tr(),
                                      onPress: () {
                                        if (book != null) {
                                          showBookDetails(context, book!);
                                        }
                                      },
                                    ),
                            ],
                          ),
                          Gap(1.w),
                          Row(
                            children: [
                              ImageHolder(
                                image: book?.company?.image,
                                width: 6.w,
                                height: 6.w,
                                fit: BoxFit.cover,
                                borderRadius: BorderRadius.circular(100.w),
                              ),
                              Gap(2.w),
                              Text(
                                book?.company?.name ?? "n/a",
                                style: context.caption,
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
