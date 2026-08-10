import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/features/auth/presentation/riverpod/is_logged_in.dart';
import 'package:kcars/features/booking/data/model/new_booking.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:kcars/features/car/presentation/screens/car_details_screen.dart';
import 'package:kcars/features/car/presentation/widget/checkout_sheet.dart';
import 'package:kcars/features/car/presentation/widget/date_range_picker.dart';
import 'package:kcars/features/car/presentation/widget/hourly_pianter.dart';
import 'package:kcars/features/car/presentation/widget/pickup_widget.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

@RoutePage()
class BookingScreen extends HookConsumerWidget {
  const BookingScreen({super.key, required this.car});
  final Car car;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final locale = useMemoized(() => context.locale.toLanguageTag(), []);
    final selectedRent = useState(car.rentalPlan?.first);

    final now = DateTime.now();
    final appointMent = useState<NewBooking>(
      NewBooking(
        carId: car.id,
        rentalPlanId: selectedRent.value?.id,
        companyId: car.company?.id,
        startDate: now,
        endDate: now.add(Duration(days: selectedRent.value?.min ?? 1)),
        periodType: selectedRent.value?.periodType,
        basePrice: selectedRent.value?.price,
        duration: selectedRent.value?.min ?? 1,
        planId: selectedRent.value?.plan?.id,
        totalPrice:
            (car.rentalPlan?.first.price ?? 0) * (selectedRent.value?.min ?? 1),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: CustomBackButton(),
        title: Text(LocaleKeys.screens_reservation.tr()),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
        ).copyWith(top: 4.w, bottom: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    IconLoadaer(AppIcons.starFill, width: 4.w),
                    Gap(1.w),
                    Text(
                      car.rate?.forMatNumber(),
                      style: context.body.copyWith(fontFamily: "plus-jakarta"),
                    ),
                    Gap(2.w),
                    Text(
                      "(${car.review?.convertToKM()})",
                      style: context.body.copyWith(fontFamily: "plus-jakarta"),
                    ),
                  ],
                ),
              ],
            ),
            Gap(6.w),
            Text(LocaleKeys.labels_rentalPlans.tr(), style: context.label2),
            Gap(6.w),
            Wrap(
              runSpacing: 4.w,
              alignment: WrapAlignment.spaceBetween,
              spacing: 2.w,
              children:
                  car.rentalPlan?.map((rent) {
                    return PlanWidget(
                      onTap: () {
                        selectedRent.value = rent;
                        appointMent.value = appointMent.value.copyWith(
                          rentalPlanId: rent.id,
                          periodType: rent.periodType,
                          duration: rent.min,
                          planId: rent.plan?.id,
                          totalPrice: rent.price * (rent.min ?? 1),
                        );
                      },
                      isSelected: selectedRent.value == rent,
                      icon: "assets/icons/${rent.periodType.name}.svg",
                      title: "Per ${rent.periodType.name}",
                      value: "${rent.price.forMatNumber()}",
                      type: rent.periodType.periodType(),
                    );
                  }).toList() ??
                  [],
            ),
            Gap(10.w),
            Text(LocaleKeys.labels_duration.tr(), style: context.label2),
            Gap(6.w),
            SizedBox(
              height: 60.w,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: selectedRent.value?.periodType == RentalPeriodType.hourly
                    ? HourlyDurationSelector(
                        key: const ValueKey('hourly'),
                        initialHour: car.rentalPlan?.first.min ?? 1,
                        maxHour: car.rentalPlan?.first.max ?? 24,
                        onHourSelected: (hour) {
                          appointMent.value = appointMent.value.copyWith(
                            totalPrice: selectedRent.value!.price * hour,
                            duration: hour,
                          );
                        },
                      )
                    : DateRangePicker(
                        key: const ValueKey('daily'),
                        car: car,
                        onSelectionChanged: (p0) {
                          final duration =
                              (p0.value.endDate
                                  ?.difference(p0.value.startDate)
                                  .inDays ??
                              1);
                          appointMent.value = appointMent.value.copyWith(
                            startDate: p0.value.startDate,
                            endDate: p0.value.endDate,
                            duration: duration.toInt(),
                            totalPrice: selectedRent.value!.price * duration,
                          );
                        },
                      ),
              ),
            ),
            Gap(10.w),
            Text(LocaleKeys.labels_pickupTime.tr(), style: context.label2),
            Gap(4.w),
            Wrap(
              runSpacing: 2.w,
              alignment: WrapAlignment.spaceBetween,
              spacing: 4.w,
              children: [
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child:
                        selectedRent.value?.periodType ==
                            RentalPeriodType.hourly
                        ? PickUpWidget(
                            icon: AppIcons.calender,
                            title: LocaleKeys.labels_startDate.tr(),
                            value:
                                appointMent.value.startDate?.formatDate2(
                                  context,
                                ) ??
                                now,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  clipBehavior: Clip.antiAlias,
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.w),
                                  ),
                                  child: SizedBox(
                                    width: 300,
                                    height: 400,
                                    child: SfDateRangePicker(
                                      todayHighlightColor: context.secondary,
                                      selectionColor: context.secondary,
                                      enablePastDates: false,
                                      backgroundColor: context.surface,
                                      showNavigationArrow: true,
                                      confirmText: LocaleKeys.buttons_ok.tr(),
                                      cancelText: LocaleKeys.buttons_cancel
                                          .tr(),
                                      initialDisplayDate:
                                          appointMent.value.startDate,
                                      initialSelectedDate:
                                          appointMent.value.startDate,
                                      showActionButtons: true,
                                      monthViewSettings:
                                          DateRangePickerMonthViewSettings(
                                            firstDayOfWeek: 6,
                                            dayFormat: "EEEEE",
                                            weekNumberStyle:
                                                DateRangePickerWeekNumberStyle(),
                                          ),
                                      maxDate: DateTime.now().add(
                                        Duration(days: 360),
                                      ),
                                      onCancel: () {
                                        Navigator.of(context).pop();
                                      },
                                      onSubmit: (Object? selectedRange) {
                                        final startDate =
                                            selectedRange as DateTime;
                                        appointMent.value = appointMent.value
                                            .copyWith(startDate: startDate);
                                        Navigator.of(context).pop();
                                      },
                                      headerStyle: DateRangePickerHeaderStyle(
                                        backgroundColor:
                                            context.secondaryContainer,
                                        textAlign: TextAlign.center,
                                        textStyle: context.label2SemiBold,
                                      ),
                                      selectableDayPredicate: (DateTime d) {
                                        return !car.bookings!.any((booking) {
                                          final start = DateTime(
                                            booking.startDate.toLocal().year,
                                            booking.startDate.toLocal().month,
                                            booking.startDate.toLocal().day,
                                          );
                                          final end = DateTime(
                                            booking.endDate.toLocal().year,
                                            booking.endDate.toLocal().month,
                                            booking.endDate.toLocal().day,
                                          );
                                          return d.isAtSameMomentAs(start) ||
                                              d.isAtSameMomentAs(end) ||
                                              (d.isAfter(start) &&
                                                  d.isBefore(end));
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : const SizedBox.shrink(key: ValueKey('empty')),
                  ),
                ),
                PickUpWidget(
                  icon: AppIcons.clock,
                  title: LocaleKeys.labels_startDate.tr(),
                  value: TimeOfDay(
                    hour: appointMent.value.startDate!.hour,
                    minute: appointMent.value.startDate!.minute,
                  ).format(context),
                  onTap: () async {
                    await picker.DatePicker.showTime12hPicker(
                      context,

                      theme: picker.DatePickerTheme(
                        doneStyle: Theme.of(context).textTheme.labelLarge!
                            .copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      // Public flutter_datetime_picker_plus has no Kurdish
                      // locale; Kurdish (Sorani) uses Arabic script, so fall
                      // back to Arabic labels for the time picker.
                      locale: (locale == "ar" || locale == "ku")
                          ? LocaleType.ar
                          : LocaleType.en,
                      onConfirm: (date) {
                        FocusManager.instance.primaryFocus?.unfocus();

                        final res = isPickupedTimeValid(
                          pickedTime: date,
                          selectedDate: appointMent.value.startDate!,
                        );
                        if (!res) {
                          showMessages(
                            context,
                            message: "Please select a valid time.",
                          );
                          return;
                        }
                        appointMent.value = appointMent.value.copyWith(
                          startDate: DateTime(
                            appointMent.value.startDate!.year,
                            appointMent.value.startDate!.month,
                            appointMent.value.startDate!.day,
                            date.hour,
                            date.minute,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 24.w,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: context.surface,
          border: Border(top: BorderSide(width: .1, color: context.outline)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.w).copyWith(top: 3.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(LocaleKeys.labels_totalPrice.tr(), style: context.body),
                Gap(1.w),
                Text.rich(
                  TextSpan(
                    text: appointMent.value.totalPrice?.forMatNumber() ?? "0",
                    style: context.label2Bold.copyWith(color: context.primary),
                    children: [
                      TextSpan(
                        text: " ${LocaleKeys.labels_iqd.tr()}",
                        style: context.caption.copyWith(
                          color: context.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            PrimaryButton(
              color: context.primary,
              width: 60.w,
              text: LocaleKeys.buttons_continue.tr(),
              onPress: () {
                if (selectedRent.value!.max != null &&
                    appointMent.value.duration! > selectedRent.value!.max!) {
                  showMessages(
                    context,
                    message:
                        "${LocaleKeys.alertMessages_maxDuration.tr(namedArgs: {"max": "${selectedRent.value!.max}"})} ${selectedRent.value?.periodType.periodDuration(appointMent.value.duration ?? 0)}",
                  );
                  return;
                }
                if (selectedRent.value!.min != null &&
                    appointMent.value.duration! < selectedRent.value!.min!) {
                  showMessages(
                    context,
                    message:
                        "${LocaleKeys.alertMessages_minDuration.tr(namedArgs: {"min": "${selectedRent.value!.min}"})} ${selectedRent.value?.periodType.periodDuration(appointMent.value.duration ?? 0)}",
                  );
                  return;
                }
                if (!isLoggedIn) {
                  showCustomAlert(
                    context,
                    closeButton: true,
                    content: LocaleKeys.alertMessages_logInToReserve.tr(),
                    primaryButtonText: LocaleKeys.buttons_login.tr(),
                    buttonColor: context.primary,
                  );
                  return;
                }
                showCheckout(
                  context,
                  car,
                  appointMent.value.copyWith(
                    endDate:
                        selectedRent.value?.periodType ==
                            RentalPeriodType.hourly
                        ? appointMent.value.startDate?.add(
                            Duration(hours: appointMent.value.duration ?? 1),
                          )
                        : appointMent.value.endDate,
                  ),
                  car.promotion,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

bool isPickupedTimeValid({
  required DateTime selectedDate,
  required DateTime pickedTime,
}) {
  final now = DateTime.now();

  final isSameDay =
      selectedDate.year == now.year &&
      selectedDate.month == now.month &&
      selectedDate.day == now.day;

  if (isSameDay) {
    if (pickedTime.hour < now.hour ||
        (pickedTime.hour == now.hour && pickedTime.minute < now.minute)) {
      return false;
    }
  }

  return true;
}
