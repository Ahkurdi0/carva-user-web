import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/utils/date_year_picker.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/loading_emoty_state.dart';
import 'package:kcars/features/company/presentation/riverpod/company_statistics.dart';
import 'package:kcars/screens/not_loggedin_screen.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

@RoutePage()
class CompanyStatiscsScreen extends HookConsumerWidget {
  const CompanyStatiscsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statisticsDate = useState<DateTime?>(null);
    final statisticAsync = ref.watch(
      companyStatisticsProvider(statisticsDate.value),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.screens_contactStistics.tr()),
        leading: CustomBackButton(),
        actions: [
          TextButton(
            onPressed: () async {
              final year = await showDateYearPicker(
                context,
                DateRangePickerView.decade,
              );
              if (year == null) return;
              statisticsDate.value = year;
            },
            child: Text("${statisticsDate.value?.year ?? DateTime.now().year}"),
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          return ref.refresh(
            companyStatisticsProvider(statisticsDate.value).future,
          );
        },
        child: statisticAsync.when(
          data: (data) {
            if (data.isEmpty) {
              return SliverToBoxAdapter(
                child: EmptyStateWidget(message: LocaleKeys.empty_noData.tr()),
              );
            }
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final stat = data[index];
                return ExpansionTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: context.surfaceContainerLow),
                  ),
                  title: Text(
                    "${stat.company?.name ?? ""} - (${stat.company?.total?.forMatNumber() ?? ""})",
                    style: context.button,
                  ),
                  children: [
                    SizedBox(
                      height: 74.w,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: stat.types?.length,
                        itemBuilder: (context, itemIndex) {
                          final item = stat.types?[itemIndex];
                          return Container(
                            margin: EdgeInsetsDirectional.only(end: 2.w),
                            padding: EdgeInsets.all(2.w),
                            constraints: BoxConstraints(minWidth: 40.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: context.surfaceContainerLow,
                              ),
                              borderRadius: BorderRadius.circular(2.w),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${item?.type.getTitle()} - ${item?.total?.forMatNumber()}",
                                  style: context.label2SemiBold,
                                ),
                                SizedBox(height: 2.w),
                                ...item?.data
                                        .asMap()
                                        .entries
                                        .map(
                                          (stat) => Container(
                                            width: 40.w,
                                            decoration: BoxDecoration(
                                              color: stat.key % 2 == 0
                                                  ? context.secondaryContainer
                                                  : null,
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "${stat.value.month} ${stat.value.month?.getMonthName(context)}",
                                                ),
                                                Spacer(),
                                                Text(
                                                  stat.value.count.toString(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList() ??
                                    [],
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 2.w),
                  ],
                );
              },
            );
          },
          error: (error, trace) => Center(child: Text(error.toString())),
          loading: () => CircleLoading(),
        ),
      ),
    );
  }
}
