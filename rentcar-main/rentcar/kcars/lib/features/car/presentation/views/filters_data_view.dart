import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_picker_plus/picker.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/core/widget/loadin_widget.dart';
import 'package:kcars/core/widget/show_sheet.dart';
import 'package:kcars/features/car/data/model/car_location.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:kcars/features/car/data/model/feature.dart';
import 'package:kcars/features/car/data/model/filter.dart';
import 'package:kcars/features/car/data/model/rental_plan.dart';
import 'package:kcars/features/car/presentation/riverpod/filter_cars.dart';
import 'package:kcars/features/car/presentation/riverpod/filters.dart';
import 'package:kcars/features/car/presentation/riverpod/filters_data.dart';
import 'package:kcars/features/car/presentation/views/brands_content.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:collection/collection.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FiltersDataView extends HookConsumerWidget {
  const FiltersDataView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filtersProvider);
    final rootContext = Navigator.of(context, rootNavigator: true).context;
    final locale = useMemoized(() => context.locale.toLanguageTag(), []);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 2.w,
        children: [
          CheckFilter(
            title: LocaleKeys.labels_all.tr(),
            onTap: () {
              final rootContent = Navigator.of(
                context,
                rootNavigator: true,
              ).context;
              showFilters(rootContent, FilterDataView());
            },
          ),
          CheckFilter(
            title: filters.brand?.getTitle(locale),
            hint: LocaleKeys.labels_brand.tr(),
            onTap: () {
              showSheet(rootContext, SheetContent(child: BrandsContent()));
            },
          ),
          CheckFilter(
            title: filters.type?.getTitle(locale),
            hint: LocaleKeys.labels_type.tr(),
            onTap: () {
              showSheet(rootContext, SheetContent(child: CarTypeContent()));
            },
          ),
          CheckFilter(
            title: filters.feature?.year == null
                ? null
                : "${filters.feature?.year}-${filters.feature?.maxYear}",
            hint: LocaleKeys.labels_year.tr(),
            onTap: () {
              final root = Navigator.of(context, rootNavigator: true).context;
              showNumberPicker(
                root,

                onReset: () {
                  ref
                      .read(filtersProvider.notifier)
                      .setFilter(
                        filters.copyWith(
                          feature: filters.feature?.copyWith(
                            year: null,
                            maxYear: null,
                          ),
                        ),
                      );
                },
                onConfirm: (v) {
                  ref
                      .read(filtersProvider.notifier)
                      .setFilter(
                        filters.copyWith(
                          feature: (filters.feature ?? Feature()).copyWith(
                            maxYear: v[1],
                            year: v[0],
                          ),
                        ),
                      );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class CheckFilter extends StatelessWidget {
  const CheckFilter({super.key, this.title, this.hint, this.onTap});
  final String? title;
  final String? hint;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = title != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
        decoration: BoxDecoration(
          color: context.secondaryContainer,
          border: Border.all(width: 0.5, color: context.outline),
          borderRadius: BorderRadius.circular(100.w),
        ),
        child: Row(
          children: [
            Gap(2.w),
            Text(
              title ?? hint ?? "",
              style: context.caption.copyWith(
                color: isSelected ? context.onSurface : context.outline,
              ),
            ),
            Gap(2.w),
            Transform.rotate(
              angle: 300,
              child: IconLoadaer(AppIcons.arrow, width: 4.w),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomFilterChip extends StatelessWidget {
  const CustomFilterChip({
    super.key,
    this.title,
    this.icon,
    this.onTap,
    this.selected = false,
    this.selectedColor,
    this.enabled = true,
  });
  final String? title;
  final String? icon;
  final bool selected;
  final VoidCallback? onTap;
  final Color? selectedColor;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.w),
        decoration: BoxDecoration(
          color: selected ? selectedColor ?? context.secondary : null,
          border: Border.all(
            width: 0.3,
            color: selected
                ? selectedColor ?? context.secondary
                : context.surfaceContainer,
          ),
          borderRadius: BorderRadius.circular(100.w),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              IconLoadaer(icon!, width: 4.w, color: context.onSecondary),
              Gap(2.w),
            ],
            Text(
              title ?? "",
              style: context.caption.copyWith(
                color: selected ? context.onSecondary : context.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showFilters(BuildContext context, Widget child) async {
  Navigator.push(
    context,
    ModalSheetRoute(
      viewportPadding: EdgeInsets.only(
        top: MediaQuery.viewPaddingOf(context).top,
      ),
      builder: (context) => child,
    ),
  );
}

class FilterDataView extends HookConsumerWidget {
  const FilterDataView({super.key, this.companyId});
  final String? companyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = useMemoized(() => context.locale.toLanguageTag());
    const minSize = SheetOffset(0.6);
    const halfSize = SheetOffset(0.7);
    const fullSize = SheetOffset(.88);

    final result = ref.watch(filtersDataProvider);
    final filters = ref.watch(filtersProvider).copyWith(companyId: companyId);
    final cars = ref.watch(filtersCarsProvider(companyId));

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
          color: Colors.white,
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
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(top: 3.w, bottom: 1.w),
                height: 1.w,
                width: 14.w,
                decoration: BoxDecoration(
                  color: context.outline,
                  borderRadius: BorderRadius.circular(100.w),
                ),
              ),
              Gap(4.w),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                  ).copyWith(bottom: 64.w),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        result.when(
                          data: (data) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Gap(2.w),
                                Text(
                                  LocaleKeys.labels_brand.tr(),
                                  style: context.labelSemiBold,
                                ),
                                Gap(4.w),
                                Wrap(
                                  runSpacing: 4.w,
                                  spacing: 2.w,
                                  children: [
                                    ShowMoreWrap(
                                      items: [
                                        ...data.brands
                                                ?.map(
                                                  (brand) => CustomFilterChip(
                                                    title: brand.getTitle(
                                                      locale,
                                                    ),
                                                    selected:
                                                        filters.brandId ==
                                                        brand.id,
                                                    onTap: () {
                                                      ref
                                                          .read(
                                                            filtersProvider
                                                                .notifier,
                                                          )
                                                          .setFilter(
                                                            filters.copyWith(
                                                              brand:
                                                                  filters.brandId ==
                                                                      brand.id
                                                                  ? null
                                                                  : brand,
                                                              brandId:
                                                                  filters.brandId ==
                                                                      brand.id
                                                                  ? null
                                                                  : brand.id,
                                                            ),
                                                          );
                                                    },
                                                  ),
                                                )
                                                .toList() ??
                                            [],
                                      ],
                                    ),
                                  ],
                                ),
                                Gap(6.w),
                                Text(
                                  LocaleKeys.labels_type.tr(),
                                  style: context.labelSemiBold,
                                ),
                                Gap(4.w),
                                ShowMoreWrap(
                                  items: [
                                    ...data.types
                                            ?.map(
                                              (type) => CustomFilterChip(
                                                title: type.getTitle(locale),
                                                selected:
                                                    filters.typeId == type.id,
                                                onTap: () {
                                                  ref
                                                      .read(
                                                        filtersProvider
                                                            .notifier,
                                                      )
                                                      .setFilter(
                                                        filters.copyWith(
                                                          type:
                                                              filters.typeId ==
                                                                  type.id
                                                              ? null
                                                              : type,
                                                          typeId:
                                                              filters.typeId ==
                                                                  type.id
                                                              ? null
                                                              : type.id,
                                                        ),
                                                      );
                                                },
                                              ),
                                            )
                                            .toList() ??
                                        [],
                                  ],
                                ),
                                if (companyId == null) ...[
                                  Gap(6.w),
                                  Text(
                                    LocaleKeys.labels_city.tr(),
                                    style: context.labelSemiBold,
                                  ),
                                  Gap(4.w),
                                  ShowMoreWrap(
                                    items: [
                                      ...data.cities
                                              ?.map(
                                                (city) => CustomFilterChip(
                                                  title: city.getTitle(locale),
                                                  selected:
                                                      filters
                                                          .location
                                                          ?.cityId ==
                                                      city.id,
                                                  onTap: () {
                                                    final newCityId =
                                                        filters
                                                                .location
                                                                ?.cityId ==
                                                            city.id
                                                        ? null
                                                        : city.id;

                                                    ref
                                                        .read(
                                                          filtersProvider
                                                              .notifier,
                                                        )
                                                        .setFilter(
                                                          filters.copyWith(
                                                            city: city,
                                                            location:
                                                                (filters.location ??
                                                                        CarLocation())
                                                                    .copyWith(
                                                                      cityId:
                                                                          newCityId,
                                                                      town:
                                                                          null,
                                                                      townId:
                                                                          null,
                                                                    ),
                                                          ),
                                                        );
                                                  },
                                                ),
                                              )
                                              .toList() ??
                                          [],
                                    ],
                                  ),
                                  AnimatedSwitcher(
                                    duration: Duration(milliseconds: 300),
                                    child: filters.location?.cityId != null
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Gap(6.w),
                                              Text(
                                                LocaleKeys.labels_town.tr(),
                                                style: context.labelSemiBold,
                                              ),
                                              Gap(4.w),
                                              ShowMoreWrap(
                                                items:
                                                    data.cities
                                                        ?.firstWhereOrNull(
                                                          (g) =>
                                                              g.id ==
                                                              filters
                                                                  .location
                                                                  ?.cityId,
                                                        )
                                                        ?.towns
                                                        ?.map(
                                                          (
                                                            town,
                                                          ) => CustomFilterChip(
                                                            title: town
                                                                .getTitle(
                                                                  locale,
                                                                ),
                                                            selected:
                                                                filters
                                                                    .location
                                                                    ?.townId ==
                                                                town.id,
                                                            onTap: () {
                                                              ref
                                                                  .read(
                                                                    filtersProvider
                                                                        .notifier,
                                                                  )
                                                                  .setFilter(
                                                                    filters.copyWith(
                                                                      location:
                                                                          (filters.location ??
                                                                                  CarLocation())
                                                                              .copyWith(
                                                                                townId:
                                                                                    filters.location?.townId ==
                                                                                        town.id
                                                                                    ? null
                                                                                    : town.id,
                                                                              ),
                                                                    ),
                                                                  );
                                                            },
                                                          ),
                                                        )
                                                        .toList() ??
                                                    [],
                                              ),
                                            ],
                                          )
                                        : SizedBox(),
                                  ),
                                ],
                                Gap(6.w),
                                Text(
                                  LocaleKeys.labels_transmission.tr(),
                                  style: context.labelSemiBold,
                                ),
                                Gap(4.w),
                                Wrap(
                                  runSpacing: 4.w,
                                  spacing: 2.w,
                                  children: [
                                    ...Transmission.values.map(
                                      (transmission) => CustomFilterChip(
                                        title: transmission.transmissionType(),
                                        selected:
                                            filters
                                                .feature
                                                ?.transmission
                                                ?.name ==
                                            transmission.name,
                                        onTap: () {
                                          ref
                                              .read(filtersProvider.notifier)
                                              .setFilter(
                                                filters.copyWith(
                                                  feature:
                                                      (filters.feature ??
                                                              Feature())
                                                          .copyWith(
                                                            transmission:
                                                                transmission ==
                                                                    filters
                                                                        .feature
                                                                        ?.transmission
                                                                ? null
                                                                : transmission,
                                                          ),
                                                ),
                                              );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(6.w),
                                Text(
                                  LocaleKeys.labels_fuel.tr(),
                                  style: context.labelSemiBold,
                                ),
                                Gap(4.w),
                                Wrap(
                                  runSpacing: 4.w,
                                  spacing: 2.w,
                                  children: [
                                    ...Fuel.values.map(
                                      (fuel) => CustomFilterChip(
                                        title: fuel.getFuel(),
                                        selected:
                                            filters.feature?.fuel?.name ==
                                            fuel.name,
                                        onTap: () {
                                          ref
                                              .read(filtersProvider.notifier)
                                              .setFilter(
                                                filters.copyWith(
                                                  feature:
                                                      (filters.feature ??
                                                              Feature())
                                                          .copyWith(
                                                            fuel:
                                                                fuel ==
                                                                    filters
                                                                        .feature
                                                                        ?.fuel
                                                                ? null
                                                                : fuel,
                                                          ),
                                                ),
                                              );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(6.w),
                                Text(
                                  LocaleKeys.labels_plan.tr(),
                                  style: context.labelSemiBold,
                                ),
                                Gap(4.w),
                                Wrap(
                                  runSpacing: 4.w,
                                  spacing: 2.w,
                                  children: [
                                    ...data.plans
                                            ?.map(
                                              (plan) => CustomFilterChip(
                                                title: plan.getTile(locale),
                                                selected:
                                                    filters
                                                        .rentalPlan
                                                        ?.planId ==
                                                    plan.id,
                                                onTap: () {
                                                  ref
                                                      .read(
                                                        filtersProvider
                                                            .notifier,
                                                      )
                                                      .setFilter(
                                                        filters.copyWith(
                                                          rentalPlan:
                                                              (filters.rentalPlan ??
                                                                      FilterRentalPlan())
                                                                  .copyWith(
                                                                    planId:
                                                                        filters.rentalPlan?.planId ==
                                                                            plan.id
                                                                        ? null
                                                                        : plan.id,
                                                                  ),
                                                        ),
                                                      );
                                                },
                                              ),
                                            )
                                            .toList() ??
                                        [],
                                  ],
                                ),
                                Gap(6.w),
                                Row(
                                  children: [
                                    Text(
                                      LocaleKeys.labels_year.tr(),
                                      style: context.labelSemiBold,
                                    ),
                                    Spacer(),
                                    CustomFilterChip(
                                      title: filters.feature?.year == null
                                          ? LocaleKeys.labels_selectYear.tr()
                                          : "${filters.feature?.year}-${filters.feature?.maxYear}",
                                      selected: filters.feature?.year != null,
                                      onTap: () {
                                        final root = Navigator.of(
                                          context,
                                          rootNavigator: true,
                                        ).context;
                                        showNumberPicker(
                                          root,
                                          onReset: () {
                                            ref
                                                .read(filtersProvider.notifier)
                                                .setFilter(
                                                  filters.copyWith(
                                                    feature: filters.feature
                                                        ?.copyWith(
                                                          year: null,
                                                          maxYear: null,
                                                        ),
                                                  ),
                                                );
                                          },
                                          onConfirm: (v) {
                                            ref
                                                .read(filtersProvider.notifier)
                                                .setFilter(
                                                  filters.copyWith(
                                                    feature:
                                                        (filters.feature ??
                                                                Feature())
                                                            .copyWith(
                                                              maxYear: v[1],
                                                              year: v[0],
                                                            ),
                                                  ),
                                                );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                Gap(6.w),
                                Row(
                                  children: [
                                    Text(
                                      LocaleKeys.labels_price.tr(),
                                      style: context.labelSemiBold,
                                    ),
                                    Spacer(),
                                    CustomFilterChip(
                                      icon: filters.rentalPlan?.minPrice == null
                                          ? null
                                          : AppIcons.cancel,
                                      onTap: () {
                                        if (filters.rentalPlan?.minPrice !=
                                                null ||
                                            filters.rentalPlan?.maxPrice !=
                                                null) {
                                          ref
                                              .read(filtersProvider.notifier)
                                              .setFilter(
                                                filters.copyWith(
                                                  rentalPlan: filters.rentalPlan
                                                      ?.copyWith(
                                                        maxPrice: null,
                                                        minPrice: null,
                                                      ),
                                                ),
                                              );
                                        }
                                      },
                                      selected:
                                          filters.rentalPlan?.minPrice != null,
                                      title:
                                          filters.rentalPlan?.minPrice == null
                                          ? LocaleKeys.labels_selectPrice.tr()
                                          : "${(filters.rentalPlan?.minPrice)?.forMatNumber()} - ${(filters.rentalPlan?.maxPrice)?.forMatNumber()} IQD",
                                    ),
                                  ],
                                ),
                                Gap(4.w),
                                PriceRange(filters: filters),
                              ],
                            );
                          },
                          error: (error, st) => Text(error.toString()),
                          loading: () => LoadingWidget(),
                        ),
                        Gap(6.w),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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
            child: Row(
              children: [
                SecondaryButton(
                  width: 40.w,
                  text: LocaleKeys.buttons_reset.tr(),
                  onPress: () {
                    ref.read(filtersProvider.notifier).clearFilter(companyId);
                    Navigator.pop(context);
                  },
                ),
                Gap(2.w),
                PrimaryButton(
                  width: 50.w,
                  isLoading: cars.isLoading,
                  text:
                      "${LocaleKeys.buttons_show.tr()} (${cars.items.length}) ${LocaleKeys.labels_carP.plural(cars.items.length).tr()}",
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShowMoreWrap extends StatefulWidget {
  final List<Widget> items;
  final int initialItemCount;

  const ShowMoreWrap({
    super.key,
    required this.items,
    this.initialItemCount = 10,
  });

  @override
  State<ShowMoreWrap> createState() => _ShowMoreWrapState();
}

class _ShowMoreWrapState extends State<ShowMoreWrap> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final visibleItems = _expanded
        ? widget.items
        : widget.items.take(widget.initialItemCount).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(runSpacing: 4.w, spacing: 2.w, children: visibleItems),
        if (widget.items.length > widget.initialItemCount)
          TextButton(
            key: ValueKey(_expanded),
            onPressed: () => setState(() => _expanded = !_expanded),
            child: Text(
              _expanded ? 'Show Less' : 'Show More',
              style: context.caption,
            ),
          ),
      ],
    );
  }
}

class PriceRange extends HookConsumerWidget {
  const PriceRange({super.key, this.filters});
  final Filter? filters;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rangeValues = useState<SfRangeValues>(
      SfRangeValues(
        filters?.rentalPlan?.minPrice ?? 5000,
        filters?.rentalPlan?.maxPrice ?? 50000,
      ),
    );
    return SizedBox(
      height: 10.w,
      child: SfRangeSlider(
        min: 5000,
        max: 150000,
        stepSize: 5000,
        values: rangeValues.value,
        onChanged: (SfRangeValues value) {
          rangeValues.value = value;
        },
        onChangeEnd: (value) {
          if (filters == null) return;
          final int min = ((value.start / 5000).round()) * 5000;
          final int max = ((value.end / 5000).round()) * 5000;
          ref
              .read(filtersProvider.notifier)
              .setFilter(
                filters!.copyWith(
                  rentalPlan: (filters?.rentalPlan ?? FilterRentalPlan())
                      .copyWith(minPrice: min, maxPrice: max),
                ),
              );
        },
        interval: 5000,
        enableTooltip: true,
        numberFormat: NumberFormat.decimalPattern(),
        showDividers: true,
        activeColor: context.onSurface,
      ),
    );
  }
}

Future<void> showSheet(BuildContext context, Widget child) async {
  Navigator.push(
    context,
    ModalSheetRoute(
      viewportPadding: EdgeInsets.only(
        top: MediaQuery.viewPaddingOf(context).top,
      ),
      builder: (context) => child,
    ),
  );
}

void showNumberPicker(
  BuildContext context, {
  Function(List<int>)? onConfirm,
  Function(List<int>)? onSelect,
  VoidCallback? onReset,
}) {
  final now = DateTime.now();

  final int minYear = 1980;
  final int maxYear = DateTime.now().year;
  final years = List.generate(
    maxYear - minYear + 1,
    (index) => minYear + index,
  );

  Picker(
    containerColor: context.surface,
    adapter: NumberPickerAdapter(
      data: [
        NumberPickerColumn(begin: 1980, end: now.year, initValue: 2000),
        NumberPickerColumn(items: years.reversed.toList()),
      ],
    ),
    onCancel: onReset,
    headerDecoration: BoxDecoration(
      color: context.surface,
      borderRadius: BorderRadius.vertical(top: Radius.circular(6.w)),
    ),
    backgroundColor: Colors.transparent,
    confirmTextStyle: context.caption,
    cancelTextStyle: context.caption,
    cancelText: LocaleKeys.buttons_reset.tr(),
    confirmText: LocaleKeys.buttons_search.tr(),
    onSelect: (picker, index, selected) {
      final values = picker.getSelectedValues() as List<int>;
      onSelect?.call(values);
    },
    onConfirm: (Picker picker, List<int> value) {
      final values = picker.getSelectedValues() as List<int>;
      onConfirm?.call(values);
    },
  ).showModal(context);
}
