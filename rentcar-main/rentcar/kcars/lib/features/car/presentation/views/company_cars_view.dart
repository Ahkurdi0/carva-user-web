import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/pagin_list_view.dart';
import 'package:kcars/core/widget/icon_loader.dart' show IconLoadaer;
import 'package:kcars/features/auth/presentation/riverpod/is_logged_in.dart';
import 'package:kcars/features/car/presentation/riverpod/filter_cars.dart';
import 'package:kcars/features/car/presentation/screens/favorite_screen.dart';
import 'package:kcars/features/car/presentation/views/filters_data_view.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

class CompanyCarsView extends ConsumerWidget {
  const CompanyCarsView({super.key, required this.company});
  final Company company;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searches = ref.watch(filtersCarsProvider(company.id));
    final isLoggedIn = ref.watch(isLoggedInProvider);

    return Scaffold(
      body: PagingSliverList(
        onRefresh: () async => ref.refresh(filtersCarsProvider(company.id)),
        padding: EdgeInsets.only(bottom: 40.w, top: 4.w),
        state: searches,
        onLoadMore: () {
          ref.read(filtersCarsProvider(company.id).notifier).loadMore();
        },
        itemBuilder: (context, car, index) =>
            FavoriteCarCard(car: car, isLoggedIn: isLoggedIn),
        initalLoadingWidget: ListView.builder(
          padding: EdgeInsets.only(bottom: 30.w),
          itemCount: 2,
          itemBuilder: (context, index) {
            return FavoriteCarCard(isSkeleton: true);
          },
        ),
      ),
      floatingActionButton: SizedBox(
        height: 10.w,
        child: FloatingActionButton.extended(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.w),
          ),
          backgroundColor: context.secondary,
          onPressed: () {
            final rootContent = Navigator.of(
              context,
              rootNavigator: true,
            ).context;
            showFilters(rootContent, FilterDataView(companyId: company.id));
          },
          icon: IconLoadaer(
            AppIcons.filter,
            color: context.surface,
            width: 5.w,
          ),
          label: Text(LocaleKeys.buttons_filter.tr()),
        ),
      ),
    );
  }
}
