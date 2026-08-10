import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/admin_tabbar_screens.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/features/app_settings/presentation/screen/views/admin_options_view.dart';
import 'package:kcars/features/auth/data/model/permissions.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class MainAdminScreen extends StatefulHookConsumerWidget {
  final List<Permissions> permissions;
  const MainAdminScreen({super.key, required this.permissions});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MainAdminScreenState();
}

class _MainAdminScreenState extends ConsumerState<MainAdminScreen> {
  late List<AdminTabbarScreens> _availableScreens = [];

  List<PageRouteInfo> routes = [];

  @override
  void initState() {
    super.initState();
    _initializeAvailableScreens();
  }

  void _initializeAvailableScreens() async {
    _availableScreens = adminTabbarScreens
        .where(
          (screenData) => widget.permissions.any((e) {
            return e.permission.permissionName == screenData.permission;
          }),
        )
        .toList();

    routes = _availableScreens.map((screenData) => screenData.screen).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: routes.isEmpty ? [EmptyRoute()] : routes,
      animationDuration: Duration.zero,
      bottomNavigationBuilder: (context, tabsRouter) => CustomTabbar(
        currentIndex: tabsRouter.activeIndex,
        onTap: (index) => tabsRouter.setActiveIndex(index),
        tabs: _availableScreens.map((e) => e.bottomNavigationBarItem).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.secondary,
        onPressed: () {
          showCustomBottomSheet(context, AdminSettings());
        },
        child: const Icon(Icons.settings),
      ),
    );
  }
}

class CustomTabbar extends StatelessWidget {
  const CustomTabbar({
    super.key,
    required this.currentIndex,
    required this.tabs,
    required this.onTap,
  });
  final int currentIndex;

  final List<CustomTab> tabs;
  final Function(int activeTab) onTap;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 20.w,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(width: .75, color: context.outline)),
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: tabs
              .asMap()
              .entries
              .map(
                (v) => InkResponse(
                  onTap: () => onTap(v.key),
                  child: Ink(
                    color: context.surface,
                    width: 18.w,
                    height: 18.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        v.value.icon,
                        SizedBox(height: 1.w),
                        AnimatedDefaultTextStyle(
                          style: currentIndex == v.key
                              ? context.label.copyWith(fontSize: 14.sp)
                              : context.label.copyWith(
                                  fontSize: 14.sp,
                                  color: context.outline,
                                ),
                          duration: const Duration(milliseconds: 200),
                          child: FittedBox(child: Text(v.value.label)),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class CompanyOptions extends StatelessWidget {
  const CompanyOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            dense: true,
            splashColor: Colors.transparent,
            title: Text(LocaleKeys.buttons_newCar.tr()),
            onTap: () {
              context.router.push(NewEditCarRoute());
            },
          ),
          ListTile(
            dense: true,
            splashColor: Colors.transparent,
            title: Text(LocaleKeys.buttons_updateCompany.tr()),
            onTap: () {
              context.router.push(EditCompanyRoute());
            },
          ),
        ],
      ),
    );
  }
}
