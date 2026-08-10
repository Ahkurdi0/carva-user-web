import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/providers/shee_controller.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/pagin_list_view.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/features/auth/presentation/riverpod/is_logged_in.dart';
import 'package:kcars/features/car/presentation/riverpod/filter_cars.dart';
import 'package:kcars/features/car/presentation/screens/explorer_map_screen.dart';
import 'package:kcars/features/car/presentation/screens/favorite_screen.dart';
import 'package:kcars/features/car/presentation/views/filters_data_view.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

@RoutePage()
class FilterScreen extends HookConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sheetController = ref.watch(sheetControllerProvider);
    final systemUiInsets = MediaQuery.of(context).padding;
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop && sheetController.hasClient) {
          final metrics = sheetController.metrics;
          if (metrics != null) {
            sheetController.animateTo(
              SheetOffset.absolute(metrics.maxOffset),
              curve: Curves.fastOutSlowIn,
            );
          }
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          scrolledUnderElevation: 0,
          title: Text(LocaleKeys.screens_Search.tr()),
          leading: CustomBackButton(
            onPressed: () {
              if (sheetController.metrics case final metrics?) {
                sheetController.animateTo(
                  SheetOffset.absolute(metrics.maxOffset),
                  curve: Curves.fastOutSlowIn,
                );
              }
              context.router.maybePop();
            },
          ),
        ),
        body: Stack(
          children: [
            ExplorerMapScreen(),
            _ContentSheet(
              systemUiInsets: systemUiInsets,
              sheetController: sheetController,
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _MapButton(sheetController),
      ),
    );
  }
}

class _MapButton extends ConsumerWidget {
  const _MapButton(this.sheetController);
  final SheetController sheetController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conroller = ref.watch(sheetControllerProvider);

    void onPressed() {
      if (sheetController.metrics case final it?) {
        sheetController.animateTo(
          SheetOffset.absolute(it.minOffset),
          curve: Curves.fastOutSlowIn,
        );
      }
    }

    final result = Padding(
      padding: EdgeInsets.only(bottom: 20.w),
      child: SizedBox(
        height: 10.w,
        child: FloatingActionButton.extended(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.w),
          ),
          backgroundColor: context.secondary,
          onPressed: onPressed,
          icon: IconLoadaer(
            AppIcons.mapLocation,
            color: context.surface,
            width: 5.w,
          ),
          label: Text(LocaleKeys.buttons_map.tr()),
        ),
      ),
    );

    final animation = SheetOffsetDrivenAnimation(
      controller: conroller,
      initialValue: 1,
      startOffset: null,
      endOffset: null,
    ).drive(CurveTween(curve: Curves.easeInExpo));
    return ScaleTransition(
      scale: animation,
      child: FadeTransition(opacity: animation, child: result),
    );
  }
}

class _ContentSheet extends ConsumerWidget {
  const _ContentSheet({required this.systemUiInsets, this.sheetController});
  final SheetController? sheetController;
  final EdgeInsets systemUiInsets;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final parentHeight = constraints.maxHeight;
        final appbarHeight = MediaQuery.of(context).padding.top + 14.w;
        final handleHeight = const ContentSheetHandle().preferredSize.height;
        final sheetHeight = parentHeight - appbarHeight + handleHeight;
        final minSheetOffset = SheetOffset.absolute(
          handleHeight + systemUiInsets.bottom,
        );
        return SheetViewport(
          child: Sheet(
            controller: sheetController,
            scrollConfiguration: const SheetScrollConfiguration(
              scrollSyncMode: SheetScrollHandlingBehavior.always,
            ),

            snapGrid: SheetSnapGrid(
              snaps: [minSheetOffset, const SheetOffset(1)],
            ),
            decoration: MaterialSheetDecoration(
              size: SheetSize.stretch,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(4.w)),
              ),
            ),
            child: SizedBox(
              height: sheetHeight,
              child: const Column(
                children: [
                  ContentSheetHandle(),
                  Expanded(child: FileredCarsView()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class FileredCarsView extends HookConsumerWidget {
  const FileredCarsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searches = ref.watch(filtersCarsProvider());
    final isLoggedIn = ref.watch(isLoggedInProvider);
    return PagingSliverList(
      padding: EdgeInsets.only(bottom: 40.w),
      state: searches,
      onLoadMore: () {
        ref.read(filtersCarsProvider().notifier).loadMore();
      },
      itemBuilder: (context, car, index) =>
          FavoriteCarCard(car: car, isLoggedIn: isLoggedIn),
      initalLoadingWidget: ListView.builder(
        padding: EdgeInsets.only(bottom: 30.w),
        itemCount: 2,
        itemBuilder: (context, index) {
          return FavoriteCarCard(isSkeleton: true);
        },
      ),
    );
  }
}

class ContentSheetHandle extends StatelessWidget
    implements PreferredSizeWidget {
  const ContentSheetHandle({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: preferredSize,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            buildIndicator(),
            Gap(4.w),
            Expanded(child: FiltersDataView()),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() {
    return Container(
      height: 6,
      width: 40,
      decoration: const ShapeDecoration(
        color: Colors.black12,
        shape: StadiumBorder(),
      ),
    );
  }
}
