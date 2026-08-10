import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/pagin_list_view.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/features/car/application/car_controller.dart';
import 'package:kcars/features/car/application/car_states.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/car_post.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:kcars/features/car/presentation/riverpod/company_cars.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:collection/collection.dart';

@RoutePage()
class CompanyCarsScreen extends ConsumerWidget {
  const CompanyCarsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyCars = ref.watch(companyCarsProvider);

    ref.listen(carControllerProvider, (prev, next) {
      if (next is DeleteCarFailed) {
        showCustomAlert(context, content: next.message);
      }
      if (next is DeleteCarCompleted) {
        showMessages(context, message: LocaleKeys.alertMessages_deleted.tr());
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.screens_cars.tr()),
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        leading: const CustomBackButton(),
      ),
      body: PagingSliverList(
        onRefresh: () async =>
            ref.read(companyCarsProvider.notifier).loadInitial(),
        onLoadMore: () {
          ref.read(companyCarsProvider.notifier).loadMore();
        },
        state: companyCars,
        itemBuilder: (itemBuilder, car, index) {
          return CarsWidget(car: car);
        },
      ),
    );
  }
}

class CarsWidget extends ConsumerWidget {
  const CarsWidget({
    super.key,
    required this.car,
    this.isAdmin = false,
    this.isFeatured = false,
  });
  final Car car;
  final bool isAdmin;
  final bool isFeatured;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rentPlan = car.rentalPlan?.firstWhereOrNull(
      (e) => e.periodType == car.displayPlan,
    );
    return GestureDetector(
      onTap: () {
        showCustomBottomSheet(
          context,
          ListView(
            shrinkWrap: true,
            children: [
              if (!isFeatured) ...[
                ListTile(
                  title: Text(LocaleKeys.buttons_update.tr()),
                  onTap: () {
                    context.router.push(NewEditCarRoute(car: car));
                  },
                ),
                ListTile(
                  title: Text(LocaleKeys.buttons_delete.tr()),
                  onTap: () {
                    Navigator.pop(context);
                    showCustomAlert(
                      context,
                      isDeleting: true,
                      content: LocaleKeys.alertMessages_deleteCar.tr(),
                      closeButton: true,
                      primaryAction: () {
                        ref
                            .read(carControllerProvider.notifier)
                            .deleteCar(car.id);
                      },
                    );
                  },
                ),
                if (car.featuredCars == null)
                  ListTile(
                    title: Text(LocaleKeys.buttons_addToFeature.tr()),
                    onTap: () {
                      context.router.push(NewEditFeaturedRoute(car: car));
                    },
                  ),
                if (isAdmin) ...[
                  ListTile(
                    title: Text(LocaleKeys.buttons_Slider.tr()),
                    onTap: () {
                      context.router.push(
                        NewSliderRoute(carId: car.id, type: SlideType.car),
                      );
                    },
                  ),
                ],
              ],
              if (isAdmin && isFeatured) ...[
                if (car.featuredCars != null)
                  ListTile(
                    title: Text(LocaleKeys.buttons_deleteFeatured.tr()),
                    onTap: () {
                      showCustomAlert(
                        context,
                        content: LocaleKeys.alertMessages_deleteFeaturedCar
                            .tr(),
                        primaryAction: () {
                          Navigator.pop(context);
                          ref
                              .read(carControllerProvider.notifier)
                              .deleteFaturedCar(car);
                        },
                      );
                    },
                  ),
              ],
            ],
          ),
        );
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(2.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (car.images?.isNotEmpty ?? false)
              ImageHolder(
                image: car.images?.first.image,
                width: 30.w,
                height: 20.w,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(2.w),
              ),
            Gap(2.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(car.title, style: context.label2SemiBold),
                  Gap(2.w),
                  Wrap(
                    spacing: 1.w,
                    children: [
                      Text("${car.feature?.year} - ", style: context.caption),
                      Text(
                        "${car.feature?.fuel?.getFuel() ?? ''} -",
                        style: context.caption,
                      ),
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
                          style: context.caption,
                        ),
                      ],
                    ),
                    style: context.caption,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (car.carId == null) return;
                    await Clipboard.setData(
                      ClipboardData(text: car.carId?.formatOrderId()),
                    );
                    showMessages(
                      context,
                      message: LocaleKeys.alertMessages_copied.tr(),
                    );
                  },
                  child: Text(car.carId?.formatOrderId() ?? ""),
                ),
                if (!isAdmin)
                  Checkbox.adaptive(
                    value: car.available,
                    onChanged: (v) {
                      ref
                          .read(carControllerProvider.notifier)
                          .updateCar(
                            CarPost(
                              car: CarUpdate(
                                id: car.id,
                                available: !car.available!,
                              ),
                            ),
                            car.copyWith(available: !car.available!),
                          );
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
