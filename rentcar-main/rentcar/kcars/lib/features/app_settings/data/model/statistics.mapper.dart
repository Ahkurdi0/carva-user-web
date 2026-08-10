// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'statistics.dart';

class StatisticsMapper extends ClassMapperBase<Statistics> {
  StatisticsMapper._();

  static StatisticsMapper? _instance;
  static StatisticsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StatisticsMapper._());
      StatisticMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Statistics';

  static List<Statistic>? _$totalUserPerMonths(Statistics v) =>
      v.totalUserPerMonths;
  static const Field<Statistics, List<Statistic>> _f$totalUserPerMonths =
      Field('totalUserPerMonths', _$totalUserPerMonths, opt: true);
  static List<Statistic>? _$totalUserPerYears(Statistics v) =>
      v.totalUserPerYears;
  static const Field<Statistics, List<Statistic>> _f$totalUserPerYears =
      Field('totalUserPerYears', _$totalUserPerYears, opt: true);
  static List<Statistic>? _$totalCompaniesPerMonths(Statistics v) =>
      v.totalCompaniesPerMonths;
  static const Field<Statistics, List<Statistic>> _f$totalCompaniesPerMonths =
      Field('totalCompaniesPerMonths', _$totalCompaniesPerMonths, opt: true);
  static List<Statistic>? _$totallCompaniesPerYears(Statistics v) =>
      v.totallCompaniesPerYears;
  static const Field<Statistics, List<Statistic>> _f$totallCompaniesPerYears =
      Field('totallCompaniesPerYears', _$totallCompaniesPerYears, opt: true);
  static int? _$totalReservations(Statistics v) => v.totalReservations;
  static const Field<Statistics, int> _f$totalReservations =
      Field('totalReservations', _$totalReservations, opt: true);
  static int? _$totalPendingReservations(Statistics v) =>
      v.totalPendingReservations;
  static const Field<Statistics, int> _f$totalPendingReservations =
      Field('totalPendingReservations', _$totalPendingReservations, opt: true);
  static int? _$totalOngoinReservations(Statistics v) =>
      v.totalOngoinReservations;
  static const Field<Statistics, int> _f$totalOngoinReservations =
      Field('totalOngoinReservations', _$totalOngoinReservations, opt: true);
  static int? _$totalCompletedReservations(Statistics v) =>
      v.totalCompletedReservations;
  static const Field<Statistics, int> _f$totalCompletedReservations = Field(
      'totalCompletedReservations', _$totalCompletedReservations,
      opt: true);
  static int? _$totalCanceledReservations(Statistics v) =>
      v.totalCanceledReservations;
  static const Field<Statistics, int> _f$totalCanceledReservations = Field(
      'totalCanceledReservations', _$totalCanceledReservations,
      opt: true);
  static List<Statistic>? _$totalCarsPerMonths(Statistics v) =>
      v.totalCarsPerMonths;
  static const Field<Statistics, List<Statistic>> _f$totalCarsPerMonths =
      Field('totalCarsPerMonths', _$totalCarsPerMonths, opt: true);
  static List<Statistic>? _$totallCarsPerYears(Statistics v) =>
      v.totallCarsPerYears;
  static const Field<Statistics, List<Statistic>> _f$totallCarsPerYears =
      Field('totallCarsPerYears', _$totallCarsPerYears, opt: true);
  static int? _$totalcars(Statistics v) => v.totalcars;
  static const Field<Statistics, int> _f$totalcars =
      Field('totalcars', _$totalcars, opt: true);

  @override
  final MappableFields<Statistics> fields = const {
    #totalUserPerMonths: _f$totalUserPerMonths,
    #totalUserPerYears: _f$totalUserPerYears,
    #totalCompaniesPerMonths: _f$totalCompaniesPerMonths,
    #totallCompaniesPerYears: _f$totallCompaniesPerYears,
    #totalReservations: _f$totalReservations,
    #totalPendingReservations: _f$totalPendingReservations,
    #totalOngoinReservations: _f$totalOngoinReservations,
    #totalCompletedReservations: _f$totalCompletedReservations,
    #totalCanceledReservations: _f$totalCanceledReservations,
    #totalCarsPerMonths: _f$totalCarsPerMonths,
    #totallCarsPerYears: _f$totallCarsPerYears,
    #totalcars: _f$totalcars,
  };

  static Statistics _instantiate(DecodingData data) {
    return Statistics(
        totalUserPerMonths: data.dec(_f$totalUserPerMonths),
        totalUserPerYears: data.dec(_f$totalUserPerYears),
        totalCompaniesPerMonths: data.dec(_f$totalCompaniesPerMonths),
        totallCompaniesPerYears: data.dec(_f$totallCompaniesPerYears),
        totalReservations: data.dec(_f$totalReservations),
        totalPendingReservations: data.dec(_f$totalPendingReservations),
        totalOngoinReservations: data.dec(_f$totalOngoinReservations),
        totalCompletedReservations: data.dec(_f$totalCompletedReservations),
        totalCanceledReservations: data.dec(_f$totalCanceledReservations),
        totalCarsPerMonths: data.dec(_f$totalCarsPerMonths),
        totallCarsPerYears: data.dec(_f$totallCarsPerYears),
        totalcars: data.dec(_f$totalcars));
  }

  @override
  final Function instantiate = _instantiate;

  static Statistics fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Statistics>(map);
  }

  static Statistics fromJson(String json) {
    return ensureInitialized().decodeJson<Statistics>(json);
  }
}

mixin StatisticsMappable {
  String toJson() {
    return StatisticsMapper.ensureInitialized()
        .encodeJson<Statistics>(this as Statistics);
  }

  Map<String, dynamic> toMap() {
    return StatisticsMapper.ensureInitialized()
        .encodeMap<Statistics>(this as Statistics);
  }

  StatisticsCopyWith<Statistics, Statistics, Statistics> get copyWith =>
      _StatisticsCopyWithImpl<Statistics, Statistics>(
          this as Statistics, $identity, $identity);
  @override
  String toString() {
    return StatisticsMapper.ensureInitialized()
        .stringifyValue(this as Statistics);
  }

  @override
  bool operator ==(Object other) {
    return StatisticsMapper.ensureInitialized()
        .equalsValue(this as Statistics, other);
  }

  @override
  int get hashCode {
    return StatisticsMapper.ensureInitialized().hashValue(this as Statistics);
  }
}

extension StatisticsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Statistics, $Out> {
  StatisticsCopyWith<$R, Statistics, $Out> get $asStatistics =>
      $base.as((v, t, t2) => _StatisticsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class StatisticsCopyWith<$R, $In extends Statistics, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Statistic, StatisticCopyWith<$R, Statistic, Statistic>>?
      get totalUserPerMonths;
  ListCopyWith<$R, Statistic, StatisticCopyWith<$R, Statistic, Statistic>>?
      get totalUserPerYears;
  ListCopyWith<$R, Statistic, StatisticCopyWith<$R, Statistic, Statistic>>?
      get totalCompaniesPerMonths;
  ListCopyWith<$R, Statistic, StatisticCopyWith<$R, Statistic, Statistic>>?
      get totallCompaniesPerYears;
  ListCopyWith<$R, Statistic, StatisticCopyWith<$R, Statistic, Statistic>>?
      get totalCarsPerMonths;
  ListCopyWith<$R, Statistic, StatisticCopyWith<$R, Statistic, Statistic>>?
      get totallCarsPerYears;
  $R call(
      {List<Statistic>? totalUserPerMonths,
      List<Statistic>? totalUserPerYears,
      List<Statistic>? totalCompaniesPerMonths,
      List<Statistic>? totallCompaniesPerYears,
      int? totalReservations,
      int? totalPendingReservations,
      int? totalOngoinReservations,
      int? totalCompletedReservations,
      int? totalCanceledReservations,
      List<Statistic>? totalCarsPerMonths,
      List<Statistic>? totallCarsPerYears,
      int? totalcars});
  StatisticsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StatisticsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Statistics, $Out>
    implements StatisticsCopyWith<$R, Statistics, $Out> {
  _StatisticsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Statistics> $mapper =
      StatisticsMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Statistic, StatisticCopyWith<$R, Statistic, Statistic>>?
      get totalUserPerMonths => $value.totalUserPerMonths != null
          ? ListCopyWith(
              $value.totalUserPerMonths!,
              (v, t) => v.copyWith.$chain(t),
              (v) => call(totalUserPerMonths: v))
          : null;
  @override
  ListCopyWith<$R, Statistic, StatisticCopyWith<$R, Statistic, Statistic>>?
      get totalUserPerYears => $value.totalUserPerYears != null
          ? ListCopyWith($value.totalUserPerYears!,
              (v, t) => v.copyWith.$chain(t), (v) => call(totalUserPerYears: v))
          : null;
  @override
  ListCopyWith<$R, Statistic, StatisticCopyWith<$R, Statistic, Statistic>>?
      get totalCompaniesPerMonths => $value.totalCompaniesPerMonths != null
          ? ListCopyWith(
              $value.totalCompaniesPerMonths!,
              (v, t) => v.copyWith.$chain(t),
              (v) => call(totalCompaniesPerMonths: v))
          : null;
  @override
  ListCopyWith<$R, Statistic, StatisticCopyWith<$R, Statistic, Statistic>>?
      get totallCompaniesPerYears => $value.totallCompaniesPerYears != null
          ? ListCopyWith(
              $value.totallCompaniesPerYears!,
              (v, t) => v.copyWith.$chain(t),
              (v) => call(totallCompaniesPerYears: v))
          : null;
  @override
  ListCopyWith<$R, Statistic, StatisticCopyWith<$R, Statistic, Statistic>>?
      get totalCarsPerMonths => $value.totalCarsPerMonths != null
          ? ListCopyWith(
              $value.totalCarsPerMonths!,
              (v, t) => v.copyWith.$chain(t),
              (v) => call(totalCarsPerMonths: v))
          : null;
  @override
  ListCopyWith<$R, Statistic, StatisticCopyWith<$R, Statistic, Statistic>>?
      get totallCarsPerYears => $value.totallCarsPerYears != null
          ? ListCopyWith(
              $value.totallCarsPerYears!,
              (v, t) => v.copyWith.$chain(t),
              (v) => call(totallCarsPerYears: v))
          : null;
  @override
  $R call(
          {Object? totalUserPerMonths = $none,
          Object? totalUserPerYears = $none,
          Object? totalCompaniesPerMonths = $none,
          Object? totallCompaniesPerYears = $none,
          Object? totalReservations = $none,
          Object? totalPendingReservations = $none,
          Object? totalOngoinReservations = $none,
          Object? totalCompletedReservations = $none,
          Object? totalCanceledReservations = $none,
          Object? totalCarsPerMonths = $none,
          Object? totallCarsPerYears = $none,
          Object? totalcars = $none}) =>
      $apply(FieldCopyWithData({
        if (totalUserPerMonths != $none)
          #totalUserPerMonths: totalUserPerMonths,
        if (totalUserPerYears != $none) #totalUserPerYears: totalUserPerYears,
        if (totalCompaniesPerMonths != $none)
          #totalCompaniesPerMonths: totalCompaniesPerMonths,
        if (totallCompaniesPerYears != $none)
          #totallCompaniesPerYears: totallCompaniesPerYears,
        if (totalReservations != $none) #totalReservations: totalReservations,
        if (totalPendingReservations != $none)
          #totalPendingReservations: totalPendingReservations,
        if (totalOngoinReservations != $none)
          #totalOngoinReservations: totalOngoinReservations,
        if (totalCompletedReservations != $none)
          #totalCompletedReservations: totalCompletedReservations,
        if (totalCanceledReservations != $none)
          #totalCanceledReservations: totalCanceledReservations,
        if (totalCarsPerMonths != $none)
          #totalCarsPerMonths: totalCarsPerMonths,
        if (totallCarsPerYears != $none)
          #totallCarsPerYears: totallCarsPerYears,
        if (totalcars != $none) #totalcars: totalcars
      }));
  @override
  Statistics $make(CopyWithData data) => Statistics(
      totalUserPerMonths:
          data.get(#totalUserPerMonths, or: $value.totalUserPerMonths),
      totalUserPerYears:
          data.get(#totalUserPerYears, or: $value.totalUserPerYears),
      totalCompaniesPerMonths: data.get(#totalCompaniesPerMonths,
          or: $value.totalCompaniesPerMonths),
      totallCompaniesPerYears: data.get(#totallCompaniesPerYears,
          or: $value.totallCompaniesPerYears),
      totalReservations:
          data.get(#totalReservations, or: $value.totalReservations),
      totalPendingReservations: data.get(#totalPendingReservations,
          or: $value.totalPendingReservations),
      totalOngoinReservations: data.get(#totalOngoinReservations,
          or: $value.totalOngoinReservations),
      totalCompletedReservations: data.get(#totalCompletedReservations,
          or: $value.totalCompletedReservations),
      totalCanceledReservations: data.get(#totalCanceledReservations,
          or: $value.totalCanceledReservations),
      totalCarsPerMonths:
          data.get(#totalCarsPerMonths, or: $value.totalCarsPerMonths),
      totallCarsPerYears:
          data.get(#totallCarsPerYears, or: $value.totallCarsPerYears),
      totalcars: data.get(#totalcars, or: $value.totalcars));

  @override
  StatisticsCopyWith<$R2, Statistics, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StatisticsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
