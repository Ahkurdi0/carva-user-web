// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'sliders.dart';

class SlidersMapper extends ClassMapperBase<Sliders> {
  SlidersMapper._();

  static SlidersMapper? _instance;
  static SlidersMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlidersMapper._());
      SlideTypeMapper.ensureInitialized();
      CompanyMapper.ensureInitialized();
      CarMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Sliders';

  static String? _$id(Sliders v) => v.id;
  static const Field<Sliders, String> _f$id = Field('id', _$id, opt: true);
  static String? _$carId(Sliders v) => v.carId;
  static const Field<Sliders, String> _f$carId =
      Field('carId', _$carId, opt: true);
  static String? _$companyId(Sliders v) => v.companyId;
  static const Field<Sliders, String> _f$companyId =
      Field('companyId', _$companyId, opt: true);
  static String? _$url(Sliders v) => v.url;
  static const Field<Sliders, String> _f$url = Field('url', _$url, opt: true);
  static String? _$image(Sliders v) => v.image;
  static const Field<Sliders, String> _f$image =
      Field('image', _$image, opt: true);
  static int? _$sort(Sliders v) => v.sort;
  static const Field<Sliders, int> _f$sort = Field('sort', _$sort, opt: true);
  static int? _$clicked(Sliders v) => v.clicked;
  static const Field<Sliders, int> _f$clicked =
      Field('clicked', _$clicked, opt: true);
  static SlideType? _$type(Sliders v) => v.type;
  static const Field<Sliders, SlideType> _f$type =
      Field('type', _$type, opt: true);
  static Company? _$company(Sliders v) => v.company;
  static const Field<Sliders, Company> _f$company =
      Field('company', _$company, opt: true);
  static Car? _$car(Sliders v) => v.car;
  static const Field<Sliders, Car> _f$car = Field('car', _$car, opt: true);
  static bool? _$available(Sliders v) => v.available;
  static const Field<Sliders, bool> _f$available =
      Field('available', _$available, opt: true);
  static DateTime? _$createdAt(Sliders v) => v.createdAt;
  static const Field<Sliders, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, opt: true);

  @override
  final MappableFields<Sliders> fields = const {
    #id: _f$id,
    #carId: _f$carId,
    #companyId: _f$companyId,
    #url: _f$url,
    #image: _f$image,
    #sort: _f$sort,
    #clicked: _f$clicked,
    #type: _f$type,
    #company: _f$company,
    #car: _f$car,
    #available: _f$available,
    #createdAt: _f$createdAt,
  };

  static Sliders _instantiate(DecodingData data) {
    return Sliders(
        id: data.dec(_f$id),
        carId: data.dec(_f$carId),
        companyId: data.dec(_f$companyId),
        url: data.dec(_f$url),
        image: data.dec(_f$image),
        sort: data.dec(_f$sort),
        clicked: data.dec(_f$clicked),
        type: data.dec(_f$type),
        company: data.dec(_f$company),
        car: data.dec(_f$car),
        available: data.dec(_f$available),
        createdAt: data.dec(_f$createdAt));
  }

  @override
  final Function instantiate = _instantiate;

  static Sliders fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Sliders>(map);
  }

  static Sliders fromJson(String json) {
    return ensureInitialized().decodeJson<Sliders>(json);
  }
}

mixin SlidersMappable {
  String toJson() {
    return SlidersMapper.ensureInitialized()
        .encodeJson<Sliders>(this as Sliders);
  }

  Map<String, dynamic> toMap() {
    return SlidersMapper.ensureInitialized()
        .encodeMap<Sliders>(this as Sliders);
  }

  SlidersCopyWith<Sliders, Sliders, Sliders> get copyWith =>
      _SlidersCopyWithImpl<Sliders, Sliders>(
          this as Sliders, $identity, $identity);
  @override
  String toString() {
    return SlidersMapper.ensureInitialized().stringifyValue(this as Sliders);
  }

  @override
  bool operator ==(Object other) {
    return SlidersMapper.ensureInitialized()
        .equalsValue(this as Sliders, other);
  }

  @override
  int get hashCode {
    return SlidersMapper.ensureInitialized().hashValue(this as Sliders);
  }
}

extension SlidersValueCopy<$R, $Out> on ObjectCopyWith<$R, Sliders, $Out> {
  SlidersCopyWith<$R, Sliders, $Out> get $asSliders =>
      $base.as((v, t, t2) => _SlidersCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SlidersCopyWith<$R, $In extends Sliders, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CompanyCopyWith<$R, Company, Company>? get company;
  CarCopyWith<$R, Car, Car>? get car;
  $R call(
      {String? id,
      String? carId,
      String? companyId,
      String? url,
      String? image,
      int? sort,
      int? clicked,
      SlideType? type,
      Company? company,
      Car? car,
      bool? available,
      DateTime? createdAt});
  SlidersCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SlidersCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Sliders, $Out>
    implements SlidersCopyWith<$R, Sliders, $Out> {
  _SlidersCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Sliders> $mapper =
      SlidersMapper.ensureInitialized();
  @override
  CompanyCopyWith<$R, Company, Company>? get company =>
      $value.company?.copyWith.$chain((v) => call(company: v));
  @override
  CarCopyWith<$R, Car, Car>? get car =>
      $value.car?.copyWith.$chain((v) => call(car: v));
  @override
  $R call(
          {Object? id = $none,
          Object? carId = $none,
          Object? companyId = $none,
          Object? url = $none,
          Object? image = $none,
          Object? sort = $none,
          Object? clicked = $none,
          Object? type = $none,
          Object? company = $none,
          Object? car = $none,
          Object? available = $none,
          Object? createdAt = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (carId != $none) #carId: carId,
        if (companyId != $none) #companyId: companyId,
        if (url != $none) #url: url,
        if (image != $none) #image: image,
        if (sort != $none) #sort: sort,
        if (clicked != $none) #clicked: clicked,
        if (type != $none) #type: type,
        if (company != $none) #company: company,
        if (car != $none) #car: car,
        if (available != $none) #available: available,
        if (createdAt != $none) #createdAt: createdAt
      }));
  @override
  Sliders $make(CopyWithData data) => Sliders(
      id: data.get(#id, or: $value.id),
      carId: data.get(#carId, or: $value.carId),
      companyId: data.get(#companyId, or: $value.companyId),
      url: data.get(#url, or: $value.url),
      image: data.get(#image, or: $value.image),
      sort: data.get(#sort, or: $value.sort),
      clicked: data.get(#clicked, or: $value.clicked),
      type: data.get(#type, or: $value.type),
      company: data.get(#company, or: $value.company),
      car: data.get(#car, or: $value.car),
      available: data.get(#available, or: $value.available),
      createdAt: data.get(#createdAt, or: $value.createdAt));

  @override
  SlidersCopyWith<$R2, Sliders, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SlidersCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
