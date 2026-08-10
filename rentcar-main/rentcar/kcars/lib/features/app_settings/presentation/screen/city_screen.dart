import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/custom_list_tile.dart';
import 'package:kcars/core/widget/loadin_widget.dart';
import 'package:kcars/features/app_settings/application/app_settigngs_controller.dart';
import 'package:kcars/features/app_settings/presentation/riverpod/all_cites.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class CityScreen extends HookConsumerWidget {
  const CityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = useMemoized(() => context.locale.toLanguageTag());
    final states = ref.watch(allCitiesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.screens_cities.tr()),
        leading: const CustomBackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.pushRoute(NewEditCityRoute()),
          ),
        ],
      ),
      body: states.when(
        data: (data) {
          return RefreshIndicator(
            onRefresh: () async => ref.refresh(allCitiesProvider.future),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ReorderableListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                onReorder: (oldIndex, newIndex) {
                  ref
                      .read(allCitiesProvider.notifier)
                      .reorderCities(
                        data,
                        oldIndex,
                        newIndex > oldIndex ? newIndex - 1 : newIndex,
                      );
                },
                children: data
                    .asMap()
                    .entries
                    .map(
                      (v) => ExpansionTile(
                        key: ValueKey("gov-${v.value.id}"),
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(width: .2),
                        ),
                        title: Text(
                          v.value.getTitle(locale),
                          style: context.label.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete, size: 5.w),
                              onPressed: () => showCustomAlert(
                                context,
                                isDeleting: true,
                                content: LocaleKeys.alertMessages_deleteCity
                                    .tr(),
                                primaryAction: () {
                                  ref
                                      .read(
                                        appSettingsControllerProvider.notifier,
                                      )
                                      .deleteCity(v.value.id!);
                                },
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit_sharp, size: 5.w),
                              onPressed: () => context.pushRoute(
                                NewEditCityRoute(city: v.value),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => context.pushRoute(
                                NewEditTownRoute(city: v.value),
                              ),
                            ),
                          ],
                        ),
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.5,
                            ),
                            child: ReorderableListView.builder(
                              proxyDecorator: (child, index, animation) {
                                return AnimatedBuilder(
                                  key: ValueKey(index),
                                  animation: animation,
                                  builder: (context, child) {
                                    return Opacity(
                                      opacity: 1 - (0.1 * animation.value),
                                      child: Material(
                                        elevation: 1,
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: child,
                                );
                              },
                              onReorder: (oldIndex, newIndex) {
                                ref
                                    .read(allCitiesProvider.notifier)
                                    .reorderTowns(
                                      data[v.key].towns!,
                                      oldIndex,
                                      newIndex > oldIndex
                                          ? newIndex - 1
                                          : newIndex,
                                      v.value.id!,
                                    );
                              },
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: v.value.towns!.length,
                              itemBuilder: (context, index) {
                                final town = data[v.key].towns![index];
                                return ReorderableDragStartListener(
                                  index: index,
                                  key: ValueKey("town-${town.id}"),
                                  child: CustomListTile(
                                    key: ValueKey("town-${town.id}"),
                                    title: town.getTitle(locale),
                                    onDelete: () => showCustomAlert(
                                      context,
                                      isDeleting: true,
                                      closeButton: true,
                                      content: LocaleKeys
                                          .alertMessages_deleteTown
                                          .tr(),
                                      primaryAction: () {
                                        ref
                                            .read(
                                              appSettingsControllerProvider
                                                  .notifier,
                                            )
                                            .deleteTown(town);
                                      },
                                    ),
                                    onEdit: () => context.router.push(
                                      NewEditTownRoute(
                                        town: town,
                                        city: v.value,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        },
        error: (error, trace) => Center(child: Text(error.toString())),
        loading: () => LoadingWidget(),
      ),
    );
  }
}
