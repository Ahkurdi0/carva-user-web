import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/widget/app_textfeild.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/features/auth/data/model/auth.dart';
import 'package:kcars/features/auth/presentation/riverpod/auth_controller.dart';
import 'package:kcars/features/auth/presentation/riverpod/auth_states.dart';
import 'package:kcars/features/auth/presentation/screens/widget/auth_header.dart';
import 'package:kcars/features/auth/presentation/screens/widget/unfocus.dart';
import 'package:kcars/features/auth/presentation/widgets/scroll_padding.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class ResetPasswordScreen extends HookConsumerWidget {
  const ResetPasswordScreen({super.key, required this.auth});
  final Auth auth;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authControllerProvider, (previous, next) {
      if (next is ResetPasswordCompleted) {
        showCustomAlert(
          context,
          content: LocaleKeys.alertMessages_resetPassword.tr(),
          primaryButtonText: LocaleKeys.buttons_login.tr(),
          primaryAction: () {
            context.router.replaceAll([LoginRoute(backButton: false)]);
          },
        );
      }
    });
    final key = useMemoized(() => GlobalKey<FormState>(), []);
    final password = useTextEditingController();
    return UnFocus(
      child: Scaffold(
        body: ScrollPadding(
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthHeader(
                  title: LocaleKeys.auth_reset_title.tr(),
                  subTitle: LocaleKeys.auth_reset_desc.tr(),
                ),
                AppTextField(
                  controller: password,
                  onFieldSubmitted: (v) {
                    FocusManager.instance.primaryFocus?.requestFocus();
                  },
                  label: LocaleKeys.inputLabels_newPassword.tr(),
                  autoFocus: true,
                  maxLength: 16,
                  isPassword: true,
                  validator: (value) => value!.length >= 8
                      ? null
                      : LocaleKeys.validations_password.tr(),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryButton(
              width: 90.w,
              text: LocaleKeys.buttons_update.tr(),
              onPress: () {
                if (!key.currentState!.validate()) return;
                ref
                    .read(authControllerProvider.notifier)
                    .resetPassword(auth.copyWith(password: password.text));
              },
            ),
          ],
        ),
      ),
    );
  }
}
