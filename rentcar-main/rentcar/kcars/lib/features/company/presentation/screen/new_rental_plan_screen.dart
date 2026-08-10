import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/widget/app_textfeild.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:kcars/features/car/data/model/paln.dart';
import 'package:kcars/features/car/data/model/rental_plan.dart';
import 'package:kcars/features/car/presentation/riverpod/plans.dart';
import 'package:kcars/features/car/presentation/views/filters_data_view.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class NewRentalPlanScreen extends HookConsumerWidget {
  const NewRentalPlanScreen({super.key, this.rentalPlan, this.plan});
  final RentalPlan? rentalPlan;
  final Plan? plan;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = useMemoized(() => context.locale.toLanguageTag());
    final price = useTextEditingController(text: rentalPlan?.price.toString());
    final min = useTextEditingController(text: rentalPlan?.min.toString());
    final max = useTextEditingController(text: rentalPlan?.max.toString());
    final isAvailable = useState(rentalPlan?.available ?? true);
    final currency = useState(rentalPlan?.currency ?? Currency.iqd);
    final formKey = useMemoized(() => GlobalKey<FormState>(), []);
    final isEnabled = rentalPlan != null;
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text(LocaleKeys.screens_rentalPlan.tr()),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
        ).copyWith(top: 4.w, bottom: 20.w),
        child: Form(
          key: formKey,
          child: Column(
            spacing: 4.w,
            children: [
              AppTextField(
                label: LocaleKeys.labels_plan.tr(),
                initialValue: plan!.getTile(locale),
                readOnly: true,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: AppTextField(
                      readOnly: isEnabled,
                      controller: price,
                      keyboardType: TextInputType.number,
                      label: LocaleKeys.inputLabels_price.tr(),
                    ),
                  ),
                  Gap(6.w),
                  Wrap(
                    spacing: 2.w,
                    children: Currency.values
                        .map(
                          (c) => CustomFilterChip(
                            selected: currency.value == c,
                            onTap: () => currency.value = c,
                            title: c.getCurrency(),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
              AppTextField(
                readOnly: isEnabled,
                controller: min,
                keyboardType: TextInputType.number,
                label:
                    "${LocaleKeys.inputLabels_min.tr()} (${LocaleKeys.labels_optional.tr()})",
                validator: (value) => null,
              ),
              AppTextField(
                readOnly: isEnabled,
                controller: max,
                keyboardType: TextInputType.number,
                label:
                    "${LocaleKeys.inputLabels_max.tr()} (${LocaleKeys.labels_optional.tr()})",
                validator: (value) => null,
              ),

              Gap(4.w),
              PrimaryButton(
                text: rentalPlan != null
                    ? LocaleKeys.buttons_update.tr()
                    : LocaleKeys.buttons_add.tr(),
                onPress: () {
                  if (!formKey.currentState!.validate()) return;
                  final r = RentalPlan(
                    id: "",
                    price: double.parse(price.text),
                    available: isAvailable.value,
                    min: int.tryParse(min.text),
                    max: int.tryParse(max.text),
                    periodType: plan!.periodType!,
                    planId: plan?.id,
                    currency: currency.value,
                  );
                  Navigator.pop(context, r);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlansView extends ConsumerWidget {
  const PlansView({super.key, this.onSelected, this.selected});
  final Function(Plan)? onSelected;
  final Plan? selected;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(plansProvider);
    return SizedBox(
      height: 30.w,
      child: switch (plans) {
        AsyncData(:final value) => Wrap(
          spacing: 2.w,
          children: value
              .map(
                (e) => ChoiceChip(
                  label: Text(e.en ?? ""),
                  selected: false,
                  onSelected: (value) {},
                ),
              )
              .toList(),
        ),
        AsyncError(:final error) => Text(error.toString()),
        _ => const Center(child: Text("....")),
      },
    );
  }
}
