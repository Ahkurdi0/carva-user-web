import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

showSheeet(
  BuildContext context,
  Widget child, {
  EdgeInsets viewportPadding = EdgeInsets.zero,
}) {
  Navigator.of(context).push(
    ModalSheetRoute(
      swipeDismissible: true,
      swipeDismissSensitivity: SwipeDismissSensitivity(minDragDistance: 10),
      viewportPadding: viewportPadding,
      builder: (context) => child,
    ),
  );
}

class ScrollableSheetContent extends StatelessWidget {
  const ScrollableSheetContent({
    super.key,
    required this.child,
    this.showHandle = false,
    this.padding = EdgeInsets.zero,
    this.borderRadius,
  });
  final Widget child;
  final bool showHandle;
  final EdgeInsets padding;
  final BorderRadiusGeometry? borderRadius;
  @override
  Widget build(BuildContext context) {
    Future<void> onPopInvoked(bool didPop, Object? result) async {
      if (didPop) {
        return;
      } else {
        Navigator.pop(context);
        return;
      }
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: onPopInvoked,
      child: SheetKeyboardDismissible(
        dismissBehavior: const SheetKeyboardDismissBehavior.onDragDown(
          isContentScrollAware: true,
        ),
        child: Sheet(
          scrollConfiguration: const SheetScrollConfiguration(),
          decoration: MaterialSheetDecoration(
            size: SheetSize.stretch,
            color: Theme.of(context).colorScheme.secondaryContainer,
            clipBehavior: Clip.antiAlias,
            shape: ContinuousRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(12.w),
            ),
          ),
          child: SheetContentScaffold(
            bottomBarVisibility: const BottomBarVisibility.always(
              ignoreBottomInset: true,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Gap(4.w),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
