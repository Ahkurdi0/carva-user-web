import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:kcars/core/providers/location_servic_provider.dart';
import 'package:kcars/core/providers/user_location.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/core/widget/loading_emoty_state.dart';
import 'package:kcars/features/auth/presentation/riverpod/is_logged_in.dart';
import 'package:kcars/features/car/presentation/riverpod/nearby_cars.dart';
import 'package:kcars/features/car/presentation/widget/car_widget_view.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

class NearbayCarsView extends ConsumerWidget {
  const NearbayCarsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasLocationPermission = ref.watch(locationStatusProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    return hasLocationPermission.when(
      data: (isGranted) {
        return SizedBox(
          height: 70.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(
                  LocaleKeys.labels_nearby.tr(),
                  style: context.label2Bold,
                ),
              ),
              Gap(4.w),
              isGranted
                  ? _NearbyCarsList(
                      isLoading: isLoggedIn,
                      isLoggedIn: isLoggedIn,
                    )
                  : const EnableLocationPrompt(),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
    );
  }
}

class _NearbyCarsList extends ConsumerWidget {
  const _NearbyCarsList({this.isLoading = true, this.isLoggedIn = false});
  final bool isLoading;
  final bool isLoggedIn;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final positionAsync = ref.watch(currentPositionProvider(context));
    final param = ref.watch(userLocationProvider());
    return positionAsync.when(
      data: (position) {
        final cars = ref.watch(nearbayCarsProvider(param));
        return cars.when(
          data: (data) => data.isEmpty
              ? EmptyWidget(
                  icon: AppIcons.noCars,
                  emptyMessage: LocaleKeys.empty_emptyCarsAround.tr(),
                )
              : CarWidget(cars: data, isLoggedIn: isLoggedIn),
          error: (e, _) => Center(child: Text("$e")),
          loading: () => CarWidget(isSkeleton: true),
        );
      },
      loading: () => const CarWidget(isSkeleton: true),
      error: (e, _) => Center(child: Text("$e")),
    );
  }
}

class EnableLocationPrompt extends ConsumerWidget {
  const EnableLocationPrompt({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconLoadaer(AppIcons.noLocation, height: 24.w),
            Text(
              LocaleKeys.alertMessages_carAroundYou.tr(),
              style: context.title3,
            ),
            Gap(4.w),
            SecondaryButton(
              color: context.secondaryContainer,
              width: 60.w,
              text: LocaleKeys.buttons_enableLocation.tr(),
              onPress: () async {
                await ref
                    .read(locationServiceProvider)
                    .handleLocationPermission(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
