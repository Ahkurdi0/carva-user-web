import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/configs/permissins.dart';
import 'package:kcars/core/providers/app_router_provider.dart';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/auth/data/model/role.dart';
import 'package:kcars/features/user/application/user_controller.dart';
import 'package:kcars/features/user/data/model/post_role.dart';
import 'package:kcars/translations/locale_keys.g.dart';

class AdminUserOptions {
  final String permission;
  final Widget child;

  AdminUserOptions({required this.permission, required this.child});
}

List<AdminUserOptions> adminUserOptions(Profile profile, Ref ref) {
  final context = sl<GlobalKey<NavigatorState>>().currentContext!;
  return [
    AdminUserOptions(
      permission: Permissions.userRoles.value,
      child: ListTile(
        leading: const Icon(Icons.person),
        onTap: () {
          showCustomBottomSheet(context, UpdateUserRoleContent(profile));
        },
        title: Text(LocaleKeys.buttons_role.tr()),
      ),
    ),

    AdminUserOptions(
      permission: Permissions.createCompany.value,
      child: ListTile(
        leading: const Icon(Icons.person),
        onTap: () {
          ref
              .read(appRouterProvider)
              .push(
                NewEditCompanyRoute(profile: profile, company: profile.company),
              );
        },
        title: Text(
          profile.company == null
              ? LocaleKeys.buttons_newCompany.tr()
              : LocaleKeys.buttons_editCompany.tr(),
        ),
      ),
    ),

    AdminUserOptions(
      permission: Permissions.accountStatus.value,
      child: ListTile(
        leading: const Icon(Icons.lock),
        onTap: () =>
            ref.read(appRouterProvider).push(BanUserRoute(profile: profile)),
        title: Text(LocaleKeys.buttons_ban.tr()),
      ),
    ),
    AdminUserOptions(
      permission: Permissions.updateUserPassword.value,
      child: ListTile(
        leading: const Icon(Icons.lock),
        onTap: () {
          ref
              .read(appRouterProvider)
              .push(UpdateUserPasswordRoute(profile: profile));
        },
        title: Text(LocaleKeys.buttons_updatePassword.tr()),
      ),
    ),
    AdminUserOptions(
      permission: Permissions.recoverAccount.value,
      child: ListTile(
        leading: const Icon(Icons.history),
        onTap: () {
          showCustomAlert(
            context,
            content: LocaleKeys.alertMessages_recoverAccount.tr(),
            primaryAction: () {
              ref
                  .read(userControllerProvider.notifier)
                  .recoverAccount(profile.userId);
            },
          );
        },
        title: Text(LocaleKeys.buttons_recoverAccount.tr()),
      ),
    ),
  ];
}

class UpdateUserRoleContent extends ConsumerWidget {
  const UpdateUserRoleContent(this.profile, {super.key});
  final Profile profile;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          leading: const Icon(Icons.star),
          onTap: () {
            Navigator.pop(context);
            ref
                .read(appRouterProvider)
                .push(PermissionsRoute(profile: profile));
          },
          title: Text(LocaleKeys.buttons_admin.tr()),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          onTap: () {
            ref
                .read(userControllerProvider.notifier)
                .updateRole(
                  PostRole(
                    role: Role(roleId: "", roleName: "user"),
                    userId: profile.userId,
                    permissions: [],
                  ),
                  profile.copyWith(permissions: []),
                );
          },
          title: Text(LocaleKeys.buttons_user.tr()),
        ),
      ],
    );
  }
}
