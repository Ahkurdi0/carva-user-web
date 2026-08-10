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
import 'package:kcars/features/car/data/model/car_type.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class NewEditCarTypeScreen extends HookConsumerWidget {
  const NewEditCarTypeScreen({super.key, this.carType});
  final CarType? carType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final en = useTextEditingController(text: carType?.en ?? '');
    final ku = useTextEditingController(text: carType?.ku ?? '');
    final ar = useTextEditingController(text: carType?.ar ?? '');

    final available = useState<bool>(carType?.available ?? true);

    final controller = ref.watch(appSettingsControllerProvider);

    final fromKey = useMemoized(() => GlobalKey<FormState>(), []);
    ref.listen(appSettingsControllerProvider, (previous, next) {
      if (next is NewCarTypeCompleted) {
        context.maybePop();
      }
      if (next is NewCarTypeFailed) {
        showMessages(context, message: next.message);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          carType == null
              ? LocaleKeys.screens_newCarType.tr()
              : LocaleKeys.screens_updateCarType.tr(),
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
              AppTextField(controller: ku, label: 'کوردی'),
              AppTextField(controller: ar, label: 'عربی'),
              AppTextField(controller: en, label: 'English'),
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
                text: carType != null
                    ? LocaleKeys.buttons_update.tr()
                    : LocaleKeys.buttons_add.tr(),
                isLoading: controller is NewTownLoading,
                onPress: () {
                  if (!fromKey.currentState!.validate()) return;
                  final newData = CarType(
                    id: carType?.id,
                    en: en.text,
                    ku: ku.text,
                    ar: ar.text,
                    available: available.value,
                  );
                  ref
                      .read(appSettingsControllerProvider.notifier)
                      .newCarType(newData, carType);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
