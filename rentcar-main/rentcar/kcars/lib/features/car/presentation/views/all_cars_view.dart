import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/core/widget/loading_emoty_state.dart';
import 'package:kcars/features/auth/presentation/riverpod/is_logged_in.dart';
import 'package:kcars/features/car/application/car_states.dart';
import 'package:kcars/features/car/application/load_more_cars.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/presentation/riverpod/cars.dart';
import 'package:flutter/rendering.dart';
import 'package:kcars/features/car/presentation/widget/favroite_button.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:collection/collection.dart';

class AllCarsView extends HookConsumerWidget {
  const AllCarsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCars = ref.watch(carsProvider);
    final loadMore = ref.watch(loadMoreCarsProvider);
    final isLogged = ref.watch(isLoggedInProvider);
    return asyncCars.when(
      data: (cars) {
        return SliverPadding(
          padding: EdgeInsets.only(bottom: 40.w),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index < cars.cars.length) {
                  return CarsWidget(
                    car: cars.cars[index],
                    isLoggedIn: isLogged,
                  );
                }

                // Footer loader if loading more
                if (loadMore is LoadMoreCarsLoading) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircleLoading()),
                  );
                }

                return const SizedBox.shrink();
              },
              childCount:
                  cars.cars.length + (loadMore is LoadMoreCarsLoading ? 1 : 0),
            ),
          ),
        );
      },
      loading: () => const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (e, _) => SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(child: Text(e.toString())),
        ),
      ),
    );
  }
}

bool onScrollNotifications(
  UserScrollNotification notification,
  VoidCallback loadMore,
  bool isLoading,
) {
  // Prevent triggering load more when scrolling up or bouncing at top
  final metrics = notification.metrics;
  final isBottom = metrics.pixels >= metrics.maxScrollExtent - 50;

  if (notification.direction == ScrollDirection.reverse &&
      isBottom &&
      !isLoading) {
    loadMore();
  }

  return false;
}

class CarsWidget extends ConsumerWidget {
  const CarsWidget({super.key, required this.car, this.isLoggedIn = false});
  final Car car;
  final bool isLoggedIn;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rentPlan = car.rentalPlan?.firstWhereOrNull(
      (plan) => plan.periodType == car.displayPlan,
    );
    return GestureDetector(
      onTap: () {
        context.router.push(CarDetailsRoute(carId: car.carId ?? ""));
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(2.w),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(24, 37, 94, 0.20),
                        blurRadius: 10,
                        spreadRadius: -2,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ImageHolder(
                    image: car.images?.first.image,
                    width: 46.w,
                    height: 26.w,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                ),
                PositionedDirectional(
                  top: 1.w,
                  start: 2.w,
                  child: FavoriteButton(
                    isFavorited: car.isFavorite == true,
                    car: car,
                    brandId: car.brand?.id,
                    isLoggedIn: isLoggedIn,
                  ),
                ),
              ],
            ),
            Gap(2.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (car.featuredCars != null) ...[
                  Container(
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
                  Gap(2.w),
                ],
                Text(car.title, style: context.label2SemiBold),
                Gap(2.w),
                Wrap(
                  spacing: 1.w,
                  children: [
                    Text("${car.feature?.year} -", style: context.caption),
                    Text(
                      car.feature?.transmission?.transmissionType() ?? '',
                      style: context.caption,
                    ),
                  ],
                ),
                Text.rich(
                  TextSpan(
                    text:
                        "${rentPlan?.price.forMatNumber() ?? ""} ${rentPlan?.currency?.getCurrency() ?? ''}",
                    children: [
                      TextSpan(
                        text:
                            " - ${rentPlan?.periodType.periodPerType() ?? ''}",
                        style: context.overline,
                      ),
                    ],
                  ),
                  style: context.overline,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
