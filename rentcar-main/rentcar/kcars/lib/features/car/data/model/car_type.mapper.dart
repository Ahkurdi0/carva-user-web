// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'car_type.dart';

class CarTypeMapper extends ClassMapperBase<CarType> {
  CarTypeMapper._();

  static CarTypeMapper? _instance;
  static CarTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CarTypeMapper._());
      CarMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CarType';

  static String? _$id(CarType v) => v.id;
  static const Field<CarType, String> _f$id = Field('id', _$id, opt: true);
  static String _$en(CarType v) => v.en;
  static const Field<CarType, String> _f$en = Field('en', _$en);
  static String? _$ar(CarType v) => v.ar;
  static const Field<CarType, String> _f$ar = Field('ar', _$ar, opt: true);
  static String? _$ku(CarType v) => v.ku;
  static const Field<CarType, String> _f$ku = Field('ku', _$ku, opt: true);
  static int? _$sort(CarType v) => v.sort;
  static const Field<CarType, int> _f$sort = Field('sort', _$sort, opt: true);
  static List<Car>? _$car(CarType v) => v.car;
  static const Field<CarType, List<Car>> _f$car =
      Field('car', _$car, opt: true);
  static bool? _$available(CarType v) => v.available;
  static const Field<CarType, bool> _f$available =
      Field('available', _$available, opt: true);

  @override
  final MappableFields<CarType> fields = const {
    #id: _f$id,
    #en: _f$en,
    #ar: _f$ar,
    #ku: _f$ku,
    #sort: _f$sort,
    #car: _f$car,
    #available: _f$available,
  };

  static CarType _instantiate(DecodingData data) {
    return CarType(
        id: data.dec(_f$id),
        en: data.dec(_f$en),
        ar: data.dec(_f$ar),
        ku: data.dec(_f$ku),
        sort: data.dec(_f$sort),
        car: data.dec(_f$car),
        available: data.dec(_f$available));
  }

  @override
  final Function instantiate = _instantiate;

  static CarType fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CarType>(map);
  }

  static CarType fromJson(String json) {
    return ensureInitialized().decodeJson<CarType>(json);
  }
}

mixin CarTypeMappable {
  String toJson() {
    return CarTypeMapper.ensureInitialized()
        .encodeJson<CarType>(this as CarType);
  }

  Map<String, dynamic> toMap() {
    return CarTypeMapper.ensureInitialized()
        .encodeMap<CarType>(this as CarType);
  }

  CarTypeCopyWith<CarType, CarType, CarType> get copyWith =>
      _CarTypeCopyWithImpl<CarType, CarType>(
          this as CarType, $identity, $identity);
  @override
  String toString() {
    return CarTypeMapper.ensureInitialized().stringifyValue(this as CarType);
  }

  @override
  bool operator ==(Object other) {
    return CarTypeMapper.ensureInitialized()
        .equalsValue(this as CarType, other);
  }

  @override
  int get hashCode {
    return CarTypeMapper.ensureInitialized().hashValue(this as CarType);
  }
}

extension CarTypeValueCopy<$R, $Out> on ObjectCopyWith<$R, CarType, $Out> {
  CarTypeCopyWith<$R, CarType, $Out> get $asCarType =>
      $base.as((v, t, t2) => _CarTypeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CarTypeCopyWith<$R, $In extends CarType, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Car, CarCopyWith<$R, Car, Car>>? get car;
  $R call(
      {String? id,
      String? en,
      String? ar,
      String? ku,
      int? sort,
      List<Car>? car,
      bool? available});
  CarTypeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CarTypeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CarType, $Out>
    implements CarTypeCopyWith<$R, CarType, $Out> {
  _CarTypeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CarType> $mapper =
      CarTypeMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Car, CarCopyWith<$R, Car, Car>>? get car =>
      $value.car != null
          ? ListCopyWith(
              $value.car!, (v, t) => v.copyWith.$chain(t), (v) => call(car: v))
          : null;
  @override
  $R call(
          {Object? id = $none,
          String? en,
          Object? ar = $none,
          Object? ku = $none,
          Object? sort = $none,
          Object? car = $none,
          Object? available = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (en != null) #en: en,
        if (ar != $none) #ar: ar,
        if (ku != $none) #ku: ku,
        if (sort != $none) #sort: sort,
        if (car != $none) #car: car,
        if (available != $none) #available: available
      }));
  @override
  CarType $make(CopyWithData data) => CarType(
      id: data.get(#id, or: $value.id),
      en: data.get(#en, or: $value.en),
      ar: data.get(#ar, or: $value.ar),
      ku: data.get(#ku, or: $value.ku),
      sort: data.get(#sort, or: $value.sort),
      car: data.get(#car, or: $value.car),
      available: data.get(#available, or: $value.available));

  @override
  CarTypeCopyWith<$R2, CarType, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CarTypeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
