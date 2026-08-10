import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/app_textfeild.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/review/data/model/cursor_review.dart';
import 'package:kcars/features/review/data/model/review_post.dart';
import 'package:kcars/features/review/presentation/application/review_controller.dart';
import 'package:kcars/features/review/presentation/application/review_states.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

Future<void> showReviewInput(BuildContext context, Widget child) async {
  Navigator.push(
    context,
    ModalSheetRoute(
      viewportPadding: EdgeInsets.only(
        top: MediaQuery.viewPaddingOf(context).top,
      ),
      builder: (context) => child,
    ),
  );
}

class ReviewContent extends HookConsumerWidget {
  const ReviewContent({super.key, required this.car});
  final Car car;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final review = ref.watch(reviewControllerProvider);
    final controller = useTextEditingController();
    final rate = useState(3);
    ref.listen(reviewControllerProvider, (prev, next) {
      if (next is NewCarReviewCompleted) {
        Navigator.pop(context);
      }
      if (next is NewCarReviewFailed) {
        Navigator.pop(context);
        showMessages(context, message: next.message);
      }
    });

    Future<void> onPopInvoked(bool didPop, Object? result) async {
      if (didPop) {
        return;
      } else {
        Navigator.pop(context);
        return;
      }
    }

    final fromKey = useMemoized(() => GlobalKey<FormState>(), []);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: onPopInvoked,
      child: SheetKeyboardDismissible(
        dismissBehavior: const SheetKeyboardDismissBehavior.onDragDown(
          isContentScrollAware: true,
        ),
        child: Sheet(
          scrollConfiguration: const SheetScrollConfiguration(),
          decoration: MaterialSheetDecoration(
            size: SheetSize.stretch,
            color: Theme.of(context).colorScheme.secondaryContainer,
            clipBehavior: Clip.antiAlias,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.w)),
            ),
          ),
          child: SheetContentScaffold(
            bottomBarVisibility: const BottomBarVisibility.always(
              ignoreBottomInset: true,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Form(
                key: fromKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(4.w),
                    Text(
                      LocaleKeys.labels_rateThisCarr.tr(),
                      style: context.label2Bold,
                    ),
                    Gap(4.w),
                    Center(
                      child: CustomStarRating(
                        rating: 3,
                        onRatingChanged: (star) {
                          rate.value = star;
                        },
                      ),
                    ),
                    Gap(6.w),
                    AppTextField(
                      hint: LocaleKeys.inputHintText_writeReview.tr(),
                      controller: controller,
                      multiLine: true,
                      validator: (value) => value!.trim().isEmpty
                          ? LocaleKeys.validations_required.tr()
                          : null,
                    ),
                    Gap(4.w),
                  ],
                ),
              ),
            ),
            bottomBar: Container(
              height: 24.w,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: context.surface,
                border: Border(
                  top: BorderSide(width: .1, color: context.outline),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 4.w).copyWith(top: 3.w),
              child: Row(
                children: [
                  SecondaryButton(
                    width: 32.w,
                    text: LocaleKeys.buttons_cancel.tr(),
                    onPress: () {
                      context.router.maybePop();
                    },
                  ),
                  Gap(2.w),
                  PrimaryButton(
                    width: 58.w,
                    isLoading: review is NewCarReviewLoading,
                    color: context.primary,
                    text: LocaleKeys.buttons_submitReview.tr(),
                    onPress: () {
                      if (!fromKey.currentState!.validate()) return;
                      ref
                          .read(reviewControllerProvider.notifier)
                          .reviewCar(
                            ReviewPost(
                              carId: car.id,
                              rate: rate.value,
                              desc: controller.text,
                            ),
                          );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CompanyReviewContent extends HookConsumerWidget {
  const CompanyReviewContent({
    super.key,
    required this.company,
    required this.param,
  });
  final Company company;
  final CursorReview param;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final review = ref.watch(reviewControllerProvider);
    final controller = useTextEditingController();
    final rate = useState(3);

    ref.listen(reviewControllerProvider, (prev, next) {
      if (next is NewCompanyReviewCompleted) {
        Navigator.pop(context);
      }
      if (next is NewCompanyReviewFailed) {
        context.maybePop();
        showMessages(context, message: next.message);
      }
    });

    Future<void> onPopInvoked(bool didPop, Object? result) async {
      if (didPop) {
        return;
      } else {
        Navigator.pop(context);
        return;
      }
    }

    final fromKey = useMemoized(() => GlobalKey<FormState>(), []);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: onPopInvoked,
      child: Sheet(
        scrollConfiguration: const SheetScrollConfiguration(),
        decoration: MaterialSheetDecoration(
          size: SheetSize.stretch,
          color: Theme.of(context).colorScheme.secondaryContainer,
          clipBehavior: Clip.antiAlias,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.w)),
          ),
        ),
        child: SheetContentScaffold(
          bottomBarVisibility: const BottomBarVisibility.always(
            ignoreBottomInset: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Form(
              key: fromKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(4.w),
                  Text(
                    LocaleKeys.labels_rateThisCompany.tr(),
                    style: context.label2Bold,
                  ),
                  Gap(4.w),
                  Center(
                    child: CustomStarRating(
                      rating: 3,
                      onRatingChanged: (star) {
                        rate.value = star;
                      },
                    ),
                  ),
                  Gap(6.w),
                  AppTextField(
                    hint: LocaleKeys.inputHintText_writeReview.tr(),
                    controller: controller,
                    multiLine: true,
                    maxHeight: 50.w,
                    maxLength: 600,
                    showCounterText: true,
                    validator: (value) => value!.trim().isEmpty
                        ? LocaleKeys.validations_required.tr()
                        : null,
                  ),
                  Gap(4.w),
                ],
              ),
            ),
          ),
          bottomBar: Container(
            height: 24.w,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              color: context.surface,
              border: Border(
                top: BorderSide(width: .1, color: context.outline),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 4.w).copyWith(top: 3.w),
            child: Row(
              children: [
                SecondaryButton(
                  width: 32.w,
                  text: LocaleKeys.buttons_cancel.tr(),
                  onPress: () {
                    context.router.maybePop();
                  },
                ),
                Gap(2.w),
                PrimaryButton(
                  width: 58.w,
                  isLoading: review is NewCompanyReviewLoading,
                  color: context.primary,
                  text: LocaleKeys.buttons_submitReview.tr(),
                  onPress: () {
                    if (!fromKey.currentState!.validate()) return;
                    ref
                        .read(reviewControllerProvider.notifier)
                        .reviewCompany(
                          ReviewPost(
                            companyId: company.id,
                            rate: rate.value,
                            desc: controller.text,
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

class CustomStarRating extends HookWidget {
  final int rating;
  final void Function(int) onRatingChanged;

  const CustomStarRating({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    final currentRating = useState(rating);
    final animationControllers = List.generate(
      5,
      (_) =>
          useAnimationController(duration: const Duration(milliseconds: 200)),
    );

    // Reset and forward the animation for the selected star
    void triggerAnimations(int selectedIndex) {
      for (int i = 0; i < animationControllers.length; i++) {
        final controller = animationControllers[i];
        controller.reset();

        if (i <= selectedIndex) {
          controller.forward();
        }
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        final isFilled = starIndex <= currentRating.value;
        final asset = isFilled ? AppIcons.starFill : AppIcons.star;

        final scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
          CurvedAnimation(
            parent: animationControllers[index],
            curve: Curves.easeOutBack,
          ),
        );

        return GestureDetector(
          onTap: () {
            currentRating.value = starIndex;
            onRatingChanged(starIndex);
            triggerAnimations(index);
          },
          child: AnimatedBuilder(
            animation: scaleAnimation,
            builder: (context, child) {
              return Transform.scale(scale: scaleAnimation.value, child: child);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: IconLoadaer(
                asset,
                width: 6.w,
                height: 6.w,
                color: isFilled ? context.primary : null,
              ),
            ),
          ),
        );
      }),
    );
  }
}
