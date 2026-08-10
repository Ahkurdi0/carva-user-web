import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/features/car/presentation/riverpod/filters.dart';
import 'package:kcars/features/car/presentation/riverpod/filters_data.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BrandsContent extends HookConsumerWidget {
  const BrandsContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fitlers = ref.watch(filtersProvider);
    final filterData = ref.watch(filtersDataProvider);
    final locale = useMemoized(() => context.locale.toLanguageTag(), []);
    return filterData.when(
      data: (data) => ListView.builder(
        shrinkWrap: true,
        itemCount: (data.brands?.length ?? 0) + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return CustomTile(
              title: LocaleKeys.labels_all.tr(),
              isSelected: fitlers.brandId == null,
              onTap: () {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(fitlers.copyWith(brandId: null, brand: null));
              },
            );
          }
          final brand = data.brands?[index - 1];
          return CustomTile(
            title: brand?.getTitle(locale) ?? "",
            isSelected: brand?.id == fitlers.brandId,
            onTap: () {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(
                    fitlers.copyWith(
                      brandId: brand?.id == fitlers.brandId ? null : brand?.id,
                      brand: brand?.id == fitlers.brandId ? null : brand,
                    ),
                  );
            },
          );
        },
      ),
      loading: () => Skeletonizer(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            return CustomTile(title: "", isSkeleton: true);
          },
        ),
      ),
      error: (error, st) => Text(error.toString()),
    );
  }
}

class CarTypeContent extends HookConsumerWidget {
  const CarTypeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = useMemoized(() => context.locale.toLanguageTag(), []);
    final fitlers = ref.watch(filtersProvider);
    final filterData = ref.watch(filtersDataProvider);

    return filterData.when(
      data: (data) => ListView.builder(
        shrinkWrap: true,
        itemCount: (data.types?.length ?? 0) + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return CustomTile(
              title: LocaleKeys.labels_all.tr(),
              isSelected: fitlers.typeId == null,
              onTap: () {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(fitlers.copyWith(typeId: null, type: null));
              },
            );
          }
          final type = data.types?[index - 1];
          return CustomTile(
            title: type?.getTitle(locale) ?? "",
            isSelected: type?.id == fitlers.typeId,
            onTap: () {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(
                    fitlers.copyWith(
                      typeId: type?.id == fitlers.typeId ? null : type?.id,
                      type: type?.id == fitlers.typeId ? null : type,
                    ),
                  );
            },
          );
        },
      ),
      loading: () => Skeletonizer(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            return CustomTile(title: "", isSkeleton: true);
          },
        ),
      ),
      error: (error, st) => Text(error.toString()),
    );
  }
}

class CustomTile extends StatelessWidget {
  const CustomTile({
    super.key,
    required this.title,
    this.isSelected = false,
    this.isSkeleton = false,
    this.onTap,
  });
  final String title;
  final bool isSelected;
  final bool isSkeleton;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isSkeleton,
      containersColor: context.surfaceContainerLow,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5, color: context.surfaceContainerLow),
          ),
        ),
        child: ListTile(
          title: isSkeleton
              ? Bone.text()
              : Text(title, textAlign: TextAlign.center),
          selected: isSelected,
          selectedColor: context.onSurface,
          textColor: context.outline,
          splashColor: Colors.transparent,
          horizontalTitleGap: 10.w,
          hoverColor: Colors.transparent,
          titleTextStyle: context.label2,
          leading: SizedBox(),
          trailing: isSkeleton
              ? Bone.circle(size: 4.w)
              : AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    final isChecked =
                        (child.key as ValueKey?)?.value == 'checked';

                    if (isChecked) {
                      return ScaleTransition(scale: animation, child: child);
                    } else {
                      return child;
                    }
                  },
                  child: IconLoadaer(
                    isSelected ? AppIcons.checked : AppIcons.check,
                    width: 5.w,
                    key: ValueKey(isSelected ? 'checked' : 'unchecked'),
                  ),
                ),

          onTap: onTap,
        ),
      ),
    );
  }
}
