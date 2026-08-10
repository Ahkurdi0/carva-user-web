import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/core/widget/loadin_widget.dart';
import 'package:kcars/features/car/application/car_controller.dart';
import 'package:kcars/features/car/application/car_states.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/promotion.dart';
import 'package:kcars/features/car/presentation/riverpod/promotions.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class PromotionsScreen extends ConsumerWidget {
  const PromotionsScreen({super.key, required this.car});
  final Car car;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final param = PromotionPost(carId: car.id);
    final promotions = ref.watch(promotionsProvider(param));
    ref.listen(carControllerProvider, (previous, next) {
      if (next is DeletePromotionCompleted) {
        showMessages(context, message: LocaleKeys.alertMessages_deleted.tr());
      }
      if (next is DeletePromotionFailed) {
        showCustomAlert(context, content: next.message);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.screens_promotions.tr()),
        leading: CustomBackButton(),
      ),
      body: promotions.when(
        data: (data) {
          return RefreshIndicator(
            onRefresh: () async =>
                ref.refresh(promotionsProvider(param).future),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
              ).copyWith(bottom: 20.w, top: 4.w),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final promotion = data[index];
                return PromotionWidget(
                  promotion: promotion,
                  car: car,
                  param: param,
                );
              },
            ),
          );
        },
        error: (error, trace) => Text(error.toString()),
        loading: () => LoadingWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.secondary,
        child: const Icon(Icons.add),
        onPressed: () {
          context.router.push(NewPromotionRoute(car: car, param: param));
        },
      ),
    );
  }
}

class PromotionWidget extends ConsumerWidget {
  const PromotionWidget({
    super.key,
    required this.promotion,
    required this.car,
    required this.param,
  });
  final Promotion promotion;
  final Car car;
  final PromotionPost param;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => context.pushRoute(
        NewPromotionRoute(promotion: promotion, car: car, param: param),
      ),
      child: Container(
        padding: EdgeInsets.all(2.w),
        margin: EdgeInsets.only(bottom: 2.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.w),
          color: context.surfaceContainerLowest,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(promotion.code ?? "", style: context.label2SemiBold),
                Gap(4.w),
                Text(
                  "(${promotion.usesCount ?? "0"}) / (${promotion.maxUses})",
                  style: context.label,
                ),
                Gap(2.w),
                Icon(Icons.person, size: 5.w),
                Text(
                  "(${promotion.maxUsePerUser?.forMatNumber()})",
                  style: context.label,
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    showCustomAlert(
                      context,
                      content: LocaleKeys.alertMessages_deletePromotion.tr(),
                      isDeleting: true,
                      primaryAction: () => ref
                          .read(carControllerProvider.notifier)
                          .deletePromotion(promotion.id, param),
                    );
                  },
                  child: IconLoadaer(AppIcons.cancel),
                ),
              ],
            ),
            Gap(2.w),
            Row(
              children: [
                Text(
                  "${promotion.startDate.formatDate2(context)} - ${promotion.endDate.formatDate2(context)}",
                  style: context.label,
                ),
              ],
            ),
            Gap(2.w),
            Row(
              children: [
                Icon(Icons.discount, size: 4.w),
                Gap(1.w),
                Text(
                  "${promotion.value?.forMatNumber()} ${promotion.priceType.pricePromotionType()}",
                  style: context.label,
                ),
              ],
            ),
            Gap(2.w),
            Row(
              children: [
                Text(
                  "${LocaleKeys.inputLabels_minDiscount.tr()} - ${promotion.minOrderValue?.forMatNumber() ?? "n/a"}",
                  style: context.caption,
                ),
                Gap(4.w),
                Text(
                  "${LocaleKeys.inputLabels_maxDiscount.tr()} - ${promotion.maxDiscountAmount?.forMatNumber() ?? "n/a"}",
                  style: context.caption,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
