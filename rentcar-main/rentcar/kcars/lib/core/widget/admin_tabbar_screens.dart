import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/configs/permissins.dart';
import 'package:kcars/translations/locale_keys.g.dart';

class AdminTabbarScreens {
  final PageRouteInfo screen;
  final String permission;
  final CustomTab bottomNavigationBarItem;
  AdminTabbarScreens({
    required this.screen,
    required this.permission,
    required this.bottomNavigationBarItem,
  });
}

List<AdminTabbarScreens> adminTabbarScreens = [
  AdminTabbarScreens(
    screen: const UsersRoute(),
    permission: Permissions.users.value,
    bottomNavigationBarItem: CustomTab(
      icon: const Icon(Icons.person),
      label: LocaleKeys.bottomNavigation_users.tr(),
    ),
  ),
  AdminTabbarScreens(
    screen: const CompaniesRoute(),
    permission: Permissions.company.value,
    bottomNavigationBarItem: CustomTab(
      icon: const Icon(Icons.business_outlined),
      label: LocaleKeys.bottomNavigation_companies.tr(),
    ),
  ),
  AdminTabbarScreens(
    screen: const AllCarsRoute(),
    permission: Permissions.companyCars.value,
    bottomNavigationBarItem: CustomTab(
      icon: const Icon(Icons.car_rental),
      label: LocaleKeys.bottomNavigation_cars.tr(),
    ),
  ),
  AdminTabbarScreens(
    screen: const FeaturedCarsRoute(),
    permission: Permissions.companyCars.value,
    bottomNavigationBarItem: CustomTab(
      icon: const Icon(Icons.car_rental),
      label: LocaleKeys.bottomNavigation_featured.tr(),
    ),
  ),
  // AdminTabbarScreens(
  //   screen: const AllBooksRoute(),
  //   permission: Permissions.books.value,
  //   bottomNavigationBarItem: CustomTab(
  //     icon: const Icon(Icons.book),
  //     label: LocaleKeys.bottomNavigation_reservations.tr(),
  //   ),
  // ),
  // AdminTabbarScreens(
  //   screen: const AllCarReviewRoute(),
  //   permission: Permissions.carReviews.value,
  //   bottomNavigationBarItem: CustomTab(
  //     icon: const Icon(Icons.star),
  //     label: LocaleKeys.bottomNavigation_car.tr(),
  //   ),
  // ),
  // AdminTabbarScreens(
  //   screen: const AllCompanyReviewRoute(),
  //   permission: Permissions.companyReviews.value,
  //   bottomNavigationBarItem: CustomTab(
  //     icon: const Icon(Icons.star),
  //     label: LocaleKeys.bottomNavigation_company.tr(),
  //   ),
  // ),
  // AdminTabbarScreens(
  //   screen: const CarReviewsFlagRoute(),
  //   permission: Permissions.carReviewsFlag.value,
  //   bottomNavigationBarItem: CustomTab(
  //     icon: const Icon(Icons.star_border),
  //     label: LocaleKeys.bottomNavigation_car.tr(),
  //   ),
  // ),
  // AdminTabbarScreens(
  //   screen: const CompanyReviewsFlagRoute(),
  //   permission: Permissions.companyReviewsFlag.value,
  //   bottomNavigationBarItem: CustomTab(
  //     icon: const Icon(Icons.star_border),
  //     label: LocaleKeys.bottomNavigation_company.tr(),
  //   ),
  // ),
];

class CustomTab {
  final String label;
  final Icon icon;

  CustomTab({required this.label, required this.icon});
}
