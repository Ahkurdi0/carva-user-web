import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/utils/pagin_list_view.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/features/car/application/car_controller.dart';
import 'package:kcars/features/car/application/car_states.dart';
import 'package:kcars/features/car/presentation/riverpod/all_cars.dart';
import 'package:kcars/features/company/presentation/screen/company_cars_screen.dart';
import 'package:kcars/translations/locale_keys.g.dart';

@RoutePage()
class AllCarsScreen extends ConsumerWidget {
  const AllCarsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(allCarsProvider);
    ref.listen(carControllerProvider, (prev, next) {
      if (next is DeleteCarCompleted) {
        showMessages(context, message: LocaleKeys.alertMessages_deleted.tr());
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.screens_cars.tr()),
        leading: CustomBackButton(),
        actions: [
          IconButton(
            onPressed: () {
              context.router.push(SearchCarRoute());
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: PagingSliverList(
        onRefresh: () => ref.read(allCarsProvider.notifier).loadInitial(),
        onLoadMore: () => ref.read(allCarsProvider.notifier).loadMore(),
        state: state,
        itemBuilder: (itemBuilder, car, index) {
          return CarsWidget(car: car, isAdmin: true);
        },
      ),
    );
  }
}
