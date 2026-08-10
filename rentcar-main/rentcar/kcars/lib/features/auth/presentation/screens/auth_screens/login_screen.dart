import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/widget/app_textfeild.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/features/auth/data/model/auth.dart';
import 'package:kcars/features/auth/presentation/riverpod/auth_controller.dart';
import 'package:kcars/features/auth/presentation/riverpod/auth_states.dart';
import 'package:kcars/features/auth/presentation/screens/widget/unfocus.dart';
import 'package:kcars/features/auth/presentation/widgets/scroll_padding.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key, this.backButton = true});
  final bool backButton;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    ref.listen(authControllerProvider, (previous, next) {
      if (next is AuthCompleted) {
        context.router.replaceAll([const MainRoute()]);
      }
      if (next is AuthFailed) {
        showCustomAlert(context, content: next.message);
      }
    });
    final email = useTextEditingController();
    final password = useTextEditingController();
    final auth = ref.watch(authControllerProvider);

    final readOnly = auth is AuthLoading || auth is AuthCompleted;
    return UnFocus(
      child: Scaffold(
        appBar: AppBar(
          leading: backButton ? CustomBackButton() : null,
          title: Text(LocaleKeys.screens_login.tr()),
        ),
        body: ScrollPadding(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  controller: email,
                  readOnly: readOnly,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (_) =>
                      FocusManager.instance.primaryFocus?.requestFocus(),
                  label: LocaleKeys.inputLabels_email.tr(),
                  hint: "example@gmail.com",
                  validator: (value) => value!.isValidEmail()
                      ? null
                      : LocaleKeys.validations_invalidEmail.tr(),
                  autoFocus: true,
                ),
                Gap(4.w),
                AppTextField(
                  onFieldSubmitted: (_) =>
                      FocusManager.instance.primaryFocus?.requestFocus(),
                  controller: password,
                  readOnly: readOnly,
                  label: LocaleKeys.inputLabels_password.tr(),
                  hint: "••••••••",
                  isPassword: true,
                  validator: (value) => value!.length >= 8
                      ? null
                      : LocaleKeys.validations_password.tr(),
                ),
                Gap(4.w),
                GestureDetector(
                  onTap: () {
                    context.router.push(ResetSendOtpRoute());
                  },
                  child: Text(
                    LocaleKeys.buttons_forgotPassword.tr(),
                    style: context.label.copyWith(color: context.outline),
                  ),
                ),
                Gap(4.w),
                PrimaryButton(
                  text: LocaleKeys.buttons_login.tr(),
                  isLoading: auth is AuthLoading,
                  onPress: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (!formKey.currentState!.validate()) return;

                    ref
                        .read(authControllerProvider.notifier)
                        .login(
                          Auth(
                            email: email.text,
                            password: password.text,
                            prefLang: context.locale.toLanguageTag(),
                          ),
                        );
                  },
                ),
                Gap(4.w),
                Center(
                  child: TertiaryButton(
                    title: LocaleKeys.buttons_createAccount.tr(),
                    onPress: () {
                      context.router.push(SignupRoute());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
