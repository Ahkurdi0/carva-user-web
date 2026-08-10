import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/configs/image_type.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/post_location.dart';
import 'package:kcars/features/car/presentation/widget/favroite_button.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:collection/collection.dart';

class CarWidget extends StatelessWidget {
  const CarWidget({
    super.key,
    this.cars,
    this.isSkeleton = false,
    this.param,
    this.isLoggedIn = false,
  });

  final List<Car>? cars;
  final bool isSkeleton;
  final PostLocation? param;
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    final itemCount = isSkeleton ? 3 : cars?.length ?? 0;

    return Expanded(
      child: Skeletonizer(
        enabled: isSkeleton,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            final car = isSkeleton ? null : cars![index];
            final rentPlan = car?.rentalPlan?.firstWhereOrNull(
              (plan) => plan.periodType == car.displayPlan,
            );
            return GestureDetector(
              onTap: () {
                if (car != null) {
                  context.router.push(CarDetailsRoute(carId: car.carId ?? ""));
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 0.8.w),
                width: 46.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            boxShadow: isSkeleton
                                ? null
                                : [
                                    BoxShadow(
                                      color: Color.fromRGBO(24, 37, 94, 0.20),
                                      blurRadius: 10,
                                      spreadRadius: -2,
                                      offset: Offset(0, 8),
                                    ),
                                  ],
                          ),
                          child: ImageHolder(
                            image: isSkeleton ? null : car?.images?.first.image,
                            type: ImageType.car,
                            fit: BoxFit.cover,
                            width: 46.w,
                            height: 36.w,
                            isLoading: isSkeleton,
                          ),
                        ),
                        if (!isSkeleton && car != null)
                          PositionedDirectional(
                            top: 2.w,
                            start: 4.w,
                            child: FavoriteButton(
                              isFavorited: car.isFavorite == true,
                              car: car,
                              brandId: car.brand?.id,
                              param: param,
                              isLoggedIn: isLoggedIn,
                            ),
                          ),

                        if (car?.featuredCars != null)
                          PositionedDirectional(
                            top: 1.w,
                            end: 1.w,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.w,
                                vertical: 0.5.w,
                              ),
                              decoration: BoxDecoration(
                                color: context.surfaceTint,
                                borderRadius: BorderRadiusDirectional.circular(
                                  100.w,
                                ),
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
                    Gap(1.w),
                    Text(
                      isSkeleton ? "Car Title" : car!.title,
                      style: context.label.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                    ),
                    Gap(1.w),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isSkeleton ? "2020" : "${car!.feature?.year}",
                          style: context.overline,
                        ),
                        Text(
                          " - ${isSkeleton ? "Automatic" : car!.feature?.transmission?.transmissionType() ?? ''}",
                          style: context.overline,
                        ),
                      ],
                    ),
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
            );
          },
        ),
      ),
    );
  }
}
