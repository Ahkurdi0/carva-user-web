import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/loading_emoty_state.dart';
import 'package:kcars/core/widget/search_feild.dart';
import 'package:kcars/features/car/application/car_controller.dart';
import 'package:kcars/features/car/application/car_states.dart';
import 'package:kcars/features/car/presentation/riverpod/search_cars.dart';
import 'package:kcars/features/company/presentation/screen/company_cars_screen.dart';
import 'package:kcars/translations/locale_keys.g.dart';

@RoutePage()
class SearchCarScreen extends HookConsumerWidget {
  const SearchCarScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchData = ref.watch(searchCarProvider);
    final controller = useTextEditingController();
    ref.listen(carControllerProvider, (prev, next) {
      if (next is DeleteCarCompleted) {
        showMessages(context, message: LocaleKeys.alertMessages_deleted.tr());
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: SearchFeild(
          controller: controller,
          isLoading: searchData.isLoading,
          onChanged: (p0) {
            if (controller.text.length <= 2) return;
            ref.read(searchCarProvider.notifier).searchForCars(controller.text);
          },
          hint: LocaleKeys.inputHintText_searchCar.tr(),
        ),
        leading: CustomBackButton(),
      ),
      body: searchData.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => CarsWidget(car: data[index]),
          );
        },
        error: (err, _) => Center(child: Text(err.toString())),
        loading: () => CircleLoading(),
        skipError: true,
        skipLoadingOnRefresh: true,
        skipLoadingOnReload: true,
      ),
    );
  }
}
