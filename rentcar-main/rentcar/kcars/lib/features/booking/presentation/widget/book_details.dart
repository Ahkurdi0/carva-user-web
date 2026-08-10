import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/features/booking/data/model/book.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:kcars/features/car/presentation/views/carousal_slider_view.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

Future<void> showBookDetails(BuildContext context, final Book book) async {
  Navigator.push(
    context,
    ModalSheetRoute(
      viewportPadding: EdgeInsets.only(
        top: MediaQuery.viewPaddingOf(context).top,
      ),
      builder: (context) => _CheckBookDetails(book: book),
    ),
  );
}

class _CheckBookDetails extends HookConsumerWidget {
  const _CheckBookDetails({required this.book});
  final Book book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const minSize = SheetOffset(0.7);
    const halfSize = SheetOffset(0.8);
    const fullSize = SheetOffset(1);

    return SheetKeyboardDismissible(
      dismissBehavior: const SheetKeyboardDismissBehavior.onDragDown(
        isContentScrollAware: true,
      ),
      child: NotificationListener<SheetDragUpdateNotification>(
        onNotification: (notification) {
          final metrics = notification.metrics;
          // Detect drag to top (fully collapsed)

          // If user drags down (positive dragDelta) and sheet is near top (minOffset)
          if (notification.dragDetails.deltaY > 0 &&
              metrics.offset <= metrics.minOffset + 0.5) {
            Navigator.of(context).maybePop(); // close the sheet (pop modal)
            return true; // handled
          }

          return false;
        },
        child: Sheet(
          initialOffset: fullSize,
          scrollConfiguration: const SheetScrollConfiguration(
            scrollSyncMode: SheetScrollHandlingBehavior.always,
            thresholdVelocityToInterruptBallisticScroll: 0.5,
          ),
          decoration: MaterialSheetDecoration(
            color: context.surface,
            size: SheetSize.stretch,
            clipBehavior: Clip.antiAlias,
            elevation: 8,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.w)),
            ),
          ),
          snapGrid: const SheetSnapGrid(snaps: [minSize, halfSize, fullSize]),
          child: SheetContentScaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindBottomBar: false,
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 3.w, bottom: 1.w),
                  height: 1.w,
                  width: 14.w,
                  decoration: BoxDecoration(
                    color: context.outline,
                    borderRadius: BorderRadius.circular(100.w),
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                    ).copyWith(bottom: 10.w),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(2.w),
                          CarousalView(sliders: book.car?.images ?? []),
                          Gap(2.w),
                          Text(
                            book.car?.title ?? "",
                            style: context.title2Bold,
                            maxLines: 2,
                          ),

                          Gap(6.w),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.w),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CheckoutTile(
                                  title: LocaleKeys.labels_duration.tr(),
                                  value:
                                      "${book.duration.forMatNumber() ?? ""} ${book.rentalPlan?.periodType.periodDuration(book.duration)}",
                                ),
                                CheckoutTile(
                                  title: LocaleKeys.labels_startDate.tr(),
                                  value:
                                      book.startDate.formatDate2(context) ??
                                      "0",
                                ),
                                if (book.rentalPlan?.periodType ==
                                    RentalPeriodType.daily)
                                  CheckoutTile(
                                    title: LocaleKeys.labels_endDate.tr(),
                                    value:
                                        book.endDate.formatDate2(context) ??
                                        "0",
                                  ),
                                CheckoutTile(
                                  title: LocaleKeys.labels_pickupTime.tr(),
                                  value:
                                      book.startDate.formatTime(context) ?? "0",
                                ),
                                CheckoutTile(
                                  title: LocaleKeys.labels_totalPrice.tr(),
                                  value: book.totalPrice.forMatNumber() ?? "0",
                                ),
                                if (book.contact != null)
                                  CheckoutTile(
                                    title: LocaleKeys.labels_contact.tr(),
                                    value: book.contact ?? "0",
                                    hasCopy: true,
                                  ),
                                if (book.promotion != null)
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 500),
                                    switchInCurve: Curves.easeIn,
                                    switchOutCurve: Curves.easeOut,
                                    transitionBuilder: (child, animation) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: SizeTransition(
                                          sizeFactor: animation,
                                          axisAlignment: -2.0,
                                          child: child,
                                        ),
                                      );
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CheckoutTile(
                                          title: LocaleKeys.labels_discount
                                              .tr(),
                                          value:
                                              "${book.promotion?.value?.forMatNumber()} ${book.promotion?.priceType.pricePromotionType()}",
                                        ),
                                        CheckoutTile(
                                          title: LocaleKeys
                                              .labels_discountApplied
                                              .tr(),
                                          value:
                                              book.discountAmount
                                                  ?.forMatNumber() ??
                                              "",
                                        ),
                                        CheckoutTile(
                                          title: LocaleKeys
                                              .labels_priceAfterDiscount
                                              .tr(),
                                          value:
                                              book.finalPrice.forMatNumber() ??
                                              "",
                                        ),
                                      ],
                                    ),
                                  ),
                                Gap(2.w),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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

class CheckoutTile extends StatelessWidget {
  const CheckoutTile({
    super.key,
    required this.title,
    required this.value,
    this.hasCopy = false,
  });
  final String title;
  final String value;
  final bool hasCopy;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.w),
        border: Border(
          bottom: BorderSide(width: 1, color: context.surfaceContainerLowest),
        ),
      ),
      child: ListTile(
        dense: true,
        title: Text(title, style: context.body),
        trailing: GestureDetector(
          onTap: () async {
            if (hasCopy) {
              await Clipboard.setData(ClipboardData(text: value));
              if (!context.mounted) return;
              context.maybePop();
              showMessages(
                context,
                message: LocaleKeys.alertMessages_copied.tr(),
              );
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(value, style: context.caption),
              if (hasCopy) ...[
                Gap(1.w),
                Padding(
                  padding: EdgeInsets.only(bottom: 1.w),
                  child: Icon(Icons.copy, size: 4.w, color: context.primary),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
