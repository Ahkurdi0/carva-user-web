import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/pagin_list_view.dart';
import 'package:kcars/core/utils/permissions.dart';
import 'package:kcars/core/widget/app_bar.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/features/booking/data/model/book.dart';
import 'package:kcars/features/booking/data/model/enums.dart';
import 'package:kcars/features/booking/data/model/new_booking.dart';
import 'package:kcars/features/booking/presentation/application/book_controller.dart';
import 'package:kcars/features/booking/presentation/application/book_states.dart';
import 'package:kcars/features/booking/presentation/riverpod/booked.dart';
import 'package:kcars/features/booking/presentation/widget/book_details.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class BookedScreen extends HookConsumerWidget {
  const BookedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useMemoized(() => notificaPermission(context), []);
    final bookData = ref.watch(bookedProvider());
    ref.listen(bookControllerProvider, (prev, next) {
      if (next is CancelBookFailed) {
        showCustomAlert(context, content: next.message);
      }
    });
    final controller = useScrollController();
    return Scaffold(
      appBar: HomeAppBar(),
      body: PagingSliverList(
        padding: EdgeInsets.only(bottom: 30.w),
        emptyMessage: LocaleKeys.empty_emptyBooking.tr(),
        onRefresh: () async =>
            ref.read(bookedProvider().notifier).loadInitial(),
        controller: controller,
        onLoadMore: () {
          ref.read(bookedProvider().notifier).loadMore(bookData.items.last.id);
        },
        state: bookData,
        itemBuilder: (context, book, index) => BookedCarCard(book: book),
        initalLoadingWidget: ListView.builder(
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, index) => BookedCarCard(isSkeleton: true),
        ),
      ),
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
    return Skeletonizer(
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
                ImageHolder(
                  image: isSkeleton
                      ? null
                      : book!.car!.images!.isNotEmpty
                      ? book!.car!.images?.first.image
                      : null,
                  width: 100.w,
                  height: 50.w,
                  borderRadius: BorderRadius.circular(4.w),
                  isLoading: isSkeleton,
                  fit: BoxFit.cover,
                ),
                if (!isSkeleton && book?.status == BookStatus.pending)
                  Positioned(
                    top: 2.w,
                    right: 2.w,
                    child: CustomIconButton(
                      icon: AppIcons.cancel,
                      iconColor: context.error,
                      color: context.surface,
                      onTap: () {
                        showCustomAlert(
                          context,
                          content: LocaleKeys.alertMessages_cancelBook.tr(),
                          primaryButtonText: LocaleKeys.buttons_yes.tr(),
                          closeButton: true,
                          primaryAction: () {
                            ref
                                .read(bookControllerProvider.notifier)
                                .cancelBook(NewBooking(bookId: book!.id));
                          },
                        );
                      },
                    ),
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
                                    : "${book?.duration} ${book?.rentalPlan?.periodType.periodDuration(book?.duration ?? 0)}",

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
                              VerticalDivider(thickness: .1),
                              BookStatusWidget(
                                icon: AppIcons.status,
                                value: isSkeleton
                                    ? "Pending"
                                    : "${book?.status.getStatus()}",
                                isLoading: isSkeleton,
                              ),
                            ],
                          ),
                        ),
                        Gap(1.w),
                        Divider(thickness: .1, color: context.surfaceContainer),
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
                                    borderRadius: BorderRadius.circular(100.w),
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
