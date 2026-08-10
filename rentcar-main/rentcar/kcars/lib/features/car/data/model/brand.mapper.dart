// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'brand.dart';

class BrandMapper extends ClassMapperBase<Brand> {
  BrandMapper._();

  static BrandMapper? _instance;
  static BrandMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BrandMapper._());
      CarMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Brand';

  static String? _$id(Brand v) => v.id;
  static const Field<Brand, String> _f$id = Field('id', _$id, opt: true);
  static String _$en(Brand v) => v.en;
  static const Field<Brand, String> _f$en = Field('en', _$en);
  static String? _$ar(Brand v) => v.ar;
  static const Field<Brand, String> _f$ar = Field('ar', _$ar, opt: true);
  static String? _$ku(Brand v) => v.ku;
  static const Field<Brand, String> _f$ku = Field('ku', _$ku, opt: true);
  static String? _$image(Brand v) => v.image;
  static const Field<Brand, String> _f$image =
      Field('image', _$image, opt: true);
  static int? _$sort(Brand v) => v.sort;
  static const Field<Brand, int> _f$sort = Field('sort', _$sort, opt: true);
  static List<Car>? _$cars(Brand v) => v.cars;
  static const Field<Brand, List<Car>> _f$cars =
      Field('cars', _$cars, opt: true);
  static bool? _$available(Brand v) => v.available;
  static const Field<Brand, bool> _f$available =
      Field('available', _$available, opt: true);

  @override
  final MappableFields<Brand> fields = const {
    #id: _f$id,
    #en: _f$en,
    #ar: _f$ar,
    #ku: _f$ku,
    #image: _f$image,
    #sort: _f$sort,
    #cars: _f$cars,
    #available: _f$available,
  };

  static Brand _instantiate(DecodingData data) {
    return Brand(
        id: data.dec(_f$id),
        en: data.dec(_f$en),
        ar: data.dec(_f$ar),
        ku: data.dec(_f$ku),
        image: data.dec(_f$image),
        sort: data.dec(_f$sort),
        cars: data.dec(_f$cars),
        available: data.dec(_f$available));
  }

  @override
  final Function instantiate = _instantiate;

  static Brand fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Brand>(map);
  }

  static Brand fromJson(String json) {
    return ensureInitialized().decodeJson<Brand>(json);
  }
}

mixin BrandMappable {
  String toJson() {
    return BrandMapper.ensureInitialized().encodeJson<Brand>(this as Brand);
  }

  Map<String, dynamic> toMap() {
    return BrandMapper.ensureInitialized().encodeMap<Brand>(this as Brand);
  }

  BrandCopyWith<Brand, Brand, Brand> get copyWith =>
      _BrandCopyWithImpl<Brand, Brand>(this as Brand, $identity, $identity);
  @override
  String toString() {
    return BrandMapper.ensureInitialized().stringifyValue(this as Brand);
  }

  @override
  bool operator ==(Object other) {
    return BrandMapper.ensureInitialized().equalsValue(this as Brand, other);
  }

  @override
  int get hashCode {
    return BrandMapper.ensureInitialized().hashValue(this as Brand);
  }
}

extension BrandValueCopy<$R, $Out> on ObjectCopyWith<$R, Brand, $Out> {
  BrandCopyWith<$R, Brand, $Out> get $asBrand =>
      $base.as((v, t, t2) => _BrandCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BrandCopyWith<$R, $In extends Brand, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Car, CarCopyWith<$R, Car, Car>>? get cars;
  $R call(
      {String? id,
      String? en,
      String? ar,
      String? ku,
      String? image,
      int? sort,
      List<Car>? cars,
      bool? available});
  BrandCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BrandCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Brand, $Out>
    implements BrandCopyWith<$R, Brand, $Out> {
  _BrandCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Brand> $mapper = BrandMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Car, CarCopyWith<$R, Car, Car>>? get cars => $value.cars !=
          null
      ? ListCopyWith(
          $value.cars!, (v, t) => v.copyWith.$chain(t), (v) => call(cars: v))
      : null;
  @override
  $R call(
          {Object? id = $none,
          String? en,
          Object? ar = $none,
          Object? ku = $none,
          Object? image = $none,
          Object? sort = $none,
          Object? cars = $none,
          Object? available = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (en != null) #en: en,
        if (ar != $none) #ar: ar,
        if (ku != $none) #ku: ku,
        if (image != $none) #image: image,
        if (sort != $none) #sort: sort,
        if (cars != $none) #cars: cars,
        if (available != $none) #available: available
      }));
  @override
  Brand $make(CopyWithData data) => Brand(
      id: data.get(#id, or: $value.id),
      en: data.get(#en, or: $value.en),
      ar: data.get(#ar, or: $value.ar),
      ku: data.get(#ku, or: $value.ku),
      image: data.get(#image, or: $value.image),
      sort: data.get(#sort, or: $value.sort),
      cars: data.get(#cars, or: $value.cars),
      available: data.get(#available, or: $value.available));

  @override
  BrandCopyWith<$R2, Brand, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BrandCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
