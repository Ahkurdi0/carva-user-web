import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/app_settings/data/model/statistic.dart';
part 'statistics.mapper.dart';

@MappableClass()
class Statistics with StatisticsMappable {
  final List<Statistic>? totalUserPerMonths;
  final List<Statistic>? totalUserPerYears;
  final List<Statistic>? totalCompaniesPerMonths;
  final List<Statistic>? totallCompaniesPerYears;
  final int? totalReservations;
  final int? totalPendingReservations;
  final int? totalOngoinReservations;
  final int? totalCompletedReservations;
  final int? totalCanceledReservations;
  final List<Statistic>? totalCarsPerMonths;
  final List<Statistic>? totallCarsPerYears;
  final int? totalcars;

  Statistics({
    this.totalUserPerMonths,
    this.totalUserPerYears,
    this.totalCompaniesPerMonths,
    this.totallCompaniesPerYears,
    this.totalReservations,
    this.totalPendingReservations,
    this.totalOngoinReservations,
    this.totalCompletedReservations,
    this.totalCanceledReservations,
    this.totalCarsPerMonths,
    this.totallCarsPerYears,
    this.totalcars,
  });
}
