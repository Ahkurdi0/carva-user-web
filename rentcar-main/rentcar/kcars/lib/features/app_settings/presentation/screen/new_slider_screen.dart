import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/permissions.dart';
import 'package:kcars/core/widget/app_textfeild.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/new_edit_image.dart';
import 'package:kcars/features/app_settings/application/app_settigngs_controller.dart';
import 'package:kcars/features/app_settings/application/states.dart';
import 'package:kcars/features/app_settings/data/model/sliders.dart';
import 'package:kcars/features/app_settings/presentation/riverpod/sliders.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class NewSliderScreen extends HookConsumerWidget {
  const NewSliderScreen({
    super.key,
    this.type = SlideType.url,
    this.carId,
    this.companyId,
    this.sliders,
  });
  final SlideType type;
  final String? carId;
  final String? companyId;
  final Sliders? sliders;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: sliders?.url);
    final selectedImage = useState<File?>(null);
    final available = useState<bool>(sliders?.available ?? true);
    final appSetting = ref.watch(appSettingsControllerProvider);
    ref.listen(appSettingsControllerProvider, (previous, next) {
      if (next is NewSliderCompleted) {
        showMessages(context, message: LocaleKeys.alertMessages_success.tr());
        context.maybePop();
        return;
      }
      if (next is NewSliderFailed) {
        showMessages(context, message: next.message);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.screens_Slider.tr()),
        leading: const CustomBackButton(),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(allSlidersProvider.future),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
          ).copyWith(bottom: 30.w, top: 4.w),
          child: Column(
            children: [
              NewEditImage(
                selectedImage: selectedImage.value?.path,
                image: sliders?.image,
                fit: BoxFit.cover,
                width: 100.w,
                height: 40.w,
                onTap: () async {
                  final image = await selectImageWithPermissionPrompt(context);
                  if (image != null) {
                    selectedImage.value = File(image.path);
                  }
                },
              ),
              Gap(4.w),
              if (type == SlideType.url) ...[
                AppTextField(
                  controller: controller,
                  label:
                      "${LocaleKeys.inputLabels_content.tr()} (${LocaleKeys.labels_optional.tr()})",
                  hint: "https://example.com",
                ),
                Gap(4.w),
              ],

              CheckboxListTile.adaptive(
                dense: true,
                visualDensity: VisualDensity.compact,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(LocaleKeys.labels_available.tr()),
                value: available.value,
                onChanged: (v) => available.value = v!,
              ),
              Gap(4.w),
              PrimaryButton(
                isLoading: appSetting is NewSliderLoading,
                text: LocaleKeys.buttons_add.tr(),
                onPress: () async {
                  ref
                      .read(appSettingsControllerProvider.notifier)
                      .newSlider(
                        Sliders(
                          id: sliders?.id,
                          image: selectedImage.value?.path,
                          carId: carId,
                          companyId: companyId,
                          type: type,
                          available: available.value,
                          url: controller.text.nullIfEmpty(),
                        ),
                        sliders,
                      );
                },
              ),
              Gap(4.w),
            ],
          ),
        ),
      ),
    );
  }
}
