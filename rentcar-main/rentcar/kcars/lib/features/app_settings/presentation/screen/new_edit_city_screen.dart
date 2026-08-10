import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/widget/app_textfeild.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/features/app_settings/application/app_settigngs_controller.dart';
import 'package:kcars/features/app_settings/application/states.dart';
import 'package:kcars/features/car/data/model/city.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class NewEditCityScreen extends HookConsumerWidget {
  const NewEditCityScreen({super.key, this.city});
  final City? city;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final en = useTextEditingController(text: city?.en ?? '');
    final ku = useTextEditingController(text: city?.ku ?? '');
    final ar = useTextEditingController(text: city?.ar ?? '');

    final available = useState<bool>(city?.available ?? true);

    final latLong = useState<LatLng?>(
      city?.lat == null ? null : LatLng(city?.lat ?? 0, city?.long ?? 0),
    );

    void onSelectMap(TapPosition tap, LatLng ltlg) {
      latLong.value = ltlg;
    }

    final controller = ref.watch(appSettingsControllerProvider);
    final fromKey = useMemoized(() => GlobalKey<FormState>(), []);
    ref.listen(appSettingsControllerProvider, (previous, next) {
      if (next is NewCityCompleted) {
        context.maybePop();
      } else if (next is NewCityFailed) {
        showMessages(context, message: next.message);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          city == null
              ? LocaleKeys.screens_newTown.tr()
              : LocaleKeys.screens_updateTown.tr(),
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
              SecondaryButton(
                text: latLong.value == null
                    ? LocaleKeys.buttons_setLocation.tr()
                    : LocaleKeys.buttons_changeLocation.tr(),
                onPress: () {
                  context.router.push(
                    PickUpMapRoute(
                      latLng: latLong.value,
                      onSelect: onSelectMap,
                    ),
                  );
                },
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
                text: city != null
                    ? LocaleKeys.buttons_update.tr()
                    : LocaleKeys.buttons_add.tr(),
                isLoading: controller is NewCityLoading,
                onPress: () {
                  if (!fromKey.currentState!.validate()) return;
                  final newData = City(
                    id: city?.id,
                    en: en.text,
                    ku: ku.text,
                    ar: ar.text,
                    lat: latLong.value?.latitude,
                    long: latLong.value?.longitude,
                    available: available.value,
                    towns: city?.towns ?? [],
                  );
                  ref
                      .read(appSettingsControllerProvider.notifier)
                      .newCity(newData, city);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
