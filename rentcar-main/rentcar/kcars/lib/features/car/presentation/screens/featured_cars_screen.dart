import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/loadin_widget.dart';
import 'package:kcars/features/car/application/car_controller.dart';
import 'package:kcars/features/car/application/car_states.dart';
import 'package:kcars/features/car/presentation/riverpod/featuerd_cars.dart';
import 'package:kcars/features/company/presentation/screen/company_cars_screen.dart';
import 'package:kcars/translations/locale_keys.g.dart';

@RoutePage()
class FeaturedCarsScreen extends ConsumerWidget {
  const FeaturedCarsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(featuredCarsProvider);
    ref.listen(carControllerProvider, (prev, next) {
      if (next is DeleteCarCompleted) {
        showMessages(context, message: LocaleKeys.alertMessages_deleted.tr());
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.screens_featuredCar.tr()),
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
      body: state.when(
        data: (data) {
          return RefreshIndicator(
            onRefresh: () async =>
                await ref.refresh(featuredCarsProvider.future),
            child: ReorderableListView.builder(
              proxyDecorator: (child, index, animation) {
                return AnimatedBuilder(
                  key: ValueKey(index),
                  animation: animation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: 1 - (0.1 * animation.value),
                      child: Material(elevation: 1, child: child),
                    );
                  },
                  child: child,
                );
              },
              physics: const AlwaysScrollableScrollPhysics(),
              onReorder: (oldIndex, newIndex) {
                ref
                    .read(featuredCarsProvider.notifier)
                    .reorderItems(
                      data,
                      oldIndex,
                      newIndex > oldIndex ? newIndex - 1 : newIndex,
                    );
              },
              itemBuilder: (context, index) {
                final car = data[index];
                return ReorderableDragStartListener(
                  key: ValueKey(index),
                  index: index,
                  child: CarsWidget(car: car, isAdmin: true, isFeatured: true),
                );
              },
              itemCount: data.length,
            ),
          );
        },

        error: (error, trace) => Center(child: Text(error.toString())),
        loading: () => LoadingWidget(),
      ),
    );
  }
}
