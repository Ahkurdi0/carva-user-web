import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateRangePicker extends ConsumerWidget {
  const DateRangePicker({
    super.key,
    required this.car,
    this.onSelectionChanged,
  });
  final Car car;
  final Function(DateRangePickerSelectionChangedArgs)? onSelectionChanged;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    return SfDateRangePicker(
      todayHighlightColor: context.secondary,
      selectionMode: DateRangePickerSelectionMode.range,
      selectionColor: context.secondary,
      enablePastDates: false,
      initialSelectedDate: now,
      backgroundColor: context.surface,
      enableMultiView: true,
      minDate: now,
      monthViewSettings: DateRangePickerMonthViewSettings(
        firstDayOfWeek: 6,
        dayFormat: "EEEEE",
        weekNumberStyle: DateRangePickerWeekNumberStyle(),
      ),

      rangeSelectionColor: context.secondary.withAlpha(20),
      endRangeSelectionColor: context.secondary,
      startRangeSelectionColor: context.secondary,
      onSelectionChanged: (args) {
        if (args.value is PickerDateRange) {
          PickerDateRange range = args.value;
          if (range.startDate == null || range.endDate == null) {
            return;
          }
          onSelectionChanged?.call(args);
        }
      },

      maxDate: DateTime.now().add(Duration(days: 360)),
      onCancel: () {
        Navigator.of(context).pop();
      },
      headerStyle: DateRangePickerHeaderStyle(
        backgroundColor: context.secondaryContainer,
        textAlign: TextAlign.center,
        textStyle: context.body,
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
              (d.isAfter(start) && d.isBefore(end));
        });
      },
    );
  }

  List<DateTime> getBlackoutDates(Car car) {
    final List<DateTime> blackoutDates = [];

    for (var booking in car.bookings ?? []) {
      final start = booking.startDate.toLocal();
      final end = booking.endDate.toLocal();

      DateTime current = DateTime(start.year, start.month, start.day);
      final endDate = DateTime(end.year, end.month, end.day);

      while (!current.isAfter(endDate)) {
        blackoutDates.add(current);
        current = current.add(Duration(days: 1));
      }
    }

    return blackoutDates.toSet().toList(); // remove duplicates if needed
  }
}
