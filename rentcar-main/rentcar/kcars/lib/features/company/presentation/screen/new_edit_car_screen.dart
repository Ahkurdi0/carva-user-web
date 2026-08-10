import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/app_textfeild.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/features/car/application/car_controller.dart';
import 'package:kcars/features/car/application/car_states.dart';
import 'package:kcars/features/car/data/model/brand.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/car_location.dart';
import 'package:kcars/features/car/data/model/car_post.dart';
import 'package:kcars/features/car/data/model/car_type.dart';
import 'package:kcars/features/car/data/model/city.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:kcars/features/car/data/model/feature.dart';
import 'package:kcars/features/car/data/model/image.dart';
import 'package:kcars/features/car/data/model/rental_plan.dart';
import 'package:kcars/features/car/data/model/town.dart';
import 'package:kcars/features/car/presentation/riverpod/plans.dart';
import 'package:kcars/features/car/presentation/views/filters_data_view.dart';
import 'package:kcars/features/company/presentation/riverpod/towns.dart';
import 'package:kcars/features/company/presentation/views/picked_imaes.dart';
import 'package:kcars/features/company/presentation/views/town_goverment_brand_types.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class NewEditCarScreen extends HookConsumerWidget {
  const NewEditCarScreen({super.key, this.car});
  final Car? car;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = useMemoized(() => context.locale.toLanguageTag());
    final plans = ref.watch(plansProvider).asData?.value;
    final title = useTextEditingController(text: car?.title);
    final hp = useTextEditingController(text: car?.feature?.hp.toString());
    final speed = useTextEditingController(
      text: car?.feature?.speed.toString(),
    );
    final seat = useTextEditingController(text: car?.feature?.seat.toString());
    final year = useTextEditingController(text: car?.feature?.year.toString());
    final odometer = useTextEditingController(
      text: car?.feature?.odometer.toString(),
    );
    final cylinders = useTextEditingController(
      text: car?.feature?.cylinders.toString(),
    );
    final engCC = useTextEditingController(
      text: car?.feature?.engCC.toString(),
    );

    final fuel = useState<Fuel?>(car?.feature?.fuel);
    final transmission = useState<Transmission?>(car?.feature?.transmission);
    final type = useState<CarType?>(car?.type);
    final brand = useState<Brand?>(car?.brand);
    final city = useState<City?>(car?.location?.city);
    final available = useState(car?.available ?? true);
    final town = useState<Town?>(car?.location?.town);
    final deletedPreviousRental = useState<List<RentalPlan>>([]);
    final newRental = useState<List<RentalPlan>>([]);
    final location = useState<CarLocation?>(car?.location);
    final carImages = useState(car?.images ?? []);
    final displayRentalPlan = useState<RentalPeriodType?>(
      car?.displayPlan ?? RentalPeriodType.hourly,
    );
    final hourly = plans?.firstWhereOrNull(
      (plan) => plan.periodType == RentalPeriodType.hourly,
    );

    final daily = plans?.firstWhereOrNull(
      (plan) => plan.periodType == RentalPeriodType.daily,
    );

    final monthly = plans?.firstWhereOrNull(
      (plan) => plan.periodType == RentalPeriodType.monthly,
    );

    final hourlyPlan = useState(
      car?.rentalPlan?.firstWhereOrNull(
        (rent) => rent.periodType == RentalPeriodType.hourly,
      ),
    );

    final dailyPlan = useState(
      car?.rentalPlan?.firstWhereOrNull(
        (rent) => rent.periodType == RentalPeriodType.daily,
      ),
    );

    final monthlyPlan = useState(
      car?.rentalPlan?.firstWhereOrNull(
        (rent) => rent.periodType == RentalPeriodType.monthly,
      ),
    );

    final latLong = useState<LatLng?>(
      car?.location?.lat == null
          ? null
          : LatLng(car?.location?.lat ?? 0, car?.location?.long ?? 0),
    );

    void onSelectMap(TapPosition tap, LatLng ltlg) {
      latLong.value = ltlg;
      location.value = location.value?.copyWith(
        lat: ltlg.latitude,
        long: ltlg.longitude,
      );
    }

    final newImages = useState<List<XFile>>([]);
    final deletePreviousImages = useState<List<Images>>([]);

    final formKey = useMemoized(GlobalKey<FormState>.new, const []);

    selectedImages(List<XFile> selectedImages) {
      newImages.value.clear();
      for (final image in selectedImages) {
        newImages.value.add(image); // images = [image];
      }
    }

    deletingImages(Images deletedImagess) {
      deletePreviousImages.value = [
        ...deletePreviousImages.value,
        deletedImagess,
      ];
    }

    final towns = ref.watch(townsProvider(city.value?.id));

    final carController = ref.watch(carControllerProvider);

    ref.listen(carControllerProvider, (prev, next) {
      if (next is NewCarFailed) {
        showCustomAlert(context, content: next.message);
      }
      if (next is NewCarCompleted) {
        showMessages(context, message: LocaleKeys.alertMessages_success.tr());
        context.pop();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          car == null
              ? LocaleKeys.screens_newCar.tr()
              : LocaleKeys.screens_updateCar.tr(),
        ),
        leading: CustomBackButton(),
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
        ).copyWith(bottom: 20.w, top: 4.w),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 3.w,
            children: [
              AppTextField(
                controller: title,
                label: LocaleKeys.inputLabels_title.tr(),
              ),
              AppTextField(
                controller: year,
                label: LocaleKeys.labels_year.tr(),
                keyboardType: TextInputType.number,
                validator: (value) => value!.length == 4
                    ? null
                    : LocaleKeys.validations_year.tr(),
              ),
              AppTextField(
                controller: speed,
                label: LocaleKeys.labels_speed.tr(),
                keyboardType: TextInputType.number,
              ),
              AppTextField(
                controller: hp,
                label: LocaleKeys.labels_horsePower.tr(),
                keyboardType: TextInputType.number,
              ),
              AppTextField(
                controller: seat,
                label: LocaleKeys.labels_seat.tr(),
                keyboardType: TextInputType.number,
              ),
              AppTextField(
                controller: odometer,
                label:
                    "${LocaleKeys.labels_odometer.tr()} - ${LocaleKeys.labels_km.tr()}",
                keyboardType: TextInputType.number,
              ),
              AppTextField(
                controller: cylinders,
                label: LocaleKeys.labels_cylinders.tr(),
                keyboardType: TextInputType.number,
              ),
              AppTextField(
                controller: engCC,
                label:
                    "${LocaleKeys.labels_engineCC.tr()} - ${LocaleKeys.labels_litter.tr()}",
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              Gap(1.w),
              Text(
                LocaleKeys.labels_fuel.tr(),
                style: context.label.copyWith(color: context.outline),
              ),
              Wrap(
                spacing: 2.w,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                runSpacing: 2.w,
                children: Fuel.values
                    .map(
                      (e) => CustomFilterChip(
                        title: e.getFuel(),
                        selected: e == fuel.value,
                        onTap: () => fuel.value = e,
                      ),
                    )
                    .toList(),
              ),
              Gap(1.w),
              Text(
                LocaleKeys.labels_transmission.tr(),
                style: context.label.copyWith(color: context.outline),
              ),
              Wrap(
                spacing: 2.w,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                runSpacing: 2.w,
                children: Transmission.values
                    .map(
                      (e) => CustomFilterChip(
                        title: e.transmissionType(),
                        selected: e == transmission.value,
                        onTap: () => transmission.value = e,
                      ),
                    )
                    .toList(),
              ),
              Gap(1.w),
              AppTextField(
                label: LocaleKeys.labels_brand.tr(),
                readOnly: true,
                initialValue: brand.value?.getTitle(locale),
                key: ValueKey(brand.value?.id ?? "brand"),
                onTap: () {
                  showCustomBottomSheet(
                    context,
                    Brands(
                      selectedBrand: brand.value,
                      onSelect: (selectedBrand) {
                        brand.value = selectedBrand;
                      },
                    ),
                  );
                },
              ),
              AppTextField(
                label: LocaleKeys.labels_type.tr(),
                readOnly: true,
                initialValue: type.value?.getTitle(locale),
                key: ValueKey(type.value?.id ?? "carType"),
                onTap: () {
                  showCustomBottomSheet(
                    context,
                    CarTypesView(
                      selectedType: type.value,
                      onSelect: (selectedType) {
                        type.value = selectedType;
                      },
                    ),
                  );
                },
              ),
              Gap(2.w),
              Text(
                LocaleKeys.labels_rentalPlans.tr(),
                style: context.label.copyWith(color: context.outline),
              ),
              Column(
                children: [
                  ListTile(
                    onTap: () async {
                      if (hourly == null || hourlyPlan.value != null) return;
                      final newHourlyPlan = await context.router.push(
                        NewRentalPlanRoute(
                          rentalPlan: hourlyPlan.value,
                          plan: hourly,
                        ),
                      );
                      if (newHourlyPlan != null) {
                        hourlyPlan.value = newHourlyPlan as RentalPlan;
                        newRental.value.add(newHourlyPlan);
                      }
                    },
                    dense: true,
                    title: Text(
                      hourlyPlan.value != null
                          ? "${hourlyPlan.value?.price.forMatNumber()} ${hourlyPlan.value?.currency?.getCurrency() ?? ""}"
                          : LocaleKeys.buttons_addHourlyPlan.tr(),
                    ),
                    trailing: hourlyPlan.value != null
                        ? IconButton(
                            onPressed: () {
                              if (hourlyPlan.value?.id != '') {
                                deletedPreviousRental.value.add(
                                  hourlyPlan.value!.copyWith(plan: null),
                                );
                              }
                              hourlyPlan.value = null;
                              newRental.value = newRental.value
                                  .where(
                                    (rent) =>
                                        rent.periodType !=
                                        RentalPeriodType.hourly,
                                  )
                                  .toList();
                            },
                            icon: Icon(Icons.close, size: 6.w),
                          )
                        : SizedBox.shrink(),
                    subtitle: Row(
                      children: [
                        Text(
                          hourlyPlan.value?.periodType.periodPerType() ?? "",
                        ),
                        Gap(2.w),
                        Text(
                          hourlyPlan.value?.min?.forMatNumber() ??
                              "".toString() ??
                              "",
                        ),
                        Text(
                          " - ${hourlyPlan.value?.max?.forMatNumber() ?? ""}",
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      if (daily == null || dailyPlan.value != null) return;
                      final newDailyPlan = await context.router.push(
                        NewRentalPlanRoute(
                          rentalPlan: dailyPlan.value,
                          plan: daily,
                        ),
                      );
                      if (newDailyPlan != null) {
                        dailyPlan.value = newDailyPlan as RentalPlan;
                        newRental.value.add(newDailyPlan.copyWith(plan: null));
                      }
                    },
                    dense: true,
                    title: Text(
                      dailyPlan.value != null
                          ? "${dailyPlan.value?.price.forMatNumber() ?? ""} ${dailyPlan.value?.currency?.getCurrency() ?? ""}"
                          : LocaleKeys.buttons_addDailyPlan.tr(),
                    ),
                    trailing: dailyPlan.value != null
                        ? IconButton(
                            onPressed: () {
                              if (dailyPlan.value?.id != "") {
                                deletedPreviousRental.value.add(
                                  dailyPlan.value!.copyWith(plan: null),
                                );
                              }
                              dailyPlan.value = null;
                              newRental.value = newRental.value
                                  .where(
                                    (rent) =>
                                        rent.periodType !=
                                        RentalPeriodType.daily,
                                  )
                                  .toList();
                            },
                            icon: Icon(Icons.close, size: 6.w),
                          )
                        : SizedBox.shrink(),
                    subtitle: Row(
                      children: [
                        Text(dailyPlan.value?.periodType.periodPerType() ?? ""),
                        Gap(2.w),
                        Text(
                          dailyPlan.value?.min?.forMatNumber() ??
                              "".toString() ??
                              "",
                        ),
                        Text(
                          " - ${dailyPlan.value?.max?.forMatNumber() ?? ""}",
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      if (monthly == null || monthlyPlan.value != null) return;
                      final newMonthlyPlan = await context.router.push(
                        NewRentalPlanRoute(
                          rentalPlan: monthlyPlan.value,
                          plan: monthly,
                        ),
                      );
                      if (newMonthlyPlan != null) {
                        monthlyPlan.value = newMonthlyPlan as RentalPlan;
                        newRental.value.add(
                          newMonthlyPlan.copyWith(plan: null),
                        );
                      }
                    },
                    dense: true,
                    title: Text(
                      monthlyPlan.value != null
                          ? "${monthlyPlan.value?.price.forMatNumber() ?? ""} ${monthlyPlan.value?.currency?.getCurrency() ?? ""}"
                          : LocaleKeys.buttons_addMonthlyPlan.tr(),
                    ),
                    trailing: monthlyPlan.value != null
                        ? IconButton(
                            onPressed: () {
                              if (monthlyPlan.value?.id != "") {
                                deletedPreviousRental.value.add(
                                  monthlyPlan.value!.copyWith(plan: null),
                                );
                              }
                              monthlyPlan.value = null;
                              newRental.value = newRental.value
                                  .where(
                                    (rent) =>
                                        rent.periodType !=
                                        RentalPeriodType.monthly,
                                  )
                                  .toList();
                            },
                            icon: Icon(Icons.close, size: 6.w),
                          )
                        : SizedBox.shrink(),
                    subtitle: Row(
                      children: [
                        Text(
                          monthlyPlan.value?.periodType.periodPerType() ?? "",
                        ),
                        Gap(2.w),
                        Text(
                          monthlyPlan.value?.min?.forMatNumber() ??
                              "".toString() ??
                              "",
                        ),
                        Text(
                          " - ${monthlyPlan.value?.max?.forMatNumber() ?? ""}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Gap(1.w),
              Text(
                LocaleKeys.labels_mainPlan.tr(),
                style: context.label.copyWith(color: context.outline),
              ),
              Wrap(
                spacing: 2.w,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                runSpacing: 2.w,
                children: RentalPeriodType.values
                    .map(
                      (e) => e != RentalPeriodType.weekly
                          ? CustomFilterChip(
                              title: e.periodType(),
                              selected: e == displayRentalPlan.value,
                              onTap: () {
                                displayRentalPlan.value = e;
                              },
                            )
                          : SizedBox.shrink(),
                    )
                    .toList(),
              ),
              Gap(2.w),
              AppTextField(
                readOnly: true,
                initialValue:
                    city.value?.getTitle(locale) ??
                    LocaleKeys.labels_selectACity.tr(),
                key: ValueKey(city.value?.id ?? "City"),
                label: LocaleKeys.inputLabels_city.tr(),
                onTap: () {
                  showCustomBottomSheet(
                    context,
                    CityViews(
                      cityId: city.value?.id,
                      onSelect: (selectedCity) {
                        city.value = selectedCity;
                        location.value = location.value?.copyWith(
                          cityId: selectedCity.id,
                          city: selectedCity,
                        );
                      },
                    ),
                  );
                },
              ),
              AppTextField(
                readOnly: true,
                initialValue:
                    town.value?.getTitle(locale) ??
                    LocaleKeys.labels_selectTown.tr(),
                key: ValueKey(town.value?.id ?? "Town"),
                label: LocaleKeys.inputLabels_town.tr(),
                onTap: () {
                  showCustomBottomSheet(
                    context,
                    TownsViwe(
                      towns: towns ?? [],
                      townId: town.value?.id,
                      onSelect: (selectedTown) {
                        final isSame = selectedTown.id == town.value?.id;
                        town.value = isSame ? null : selectedTown;
                        location.value = location.value?.copyWith(
                          townId: isSame ? "null" : selectedTown.id,
                          town: isSame ? null : selectedTown,
                        );
                      },
                    ),
                  );
                },
              ),
              Gap(2.w),
              SecondaryButton(
                text: latLong.value == null
                    ? LocaleKeys.buttons_setLocation.tr()
                    : LocaleKeys.buttons_changeLocation.tr(),
                onPress: () {
                  context.router.push(
                    PickUpMapRoute(
                      car: car?.copyWith(
                        location: car?.location?.copyWith(
                          lat: latLong.value?.latitude,
                          long: latLong.value?.longitude,
                        ),
                      ),
                      onSelect: onSelectMap,
                    ),
                  );
                },
              ),
              Gap(4.w),
              car == null
                  ? PcikedImagesScreen(
                      isPost: true,
                      selectedImages: (v) => selectedImages(v),
                    )
                  : EditPcikerImageServiceScreen(
                      key: ValueKey(carImages.value),
                      selectedImages: selectedImages,
                      deletedImages: deletingImages,
                      images: carImages.value,
                    ),
              Gap(2.w),
              SizedBox(
                height: 10.w,
                child:
                    (car != null &&
                        (deletePreviousImages.value.isEmpty &&
                            newImages.value.isEmpty &&
                            carImages.value.length > 1))
                    ? SecondaryButton(
                        onPress: () async {
                          if (car != null &&
                              (deletePreviousImages.value.isEmpty &&
                                  newImages.value.isEmpty)) {
                            final sortedImages = await context.router.push(
                              SortingImageRoute(car: car!),
                            );
                            if (sortedImages != null) {
                              carImages.value = sortedImages as List<Images>;
                            }
                          }
                        },
                        text: LocaleKeys.buttons_sortImages.tr(),
                      )
                    : SizedBox(),
              ),
              CheckboxListTile.adaptive(
                dense: true,
                visualDensity: VisualDensity.compact,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                value: available.value,
                title: Text(LocaleKeys.buttons_available.tr()),
                onChanged: (v) => available.value = v!,
              ),
              Gap(6.w),
              PrimaryButton(
                text: car == null
                    ? LocaleKeys.buttons_add.tr()
                    : LocaleKeys.buttons_update.tr(),
                isLoading: carController is NewCarLoading,
                onPress: () {
                  if (!formKey.currentState!.validate()) return;
                  if (car == null) {
                    if (newRental.value.isEmpty) {
                      showMessages(
                        context,
                        message: LocaleKeys.alertMessages_addPlan.tr(),
                      );
                      return;
                    }
                    if (newImages.value.isEmpty) {
                      showMessages(
                        context,
                        message: LocaleKeys.alertMessages_addImage.tr(),
                      );
                      return;
                    }
                  }
                  if (city.value == null) {
                    showMessages(
                      context,
                      message: LocaleKeys.alertMessages_selectCity.tr(),
                    );
                    return;
                  }
                  if (latLong.value == null) {
                    showMessages(
                      context,
                      message: LocaleKeys.alertMessages_addLocation.tr(),
                    );
                    return;
                  }
                  if (fuel.value == null) {
                    showMessages(
                      context,
                      message: LocaleKeys.alertMessages_selectFuel.tr(),
                    );
                    return;
                  }

                  if (transmission.value == null) {
                    showMessages(
                      context,
                      message: LocaleKeys.alertMessages_selectTransmission.tr(),
                    );
                    return;
                  }
                  if (type.value == null) {
                    showMessages(
                      context,
                      message: LocaleKeys.alertMessages_selectType.tr(),
                    );
                    return;
                  }

                  if (brand.value == null) {
                    showMessages(
                      context,
                      message: LocaleKeys.alertMessages_selectBrand.tr(),
                    );
                    return;
                  }
                  if (car != null) {
                    if (dailyPlan.value == null && hourlyPlan.value == null) {
                      showMessages(
                        context,
                        message: LocaleKeys.alertMessages_addPlan.tr(),
                      );
                      return;
                    }

                    if (deletePreviousImages.value.length ==
                            carImages.value.length &&
                        newImages.value.isEmpty) {
                      showMessages(
                        context,
                        message: LocaleKeys.alertMessages_addImage.tr(),
                      );
                      return;
                    }
                  }

                  final newCar = CarUpdate(
                    id: car?.id,
                    title: title.text,
                    brand: brand.value,
                    type: type.value,
                    typeId: type.value?.id,
                    brandId: brand.value?.id,
                    rentalPlan: newRental.value,
                    available: available.value,
                    displayPlan: displayRentalPlan.value,
                    feature: (car?.feature ?? Feature()).copyWith(
                      hp: int.tryParse(hp.text),
                      speed: int.tryParse(speed.text),
                      year: int.tryParse(year.text),
                      fuel: fuel.value,
                      transmission: transmission.value,
                      seat: int.tryParse(seat.text),
                      type: type.value,
                      carId: car?.id,
                      cylinders: int.tryParse(cylinders.text),
                      odometer: int.tryParse(odometer.text),
                      engCC: double.tryParse(engCC.text),
                    ),
                    location: (car?.location ?? CarLocation()).copyWith(
                      id: car?.location?.id,
                      cityId: city.value?.id,
                      townId: location.value?.townId,
                      lat: latLong.value?.latitude,
                      long: latLong.value?.longitude,
                      city: city.value,
                      town: town.value,
                      companyId: null,
                    ),
                  );
                  final controller = ref.read(carControllerProvider.notifier);
                  if (car == null) {
                    controller.listCar(
                      CarPost(
                        car: newCar.copyWith(brand: null, type: null),
                        images: newImages.value,
                      ),
                    );
                  } else {
                    controller.updateCar(
                      CarPost(
                        car: newCar.toDiff(car!),
                        deletedImages: deletePreviousImages.value,
                        deletedRentalPlans: deletedPreviousRental.value,
                        images: newImages.value,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
