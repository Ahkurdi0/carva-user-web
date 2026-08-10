import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/configs/permissins.dart';
import 'package:kcars/core/providers/app_router_provider.dart';
import 'package:kcars/translations/locale_keys.g.dart';

class AdminSettingsScreen {
  final String permission;
  final Widget child;

  AdminSettingsScreen({required this.permission, required this.child});
}

List<AdminSettingsScreen> adminOptions(Ref ref) => [
  AdminSettingsScreen(
    permission: Permissions.brands.value,
    child: ListTile(
      leading: const Icon(Icons.branding_watermark),
      onTap: () => ref.read(appRouterProvider).push(const BrandsRoute()),
      title: Text(LocaleKeys.buttons_brands.tr()),
    ),
  ),
  AdminSettingsScreen(
    permission: Permissions.cities.value,
    child: ListTile(
      leading: const Icon(Icons.location_city),
      onTap: () => ref.read(appRouterProvider).push(const CityRoute()),
      title: Text(LocaleKeys.buttons_cities.tr()),
    ),
  ),
  AdminSettingsScreen(
    permission: Permissions.carTypes.value,
    child: ListTile(
      leading: const Icon(Icons.category_rounded),
      onTap: () => ref.read(appRouterProvider).push(const CarTypesRoute()),
      title: Text(LocaleKeys.buttons_carTypes.tr()),
    ),
  ),
  AdminSettingsScreen(
    permission: Permissions.sliders.value,
    child: ListTile(
      leading: const Icon(Icons.view_carousel_rounded),
      onTap: () => ref.read(appRouterProvider).push(SlidersRoute()),
      title: Text(LocaleKeys.buttons_Slider.tr()),
    ),
  ),

  AdminSettingsScreen(
    permission: Permissions.notification.value,
    child: ListTile(
      leading: const Icon(Icons.notification_add),
      onTap: () =>
          ref.read(appRouterProvider).push(const NewNotificationRoute()),
      title: Text(LocaleKeys.buttons_notification.tr()),
    ),
  ),
  AdminSettingsScreen(
    permission: Permissions.companyStatistics.value,
    child: ListTile(
      leading: const Icon(Icons.bar_chart),
      onTap: () =>
          ref.read(appRouterProvider).push(const CompanyStatiscsRoute()),
      title: Text(LocaleKeys.buttons_contactStistics.tr()),
    ),
  ),
  AdminSettingsScreen(
    permission: Permissions.adminStatistics.value,
    child: ListTile(
      leading: const Icon(Icons.bar_chart),
      onTap: () => ref.read(appRouterProvider).push(const StatisticsRoute()),
      title: Text(LocaleKeys.buttons_statistics.tr()),
    ),
  ),
  AdminSettingsScreen(
    permission: Permissions.support.value,
    child: ListTile(
      leading: const Icon(Icons.support_agent),
      onTap: () => ref.read(appRouterProvider).push(const SupportsRoute()),
      title: Text(LocaleKeys.buttons_supports.tr()),
    ),
  ),
];
