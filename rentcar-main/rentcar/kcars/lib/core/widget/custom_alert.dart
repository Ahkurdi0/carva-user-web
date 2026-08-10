import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

showCustomAlert(
  BuildContext context, {
  String? title,
  String? primaryButtonText,
  String? content,
  VoidCallback? primaryAction,
  Color? buttonColor,
  bool closeButton = false,
  IconData? icon,
  bool isDeleting = false,
  bool barrierDismissible = true,
  final Widget? child,
}) async {
  await showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return Dialog(
        clipBehavior: Clip.antiAlias,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (title != null) ...[
                    Text(
                      title,
                      style: context.label2SemiBold,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 2.w),
                  ],
                  child ??
                      Text(
                        content ?? "",
                        style: context.subTitle2.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: context.secondaryContainer),
              width: 100.w,
              padding: EdgeInsets.symmetric(
                horizontal: 2.w,
              ).copyWith(bottom: 2.5.w, top: 2.5.w),
              child: Column(
                children: [
                  closeButton || isDeleting
                      ? IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SecondaryButton(
                                width: 36.w,
                                height: 11.w,
                                color: context.secondaryContainer,
                                borderRadius: BorderRadius.circular(100.w),
                                text: LocaleKeys.buttons_close.tr(),
                                onPress: () => Navigator.pop(context),
                              ),
                              PrimaryButton(
                                borderRadius: BorderRadius.circular(100.w),
                                width: 36.w,
                                height: 11.w,
                                color: isDeleting ? context.error : buttonColor,
                                text: isDeleting
                                    ? LocaleKeys.buttons_delete.tr()
                                    : primaryButtonText ??
                                          LocaleKeys.buttons_ok.tr(),
                                onPress: () {
                                  primaryAction?.call();
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        )
                      : PrimaryButton(
                          height: 12.w,
                          width: 60.w,
                          borderRadius: BorderRadius.circular(100.w),
                          color: isDeleting ? context.error : context.primary,
                          text: isDeleting
                              ? LocaleKeys.buttons_delete.tr()
                              : primaryButtonText ?? LocaleKeys.buttons_ok.tr(),
                          onPress: () {
                            primaryAction?.call();

                            Navigator.pop(context);
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

showMessages(
  BuildContext context, {
  required message,
  Color? backgroundColor,
  Duration? duration,
  SnackBarBehavior? behavior,
  EdgeInsetsGeometry? margin,
}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      duration: duration ?? const Duration(seconds: 4),
      content: Text(message, textAlign: TextAlign.center),
      behavior: behavior ?? SnackBarBehavior.floating,
      margin: margin,
    ),
  );
}

showCustomBottomSheet(
  BuildContext context,
  Widget child, {
  bool isScrollControlled = false,
  bool enableDrag = true,
  bool isDismissible = true,
  bool showDragHandle = true,
  bool useRootNavigator = false,
}) {
  showModalBottomSheet(
    elevation: 0,
    useRootNavigator: useRootNavigator,
    showDragHandle: showDragHandle,
    isDismissible: isDismissible,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(6.w),
        topRight: Radius.circular(6.w),
      ),
    ),

    isScrollControlled: isScrollControlled,
    enableDrag: enableDrag,
    context: context,
    builder: (context) => child,
  );
}
