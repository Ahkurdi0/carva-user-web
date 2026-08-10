import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/app_bar.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/loading_emoty_state.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class NotLoggedinScreen extends StatelessWidget {
  const NotLoggedinScreen({super.key, this.content, this.icon});
  final String? content;
  final String? icon;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EmptyWidget(
              icon: AppIcons.notLoggedIn,
              emptyMessage: LocaleKeys.alertMessages_notLoggedInFavScreen.tr(),
            ),
            Gap(10.w),
            PrimaryButton(
              width: 50.w,
              height: 10.w,
              text: LocaleKeys.buttons_login.tr(),
              onPress: () {
                context.router.push(LoginRoute());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key, this.message});
  final String? message;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          EmptyState(),
          Positioned(
            bottom: 20.w,
            child: Text(message ?? "No data found", style: context.caption),
          ),
        ],
      ),
    );
  }
}
