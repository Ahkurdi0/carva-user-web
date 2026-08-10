import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/widget/app_textfeild.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/features/app_settings/application/app_settigngs_controller.dart';
import 'package:kcars/features/app_settings/application/states.dart';
import 'package:kcars/features/app_settings/data/model/notifications.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class NewNotificationScreen extends HookConsumerWidget {
  const NewNotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enTitle = useTextEditingController();
    final enDesc = useTextEditingController();

    final arTitle = useTextEditingController();
    final arDesc = useTextEditingController();

    final kuTitle = useTextEditingController();
    final kuDesc = useTextEditingController();

    ref.listen(appSettingsControllerProvider, (prev, next) {
      if (next is NewNotificationCompleted) {
        showMessages(context, message: LocaleKeys.alertMessages_success.tr());
        // context.maybePop();
      }
      if (next is NewNotificationFailed) {
        showMessages(context, message: next.message);
      }
    });
    final controller = ref.watch(appSettingsControllerProvider);
    final formKey = useMemoized(() => GlobalKey<FormState>(), []);

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.screens_notification.tr()),
        leading: const CustomBackButton(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
        ).copyWith(top: 4.w, bottom: 20.w),
        child: Form(
          key: formKey,
          child: Column(
            spacing: 3.w,
            children: [
              AppTextField(controller: kuTitle, label: "ناونیشان"),
              AppTextField(controller: kuDesc, label: "ناوەڕۆک"),
              AppTextField(controller: arTitle, label: "عنوان"),
              AppTextField(controller: arDesc, label: "محتوى"),
              AppTextField(controller: enTitle, label: "Title"),
              AppTextField(controller: enDesc, label: "Descriptioon"),
              Gap(4.w),
              PrimaryButton(
                text: LocaleKeys.buttons_send.tr(),
                isLoading: controller is NewNotificationLoading,
                onPress: () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  ref
                      .read(appSettingsControllerProvider.notifier)
                      .newNotification(
                        Notifications(
                          id: "id",
                          kuTitle: kuTitle.text,
                          arTitle: arTitle.text,
                          enTitle: enTitle.text,
                          kuDescription: kuDesc.text,
                          arDescription: arDesc.text,
                          enDescription: enDesc.text,
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
