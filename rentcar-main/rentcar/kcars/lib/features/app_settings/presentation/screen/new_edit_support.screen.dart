import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/utils/permissions.dart';
import 'package:kcars/core/widget/app_textfeild.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/new_edit_image.dart';
import 'package:kcars/features/app_settings/application/app_settigngs_controller.dart';
import 'package:kcars/features/app_settings/application/states.dart';
import 'package:kcars/features/app_settings/data/model/post_model.dart';
import 'package:kcars/features/app_settings/data/model/suppprt.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class NewEditSupportScreen extends HookConsumerWidget {
  const NewEditSupportScreen({super.key, this.support});
  final Support? support;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final en = useTextEditingController(text: support?.en ?? '');
    final ar = useTextEditingController(text: support?.ar ?? '');
    final ku = useTextEditingController(text: support?.ku ?? '');
    final content = useTextEditingController(text: support?.content ?? '');

    final available = useState<bool>(support?.available ?? true);

    final controller = ref.watch(appSettingsControllerProvider);
    final selectedImage = useState<File?>(null);

    final fromKey = useMemoized(() => GlobalKey<FormState>(), []);

    ref.listen(appSettingsControllerProvider, (previous, next) {
      if (next is NewSupportCompleted) {
        context.maybePop();
      } else if (next is DeleteSupportFailed) {
        showMessages(context, message: next.message);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          support == null
              ? LocaleKeys.buttons_add.tr()
              : LocaleKeys.buttons_update.tr(),
        ),
        leading: CustomBackButton(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
        ).copyWith(top: 4.w, bottom: 20.w),
        child: Form(
          key: fromKey,
          child: Column(
            spacing: 2.w,
            children: [
              NewEditImage(
                image: support?.image,
                selectedImage: selectedImage.value?.path,
                fit: BoxFit.cover,
                aspectRation: 1,
                padding: EdgeInsets.zero,
                onTap: () async {
                  final image = await selectImageWithPermissionPrompt(context);
                  if (image != null) {
                    selectedImage.value = image;
                  }
                },
              ),
              AppTextField(controller: ku, label: "کوردی"),
              AppTextField(controller: ar, label: "عربی"),
              AppTextField(controller: en, label: "English"),
              AppTextField(
                controller: content,
                label: LocaleKeys.inputLabels_content.tr(),
              ),

              Gap(2.w),
              CheckboxListTile.adaptive(
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
                visualDensity: VisualDensity.compact,
                value: available.value,
                onChanged: (v) => available.value = v!,
                title: Text(LocaleKeys.buttons_available.tr()),
              ),
              Gap(4.w),
              PrimaryButton(
                text: support != null
                    ? LocaleKeys.buttons_available.tr()
                    : LocaleKeys.buttons_update.tr(),
                isLoading: controller is NewSupportLoading,
                onPress: () {
                  if (!fromKey.currentState!.validate()) return;
                  final newData = Support(
                    id: support?.id,
                    en: en.text,
                    ar: ar.text,
                    ku: ku.text,
                    content: content.text,
                    available: available.value,
                  );
                  ref
                      .read(appSettingsControllerProvider.notifier)
                      .newSupport(
                        PostModel(suppprt: newData, image: selectedImage.value),
                        support,
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
