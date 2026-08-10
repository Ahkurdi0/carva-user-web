import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/custom_list_tile.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/core/widget/loading_emoty_state.dart';
import 'package:kcars/features/app_settings/application/app_settigngs_controller.dart';
import 'package:kcars/features/app_settings/presentation/riverpod/sliders.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class SlidersScreen extends ConsumerWidget {
  const SlidersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sliderAsync = ref.watch(allSlidersProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.screens_Slider.tr()),
        leading: const CustomBackButton(),
        actions: [
          IconButton(
            onPressed: () {
              context.router.push(NewSliderRoute());
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(allSlidersProvider.future),
        child: sliderAsync.when(
          data: (items) => ReorderableListView.builder(
            padding: EdgeInsets.only(top: 4.w),
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
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            onReorder: (oldIndex, newIndex) {
              ref
                  .read(allSlidersProvider.notifier)
                  .sortSliders(
                    items,
                    oldIndex,
                    newIndex > oldIndex ? newIndex - 1 : newIndex,
                  );
            },
            itemBuilder: (context, index) {
              final slider = items[index];
              return ReorderableDragStartListener(
                key: ValueKey(index),
                index: index,
                child: Container(
                  margin: EdgeInsets.only(bottom: 2.w),
                  child: CustomListTile(
                    leading: ImageHolder(
                      image: slider.image,
                      height: 20.w,
                      width: 30.w,
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(1.w),
                    ),
                    title: slider.clicked?.forMatNumber() ?? "0",
                    onEdit: () {
                      context.router.push(NewSliderRoute(sliders: slider));
                    },
                    onDelete: () {
                      showCustomAlert(
                        context,
                        isDeleting: true,
                        content: LocaleKeys.alertMessages_deleteSlider.tr(),
                        primaryAction: () {
                          ref
                              .read(appSettingsControllerProvider.notifier)
                              .deleteSlider(slider.id!);
                        },
                      );
                    },
                  ),
                ),
              );
            },
            itemCount: items.length,
          ),
          loading: () => CircleLoading(),
          skipLoadingOnReload: true,
          skipLoadingOnRefresh: true,
          error: (e, _) => Center(child: Text(e.toString())),
        ),
      ),
    );
  }
}
