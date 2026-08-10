// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'feature.dart';

class FeatureMapper extends ClassMapperBase<Feature> {
  FeatureMapper._();

  static FeatureMapper? _instance;
  static FeatureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FeatureMapper._());
      TransmissionMapper.ensureInitialized();
      FuelMapper.ensureInitialized();
      CarTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Feature';

  static String? _$id(Feature v) => v.id;
  static const Field<Feature, String> _f$id = Field('id', _$id, opt: true);
  static String? _$carId(Feature v) => v.carId;
  static const Field<Feature, String> _f$carId =
      Field('carId', _$carId, opt: true);
  static int? _$year(Feature v) => v.year;
  static const Field<Feature, int> _f$year = Field('year', _$year, opt: true);
  static int? _$maxYear(Feature v) => v.maxYear;
  static const Field<Feature, int> _f$maxYear =
      Field('maxYear', _$maxYear, opt: true);
  static int? _$seat(Feature v) => v.seat;
  static const Field<Feature, int> _f$seat = Field('seat', _$seat, opt: true);
  static int? _$hp(Feature v) => v.hp;
  static const Field<Feature, int> _f$hp = Field('hp', _$hp, opt: true);
  static int? _$speed(Feature v) => v.speed;
  static const Field<Feature, int> _f$speed =
      Field('speed', _$speed, opt: true);
  static int? _$odometer(Feature v) => v.odometer;
  static const Field<Feature, int> _f$odometer =
      Field('odometer', _$odometer, opt: true);
  static Transmission? _$transmission(Feature v) => v.transmission;
  static const Field<Feature, Transmission> _f$transmission =
      Field('transmission', _$transmission, opt: true);
  static Fuel? _$fuel(Feature v) => v.fuel;
  static const Field<Feature, Fuel> _f$fuel = Field('fuel', _$fuel, opt: true);
  static CarType? _$type(Feature v) => v.type;
  static const Field<Feature, CarType> _f$type =
      Field('type', _$type, opt: true);
  static int? _$cylinders(Feature v) => v.cylinders;
  static const Field<Feature, int> _f$cylinders =
      Field('cylinders', _$cylinders, opt: true);
  static double? _$engCC(Feature v) => v.engCC;
  static const Field<Feature, double> _f$engCC =
      Field('engCC', _$engCC, opt: true);

  @override
  final MappableFields<Feature> fields = const {
    #id: _f$id,
    #carId: _f$carId,
    #year: _f$year,
    #maxYear: _f$maxYear,
    #seat: _f$seat,
    #hp: _f$hp,
    #speed: _f$speed,
    #odometer: _f$odometer,
    #transmission: _f$transmission,
    #fuel: _f$fuel,
    #type: _f$type,
    #cylinders: _f$cylinders,
    #engCC: _f$engCC,
  };

  static Feature _instantiate(DecodingData data) {
    return Feature(
        id: data.dec(_f$id),
        carId: data.dec(_f$carId),
        year: data.dec(_f$year),
        maxYear: data.dec(_f$maxYear),
        seat: data.dec(_f$seat),
        hp: data.dec(_f$hp),
        speed: data.dec(_f$speed),
        odometer: data.dec(_f$odometer),
        transmission: data.dec(_f$transmission),
        fuel: data.dec(_f$fuel),
        type: data.dec(_f$type),
        cylinders: data.dec(_f$cylinders),
        engCC: data.dec(_f$engCC));
  }

  @override
  final Function instantiate = _instantiate;

  static Feature fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Feature>(map);
  }

  static Feature fromJson(String json) {
    return ensureInitialized().decodeJson<Feature>(json);
  }
}

mixin FeatureMappable {
  String toJson() {
    return FeatureMapper.ensureInitialized()
        .encodeJson<Feature>(this as Feature);
  }

  Map<String, dynamic> toMap() {
    return FeatureMapper.ensureInitialized()
        .encodeMap<Feature>(this as Feature);
  }

  FeatureCopyWith<Feature, Feature, Feature> get copyWith =>
      _FeatureCopyWithImpl<Feature, Feature>(
          this as Feature, $identity, $identity);
  @override
  String toString() {
    return FeatureMapper.ensureInitialized().stringifyValue(this as Feature);
  }

  @override
  bool operator ==(Object other) {
    return FeatureMapper.ensureInitialized()
        .equalsValue(this as Feature, other);
  }

  @override
  int get hashCode {
    return FeatureMapper.ensureInitialized().hashValue(this as Feature);
  }
}

extension FeatureValueCopy<$R, $Out> on ObjectCopyWith<$R, Feature, $Out> {
  FeatureCopyWith<$R, Feature, $Out> get $asFeature =>
      $base.as((v, t, t2) => _FeatureCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FeatureCopyWith<$R, $In extends Feature, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CarTypeCopyWith<$R, CarType, CarType>? get type;
  $R call(
      {String? id,
      String? carId,
      int? year,
      int? maxYear,
      int? seat,
      int? hp,
      int? speed,
      int? odometer,
      Transmission? transmission,
      Fuel? fuel,
      CarType? type,
      int? cylinders,
      double? engCC});
  FeatureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FeatureCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Feature, $Out>
    implements FeatureCopyWith<$R, Feature, $Out> {
  _FeatureCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Feature> $mapper =
      FeatureMapper.ensureInitialized();
  @override
  CarTypeCopyWith<$R, CarType, CarType>? get type =>
      $value.type?.copyWith.$chain((v) => call(type: v));
  @override
  $R call(
          {Object? id = $none,
          Object? carId = $none,
          Object? year = $none,
          Object? maxYear = $none,
          Object? seat = $none,
          Object? hp = $none,
          Object? speed = $none,
          Object? odometer = $none,
          Object? transmission = $none,
          Object? fuel = $none,
          Object? type = $none,
          Object? cylinders = $none,
          Object? engCC = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (carId != $none) #carId: carId,
        if (year != $none) #year: year,
        if (maxYear != $none) #maxYear: maxYear,
        if (seat != $none) #seat: seat,
        if (hp != $none) #hp: hp,
        if (speed != $none) #speed: speed,
        if (odometer != $none) #odometer: odometer,
        if (transmission != $none) #transmission: transmission,
        if (fuel != $none) #fuel: fuel,
        if (type != $none) #type: type,
        if (cylinders != $none) #cylinders: cylinders,
        if (engCC != $none) #engCC: engCC
      }));
  @override
  Feature $make(CopyWithData data) => Feature(
      id: data.get(#id, or: $value.id),
      carId: data.get(#carId, or: $value.carId),
      year: data.get(#year, or: $value.year),
      maxYear: data.get(#maxYear, or: $value.maxYear),
      seat: data.get(#seat, or: $value.seat),
      hp: data.get(#hp, or: $value.hp),
      speed: data.get(#speed, or: $value.speed),
      odometer: data.get(#odometer, or: $value.odometer),
      transmission: data.get(#transmission, or: $value.transmission),
      fuel: data.get(#fuel, or: $value.fuel),
      type: data.get(#type, or: $value.type),
      cylinders: data.get(#cylinders, or: $value.cylinders),
      engCC: data.get(#engCC, or: $value.engCC));

  @override
  FeatureCopyWith<$R2, Feature, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FeatureCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
