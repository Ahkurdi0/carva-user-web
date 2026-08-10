import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/features/car/presentation/riverpod/filter_cars.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class SheetContent extends HookConsumerWidget {
  const SheetContent({super.key, required this.child, this.bottomBar});
  final Widget child;
  final Widget? bottomBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cars = ref.watch(filtersCarsProvider());
    const minSize = SheetOffset(0.6);
    const halfSize = SheetOffset(0.6);
    const fullSize = SheetOffset(.6);

    return NotificationListener<SheetDragUpdateNotification>(
      onNotification: (notification) {
        final metrics = notification.metrics;
        if (notification.dragDetails.deltaY > 0 &&
            metrics.offset <= metrics.minOffset + 0.5) {
          Navigator.of(context).maybePop();
          return true;
        }
        return false;
      },
      child: Sheet(
        initialOffset: halfSize,
        scrollConfiguration: const SheetScrollConfiguration(
          scrollSyncMode: SheetScrollHandlingBehavior.always,
          thresholdVelocityToInterruptBallisticScroll: 0.5,
        ),
        decoration: MaterialSheetDecoration(
          color: context.surface,
          size: SheetSize.stretch,
          clipBehavior: Clip.antiAlias,
          elevation: 8,
          borderRadius: BorderRadius.vertical(top: Radius.circular(6.w)),
        ),
        snapGrid: const SheetSnapGrid(snaps: [minSize, halfSize, fullSize]),
        child: SheetContentScaffold(
          backgroundColor: Colors.transparent,
          bottomBarVisibility: BottomBarVisibility.conditional(
            isVisible: (m) => m.offset >= const SheetOffset(0.6).resolve(m),
          ),
          extendBodyBehindBottomBar: true,
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
              isLoading: cars.isLoading == true,
              text:
                  "${LocaleKeys.buttons_show.tr()} (${cars.items.length}) ${LocaleKeys.labels_carP.plural(cars.items.length).tr()} ",
              onPress: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(top: 3.w, bottom: 1.w),
                padding: EdgeInsets.only(bottom: 6.w),
                height: 1.w,
                width: 14.w,
                decoration: BoxDecoration(
                  color: context.outline,
                  borderRadius: BorderRadius.circular(100.w),
                ),
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
