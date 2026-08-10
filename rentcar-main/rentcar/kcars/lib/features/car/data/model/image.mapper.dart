// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'image.dart';

class ImagesMapper extends ClassMapperBase<Images> {
  ImagesMapper._();

  static ImagesMapper? _instance;
  static ImagesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImagesMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Images';

  static String? _$id(Images v) => v.id;
  static const Field<Images, String> _f$id = Field('id', _$id, opt: true);
  static String _$image(Images v) => v.image;
  static const Field<Images, String> _f$image = Field('image', _$image);
  static String? _$companyId(Images v) => v.companyId;
  static const Field<Images, String> _f$companyId =
      Field('companyId', _$companyId, opt: true);
  static int? _$sort(Images v) => v.sort;
  static const Field<Images, int> _f$sort = Field('sort', _$sort, opt: true);
  static String? _$carId(Images v) => v.carId;
  static const Field<Images, String> _f$carId =
      Field('carId', _$carId, opt: true);

  @override
  final MappableFields<Images> fields = const {
    #id: _f$id,
    #image: _f$image,
    #companyId: _f$companyId,
    #sort: _f$sort,
    #carId: _f$carId,
  };

  static Images _instantiate(DecodingData data) {
    return Images(
        id: data.dec(_f$id),
        image: data.dec(_f$image),
        companyId: data.dec(_f$companyId),
        sort: data.dec(_f$sort),
        carId: data.dec(_f$carId));
  }

  @override
  final Function instantiate = _instantiate;

  static Images fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Images>(map);
  }

  static Images fromJson(String json) {
    return ensureInitialized().decodeJson<Images>(json);
  }
}

mixin ImagesMappable {
  String toJson() {
    return ImagesMapper.ensureInitialized().encodeJson<Images>(this as Images);
  }

  Map<String, dynamic> toMap() {
    return ImagesMapper.ensureInitialized().encodeMap<Images>(this as Images);
  }

  ImagesCopyWith<Images, Images, Images> get copyWith =>
      _ImagesCopyWithImpl<Images, Images>(this as Images, $identity, $identity);
  @override
  String toString() {
    return ImagesMapper.ensureInitialized().stringifyValue(this as Images);
  }

  @override
  bool operator ==(Object other) {
    return ImagesMapper.ensureInitialized().equalsValue(this as Images, other);
  }

  @override
  int get hashCode {
    return ImagesMapper.ensureInitialized().hashValue(this as Images);
  }
}

extension ImagesValueCopy<$R, $Out> on ObjectCopyWith<$R, Images, $Out> {
  ImagesCopyWith<$R, Images, $Out> get $asImages =>
      $base.as((v, t, t2) => _ImagesCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ImagesCopyWith<$R, $In extends Images, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id, String? image, String? companyId, int? sort, String? carId});
  ImagesCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ImagesCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Images, $Out>
    implements ImagesCopyWith<$R, Images, $Out> {
  _ImagesCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Images> $mapper = ImagesMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          String? image,
          Object? companyId = $none,
          Object? sort = $none,
          Object? carId = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (image != null) #image: image,
        if (companyId != $none) #companyId: companyId,
        if (sort != $none) #sort: sort,
        if (carId != $none) #carId: carId
      }));
  @override
  Images $make(CopyWithData data) => Images(
      id: data.get(#id, or: $value.id),
      image: data.get(#image, or: $value.image),
      companyId: data.get(#companyId, or: $value.companyId),
      sort: data.get(#sort, or: $value.sort),
      carId: data.get(#carId, or: $value.carId));

  @override
  ImagesCopyWith<$R2, Images, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ImagesCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
