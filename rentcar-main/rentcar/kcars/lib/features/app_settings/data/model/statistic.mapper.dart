// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'statistic.dart';

class StatisticMapper extends ClassMapperBase<Statistic> {
  StatisticMapper._();

  static StatisticMapper? _instance;
  static StatisticMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StatisticMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Statistic';

  static int? _$year(Statistic v) => v.year;
  static const Field<Statistic, int> _f$year = Field('year', _$year, opt: true);
  static int? _$month(Statistic v) => v.month;
  static const Field<Statistic, int> _f$month =
      Field('month', _$month, opt: true);
  static double _$total(Statistic v) => v.total;
  static const Field<Statistic, double> _f$total = Field('total', _$total);

  @override
  final MappableFields<Statistic> fields = const {
    #year: _f$year,
    #month: _f$month,
    #total: _f$total,
  };

  static Statistic _instantiate(DecodingData data) {
    return Statistic(
        year: data.dec(_f$year),
        month: data.dec(_f$month),
        total: data.dec(_f$total));
  }

  @override
  final Function instantiate = _instantiate;

  static Statistic fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Statistic>(map);
  }

  static Statistic fromJson(String json) {
    return ensureInitialized().decodeJson<Statistic>(json);
  }
}

mixin StatisticMappable {
  String toJson() {
    return StatisticMapper.ensureInitialized()
        .encodeJson<Statistic>(this as Statistic);
  }

  Map<String, dynamic> toMap() {
    return StatisticMapper.ensureInitialized()
        .encodeMap<Statistic>(this as Statistic);
  }

  StatisticCopyWith<Statistic, Statistic, Statistic> get copyWith =>
      _StatisticCopyWithImpl<Statistic, Statistic>(
          this as Statistic, $identity, $identity);
  @override
  String toString() {
    return StatisticMapper.ensureInitialized()
        .stringifyValue(this as Statistic);
  }

  @override
  bool operator ==(Object other) {
    return StatisticMapper.ensureInitialized()
        .equalsValue(this as Statistic, other);
  }

  @override
  int get hashCode {
    return StatisticMapper.ensureInitialized().hashValue(this as Statistic);
  }
}

extension StatisticValueCopy<$R, $Out> on ObjectCopyWith<$R, Statistic, $Out> {
  StatisticCopyWith<$R, Statistic, $Out> get $asStatistic =>
      $base.as((v, t, t2) => _StatisticCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class StatisticCopyWith<$R, $In extends Statistic, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? year, int? month, double? total});
  StatisticCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StatisticCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Statistic, $Out>
    implements StatisticCopyWith<$R, Statistic, $Out> {
  _StatisticCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Statistic> $mapper =
      StatisticMapper.ensureInitialized();
  @override
  $R call({Object? year = $none, Object? month = $none, double? total}) =>
      $apply(FieldCopyWithData({
        if (year != $none) #year: year,
        if (month != $none) #month: month,
        if (total != null) #total: total
      }));
  @override
  Statistic $make(CopyWithData data) => Statistic(
      year: data.get(#year, or: $value.year),
      month: data.get(#month, or: $value.month),
      total: data.get(#total, or: $value.total));

  @override
  StatisticCopyWith<$R2, Statistic, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StatisticCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
