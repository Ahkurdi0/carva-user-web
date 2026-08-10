import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/providers/connectivity.dart';
import 'package:kcars/core/providers/shee_controller.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/bottm_bar.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/features/auth/presentation/riverpod/current_user_controller.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

@RoutePage()
class MainScreen extends StatefulHookConsumerWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final network = ref.watch(networkAwareProvider);
    if (network == NetworkStatus.off) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.router.replaceAll([const ConnectivityRoute()]);
      });
    }
    final locale = useMemoized(() => context.locale.languageCode, []);
    final contrller = ref.watch(sheetControllerProvider);
    return AutoTabsScaffold(
      extendBody: true,
      animationDuration: Duration.zero,
      routes: [
        HomeRoute(),
        FavoriteRoute(),
        AllCompaniesRoute(),
        SettingsRoute(),
      ],
      bottomNavigationBuilder: (context, tab) => SlideTransition(
        position: SheetOffsetDrivenAnimation(
          controller: contrller,
          initialValue: 1,
        ).drive(Tween(begin: const Offset(0, 1), end: Offset.zero)),
        child: CustomBottomNavigationBar(
          key: ValueKey(locale),
          onTap: (index) {
            tab.setActiveIndex(index);
          },
          tabs: [
            BottmBarModel(
              lable: LocaleKeys.bottomNavigation_car.tr(),
              icon: AppIcons.car,
              activeIcon: AppIcons.carActive,
            ),
            BottmBarModel(
              lable: LocaleKeys.bottomNavigation_Favorites.tr(),
              icon: AppIcons.heart,
              activeIcon: AppIcons.heartActive,
            ),
            BottmBarModel(
              lable: LocaleKeys.bottomNavigation_company.tr(),
              icon: AppIcons.company,
              activeIcon: AppIcons.companyFill,
            ),
            BottmBarModel(
              lable: LocaleKeys.bottomNavigation_setting.tr(),
              icon: AppIcons.settings,
              activeIcon: AppIcons.settingsActive,
            ),
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) {
          final currentUser = ref.watch(currentUserControllerProvider);
          return currentUser.when(
            loading: () => SizedBox.shrink(),
            error: (error, stackTrace) => SizedBox.shrink(),
            data: (user) {
              return Padding(
                padding: EdgeInsets.only(bottom: 0.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (user?.company != null)
                      FloatingActionButton.extended(
                        heroTag: "company",
                        backgroundColor: context.secondary,
                        label: Text(LocaleKeys.buttons_company.tr()),
                        onPressed: () {
                          final isExpired =
                              user?.company?.expiresAt?.isBefore(
                                DateTime.now(),
                              ) ??
                              true;

                          if (isExpired) {
                            showCustomAlert(
                              context,
                              content: LocaleKeys.alertMessages_companyExpired
                                  .tr(),
                            );
                            return;
                          }
                          context.router.push(MainCompanyRoute());
                        },
                      ),
                    Gap(2.w),
                    if (user?.role.roleName == "admin")
                      FloatingActionButton.extended(
                        heroTag: "admin",
                        backgroundColor: context.secondary,
                        label: Text(LocaleKeys.buttons_dashbord.tr()),
                        onPressed: () {
                          context.router.push(
                            MainAdminRoute(
                              permissions: user?.permissions ?? [],
                            ),
                          );
                        },
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
