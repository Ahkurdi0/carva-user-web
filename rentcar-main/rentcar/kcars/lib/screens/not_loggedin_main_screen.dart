import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/providers/connectivity.dart';
import 'package:kcars/core/providers/shee_controller.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/widget/bottm_bar.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

@RoutePage()
class NotLoggedInMainScreen extends ConsumerWidget {
  const NotLoggedInMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contrller = ref.watch(sheetControllerProvider);
    final network = ref.watch(networkAwareProvider);
    if (network == NetworkStatus.off) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.router.replaceAll([const ConnectivityRoute()]);
      });
    }
    return AutoTabsScaffold(
      extendBody: true,
      animationDuration: Duration.zero,
      routes: [HomeRoute(), NotLoggedinRoute(), AllCompaniesRoute()],
      bottomNavigationBuilder: (context, tab) => SlideTransition(
        position: SheetOffsetDrivenAnimation(
          controller: contrller,
          initialValue: 1,
        ).drive(Tween(begin: const Offset(0, 1), end: Offset.zero)),
        child: CustomBottomNavigationBar(
          onTap: (index) {
            if (index == 3) {
              context.router.push(LoginRoute());
              return;
            }
            tab.setActiveIndex(index);
          },
          tabs: [
            BottmBarModel(
              lable: LocaleKeys.bottomNavigation_cars.tr(),
              icon: AppIcons.car,
              activeIcon: AppIcons.carActive,
            ),
            BottmBarModel(
              lable: LocaleKeys.bottomNavigation_Favorites.tr(),
              icon: AppIcons.heart,
              activeIcon: AppIcons.heartActive,
            ),
            BottmBarModel(
              lable: LocaleKeys.bottomNavigation_companies.tr(),
              icon: AppIcons.company,
              activeIcon: AppIcons.companyFill,
            ),
            BottmBarModel(
              lable: LocaleKeys.bottomNavigation_settings.tr(),
              icon: AppIcons.settings,
              activeIcon: AppIcons.settings,
            ),
          ],
        ),
      ),
    );
  }
}
