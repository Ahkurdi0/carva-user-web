import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:kcars/configs/app_router.gr.dart';
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
import 'package:kcars/features/booking/data/model/new_booking.dart';
import 'package:kcars/features/booking/presentation/application/book_controller.dart';
import 'package:kcars/features/booking/presentation/application/book_states.dart';
import 'package:kcars/features/booking/presentation/riverpod/company_book.dart';
import 'package:kcars/features/booking/presentation/widget/book_details.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class CompanyBookedScreen extends ConsumerWidget {
  const CompanyBookedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (headerSliverBuilder, innerBoxIsScrolled) => [
            SliverAppBar(
              title: Text(LocaleKeys.screens_reservations.tr()),
              leading: CustomBackButton(),
              actions: [
                IconButton(
                  onPressed: () {
                    context.router.push(const SearchBooksRoute());
                  },
                  icon: Icon(Icons.search),
                ),
              ],
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
                      CompanyBookView(status: BookStatus.pending),
                      CompanyBookView(status: BookStatus.ongoing),
                      CompanyBookView(status: BookStatus.completed),
                      CompanyBookView(status: BookStatus.canceled),
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

class CompanyBookView extends ConsumerWidget {
  const CompanyBookView({super.key, required this.status});
  final BookStatus status;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final param = BookCursor(status: status);
    final companyBooked = ref.watch(companyBookedProvider(param));
    return PagingSliverList(
      onRefresh: () =>
          ref.read(companyBookedProvider(param).notifier).loadInitial(),
      onLoadMore: () =>
          ref.read(companyBookedProvider(param).notifier).loadMore(),
      padding: EdgeInsets.only(bottom: 40.w, top: 4.w),
      state: companyBooked,
      itemBuilder: (itemBuilder, book, index) {
        return BookedCarCard(book: book, param: param);
      },
    );
  }
}

class BookedCarCard extends ConsumerWidget {
  const BookedCarCard({
    super.key,
    this.book,
    this.isSkeleton = false,
    this.brandId,
    this.param,
    this.showStatus = false,
  });
  final Book? book;
  final bool isSkeleton;
  final String? brandId;
  final BookCursor? param;
  final bool showStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (book != null && param != null) {
          showCustomBottomSheet(
            context,
            BookOptions(book: book!, param: param!),
          );
        }
      },
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
                                if (showStatus) ...[
                                  VerticalDivider(thickness: .1),
                                  BookStatusWidget(
                                    icon: AppIcons.receipt,
                                    value: isSkeleton
                                        ? "Pendig"
                                        : "${book?.status.getStatus()}",
                                    isLoading: isSkeleton,
                                  ),
                                ],
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
                                  onTap: () {
                                    if (book != null) {
                                      Clipboard.setData(
                                        ClipboardData(text: book!.bookId ?? ""),
                                      );
                                      if (!context.mounted) return;
                                      showMessages(
                                        context,
                                        message: LocaleKeys.alertMessages_copied
                                            .tr(),
                                      );
                                    }
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

class BookOptions extends ConsumerWidget {
  const BookOptions({super.key, required this.book, required this.param});
  final Book book;
  final BookCursor param;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(bookControllerProvider, (prev, next) {
      if (next is UpdateBookFailed) {
        showCustomAlert(context, content: next.message);
      }
      if (next is UpdateBookCompleted) {
        showMessages(context, message: LocaleKeys.alertMessages_success.tr());
      }
    });
    void onTap(BookStatus status) {
      ref
          .read(bookControllerProvider.notifier)
          .updateBook(NewBooking(bookId: book.id, status: status), param, book);
      Navigator.pop(context);
    }

    return ListView(
      shrinkWrap: true,
      children: [
        CustomTile(
          title: LocaleKeys.bookStatus_ongoing.tr(),
          onTap: () => onTap(BookStatus.ongoing),
          enalbed: book.status == BookStatus.pending,
        ),
        CustomTile(
          title: LocaleKeys.bookStatus_completed.tr(),
          onTap: () => onTap(BookStatus.completed),
          enalbed:
              book.status == BookStatus.ongoing ||
              book.status == BookStatus.pending,
        ),
        CustomTile(
          title: LocaleKeys.bookStatus_canceled.tr(),
          onTap: () => onTap(BookStatus.canceled),
          enalbed:
              book.status == BookStatus.ongoing ||
              book.status == BookStatus.pending,
        ),
      ],
    );
  }
}

class CustomTile extends StatelessWidget {
  const CustomTile({
    super.key,
    this.onTap,
    required this.title,
    this.enalbed = true,
  });
  final VoidCallback? onTap;
  final String title;
  final bool enalbed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: enalbed,
      splashColor: Colors.transparent,
      onTap: onTap,
      title: Text(title),
    );
  }
}
