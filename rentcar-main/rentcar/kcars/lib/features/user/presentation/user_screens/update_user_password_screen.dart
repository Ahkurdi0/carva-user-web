import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/widget/app_textfeild.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/user/application/user_controller.dart';
import 'package:kcars/features/user/application/user_states.dart';
import 'package:kcars/features/user/data/model/user_password.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class UpdateUserPasswordScreen extends HookConsumerWidget {
  const UpdateUserPasswordScreen(this.profile, {super.key});
  final Profile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contrller = ref.watch(userControllerProvider);
    final password = useTextEditingController();
    final fromKey = useMemoized(() => GlobalKey<FormState>(), []);

    ref.listen(userControllerProvider, (previous, next) {
      if (next is UpdateUserPasswordCompleted) {
        showMessages(context, message: LocaleKeys.alertMessages_updated.tr());
        context.maybePop();
      }
      if (next is UpdateUserPasswordFailed) {
        showMessages(context, message: next.message);
      }
    });
    return Scaffold(
      appBar: AppBar(title: Text(profile.name), leading: CustomBackButton()),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
        ).copyWith(top: 4.w, bottom: 20.w),
        child: Form(
          key: fromKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(
                label: LocaleKeys.inputLabels_newPassword.tr(),
                hint: "••••••••",
                controller: password,
                isPassword: true,
                autoFocus: true,
                validator: (value) => value!.length >= 8
                    ? null
                    : LocaleKeys.validations_password.tr(),
              ),
              SizedBox(height: 4.w),
              PrimaryButton(
                isActive: true,
                text: LocaleKeys.buttons_update.tr(),
                isLoading: contrller is UpdateUserRoleLoading,
                onPress: () {
                  if (!fromKey.currentState!.validate()) return;
                  ref
                      .read(userControllerProvider.notifier)
                      .updateUserPassword(
                        UserPassword(
                          password: password.text,
                          userId: profile.userId,
                        ),
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
