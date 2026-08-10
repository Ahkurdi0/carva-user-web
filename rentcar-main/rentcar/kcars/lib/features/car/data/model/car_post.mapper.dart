// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'car_post.dart';

class CarPostMapper extends ClassMapperBase<CarPost> {
  CarPostMapper._();

  static CarPostMapper? _instance;
  static CarPostMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CarPostMapper._());
      CarUpdateMapper.ensureInitialized();
      ImagesMapper.ensureInitialized();
      RentalPlanMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CarPost';

  static CarUpdate _$car(CarPost v) => v.car;
  static const Field<CarPost, CarUpdate> _f$car = Field('car', _$car);
  static List<Images>? _$deletedImages(CarPost v) => v.deletedImages;
  static const Field<CarPost, List<Images>> _f$deletedImages =
      Field('deletedImages', _$deletedImages, opt: true);
  static List<RentalPlan>? _$deletedRentalPlans(CarPost v) =>
      v.deletedRentalPlans;
  static const Field<CarPost, List<RentalPlan>> _f$deletedRentalPlans =
      Field('deletedRentalPlans', _$deletedRentalPlans, opt: true);
  static List<XFile>? _$images(CarPost v) => v.images;
  static const Field<CarPost, List<XFile>> _f$images =
      Field('images', _$images, opt: true);

  @override
  final MappableFields<CarPost> fields = const {
    #car: _f$car,
    #deletedImages: _f$deletedImages,
    #deletedRentalPlans: _f$deletedRentalPlans,
    #images: _f$images,
  };

  static CarPost _instantiate(DecodingData data) {
    return CarPost(
        car: data.dec(_f$car),
        deletedImages: data.dec(_f$deletedImages),
        deletedRentalPlans: data.dec(_f$deletedRentalPlans),
        images: data.dec(_f$images));
  }

  @override
  final Function instantiate = _instantiate;

  static CarPost fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CarPost>(map);
  }

  static CarPost fromJson(String json) {
    return ensureInitialized().decodeJson<CarPost>(json);
  }
}

mixin CarPostMappable {
  String toJson() {
    return CarPostMapper.ensureInitialized()
        .encodeJson<CarPost>(this as CarPost);
  }

  Map<String, dynamic> toMap() {
    return CarPostMapper.ensureInitialized()
        .encodeMap<CarPost>(this as CarPost);
  }

  CarPostCopyWith<CarPost, CarPost, CarPost> get copyWith =>
      _CarPostCopyWithImpl<CarPost, CarPost>(
          this as CarPost, $identity, $identity);
  @override
  String toString() {
    return CarPostMapper.ensureInitialized().stringifyValue(this as CarPost);
  }

  @override
  bool operator ==(Object other) {
    return CarPostMapper.ensureInitialized()
        .equalsValue(this as CarPost, other);
  }

  @override
  int get hashCode {
    return CarPostMapper.ensureInitialized().hashValue(this as CarPost);
  }
}

extension CarPostValueCopy<$R, $Out> on ObjectCopyWith<$R, CarPost, $Out> {
  CarPostCopyWith<$R, CarPost, $Out> get $asCarPost =>
      $base.as((v, t, t2) => _CarPostCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CarPostCopyWith<$R, $In extends CarPost, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CarUpdateCopyWith<$R, CarUpdate, CarUpdate> get car;
  ListCopyWith<$R, Images, ImagesCopyWith<$R, Images, Images>>?
      get deletedImages;
  ListCopyWith<$R, RentalPlan, RentalPlanCopyWith<$R, RentalPlan, RentalPlan>>?
      get deletedRentalPlans;
  ListCopyWith<$R, XFile, ObjectCopyWith<$R, XFile, XFile>>? get images;
  $R call(
      {CarUpdate? car,
      List<Images>? deletedImages,
      List<RentalPlan>? deletedRentalPlans,
      List<XFile>? images});
  CarPostCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CarPostCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CarPost, $Out>
    implements CarPostCopyWith<$R, CarPost, $Out> {
  _CarPostCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CarPost> $mapper =
      CarPostMapper.ensureInitialized();
  @override
  CarUpdateCopyWith<$R, CarUpdate, CarUpdate> get car =>
      $value.car.copyWith.$chain((v) => call(car: v));
  @override
  ListCopyWith<$R, Images, ImagesCopyWith<$R, Images, Images>>?
      get deletedImages => $value.deletedImages != null
          ? ListCopyWith($value.deletedImages!, (v, t) => v.copyWith.$chain(t),
              (v) => call(deletedImages: v))
          : null;
  @override
  ListCopyWith<$R, RentalPlan, RentalPlanCopyWith<$R, RentalPlan, RentalPlan>>?
      get deletedRentalPlans => $value.deletedRentalPlans != null
          ? ListCopyWith(
              $value.deletedRentalPlans!,
              (v, t) => v.copyWith.$chain(t),
              (v) => call(deletedRentalPlans: v))
          : null;
  @override
  ListCopyWith<$R, XFile, ObjectCopyWith<$R, XFile, XFile>>? get images =>
      $value.images != null
          ? ListCopyWith($value.images!,
              (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(images: v))
          : null;
  @override
  $R call(
          {CarUpdate? car,
          Object? deletedImages = $none,
          Object? deletedRentalPlans = $none,
          Object? images = $none}) =>
      $apply(FieldCopyWithData({
        if (car != null) #car: car,
        if (deletedImages != $none) #deletedImages: deletedImages,
        if (deletedRentalPlans != $none)
          #deletedRentalPlans: deletedRentalPlans,
        if (images != $none) #images: images
      }));
  @override
  CarPost $make(CopyWithData data) => CarPost(
      car: data.get(#car, or: $value.car),
      deletedImages: data.get(#deletedImages, or: $value.deletedImages),
      deletedRentalPlans:
          data.get(#deletedRentalPlans, or: $value.deletedRentalPlans),
      images: data.get(#images, or: $value.images));

  @override
  CarPostCopyWith<$R2, CarPost, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CarPostCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
