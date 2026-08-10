import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/custom_tabbar.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/core/widget/loading_emoty_state.dart';
import 'package:kcars/features/auth/presentation/riverpod/is_logged_in.dart';
import 'package:kcars/features/car/data/model/brand.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/presentation/riverpod/brand_cars.dart';
import 'package:kcars/features/car/presentation/widget/favroite_button.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:collection/collection.dart';

class BrandCarsView extends HookConsumerWidget {
  const BrandCarsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(brandCarsProvider);
    final locale = useMemoized(() => context.locale.toLanguageTag(), [
      context.locale,
    ]);

    return SizedBox(
      height: 66.w,
      child: data.when(
        data: (data) {
          return data.isEmpty
              ? EmptyWidget(icon: AppIcons.noCars)
              : CarTabsView(brands: data, locale: locale);
        },
        error: (error, st) => Center(child: Text(error.toString())),
        loading: () => CarTabsView(isSkeleton: true),
      ),
    );
  }
}

class CarTabsView extends HookConsumerWidget {
  final List<Brand>? brands;
  final bool isSkeleton;
  final String locale;
  const CarTabsView({
    super.key,
    this.brands,
    this.isSkeleton = false,
    this.locale = 'en',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final tabs = isSkeleton
        ? ['Toyota', 'Nissan', 'Huuda']
        : brands!.map((b) => b.getTitle(locale)).toList();
    final tabControlelr = useTabController(
      initialLength: tabs.length,
      keys: [
        ValueKey(tabs.length),
        [locale],
      ],
    );

    return Column(
      children: [
        Skeletonizer(
          enabled: isSkeleton,
          child: CustomTabbar(
            key: ValueKey(locale),
            isScrollable: true,
            controller: tabControlelr,
            tabs: isSkeleton
                ? tabs.map((b) => Tab(text: b)).toList()
                : brands!.map((b) => Tab(text: b.getTitle(locale))).toList(),
          ),
        ),
        Gap(2.w),
        Expanded(
          child: TabBarView(
            controller: tabControlelr,
            children: List.generate(tabs.length, (i) {
              final cars = isSkeleton
                  ? List.filled(3, null)
                  : brands?[i].cars ?? [];
              if (cars.isEmpty) {
                return EmptyWidget(
                  icon: AppIcons.noCars,
                  emptyMessage: LocaleKeys.empty_cars.tr(),
                );
              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cars.length,
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                itemBuilder: (_, index) {
                  final car = cars[index];
                  return CarCard(
                    car: car,
                    isSkeleton: isSkeleton,
                    brandId: isSkeleton ? null : brands?[i].id,
                    isLoggedIn: isLoggedIn,
                    locale: locale,
                  );
                },
              );
            }),
          ),
        ),
      ],
    );
  }
}

class CarCard extends StatelessWidget {
  final Car? car;
  final bool isSkeleton;
  final String? brandId;
  final bool isLoggedIn;
  final String locale;
  const CarCard({
    super.key,
    this.car,
    this.isSkeleton = false,
    this.brandId,
    this.isLoggedIn = false,
    this.locale = 'en',
  });

  @override
  Widget build(BuildContext context) {
    final rentPlan = car?.rentalPlan?.firstWhereOrNull(
      (plan) => plan.periodType == car!.displayPlan,
    );
    return Skeletonizer(
      enabled: isSkeleton,
      child: GestureDetector(
        onTap: () {
          if (car != null) {
            context.router.push(CarDetailsRoute(carId: car!.carId ?? ""));
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 0.7.w),
          width: 94.w,
          height: 54.w,

          child: Stack(
            children: [
              ImageHolder(
                image: isSkeleton ? null : car!.images?.first.image,
                width: 94.w,
                height: 54.w,
                borderRadius: BorderRadius.circular(6.w),
                fit: BoxFit.cover,
                isLoading: isSkeleton,
              ),
              if (!isSkeleton)
                Container(
                  width: 94.w,
                  height: 54.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(6.w),
                    ),
                    gradient: const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.0, 0.35, 0.6, 1.0],
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0.70),
                        Color.fromRGBO(0, 0, 0, 0.50),
                        Color.fromRGBO(0, 0, 0, 0.15),
                        Color.fromRGBO(0, 0, 0, 0.0),
                      ],
                    ),
                  ),
                ),
              Positioned(
                bottom: 0.w,
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: SizedBox(
                    width: 86.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.ideographic,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isSkeleton ? "Loading..." : car!.title,
                                style: context.title3SemiBold.copyWith(
                                  color: context.surface,
                                ),
                                maxLines: 2,
                              ),
                              Gap(1.w),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    isSkeleton
                                        ? "2020"
                                        : "${car!.feature?.year ?? '–'}",
                                    style: context.label.copyWith(
                                      color: context.surface,
                                    ),
                                  ),
                                  Gap(1.w),
                                  Text(
                                    isSkeleton
                                        ? "- automatic"
                                        : "- ${car!.feature?.transmission?.transmissionType() ?? ''}",
                                    style: context.label.copyWith(
                                      color: context.surface,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(1.w),
                              Text.rich(
                                TextSpan(
                                  text:
                                      "${isSkeleton ? "0" : rentPlan?.price.forMatNumber() ?? ""} ${isSkeleton ? "IQD" : rentPlan?.currency?.getCurrency() ?? ''}",
                                  children: [
                                    TextSpan(
                                      text:
                                          " - ${isSkeleton ? "Hourly" : rentPlan?.periodType.periodPerType() ?? ''}",
                                      style: context.label.copyWith(
                                        color: context.surface,
                                      ),
                                    ),
                                  ],
                                ),
                                style: context.label.copyWith(
                                  color: context.surface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (!isSkeleton)
                PositionedDirectional(
                  top: 4.w,
                  start: 6.w,
                  child: FavoriteButton(
                    isFavorited: car?.isFavorite == true,
                    car: car,
                    brandId: brandId,
                    isLoggedIn: isLoggedIn,
                  ),
                ),
              if (car?.featuredCars != null)
                PositionedDirectional(
                  top: 4.w,
                  end: 4.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                      vertical: 0.5.w,
                    ),
                    decoration: BoxDecoration(
                      color: context.surfaceTint,
                      borderRadius: BorderRadiusDirectional.circular(100.w),
                    ),
                    child: Text(
                      LocaleKeys.labels_featured.tr(),
                      style: context.caption.copyWith(
                        color: context.surface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
