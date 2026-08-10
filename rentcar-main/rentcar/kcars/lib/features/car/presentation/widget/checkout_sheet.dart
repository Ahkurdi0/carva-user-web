import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/app_textfeild.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/features/booking/data/model/new_booking.dart';
import 'package:kcars/features/booking/data/model/promo_code.dart';
import 'package:kcars/features/booking/presentation/application/book_controller.dart';
import 'package:kcars/features/booking/presentation/application/book_states.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:kcars/features/car/data/model/promotion.dart';
import 'package:kcars/features/car/presentation/views/carousal_slider_view.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

Future<void> showCheckout(
  BuildContext context,

  final Car car,
  final NewBooking booking,
  final Promotion? promotion,
) async {
  Navigator.push(
    context,
    ModalSheetRoute(
      viewportPadding: EdgeInsets.only(
        top: MediaQuery.viewPaddingOf(context).top,
      ),
      builder: (context) =>
          _CheckoutSheet(car: car, booking: booking, promotion: promotion),
    ),
  );
}

class _CheckoutSheet extends HookConsumerWidget {
  const _CheckoutSheet({
    required this.car,
    required this.booking,
    required this.promotion,
  });
  final Car car;
  final NewBooking booking;

  final Promotion? promotion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const minSize = SheetOffset(0.8);
    const halfSize = SheetOffset(0.9);
    const fullSize = SheetOffset(1);
    final book = ref.watch(bookControllerProvider);
    final code = useTextEditingController();
    final contact = useTextEditingController();

    final from = useMemoized(() => GlobalKey<FormState>(), []);
    ref.listen(bookControllerProvider, (prev, next) {
      if (next is NewBookCompleted) {
        showMessages(
          context,
          message: LocaleKeys.alertMessages_reservationSuccess.tr(),
        );
        Navigator.pop(context);
      }
      if (next is NewBookFailed) {
        showMessages(
          context,
          message: next.message,
          margin: EdgeInsets.symmetric(horizontal: 4.w).copyWith(bottom: 20.w),
        );
      }
    });
    final isCorrectPromotion = useMemoized(() {
      if (promotion == null) return false;
      if (booking.companyId != promotion?.companyId) {
        return false;
      }
      switch (promotion?.type) {
        case PromotionType.company:
          if (booking.companyId != promotion?.companyId) return false;

          if (promotion?.rentalPlanId != null &&
              booking.rentalPlanId != promotion?.rentalPlanId) {
            return false;
          }

          if (promotion?.planId != null &&
              booking.planId != promotion?.planId) {
            return false;
          }

          if (promotion?.carId != null && booking.carId != promotion?.carId) {
            return false;
          }

          return true;

        case PromotionType.plan:

          // Plan promo applies if plan matches,
          // Optional car or rentalPlan filters narrow it further
          if (booking.planId != promotion?.planId) return false;
          if (promotion?.rentalPlanId != null &&
              booking.rentalPlanId != promotion?.rentalPlanId) {
            return false;
          }
          if (promotion?.carId != null && booking.carId != promotion?.carId) {
            return false;
          }
          return true;

        case PromotionType.rentalPlan:

          // RentalPlan promo applies if rentalPlan matches,
          // Optional car filter narrows it
          if (booking.rentalPlanId != promotion?.rentalPlanId) return false;
          if (promotion?.carId != null && booking.carId != promotion?.carId) {
            return false;
          }
          return true;

        case PromotionType.car:
          if (booking.carId != promotion?.carId) return false;
          if (promotion?.rentalPlanId != null &&
              booking.rentalPlanId != promotion?.rentalPlanId) {
            return false;
          }
          if (promotion?.planId != null &&
              booking.planId != promotion?.planId) {
            return false;
          }
          return true;

        default:
          return false;
      }
    }, [promotion?.type]);

    final promotEnabled = car.promotion == null || !isCorrectPromotion;
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
          scrollConfiguration: const SheetScrollConfiguration(
            scrollSyncMode: SheetScrollHandlingBehavior.always,
            thresholdVelocityToInterruptBallisticScroll: 0.5,
          ),
          decoration: MaterialSheetDecoration(
            color: Colors.white,
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
            bottomBarVisibility: BottomBarVisibility.conditional(
              // ignoreBottomInset: true,
              isVisible: (m) => m.offset >= const SheetOffset(0.5).resolve(m),
            ),
            extendBodyBehindBottomBar: true,
            body: Scaffold(
              body: Form(
                key: from,
                child: Column(
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
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 4.w).copyWith(
                          bottom:
                              MediaQuery.viewPaddingOf(context).bottom + 20.w,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              Gap(2.w),
                              CarousalView(sliders: car.images ?? []),
                              Gap(2.w),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      car.title,
                                      style: context.title2Bold,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconLoadaer(
                                        AppIcons.starFill,
                                        width: 4.w,
                                      ),
                                      Gap(1.w),
                                      Text(
                                        car.rate?.forMatNumber(),
                                        style: context.body,
                                      ),
                                      Gap(2.w),
                                      Text(
                                        "(${car.review?.convertToKM()})",
                                        style: context.body,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Gap(6.w),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.w),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CheckoutTile(
                                      title: LocaleKeys.labels_duration.tr(),
                                      value:
                                          "${booking.duration?.forMatNumber() ?? ""} ${booking.periodType?.periodDuration(booking.duration ?? 0)}",
                                    ),
                                    CheckoutTile(
                                      title: LocaleKeys.labels_startDate.tr(),
                                      value:
                                          booking.startDate?.formatDate2(
                                            context,
                                          ) ??
                                          "0",
                                    ),
                                    if (booking.periodType ==
                                        RentalPeriodType.daily)
                                      CheckoutTile(
                                        title: LocaleKeys.labels_endDate.tr(),
                                        value:
                                            booking.endDate?.formatDate2(
                                              context,
                                            ) ??
                                            "0",
                                      ),
                                    CheckoutTile(
                                      title: LocaleKeys.labels_pickupTime.tr(),
                                      value:
                                          booking.startDate?.formatTime(
                                            context,
                                          ) ??
                                          "0",
                                    ),
                                    CheckoutTile(
                                      title: LocaleKeys.labels_totalPrice.tr(),
                                      value:
                                          booking.totalPrice?.forMatNumber() ??
                                          "0",
                                    ),
                                    Gap(2.w),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 2.w,
                                      ),
                                      child: AppTextField(
                                        label: LocaleKeys.labels_contact.tr(),
                                        hint: "7XXxxxxxxx",
                                        keyboardType: TextInputType.number,
                                        controller: contact,
                                      ),
                                    ),
                                    AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 500,
                                      ),
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
                                      child:
                                          book is! ApplyPromotionCompleted ||
                                              book is NewBookLoading
                                          ? Padding(
                                              key: const ValueKey(
                                                'promo-input',
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 3.w,
                                              ).copyWith(top: 2.w),
                                              child: AppTextField(
                                                controller: code,
                                                validator: (value) => null,
                                                readOnly:
                                                    promotEnabled ||
                                                    book
                                                        is ApplyPromotionLoading,
                                                label: LocaleKeys
                                                    .labels_promotionCode
                                                    .tr(),
                                                hint: "XXXX-XXXX",
                                                maxLength: 50,
                                                suffixIcon: PrimaryButton(
                                                  isActive: !promotEnabled,
                                                  borderRadius:
                                                      BorderRadiusDirectional.only(
                                                        topEnd: Radius.circular(
                                                          2.w,
                                                        ),
                                                        bottomEnd:
                                                            Radius.circular(
                                                              2.w,
                                                            ),
                                                      ),

                                                  width: 24.w,
                                                  height: 10.w,
                                                  text: LocaleKeys.buttons_apply
                                                      .tr(),
                                                  isLoading:
                                                      book
                                                          is ApplyPromotionLoading,
                                                  onPress: car.promotion == null
                                                      ? null
                                                      : () {
                                                          FocusManager
                                                              .instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                          if (code
                                                                  .text
                                                                  .isEmpty ||
                                                              code.text.length <
                                                                  8) {
                                                            showMessages(
                                                              context,
                                                              message: LocaleKeys
                                                                  .validations_promotionCode
                                                                  .tr(),
                                                              margin:
                                                                  EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        4.w,
                                                                  ).copyWith(
                                                                    bottom:
                                                                        20.w,
                                                                  ),
                                                            );
                                                            return;
                                                          }

                                                          ref
                                                              .read(
                                                                bookControllerProvider
                                                                    .notifier,
                                                              )
                                                              .applyPromoCode(
                                                                PromoCode(
                                                                  carId: car.id,
                                                                  code:
                                                                      code.text,
                                                                  companyId:
                                                                      car
                                                                          .company
                                                                          ?.id ??
                                                                      "",
                                                                  planId:
                                                                      booking
                                                                          .planId ??
                                                                      "",
                                                                  rentalPlanId:
                                                                      booking
                                                                          .rentalPlanId ??
                                                                      "",
                                                                  endDate: booking
                                                                      .endDate!,
                                                                  startDate: booking
                                                                      .startDate!,
                                                                ),
                                                              );
                                                        },
                                                ),
                                              ),
                                            )
                                          : Column(
                                              key: const ValueKey(
                                                'promo-summary',
                                              ),
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CheckoutTile(
                                                  title: LocaleKeys
                                                      .labels_discount
                                                      .tr(),
                                                  value:
                                                      "${car.promotion?.value?.forMatNumber()} ${car.promotion?.priceType.pricePromotionType()}",
                                                ),
                                                CheckoutTile(
                                                  title: LocaleKeys
                                                      .labels_discountApplied
                                                      .tr(),
                                                  value:
                                                      book.result.discount
                                                          .forMatNumber() ??
                                                      "",
                                                ),
                                                CheckoutTile(
                                                  title: LocaleKeys
                                                      .labels_priceAfterDiscount
                                                      .tr(),
                                                  value:
                                                      book.result.finalPrice
                                                          .forMatNumber() ??
                                                      "",
                                                ),
                                              ],
                                            ),
                                    ),
                                    ...[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 4.w,
                                        ),
                                        child: AnimatedSwitcher(
                                          duration: Duration(milliseconds: 500),
                                          transitionBuilder:
                                              (child, animation) {
                                                return FadeTransition(
                                                  opacity: animation,
                                                  child: SizeTransition(
                                                    sizeFactor: animation,
                                                    axisAlignment: 2.0,
                                                    child: child,
                                                  ),
                                                );
                                              },
                                          child: book is ApplyPromotionFailed
                                              ? Text(
                                                  key: ValueKey("error"),
                                                  book.message,
                                                  style: context.caption
                                                      .copyWith(
                                                        color: context.error,
                                                      ),
                                                )
                                              : SizedBox.shrink(
                                                  key: const ValueKey('empty'),
                                                ),
                                        ),
                                      ),
                                      Gap(2.w),
                                    ],
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
            bottomBar: Container(
              height: 24.w,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: context.surface,
                border: Border(
                  top: BorderSide(width: .1, color: context.outline),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 4.w).copyWith(top: 3.w),
              child: PrimaryButton(
                isLoading: book is NewBookLoading,
                color: context.primary,
                text: LocaleKeys.buttons_reserve.tr(),
                onPress: () {
                  if (!from.currentState!.validate()) return;
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (code.text.isNotEmpty && code.text.length < 8) {
                    showMessages(
                      context,
                      message: LocaleKeys.validations_promotionCode.tr(),
                      margin: EdgeInsets.symmetric(
                        horizontal: 4.w,
                      ).copyWith(bottom: 20.w),
                    );
                    return;
                  }
                  ref
                      .read(bookControllerProvider.notifier)
                      .bookCar(
                        booking.copyWith(
                          code: code.text,
                          contact: contact.text,
                        ),
                      );
                },
              ),
            ),
            //  const _ExampleBottomBar(),
          ),
        ),
      ),
    );
  }
}

class CheckoutTile extends StatelessWidget {
  const CheckoutTile({super.key, required this.title, required this.value});
  final String title;
  final String value;
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
        trailing: Text(value),
      ),
    );
  }
}
