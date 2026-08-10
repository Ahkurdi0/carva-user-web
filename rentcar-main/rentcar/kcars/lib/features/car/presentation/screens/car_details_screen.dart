import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/configs/image_type.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/launch_links.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/core/widget/profile_container.dart';
import 'package:kcars/features/booking/presentation/application/book_controller.dart';
import 'package:kcars/features/booking/presentation/application/book_states.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/presentation/riverpod/details_car.dart';
import 'package:kcars/features/car/presentation/views/carousal_slider_view.dart';
import 'package:kcars/features/car/presentation/widget/custom_sheet.dart';
import 'package:kcars/features/company/data/model/contact_statistic.dart';
import 'package:kcars/features/company/data/model/enums.dart';
import 'package:kcars/features/company/presentation/views/contacts_view.dart';
import 'package:kcars/features/company/presentation/views/map_viwe.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class CarDetailsScreen extends ConsumerWidget {
  const CarDetailsScreen({super.key, required this.carId});
  final String carId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carDetails = ref.watch(detailsCarProvider(carId));
    final bookController = ref.watch(bookControllerProvider);
    ref.listen(bookControllerProvider, (prev, next) {
      if (next is ContactFailed) {
        showMessages(context, message: next.message);
      }
      if (next is ContactCompleted) {
        if (next.result != null && next.result!.isNotEmpty) {
          openLinks(appLink: next.result!, webLink: next.result!);
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(
          onPressed: () {
            final canPop = context.router.canPop();
            if (canPop) {
              context.router.pop();
            } else {
              context.router.replaceAll([WelcomeRoute()]);
            }
          },
        ),
        forceMaterialTransparency: true,
        title: Text(LocaleKeys.screens_detailsCars.tr()),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          carDetails.when(
            data: (data) {
              return CarDetailsView(car: data);
            },
            error: (error, stackTrace) => SliverFillRemaining(
              child: Center(child: Text(error.toString())),
            ),
            loading: () => CarDetailsView(isLoading: true),
          ),
        ],
      ),
      bottomSheet: Container(
        height: 24.w,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: context.surface,
          border: Border(top: BorderSide(width: .1, color: context.outline)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.w).copyWith(top: 3.w),
        child: carDetails.when(
          data: (currentCar) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryButton(
                color: context.surfaceTint,
                width: 54.w,
                icon: AppIcons.whatsapp,
                iconColor: context.surface,
                isLoading: bookController is ContactLoading,
                text: LocaleKeys.buttons_whatsapp.tr(),
                onPress: () {
                  ref
                      .read(bookControllerProvider.notifier)
                      .contact(
                        ContactStatistic(
                          companyId: currentCar.company?.id,
                          type: ContactTypes.whatsapp,
                          carId: currentCar.id,
                        ),
                      );
                },
              ),
              Gap(2.w),
              SecondaryButton(
                borderRadius: BorderRadius.circular(100.w),
                height: 12.w,
                width: 34.w,
                text: LocaleKeys.buttons_contact.tr(),
                color: context.secondaryContainer,
                icon: AppIcons.call,
                iconColor: context.onSurface,
                onPress: () {
                  showSheeet(
                    context,
                    ScrollableSheetContent(
                      showHandle: true,
                      child: ContactsView(
                        contacts: currentCar.company?.contacts ?? [],
                        companyId: currentCar.company?.id ?? "",
                        carId: currentCar.id,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          loading: () => Skeletonizer.zone(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Bone(
                  width: 42.w,
                  height: 12.w,
                  borderRadius: BorderRadius.circular(100.w),
                ),
                Bone(
                  width: 48.w,
                  height: 12.w,
                  borderRadius: BorderRadius.circular(100.w),
                ),
              ],
            ),
          ),
          error: (s, t) => SizedBox.shrink(),
        ),
      ),
    );
  }
}

class CarDetailsView extends StatelessWidget {
  const CarDetailsView({super.key, this.car, this.isLoading = false});
  final Car? car;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer.sliver(
      enabled: isLoading,
      child: SliverPadding(
        padding: EdgeInsets.only(bottom: 30.w),
        sliver: SliverList(
          delegate: SliverChildListDelegate([
            Container(
              height: 50.w,
              decoration: BoxDecoration(),
              child: isLoading
                  ? Skeleton.leaf(
                      child: EmptySlider(width: 92.w, height: 50.w),
                    )
                  : CarousalView(
                      sliders: isLoading ? [] : car?.images ?? [],
                      imageWidth: 92.w,
                    ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(2.w),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          isLoading ? "Toyotoa camery" : car?.title ?? "",
                          style: context.title2Bold,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  Gap(6.w),
                  Skeleton.keep(
                    child: Text(
                      LocaleKeys.labels_features.tr(),
                      style: context.label2,
                    ),
                  ),
                  Gap(6.w),
                  Skeletonizer(
                    enabled: isLoading,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Wrap(
                        runSpacing: 4.w,
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          FeatureWidget(
                            icon: AppIcons.engine,
                            title: LocaleKeys.labels_engineCC.tr(),
                            badge: LocaleKeys.labels_litter.tr(),
                            value:
                                "${isLoading ? "2.5 Litter" : car?.feature?.engCC}",
                            isSkeleton: isLoading,
                          ),
                          FeatureWidget(
                            icon: AppIcons.engine,
                            title: LocaleKeys.labels_horsePower.tr(),
                            value: "${isLoading ? "200" : car?.feature?.hp}",
                            isSkeleton: isLoading,
                          ),
                          FeatureWidget(
                            icon: AppIcons.cylinder,
                            title: LocaleKeys.labels_cylinders.tr(),
                            value:
                                "${isLoading ? "4" : car?.feature?.cylinders}",
                            isSkeleton: isLoading,
                          ),
                          FeatureWidget(
                            icon: AppIcons.transmission,
                            title: LocaleKeys.labels_transmission.tr(),
                            value:
                                "${isLoading ? "Daily" : car?.feature?.transmission?.transmissionType()}",
                            isSkeleton: isLoading,
                          ),

                          FeatureWidget(
                            icon: AppIcons.speed,
                            title: LocaleKeys.labels_speed.tr(),
                            badge: LocaleKeys.labels_kmH.tr(),
                            value:
                                "${isLoading ? "250 Km" : car?.feature?.speed}",
                            isSkeleton: isLoading,
                          ),

                          FeatureWidget(
                            icon: AppIcons.odometer,
                            title: LocaleKeys.labels_odometer.tr(),
                            badge: LocaleKeys.labels_km.tr(),
                            value:
                                "${isLoading ? "1200" : car?.feature?.odometer}",
                            isSkeleton: isLoading,
                          ),
                          FeatureWidget(
                            icon: AppIcons.fuel,
                            title: LocaleKeys.labels_fuel.tr(),
                            value:
                                "${isLoading ? "Diseal" : car?.feature?.fuel?.getFuel()}",
                            isSkeleton: isLoading,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(4.w),
                  Divider(color: context.outline, thickness: 0.1),
                  Gap(4.w),
                  Skeleton.keep(
                    child: Text(
                      LocaleKeys.labels_plans.tr(),
                      style: context.label2,
                    ),
                  ),
                  Gap(6.w),
                  Wrap(
                    runSpacing: 2.w,
                    spacing: 2.w,
                    alignment: WrapAlignment.spaceBetween,
                    children: isLoading
                        ? [
                            PlanWidget(
                              icon: AppIcons.hourly,
                              title: "Per Hours",
                              value: "10,000",
                              isLoading: isLoading,
                              type: "hour",
                            ),
                            PlanWidget(
                              icon: AppIcons.hourly,
                              title: "Per Hours",
                              value: "10,000",
                              isLoading: isLoading,
                              type: "hour",
                            ),
                            PlanWidget(
                              icon: AppIcons.monthly,
                              title: "Per Month",
                              value: "250,000",
                              isLoading: isLoading,
                              type: "month",
                            ),
                          ]
                        : car?.rentalPlan?.map((rent) {
                                return PlanWidget(
                                  icon:
                                      "assets/icons/${rent.periodType.name}.svg",
                                  title: "Per ${rent.periodType.name}",
                                  value:
                                      "${rent.price.forMatNumber()} ${rent.currency?.getCurrency() ?? ""}",
                                  isLoading: isLoading,
                                  type: rent.periodType.periodType(),
                                );
                              }).toList() ??
                              [],
                  ),
                  Gap(6.w),
                  if (!isLoading || car != null) ...[
                    Text(
                      LocaleKeys.labels_providedBy.tr(),
                      style: context.label2Bold,
                    ),
                    Gap(4.w),
                    GestureDetector(
                      onTap: () {
                        context.router.push(
                          CompanyDetailsRoute(companyId: car!.company!.id),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 2.w,
                        ),
                        decoration: BoxDecoration(
                          color: context.secondaryContainer,
                          border: Border.all(
                            width: 0.1,
                            color: context.outline,
                          ),
                          borderRadius: BorderRadius.circular(4.w),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ProfileContainer(
                                    child: ImageHolder(
                                      image: car?.company?.image,
                                      type: ImageType.company,
                                      width: 10.w,
                                      height: 10.w,
                                      fit: BoxFit.cover,
                                      borderRadius: BorderRadius.circular(
                                        100.w,
                                      ),
                                    ),
                                  ),
                                  Gap(4.w),
                                  Expanded(
                                    child: Text(
                                      car?.company?.name ?? "",
                                      style: context.bodySemiBild,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gap(2.w),

                            Text(LocaleKeys.buttons_seedMore.tr()),
                            Gap(2.w),
                            Icon(Icons.arrow_forward_ios_rounded, size: 4.w),
                          ],
                        ),
                      ),
                    ),
                    if (car?.location != null) ...[
                      Gap(6.w),
                      Text(
                        LocaleKeys.labels_location.tr(),
                        style: context.label2Bold,
                      ),
                      Gap(6),
                      Container(
                        height: 40.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.w),
                        ),
                        clipBehavior: Clip.hardEdge, // or Clip.none if needed
                        child: MapView(
                          latLang: LatLng(
                            car!.location!.lat!,
                            car!.location!.long!,
                          ),
                          image: car?.images?.first.image,
                        ),
                      ),
                    ],
                    Gap(6.w),
                  ],
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class FeatureWidget extends StatelessWidget {
  const FeatureWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
    required this.isSkeleton,
    this.badge,
  });
  final String title;
  final String icon;
  final String value;
  final bool isSkeleton;
  final String? badge;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isSkeleton,
      child: SizedBox(
        width: 42.w,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isSkeleton ? Bone.circle(size: 6.2.w) : IconLoadaer(icon),
            Gap(6.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: value,
                    children: [
                      if (badge != null)
                        TextSpan(
                          text: " $badge",
                          style: context.label.copyWith(color: context.outline),
                        ),
                    ],
                  ),
                  style: context.bodySemiBild,
                ),
                Text(
                  title,
                  style: context.body.copyWith(color: context.outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PlanWidget extends StatelessWidget {
  const PlanWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
    required this.type,
    this.isLoading = false,
    this.isSelected = true,
    this.onTap,
  });
  final String title;
  final String icon;
  final String value;
  final String type;
  final bool isLoading;
  final bool isSelected;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final interactive = isSelected && onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45.w,
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: interactive
              ? context.primaryContainer
              : context.secondaryContainer,
          borderRadius: BorderRadius.circular(100.w),
          border: Border.all(
            width: 0.2,
            color: interactive ? context.primary : context.outline,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isLoading
                ? Bone.circle(size: 6.2.w)
                : IconLoadaer(
                    icon,
                    color: interactive ? context.primary : null,
                  ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text.rich(
                  TextSpan(
                    text: value,
                    style: context.bodySemiBild.copyWith(
                      color: interactive ? context.primary : null,
                    ),
                    children: [
                      TextSpan(
                        text: "/$type",
                        style: context.overline.copyWith(
                          color: interactive ? context.primary : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
