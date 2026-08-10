import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

Future<DateTime?> showDateYearPicker(
  BuildContext context, [
  DateRangePickerView view = DateRangePickerView.month,
]) {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.w)),
      child: SizedBox(
        width: 300,
        height: 400,
        child: SfDateRangePicker(
          allowViewNavigation: false,
          view: view,
          todayHighlightColor: context.secondary,
          selectionColor: context.secondary,
          enablePastDates: false,
          backgroundColor: context.surface,
          showNavigationArrow: true,
          confirmText: LocaleKeys.buttons_ok.tr(),
          cancelText: LocaleKeys.buttons_cancel.tr(),
          showActionButtons: true,
          monthViewSettings: DateRangePickerMonthViewSettings(
            firstDayOfWeek: 6,
            dayFormat: "EEEEE",
            weekNumberStyle: DateRangePickerWeekNumberStyle(),
          ),
          maxDate: DateTime.now().add(Duration(days: 360)),
          onCancel: () {
            Navigator.of(context).pop();
          },
          onSubmit: (Object? selectedRange) {
            final startDate = selectedRange as DateTime;
            Navigator.of(context).pop(startDate);
          },
          headerStyle: DateRangePickerHeaderStyle(
            backgroundColor: context.secondaryContainer,
            textAlign: TextAlign.center,
            textStyle: context.label2SemiBold,
          ),
        ),
      ),
    ),
  );
}
