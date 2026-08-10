import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/launch_links.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/core/widget/loadin_widget.dart';
import 'package:kcars/features/app_settings/presentation/riverpod/supports.dart';
import 'package:sizer/sizer.dart';

class SupportsView extends HookConsumerWidget {
  const SupportsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsData = ref.watch(supportsProvider);
    final locale = useMemoized(() => context.locale.toLanguageTag(), []);
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 18.w),
      child: contactsData.when(
        data: (data) {
          return ListView.builder(
            padding: EdgeInsets.only(bottom: 4.w),
            itemCount: data.length,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final support = data[index];
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.8,
                      color: context.surfaceContainerLow,
                    ),
                  ),
                ),
                child: ListTile(
                  onTap: () {
                    openLinks(
                      webLink: support.content,
                      appLink: support.content,
                    );
                  },
                  splashColor: Colors.transparent,
                  leading: ImageHolder(
                    image: support.image,
                    width: 8.w,
                    height: 8.w,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(100.w),
                  ),
                  title: Text(support.getTitle(locale)),
                ),
              );
            },
          );
        },
        error: (error, trace) => Center(child: Text(error.toString())),
        loading: () => SizedBox(height: 18.w, child: LoadingWidget()),
      ),
    );
  }
}
