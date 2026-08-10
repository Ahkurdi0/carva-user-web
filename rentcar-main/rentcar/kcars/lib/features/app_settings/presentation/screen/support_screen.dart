import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/custom_list_tile.dart';
import 'package:kcars/core/widget/loadin_widget.dart';
import 'package:kcars/features/app_settings/application/app_settigngs_controller.dart';
import 'package:kcars/features/app_settings/application/states.dart';
import 'package:kcars/features/app_settings/presentation/riverpod/supports.dart';
import 'package:kcars/translations/locale_keys.g.dart';

@RoutePage()
class SupportsScreen extends HookConsumerWidget {
  const SupportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = useMemoized(() => context.locale.toLanguageTag(), []);
    ref.listen(appSettingsControllerProvider, (prev, next) {
      if (next is DeleteSupportCompleted) {
        showMessages(context, message: LocaleKeys.alertMessages_deleted.tr());
        return;
      }
      if (next is DeleteSupportFailed) {
        showMessages(context, message: next.message);
      }
    });

    final carTypes = ref.watch(supportsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.screens_supports.tr()),
        leading: CustomBackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.router.push(NewEditSupportRoute());
            },
          ),
        ],
      ),
      body: carTypes.when(
        data: (data) {
          return RefreshIndicator(
            onRefresh: () async => await ref.refresh(supportsProvider.future),
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
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              onReorder: (oldIndex, newIndex) {
                ref
                    .read(supportsProvider.notifier)
                    .reorderItems(
                      data,
                      oldIndex,
                      newIndex > oldIndex ? newIndex - 1 : newIndex,
                    );
              },
              itemBuilder: (context, index) {
                final support = data[index];
                return ReorderableDragStartListener(
                  key: ValueKey(index),
                  index: index,
                  child: CustomListTile(
                    title: support.getTitle(locale),
                    onEdit: () {
                      context.router.push(
                        NewEditSupportRoute(support: support),
                      );
                    },
                    onDelete: () {
                      showCustomAlert(
                        context,
                        isDeleting: true,
                        content: LocaleKeys.alertMessages_deleteSupport.tr(),
                        primaryAction: () {
                          ref
                              .read(appSettingsControllerProvider.notifier)
                              .deleteSupport(support.id!);
                        },
                      );
                    },
                  ),
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
