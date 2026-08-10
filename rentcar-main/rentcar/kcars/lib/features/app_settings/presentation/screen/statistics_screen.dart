import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/utils/date_year_picker.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/loadin_widget.dart';
import 'package:kcars/features/app_settings/data/model/statistic.dart';
import 'package:kcars/features/app_settings/presentation/riverpod/statistics.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

@RoutePage()
class StatisticsScreen extends StatefulHookConsumerWidget {
  const StatisticsScreen({super.key});
  @override
  ConsumerState<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends ConsumerState<StatisticsScreen> {
  late TooltipBehavior _monthTooltipBehavior;
  late TooltipBehavior _yeartooltipBehavior;

  @override
  void initState() {
    _monthTooltipBehavior = TooltipBehavior(enable: true, animationDuration: 5);
    _yeartooltipBehavior = TooltipBehavior(enable: true, animationDuration: 5);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final statisticsDate = useState<DateTime?>(null);
    final statisitcs = ref.watch(adminStatisticsProvider(statisticsDate.value));
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.screens_statistics.tr()),
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
        onRefresh: () async => await ref.refresh(
          adminStatisticsProvider(statisticsDate.value).future,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric().copyWith(top: 4.w, bottom: 20.w),
          child: statisitcs.when(
            data: (data) {
              return Column(
                children: [
                  SizedBox(
                    height: 24.w,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      controller: PageController(
                        viewportFraction: 0.8,
                        initialPage: 0,
                      ),
                      children: [
                        StatisticsCard(
                          label: LocaleKeys.screens_cars.tr(),
                          result: data.totalcars ?? 0,
                        ),
                        StatisticsCard(
                          label: LocaleKeys.screens_reservations.tr(),
                          result: data.totalReservations ?? 0,
                        ),
                        StatisticsCard(
                          label:
                              "${LocaleKeys.screens_reservations.tr()} - ${LocaleKeys.bookStatus_pending.tr()}",
                          result: data.totalPendingReservations ?? 0,
                        ),
                        StatisticsCard(
                          label:
                              "${LocaleKeys.screens_reservations.tr()} - ${LocaleKeys.bookStatus_ongoing.tr()}",
                          result: data.totalOngoinReservations ?? 0,
                        ),
                        StatisticsCard(
                          label:
                              "${LocaleKeys.screens_reservations.tr()} - ${LocaleKeys.bookStatus_completed.tr()}",

                          result: data.totalCompletedReservations ?? 0,
                        ),
                        StatisticsCard(
                          label:
                              "${LocaleKeys.screens_reservations.tr()} - ${LocaleKeys.bookStatus_canceled.tr()}",
                          result: data.totalCanceledReservations ?? 0,
                        ),
                      ],
                    ),
                  ),
                  Gap(2.w),
                  mothlyChart(
                    data.totalCompaniesPerMonths,
                    title:
                        "${LocaleKeys.screens_companies.tr()} ${statisticsDate.value?.year ?? DateTime.now().year}",
                  ),
                  Gap(2.w),
                  yearlyChart(
                    data.totallCompaniesPerYears,
                    title:
                        "${LocaleKeys.screens_companies.tr()} ${LocaleKeys.labels_perYear.tr()}",
                  ),
                  Gap(2.w),
                  mothlyChart(
                    data.totalCarsPerMonths,
                    title:
                        "${LocaleKeys.screens_cars.tr()} ${statisticsDate.value?.year ?? DateTime.now().year}",
                  ),
                  Gap(2.w),
                  yearlyChart(
                    data.totallCarsPerYears,
                    title:
                        "${LocaleKeys.screens_cars.tr()} ${LocaleKeys.labels_perYear.tr()}",
                  ),
                  Gap(2.w),
                  mothlyChart(
                    data.totalUserPerMonths,
                    title:
                        "${LocaleKeys.screens_users.tr()} ${statisticsDate.value?.year ?? DateTime.now().year}",
                  ),
                  Gap(2.w),
                  yearlyChart(
                    data.totalUserPerYears,
                    title:
                        "${LocaleKeys.screens_users.tr()} ${LocaleKeys.labels_perYear.tr()}",
                  ),
                ],
              );
            },
            error: (error, tr) => Center(child: Text(error.toString())),
            loading: () => LoadingWidget(),
          ),
        ),
      ),
    );
  }

  Container mothlyChart(List<Statistic>? data, {required String title}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: chartBoxDecoraations(),
      child: SfCartesianChart(
        title: ChartTitle(text: title, textStyle: chartTitleSyle()),
        tooltipBehavior: _monthTooltipBehavior,
        series: <CartesianSeries>[
          SplineAreaSeries<Statistic, int>(
            name: "",
            splineType: SplineType.cardinal,
            enableTooltip: true,
            animationDelay: 5,
            borderWidth: .5.w,
            borderColor: Theme.of(context).colorScheme.primary,
            gradient: splineAreaGradient(),
            dataSource: data!,
            xValueMapper: (Statistic year, _) => year.month,
            yValueMapper: (Statistic month, _) => month.total,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              connectorLineSettings: ConnectorLineSettings(
                type: ConnectorType.curve,
              ),
              textStyle: TextStyle(
                fontFamily: "plus-jakarta",
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
        enableAxisAnimation: true,
        primaryYAxis: primarYLabelAxix(context),
        primaryXAxis: primayYLabelAxix(context),
      ),
    );
  }

  Container yearlyChart(List<Statistic>? data, {required String title}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: chartBoxDecoraations(),
      child: SfCartesianChart(
        title: ChartTitle(text: title, textStyle: chartTitleSyle()),
        tooltipBehavior: _yeartooltipBehavior,
        series: <CartesianSeries>[
          SplineAreaSeries<Statistic, int>(
            name: "",
            splineType: SplineType.cardinal,
            enableTooltip: true,
            animationDelay: 5,
            borderWidth: .5.w,
            borderColor: Theme.of(context).colorScheme.primary,
            gradient: splineAreaGradient(),
            dataSource: data!,
            xValueMapper: (Statistic year, _) => year.year,
            yValueMapper: (Statistic month, _) => month.total,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              connectorLineSettings: ConnectorLineSettings(
                type: ConnectorType.curve,
              ),
              textStyle: TextStyle(
                fontFamily: "plus-jakarta",
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
        enableAxisAnimation: true,
        primaryYAxis: primarYLabelAxix(context),
        primaryXAxis: primayYLabelAxix(context),
      ),
    );
  }
}

TextStyle chartTitleSyle() {
  return TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600);
}

dataLabelSettings() {
  return const DataLabelSettings(
    isVisible: true,
    textStyle: TextStyle(
      fontFamily: "plus-jakarta",
      fontWeight: FontWeight.w400,
    ),
  );
}

splineAreaGradient() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.blue.withAlpha(100), Colors.blue.withAlpha(10)],
  );
}

BoxDecoration chartBoxDecoraations() {
  return BoxDecoration(borderRadius: BorderRadius.circular(2.w));
}

primarYLabelAxix(BuildContext context) {
  return NumericAxis(
    labelStyle: const TextStyle(
      fontFamily: "satoshi",
      fontWeight: FontWeight.w600,
    ),
    numberFormat: NumberFormat.decimalPatternDigits(),
    anchorRangeToVisiblePoints: true,
    majorGridLines: MajorGridLines(
      color: Theme.of(context).colorScheme.primary.withAlpha(50),
      width: .05.w,
      dashArray: const [14, 14],
    ),
  );
}

primayYLabelAxix(BuildContext context) {
  return CategoryAxis(
    majorGridLines: MajorGridLines(
      color: Theme.of(context).colorScheme.primary.withAlpha(100),
      width: .5,
      dashArray: const [10, 10],
    ),
    edgeLabelPlacement: EdgeLabelPlacement.shift,
  );
}

class StatisticsCard extends StatelessWidget {
  final String label;
  final num result;
  const StatisticsCard({super.key, required this.label, required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4.w),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.scrim.withAlpha(20),
            offset: const Offset(0, .1),
            spreadRadius: .1,
            blurRadius: .1,
          ),
        ],
        borderRadius: BorderRadius.circular(2.w),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [context.primary, context.primary.withAlpha(200)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            result.forMatNumber(),
            style: TextStyle(
              fontSize: 22.sp,
              color: Colors.white,
              fontFamily: "outfit",
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.w),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
