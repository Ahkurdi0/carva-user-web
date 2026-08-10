import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class MainCompanyScreen extends StatelessWidget {
  const MainCompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [CompanyCarsRoute()],

      floatingActionButton: FloatingActionButton(
        backgroundColor: context.secondary,
        onPressed: () {
          showCustomBottomSheet(context, CompanyOptions());
        },
        child: const Icon(Icons.settings),
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
            leading: Icon(Icons.add),
            dense: true,
            splashColor: Colors.transparent,
            title: Text(LocaleKeys.buttons_newCar.tr()),
            onTap: () {
              context.router.push(NewEditCarRoute());
            },
          ),
          ListTile(
            leading: Icon(Icons.edit, size: 5.w),
            dense: true,
            splashColor: Colors.transparent,
            title: Text(LocaleKeys.buttons_editCompany.tr()),
            onTap: () {
              context.router.push(EditCompanyRoute());
            },
          ),
        ],
      ),
    );
  }
}
