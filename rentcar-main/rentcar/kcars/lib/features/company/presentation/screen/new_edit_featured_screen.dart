import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/utils/date_year_picker.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/app_textfeild.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/features/car/application/car_controller.dart';
import 'package:kcars/features/car/application/car_states.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/featured_cars.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class NewEditFeaturedScreen extends HookConsumerWidget {
  const NewEditFeaturedScreen({super.key, required this.car});
  final Car car;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startAt = useState(car.featuredCars?.startAt ?? DateTime.now());
    final until = useState(car.featuredCars?.until);
    final carController = ref.watch(carControllerProvider);
    ref.listen(carControllerProvider, (prev, next) {
      if (next is NewFeatureCarFailed) {
        showMessages(context, message: LocaleKeys.alertMessages_deleted.tr());
      }
      if (next is NewFeatureCarCompleted) {
        context.maybePop();
        showMessages(context, message: LocaleKeys.alertMessages_success.tr());
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.screens_featuredCar.tr()),
        leading: const CustomBackButton(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
        ).copyWith(top: 4.w, bottom: 10.w),
        child: Column(
          spacing: 4.w,
          children: [
            AppTextField(
              readOnly: true,
              initialValue: startAt.value.formatDate2(context) ?? "",
              key: ValueKey(startAt.value),
              label:
                  "${LocaleKeys.labels_startDate.tr()} (${LocaleKeys.labels_optional.tr()}})",

              onTap: () async {
                final date = await showDateYearPicker(context);
                if (date != null) {
                  startAt.value = date;
                }
              },
            ),
            AppTextField(
              key: ValueKey(until.value ?? "Until"),
              readOnly: true,
              initialValue: until.value?.formatDate2(context),
              label:
                  "${LocaleKeys.labels_expireDate.tr()} (${LocaleKeys.labels_optional.tr()}})",
              onTap: () async {
                final date = await showDateYearPicker(context);
                if (date != null) {
                  until.value = date;
                }
              },
            ),
            Gap(4.w),
            PrimaryButton(
              isLoading: carController is NewFeatureCarLoading,
              text: LocaleKeys.buttons_add.tr(),
              onPress: () {
                ref
                    .read(carControllerProvider.notifier)
                    .newFaturedCar(
                      car.copyWith(
                        featuredCars: FeaturedCars(
                          id: null,
                          carId: car.id,
                          companyId: car.company?.id,
                          startAt: startAt.value,
                          until: until.value,
                        ),
                      ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
