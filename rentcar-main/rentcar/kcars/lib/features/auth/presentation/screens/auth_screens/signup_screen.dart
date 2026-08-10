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
import 'package:kcars/features/auth/presentation/widgets/scroll_padding.dart';
import 'package:kcars/translations/locale_keys.g.dart';

import 'package:sizer/sizer.dart';

@RoutePage()
class SignupScreen extends HookConsumerWidget {
  const SignupScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    ref.listen(authControllerProvider, (previous, next) {
      if (next is SignupCompleted) {
        context.router.replaceAll([const MainRoute()]);
      }
      if (next is SignupFailed) {
        showCustomAlert(context, content: next.message);
      }
    });

    final auth = ref.watch(authControllerProvider);

    final name = useTextEditingController();
    final email = useTextEditingController();
    final phone = useTextEditingController();
    final password = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text(LocaleKeys.screens_sigUp.tr()),
      ),
      body: ScrollPadding(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                controller: name,
                label: LocaleKeys.inputLabels_name.tr(),
                hint: LocaleKeys.inputHintText_yourName.tr(),
                validator: (value) => value!.length >= 3
                    ? null
                    : LocaleKeys.validations_name.tr(),
              ),
              Gap(4.w),
              AppTextField(
                controller: email,
                label: LocaleKeys.inputLabels_email.tr(),
                hint: "example@gmail.com",
                validator: (value) => value!.isValidEmail()
                    ? null
                    : LocaleKeys.validations_invalidEmail.tr(),
              ),
              Gap(4.w),
              AppTextField(
                controller: phone,
                label:
                    "${LocaleKeys.inputLabels_phoneNumber.tr()} (${LocaleKeys.labels_optional.tr()})",
                hint: "77Xxxxxxxx",
                isPhoneNumber: true,
                validator: (value) => value!.isEmpty || value.length == 10
                    ? null
                    : LocaleKeys.validations_phone.tr(),
              ),
              Gap(4.w),
              AppTextField(
                controller: password,
                label: LocaleKeys.inputLabels_password.tr(),
                hint: "••••••••",
                isPassword: true,
                validator: (value) => value!.length >= 8
                    ? null
                    : LocaleKeys.validations_password.tr(),
              ),
              Gap(8.w),
              PrimaryButton(
                isLoading: auth is SignupLoading,
                text: LocaleKeys.buttons_signup.tr(),
                onPress: () {
                  if (!formKey.currentState!.validate()) return;
                  ref
                      .read(authControllerProvider.notifier)
                      .signup(
                        Auth(
                          name: name.text,
                          email: email.text,
                          phoneNumber: phone.text.nullIfEmpty(),
                          password: password.text,
                          countryCode: "+964",
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
