import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/pagin_list_view.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/presentation/widget/review_widget.dart';
import 'package:kcars/features/review/data/model/car_review.dart';
import 'package:kcars/features/review/data/model/cursor_review.dart';
import 'package:kcars/features/review/presentation/riverpod/car_review.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

class CarReviewView extends ConsumerWidget {
  const CarReviewView({
    super.key,
    required this.car,
    this.userCarReviews,
    this.lastId,
  });
  final Car car;
  final String? lastId;
  final CarReview? userCarReviews;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cursor = CursorReview(id: car.id, cursor: lastId);
    final carReviews = ref.watch(carReviewsProvider(cursor));

    return PagingListView(
      shirkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      emptyWidget: car.reviews == null && carReviews.items.isEmpty
          ? Center(child: Text(LocaleKeys.empty_noReviews.tr()))
          : car.reviews != null
          ? Text("")
          : null,
      suffixWidget: carReviews.items.length >= 5
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w).copyWith(top: 4.w),
              child: SecondaryButton(
                width: 40.w,
                height: 10.w,
                color: context.secondaryContainer,
                onPress: () {
                  showCustomBottomSheet(
                    context,
                    AllCarReviews(car: car, lastId: carReviews.items.last.id),
                  );
                },
                text: "See all",
              ),
            )
          : null,

      state: carReviews,
      itemBuilder: (context, review, index) => ReviewWidget(review: review),
    );
  }
}

class AllCarReviews extends ConsumerWidget {
  const AllCarReviews({
    super.key,
    required this.car,
    this.lastId,
    this.userCarReviews,
  });
  final Car car;
  final String? lastId;
  final CarReview? userCarReviews;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cursor = CursorReview(id: car.id, cursor: lastId);
    final carReviews = ref.watch(carReviewsProvider(cursor));
    return PagingSliverList(
      onRefresh: () =>
          ref.read(carReviewsProvider(cursor).notifier).loadInitial(),
      onLoadMore: () =>
          ref.read(carReviewsProvider(cursor).notifier).loadMore(),
      padding: EdgeInsets.symmetric(horizontal: 4.w).copyWith(bottom: 30.w),
      emptyWidget: car.reviews == null && carReviews.items.isEmpty
          ? Center(child: Text(LocaleKeys.empty_noReviews.tr()))
          : car.reviews != null
          ? Text("")
          : null,
      state: carReviews,
      itemBuilder: (context, review, index) => ReviewWidget(review: review),
    );
  }
}
