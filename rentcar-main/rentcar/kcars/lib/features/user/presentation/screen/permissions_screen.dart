import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/loading_emoty_state.dart';
import 'package:kcars/features/auth/data/model/permission.dart';
import 'package:kcars/features/auth/data/model/permissions.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/user/application/user_controller.dart';
import 'package:kcars/features/user/application/user_states.dart';
import 'package:kcars/features/user/data/model/post_role.dart';
import 'package:kcars/features/user/presentation/riverpod/permissions_provider.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class PermissionsScreen extends StatefulHookConsumerWidget {
  const PermissionsScreen(this.profile, {super.key});
  final Profile profile;

  @override
  ConsumerState<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends ConsumerState<PermissionsScreen> {
  late List<Permission> permissions = [];

  @override
  void initState() {
    super.initState();
    permissions = widget.profile.permissions
        .map((permission) => permission.permission)
        .toList();
  }

  void changePermission(Permission permissionId) {
    setState(() {
      if (permissions.contains(permissionId)) {
        permissions.remove(permissionId);
      } else {
        permissions.add(permissionId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataValue = ref.watch(allPermissionsProvider);
    final controller = ref.watch(userControllerProvider);
    ref.listen(userControllerProvider, (previous, next) {
      if (next is UpdateUserRoleFailed) {
        showMessages(context, message: next.message);
      }
      if (next is UpdateUserRoleCompleted) {
        context.maybePop();
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.profile.name),
        leading: const CustomBackButton(),
      ),
      body: switch (dataValue) {
        AsyncData(:final value) => RefreshIndicator(
          onRefresh: () async => ref.refresh(allPermissionsProvider.future),
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 50.w),
            itemCount: value.length,
            itemBuilder: (context, index) {
              final permission = value[index];
              return CheckboxListTile.adaptive(
                controlAffinity: ListTileControlAffinity.leading,
                visualDensity: VisualDensity.compact,
                dense: true,
                value: permissions.contains(permission),
                title: Text(permission.description ?? ""),
                onChanged: (v) => changePermission(permission),
              );
            },
          ),
        ),
        AsyncError(:final error) => Text(error.toString()),
        _ => const Center(child: CircleLoading()),
      },

      bottomSheet: Container(
        padding: EdgeInsets.only(bottom: 10.w, top: 4.w, left: 4.w, right: 4.w),
        child: PrimaryButton(
          isLoading: controller is UpdateUserRoleLoading,
          text: LocaleKeys.buttons_update.tr(),
          onPress: () {
            ref
                .read(userControllerProvider.notifier)
                .updateRole(
                  PostRole(
                    userId: widget.profile.userId,
                    role: widget.profile.role.copyWith(roleName: "admin"),
                    permissions: permissions
                        .map((e) => Permissions(permission: e))
                        .toList(),
                  ),
                  widget.profile.copyWith(
                    permissions: permissions
                        .map((e) => Permissions(permission: e))
                        .toList(),
                  ),
                );
          },
        ),
      ),
    );
  }
}
