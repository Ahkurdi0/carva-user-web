import 'package:flutter/material.dart';
import 'package:kcars/configs/permissins.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/user/presentation/user_screens/user_details_screen.dart';
import 'package:kcars/features/user/presentation/view/account_status_view.dart';

class UserDetailsTabs {
  final Tab tab;
  final Widget screen;
  final Permissions permissions;

  UserDetailsTabs({
    required this.tab,
    required this.screen,
    required this.permissions,
  });
}

List<UserDetailsTabs> userDetailsTabScreens(Profile profile) {
  return [
    UserDetailsTabs(
      tab: Tab(text: "Books"), //Tab(text: LocaleKeys.tabbBar_orders.tr()),
      screen: UserBookedView(profile: profile),
      permissions: Permissions.books,
    ),
    UserDetailsTabs(
      tab: Tab(
        text: "Car Review",
      ), //Tab(text: LocaleKeys.tabbBar_deposits.tr()),
      screen: UserCarReviewView(profile: profile),
      permissions: Permissions.carReviews,
    ),
    UserDetailsTabs(
      tab: Tab(
        text: "Company review",
      ), //Tab(text: LocaleKeys.tabbBar_deposits.tr()),
      screen: UserCompanyReviewView(profile: profile),
      permissions: Permissions.companyReviews,
    ),

    UserDetailsTabs(
      tab: Tab(
        text: "Account Status",
      ), //Tab(text: LocaleKeys.admin_tabbs_accountStatus.tr()),
      screen: AccountStatusView(profile),
      permissions: Permissions.accountStatus,
    ),
  ];
}
