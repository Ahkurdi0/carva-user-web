import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/app_textfeild.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/user/application/user_controller.dart';
import 'package:kcars/features/user/application/user_states.dart';
import 'package:kcars/features/user/data/model/account_status.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class BanUserScreen extends HookConsumerWidget {
  const BanUserScreen({super.key, required this.profile, this.accountStatus});
  final Profile profile;
  final AccountStatus? accountStatus;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final banController = useTextEditingController(
      text: accountStatus?.bannedUntil?.formatDate2(context),
    );

    final kuTitle = useTextEditingController(text: accountStatus?.title);
    final kuDescription = useTextEditingController(
      text: accountStatus?.description,
    );

    final bannedUntil = useState<DateTime?>(
      accountStatus?.bannedUntil ?? DateTime.now(),
    );

    final ban = ref.watch(userControllerProvider);

    final formKey = useMemoized(() => GlobalKey<FormState>(), []);

    ref.listen(userControllerProvider, (previous, next) {
      if (next is UpdateAccountStatusFailed) {
        showCustomAlert(context, content: next.message);
      }
      if (next is UpdateAccountStatusCompleted) {
        Navigator.pop(context);
      }
    });

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(),
          title: Text(profile.name),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
          ).copyWith(top: 4.w, bottom: 10.w),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 4.w),
                AppTextField(
                  label: LocaleKeys.inputLabels_banUtil.tr(),
                  hint: DateTime.now().formatDate2(context),
                  controller: banController,
                  autoFocus: true,
                  readOnly: true,
                  onTap: () async {
                    final dd = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (dd != null && context.mounted) {
                      bannedUntil.value = dd;
                      banController.text = dd.formatDate2(context);
                    }
                  },
                ),
                SizedBox(height: 4.w),
                AppTextField(
                  label: LocaleKeys.inputLabels_title.tr(),
                  controller: kuTitle,
                ),
                SizedBox(height: 4.w),
                AppTextField(
                  label: LocaleKeys.inputLabels_content.tr(),
                  multiLine: true,
                  maxHeight: 30.w,
                  controller: kuDescription,
                ),
                SizedBox(height: 4.w),
                PrimaryButton(
                  isLoading: ban is UpdateAccountStatusLoading,
                  isActive: true,
                  text: accountStatus == null
                      ? LocaleKeys.buttons_ban.tr()
                      : LocaleKeys.buttons_update.tr(),
                  onPress: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    ref
                        .read(userControllerProvider.notifier)
                        .updateAccountStatus(
                          AccountStatus(
                            id: accountStatus?.id,
                            title: kuTitle.text,
                            description: kuDescription.text,
                            userId: profile.userId,
                            bannedAt: DateTime.now(),
                            bannedUntil: bannedUntil.value!.toUtc(),
                            profile: profile,
                          ),
                        );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
