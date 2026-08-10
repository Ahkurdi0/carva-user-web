import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/app_textfeild.dart';
import 'package:kcars/core/widget/buttons.dart';
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
class ResetVerifyOtpScreen extends HookConsumerWidget {
  const ResetVerifyOtpScreen({super.key, required this.auth});
  final Auth auth;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final code = useTextEditingController();
    ref.listen(authControllerProvider, (previous, next) {
      if (next is ResetVerifyOtpCompleted) {
        context.router.push(
          ResetPasswordRoute(auth: auth.copyWith(code: code.text)),
        );
      }
    });
    final controller = ref.watch(authControllerProvider);

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
                  title: LocaleKeys.auth_verify_title.tr(),
                  subTitle:
                      "${LocaleKeys.auth_verify_desc.tr()}  ${auth.email}",
                ),

                AppTextField(
                  controller: code,
                  onFieldSubmitted: (v) {
                    FocusManager.instance.primaryFocus?.requestFocus();
                  },
                  label: LocaleKeys.inputLabels_otp.tr(),
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  autoFocus: true,
                  validator: (value) => value!.length == 6
                      ? null
                      : LocaleKeys.validations_otp.tr(),
                ),
                Gap(2.w),
                Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(authControllerProvider);
                    return SwitchWidget(
                      showChild: state is ResetVerifyOtpFailed,
                      child: Text(
                        state is ResetVerifyOtpFailed ? state.message : "",
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
              width: 90.w,
              text: LocaleKeys.buttons_verify.tr(),
              isLoading: controller is ResetVerifyOtpLoading,
              onPress: () {
                if (!key.currentState!.validate()) return;
                ref
                    .read(authControllerProvider.notifier)
                    .resetVerifyOtp(auth.copyWith(code: code.text));
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
