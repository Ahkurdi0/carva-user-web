import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/widget/app_textfeild.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/features/auth/data/model/auth.dart';
import 'package:kcars/features/auth/presentation/riverpod/auth_controller.dart';
import 'package:kcars/features/auth/presentation/riverpod/auth_states.dart';
import 'package:kcars/features/auth/presentation/screens/widget/auth_header.dart';
import 'package:kcars/features/auth/presentation/screens/widget/swithcher.dart';
import 'package:kcars/features/auth/presentation/screens/widget/unfocus.dart';
import 'package:kcars/features/auth/presentation/widgets/scroll_padding.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class ResetSendOtpScreen extends HookConsumerWidget {
  const ResetSendOtpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useTextEditingController();

    ref.listen(authControllerProvider, (previous, next) {
      if (next is ResetSendOtpCompleted) {
        context.router.push(ResetVerifyOtpRoute(auth: Auth(email: email.text)));
      }
    });

    final auth = ref.watch(authControllerProvider);

    final key = useMemoized(() => GlobalKey<FormState>(), []);
    return UnFocus(
      child: Scaffold(
        body: ScrollPadding(
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthHeader(
                  title: LocaleKeys.auth_send_title.tr(),
                  subTitle: LocaleKeys.auth_send_desc.tr(),
                ),
                AppTextField(
                  controller: email,
                  label: LocaleKeys.inputLabels_email.tr(),
                  autoFocus: true,
                  maxLength: 100,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (v) {
                    FocusManager.instance.primaryFocus?.requestFocus();
                  },
                  validator: (value) => value!.isValidEmail()
                      ? null
                      : LocaleKeys.validations_invalidEmail.tr(),
                ),
                Gap(2.w),
                Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(authControllerProvider);
                    return SwitchWidget(
                      showChild: state is ResetSendOtpFailed,
                      child: Text(
                        state is ResetSendOtpFailed ? state.message : "",
                        style: context.caption.copyWith(color: context.error),
                      ),
                    );
                  },
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
              isLoading: auth is ResetSendOtpLoading,
              width: 90.w,
              text: LocaleKeys.buttons_send.tr(),
              onPress: () {
                if (!key.currentState!.validate()) return;
                ref
                    .read(authControllerProvider.notifier)
                    .resetSendOtp(Auth(email: email.text));
              },
            ),
            Gap(2.w),
            TertiaryButton(
              title: LocaleKeys.buttons_back.tr(),
              onPress: () {
                context.maybePop();
              },
            ),
            Gap(2.w),
          ],
        ),
      ),
    );
  }
}
