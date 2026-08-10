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
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:kcars/features/car/data/model/promotion.dart';
import 'package:kcars/features/car/data/model/rental_plan.dart';
import 'package:kcars/features/car/presentation/views/filters_data_view.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class NewPromotionScreen extends HookConsumerWidget {
  const NewPromotionScreen({
    super.key,
    this.car,
    this.promotion,
    required this.param,
  });
  final Car? car;
  final Promotion? promotion;
  final PromotionPost param;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startDate = useState(promotion?.startDate ?? DateTime.now());
    final endDate = useState(
      promotion?.endDate ?? DateTime.now().add(Duration(hours: 1)),
    );
    final priceType = useState<PromotionPriceType>(
      promotion?.priceType ?? PromotionPriceType.fixed,
    );
    final promotionType = useState<PromotionType>(
      promotion?.type ?? PromotionType.car,
    );
    final code = useTextEditingController(text: promotion?.code);
    final maxPerUser = useTextEditingController(
      text: promotion?.maxUsePerUser.toString(),
    );
    final maxUses = useTextEditingController(
      text: promotion?.maxUses.toString(),
    );
    final maxDiscountAmount = useTextEditingController(
      text: promotion?.maxDiscountAmount.toString() ?? "",
    );
    final minOrderValue = useTextEditingController(
      text: promotion?.minOrderValue.toString() ?? "",
    );
    final value = useTextEditingController(text: promotion?.value.toString());

    final selectedRent = useState<RentalPlan?>(
      car?.rentalPlan?.firstWhere(
        (r) => r.id == promotion?.rentalPlanId,
        orElse: () => car!.rentalPlan!.first,
      ),
    );

    final isAvailable = useState(promotion?.available ?? true);

    final isEnabled = promotion != null;
    final formKey = useMemoized(() => GlobalKey<FormState>(), []);
    final newPromotion = ref.watch(carControllerProvider);
    ref.listen(carControllerProvider, (previous, next) {
      if (next is NewPromotionCompleted) {
        showMessages(context, message: LocaleKeys.alertMessages_success.tr());
        context.maybePop();
      }
      if (next is NewPromotionFailed) {
        showCustomAlert(context, content: next.message);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          promotion == null
              ? LocaleKeys.screens_newPromotion.tr()
              : LocaleKeys.screens_updatePromotion.tr(),
        ),
        leading: CustomBackButton(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
        ).copyWith(top: 4.w, bottom: 20.w),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2.w,
            children: [
              AppTextField(
                hint: "ex KCARS2025",
                readOnly: isEnabled,
                controller: code,
                label: LocaleKeys.labels_promotionCode.tr(),
                validator: (value) => value!.length >= 8
                    ? null
                    : LocaleKeys.validations_year.tr(),
              ),
              Gap(1.w),
              Text(
                LocaleKeys.labels_promotionType.tr(),
                style: context.caption.copyWith(color: context.outline),
              ),
              Row(
                children: [
                  CustomFilterChip(
                    title: LocaleKeys.labels_fixed.tr(),
                    onTap: () => isEnabled
                        ? null
                        : priceType.value = PromotionPriceType.fixed,
                    selected: priceType.value == PromotionPriceType.fixed,
                  ),
                  Gap(2.w),
                  CustomFilterChip(
                    title: LocaleKeys.labels_percentage.tr(),
                    onTap: () =>
                        priceType.value = PromotionPriceType.percentage,
                    selected: priceType.value == PromotionPriceType.percentage,
                  ),
                ],
              ),
              Gap(1.w),
              AppTextField(
                readOnly: isEnabled,
                controller: value,
                label: LocaleKeys.labels_value.tr(),
                hint: priceType.value == PromotionPriceType.fixed
                    ? "10000"
                    : "10",
              ),
              AppTextField(
                readOnly: isEnabled,
                controller: maxUses,
                label: LocaleKeys.inputLabels_maxUses.tr(),
              ),
              AppTextField(
                readOnly: isEnabled,
                controller: maxPerUser,
                label: LocaleKeys.inputLabels_maxPerUser.tr(),
              ),

              AppTextField(
                readOnly: isEnabled,
                controller: maxDiscountAmount,
                label: LocaleKeys.inputLabels_maxDiscount.tr(),
                validator: (value) => null,
              ),
              AppTextField(
                readOnly: isEnabled,
                controller: minOrderValue,
                label: LocaleKeys.inputLabels_minDiscount.tr(),
                validator: (value) => null,
              ),
              AppTextField(
                readOnly: true,
                initialValue: startDate.value.formatDate2(context),
                label: LocaleKeys.labels_startDate.tr(),
                key: ValueKey(startDate.value),
                onTap: () async {
                  final date = await showDateYearPicker(context);

                  if (date != null) {
                    startDate.value = date;
                  }
                },
              ),
              AppTextField(
                readOnly: true,
                initialValue: endDate.value.formatDate2(context),
                label: LocaleKeys.labels_endDate.tr(),
                key: ValueKey(endDate.value),
                onTap: () async {
                  final date = await showDateYearPicker(context);
                  if (date != null) {
                    endDate.value = date;
                  }
                },
              ),
              Gap(2.w),
              Text(
                LocaleKeys.labels_promotionType.tr(),
                style: context.caption.copyWith(color: context.outline),
              ),
              Wrap(
                runSpacing: 4.w,
                alignment: WrapAlignment.spaceBetween,
                spacing: 2.w,
                children: [
                  ...car?.rentalPlan?.map((rent) {
                        return CustomFilterChip(
                          title:
                              "${rent.price.forMatNumber()} / ${rent.periodType.periodType()}",
                          onTap: () =>
                              isEnabled ? null : selectedRent.value = rent,
                          selected: selectedRent.value == rent,
                        );
                      }).toList() ??
                      [],
                  CustomFilterChip(
                    title: LocaleKeys.labels_all.tr(),
                    onTap: () => isEnabled ? null : selectedRent.value = null,
                    selected: selectedRent.value == null,
                  ),
                ],
              ),

              Gap(2.w),
              CheckboxListTile.adaptive(
                title: Text(LocaleKeys.labels_available.tr()),
                dense: true,
                visualDensity: VisualDensity.compact,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                value: isAvailable.value,
                onChanged: (v) => isAvailable.value = v!,
              ),
              Gap(4.w),
              PrimaryButton(
                color: context.primary,
                isLoading: newPromotion is NewPromotionLoading,
                text: promotion != null
                    ? LocaleKeys.buttons_update.tr()
                    : LocaleKeys.buttons_add.tr(),
                onPress: () {
                  if (!formKey.currentState!.validate()) return;
                  final promotionUpdate = PromotionUpdate(
                    id: promotion?.id,
                    code: code.text,
                    startDate: startDate.value.toLocal(),
                    endDate: endDate.value.toLocal(),
                    priceType: priceType.value,
                    type: promotionType.value,
                    available: isAvailable.value,
                    carId: car!.id,
                    maxUsePerUser: int.tryParse(maxPerUser.text),
                    maxUses: int.tryParse(maxUses.text),
                    maxDiscountAmount: double.tryParse(maxDiscountAmount.text),
                    minOrderValue: double.tryParse(minOrderValue.text),
                    planId: selectedRent.value?.plan?.id,
                    rentalPlanId: selectedRent.value?.id,
                    value: double.tryParse(value.text),
                  );

                  final controller = ref.read(carControllerProvider.notifier);

                  if (promotion == null) {
                    final newPromotion = promotionUpdate.toPromotion();
                    controller.newPromotion(newPromotion, param);
                  } else {
                    final diff = promotionUpdate.toDiff(promotion!);

                    controller.updatePromotion(
                      diff,
                      param,
                      promotion!.copyWith(available: diff.available),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
