// ignore_for_file: unused_result

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/providers/shee_controller.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/permissions.dart';
import 'package:kcars/core/widget/app_bar.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/features/app_settings/presentation/riverpod/sliders.dart';
import 'package:kcars/features/auth/presentation/riverpod/is_logged_in.dart';
import 'package:kcars/features/car/application/car_states.dart';
import 'package:kcars/features/car/application/load_more_cars.dart';
import 'package:kcars/features/car/presentation/riverpod/brand_cars.dart';
import 'package:kcars/features/car/presentation/riverpod/cars.dart';
import 'package:kcars/features/car/presentation/riverpod/recently_viewed.dart';
import 'package:kcars/features/car/presentation/riverpod/suggested_controller.dart';
import 'package:kcars/features/car/presentation/views/all_cars_view.dart';
import 'package:kcars/features/car/presentation/views/brand_cars_view.dart';
import 'package:kcars/features/car/presentation/views/filters_data_view.dart';
import 'package:kcars/features/car/presentation/views/nearbay_cars_view.dart';
import 'package:kcars/features/car/presentation/views/recently_views_cars_view.dart';
import 'package:kcars/features/car/presentation/views/sliders_view.dart';
import 'package:kcars/features/car/presentation/views/suggested_cars_view.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

@RoutePage()
class CarsScreen extends HookConsumerWidget {
  const CarsScreen({super.key, this.isLogged = true});
  final bool isLogged;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sheetController = DefaultSheetController.of(context);
    final isLogged = ref.watch(isLoggedInProvider);
    final loadMore = ref.watch(loadMoreCarsProvider);

    useMemoized(() => notificaPermission(context), []);

    return Scaffold(
      appBar: HomeAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.refresh(suggestedCarProvider().future);
          await ref.refresh(brandCarsProvider.future);
          await ref.refresh(allSlidersProvider.future);
          await ref.refresh(carsProvider.future);
          if (isLogged) {
            await ref.refresh(recentlyViwedCarProvider.future);
          }
        },

        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) =>
              onScrollNotifications(notification, () {
                ref.read(carsProvider.notifier).loadMoreCars();
              }, loadMore is LoadMoreCarsLoading),

          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SuggestedCarsView()),
              SliverToBoxAdapter(child: BrandCarsView()),
              SliverToBoxAdapter(child: Gap(4.w)),
              SliverToBoxAdapter(child: SlidesViwe()),
              SliverToBoxAdapter(child: Gap(4.w)),
              SliverToBoxAdapter(child: RenecentlyViewdCarsView()),
              SliverToBoxAdapter(child: NearbayCarsView()),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    LocaleKeys.labels_cars.tr(),
                    style: context.label2Bold,
                  ),
                ),
              ),
              AllCarsView(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _MapButton(sheetController),
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

class _MapButton extends ConsumerWidget {
  const _MapButton(this.sheetController);
  final SheetController sheetController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conroller = ref.watch(sheetControllerProvider);

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
          onPressed: () {
            context.router.push(FilterRoute());
          },
          icon: IconLoadaer(
            AppIcons.search,
            color: context.surface,
            width: 5.w,
          ),
          label: Text(LocaleKeys.buttons_search.tr()),
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
