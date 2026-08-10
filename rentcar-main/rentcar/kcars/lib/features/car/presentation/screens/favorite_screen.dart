import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/configs/image_type.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/pagin_list_view.dart';
import 'package:kcars/core/widget/app_bar.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/features/auth/presentation/riverpod/is_logged_in.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/presentation/riverpod/favorite_cars.dart';
import 'package:kcars/features/car/presentation/widget/favroite_button.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:collection/collection.dart';

@RoutePage()
class FavoriteScreen extends StatefulHookConsumerWidget {
  const FavoriteScreen({super.key});
  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final carsData = ref.watch(favoriteCarsProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    return Scaffold(
      appBar: HomeAppBar(),
      body: PagingSliverList<Car>(
        padding: EdgeInsets.only(bottom: 30.w),
        onRefresh: () => ref.read(favoriteCarsProvider.notifier).loadInitial(),
        emptyMessage: LocaleKeys.empty_emptyFavorite.tr(),
        state: carsData,
        onLoadMore: () {
          ref
              .read(favoriteCarsProvider.notifier)
              .loadMore(carsData.items.last.id);
        },
        itemBuilder: (context, car, index) =>
            FavoriteCarCard(car: car, isLoggedIn: isLoggedIn),
        initalLoadingWidget: ListView.builder(
          itemCount: 2,
          itemBuilder: (_, __) => FavoriteCarCard(isSkeleton: true),
        ),
      ),
    );
  }
}

class FavoriteCarCard extends StatelessWidget {
  final Car? car;
  final bool isSkeleton;
  final String? brandId;
  final bool isLoggedIn;

  const FavoriteCarCard({
    super.key,
    this.car,
    this.isSkeleton = false,
    this.brandId,
    this.isLoggedIn = false,
  });

  @override
  Widget build(BuildContext context) {
    final rentPlan = car?.rentalPlan?.firstWhereOrNull(
      (plan) => plan.periodType == car?.displayPlan,
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
          padding: EdgeInsets.symmetric(
            horizontal: 2.w,
          ).copyWith(bottom: 4.w, top: 2.w),
          margin: EdgeInsets.symmetric(horizontal: 4.w).copyWith(bottom: 8.w),
          decoration: BoxDecoration(
            color: context.secondaryContainer,
            border: Border.all(width: 0.5, color: context.surfaceContainerLow),
            borderRadius: BorderRadius.circular(6.w),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  ImageHolder(
                    image: isSkeleton ? null : car!.images?.first.image,
                    type: ImageType.car,
                    width: 100.w,
                    height: 50.w,
                    borderRadius: BorderRadius.circular(4.w),
                    fit: BoxFit.cover,
                    isLoading: isSkeleton,
                  ),
                  if (!isSkeleton)
                    PositionedDirectional(
                      top: 4.w,
                      start: 6.w,
                      child: FavoriteButton(
                        isFavorited: car!.isFavorite == true,
                        car: car,
                        brandId: brandId ?? car?.brand?.id,
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
              Gap(2.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isSkeleton ? "Loading..." : car?.title ?? "",
                            style: context.label2SemiBold,
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
                                style: context.label,
                              ),
                              Gap(1.w),
                              Text(
                                isSkeleton
                                    ? "- automatic"
                                    : "- ${car!.feature?.transmission?.transmissionType() ?? ''}",
                                style: context.caption,
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
                                  style: context.caption,
                                ),
                              ],
                            ),
                            style: context.caption,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
