import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import "package:intl/intl.dart" as intl;

String getMimeType(String filePath) {
  final extension = filePath.split('.').last.toLowerCase();

  switch (extension) {
    case 'jpg':
    case 'jpeg':
      return 'image/jpeg';
    case 'png':
      return 'image/png';
    case 'gif':
      return 'image/gif';
    default:
      return 'application/octet-stream';
  }
}

extension ThemeExtension on BuildContext {
  //Colros

  ColorScheme get baseColor => Theme.of(this).colorScheme;
  Color get primary => baseColor.primary;
  Color get primaryContainer => baseColor.primaryContainer;
  Color get onPrimary => baseColor.onPrimary;
  Color get secondary => baseColor.secondary;
  Color get secondaryContainer => baseColor.secondaryContainer;
  Color get onSecondary => baseColor.onSecondary;
  Color get error => baseColor.error;
  Color get onError => baseColor.onError;
  Color get surface => baseColor.surface;
  Color get onSurface => baseColor.onSurface;
  Color get outline => baseColor.outline;
  Color get surfaceContainerLow => baseColor.surfaceContainerLow;
  Color get surfaceContainerLowest => baseColor.surfaceContainerLowest;
  Color get surfaceContainer => baseColor.surfaceContainer;

  Color get disabled => Theme.of(this).disabledColor;

  Color get surfaceTint => baseColor.surfaceTint;
  Color get onSurfaceVariant => baseColor.onSurfaceVariant;

  //Typography
  TextStyle get baseText => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get titleBold =>
      baseText.copyWith(fontWeight: FontWeight.bold, fontSize: 22.sp);

  TextStyle get title2Bold =>
      baseText.copyWith(fontWeight: FontWeight.bold, fontSize: 20.sp);

  TextStyle get title2SemiBold =>
      baseText.copyWith(fontWeight: FontWeight.w600, fontSize: 20.sp);

  TextStyle get title3 =>
      baseText.copyWith(fontWeight: FontWeight.w400, fontSize: 16.sp);

  TextStyle get title3SemiBold =>
      baseText.copyWith(fontWeight: FontWeight.w600, fontSize: 16.sp);

  TextStyle get subTitle =>
      baseText.copyWith(fontWeight: FontWeight.w400, fontSize: 18.sp);

  TextStyle get subTitle2 =>
      baseText.copyWith(fontWeight: FontWeight.w400, fontSize: 17.sp);

  TextStyle get button =>
      baseText.copyWith(fontWeight: FontWeight.w500, fontSize: 16.sp);

  TextStyle get body =>
      baseText.copyWith(fontWeight: FontWeight.w400, fontSize: 16.sp);

  TextStyle get bodySemiBild =>
      baseText.copyWith(fontWeight: FontWeight.w700, fontSize: 16.sp);

  TextStyle get label =>
      baseText.copyWith(fontWeight: FontWeight.w400, fontSize: 15.sp);

  TextStyle get labelSemiBold =>
      baseText.copyWith(fontWeight: FontWeight.w700, fontSize: 15.sp);

  TextStyle get label2 =>
      baseText.copyWith(fontWeight: FontWeight.w400, fontSize: 17.sp);

  TextStyle get label2Bold =>
      baseText.copyWith(fontWeight: FontWeight.w700, fontSize: 17.sp);

  TextStyle get label2SemiBold =>
      baseText.copyWith(fontWeight: FontWeight.w600, fontSize: 17.sp);

  TextStyle get caption =>
      baseText.copyWith(fontWeight: FontWeight.w400, fontSize: 15.sp);

  TextStyle get overline =>
      baseText.copyWith(fontWeight: FontWeight.w400, fontSize: 14.sp);
}

extension FomratDate on DateTime {
  formatDate(BuildContext context) {
    final tag = Localizations.maybeLocaleOf(context)?.toLanguageTag();
    return intl.DateFormat("", tag).add_yMd().add_jmz().format(toLocal());
  }

  formatDate2(BuildContext context) {
    final tag = Localizations.maybeLocaleOf(context)?.toLanguageTag();
    return intl.DateFormat("dd/MM/yyyy", tag).format(toLocal());
  }

  formatDate3(BuildContext context) {
    final tag = Localizations.maybeLocaleOf(context)?.toLanguageTag();
    return intl.DateFormat("dd/MM", tag).add_jm().format(toLocal());
  }

  formatTime(BuildContext context) {
    final tag = Localizations.maybeLocaleOf(context)?.toLanguageTag();
    return intl.DateFormat("", tag).add_jm().format(toLocal());
  }
}

extension FormmatNumber on num {
  forMatNumber() {
    final value = intl.NumberFormat.decimalPattern();
    return value.format(this);
  }

  convertToKM() {
    final value = intl.NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
    );

    return value.format(this);
  }

  getMonthName(BuildContext context) {
    final tag = Localizations.maybeLocaleOf(context)?.toLanguageTag();
    return intl.DateFormat.MMMM(tag).format(DateTime(0, this as int));
  }
}

extension CustomErrorsHandlers on dynamic {
  Widget transformErrors() {
    return Center(child: Text(this));
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }

  formatOrderId() {
    return substring(0, 10).toUpperCase();
  }

  String? nullIfEmpty() => isEmpty ? null : this;

  (int?, int) parseIntToOrZeroNull() {
    if (isEmpty) return (null, 0);
    final parsed = int.tryParse(this);
    return (parsed, parsed ?? 0);
  }
}
