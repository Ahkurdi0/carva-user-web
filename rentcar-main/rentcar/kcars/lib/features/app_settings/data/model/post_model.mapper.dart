// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'post_model.dart';

class PostModelMapper extends ClassMapperBase<PostModel> {
  PostModelMapper._();

  static PostModelMapper? _instance;
  static PostModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PostModelMapper._());
      BrandMapper.ensureInitialized();
      SupportMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PostModel';

  static Brand? _$brand(PostModel v) => v.brand;
  static const Field<PostModel, Brand> _f$brand =
      Field('brand', _$brand, opt: true);
  static Support? _$suppprt(PostModel v) => v.suppprt;
  static const Field<PostModel, Support> _f$suppprt =
      Field('suppprt', _$suppprt, opt: true);
  static File? _$image(PostModel v) => v.image;
  static const Field<PostModel, File> _f$image =
      Field('image', _$image, opt: true);

  @override
  final MappableFields<PostModel> fields = const {
    #brand: _f$brand,
    #suppprt: _f$suppprt,
    #image: _f$image,
  };

  static PostModel _instantiate(DecodingData data) {
    return PostModel(
        brand: data.dec(_f$brand),
        suppprt: data.dec(_f$suppprt),
        image: data.dec(_f$image));
  }

  @override
  final Function instantiate = _instantiate;

  static PostModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PostModel>(map);
  }

  static PostModel fromJson(String json) {
    return ensureInitialized().decodeJson<PostModel>(json);
  }
}

mixin PostModelMappable {
  String toJson() {
    return PostModelMapper.ensureInitialized()
        .encodeJson<PostModel>(this as PostModel);
  }

  Map<String, dynamic> toMap() {
    return PostModelMapper.ensureInitialized()
        .encodeMap<PostModel>(this as PostModel);
  }

  PostModelCopyWith<PostModel, PostModel, PostModel> get copyWith =>
      _PostModelCopyWithImpl<PostModel, PostModel>(
          this as PostModel, $identity, $identity);
  @override
  String toString() {
    return PostModelMapper.ensureInitialized()
        .stringifyValue(this as PostModel);
  }

  @override
  bool operator ==(Object other) {
    return PostModelMapper.ensureInitialized()
        .equalsValue(this as PostModel, other);
  }

  @override
  int get hashCode {
    return PostModelMapper.ensureInitialized().hashValue(this as PostModel);
  }
}

extension PostModelValueCopy<$R, $Out> on ObjectCopyWith<$R, PostModel, $Out> {
  PostModelCopyWith<$R, PostModel, $Out> get $asPostModel =>
      $base.as((v, t, t2) => _PostModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PostModelCopyWith<$R, $In extends PostModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  BrandCopyWith<$R, Brand, Brand>? get brand;
  SupportCopyWith<$R, Support, Support>? get suppprt;
  $R call({Brand? brand, Support? suppprt, File? image});
  PostModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PostModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PostModel, $Out>
    implements PostModelCopyWith<$R, PostModel, $Out> {
  _PostModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PostModel> $mapper =
      PostModelMapper.ensureInitialized();
  @override
  BrandCopyWith<$R, Brand, Brand>? get brand =>
      $value.brand?.copyWith.$chain((v) => call(brand: v));
  @override
  SupportCopyWith<$R, Support, Support>? get suppprt =>
      $value.suppprt?.copyWith.$chain((v) => call(suppprt: v));
  @override
  $R call(
          {Object? brand = $none,
          Object? suppprt = $none,
          Object? image = $none}) =>
      $apply(FieldCopyWithData({
        if (brand != $none) #brand: brand,
        if (suppprt != $none) #suppprt: suppprt,
        if (image != $none) #image: image
      }));
  @override
  PostModel $make(CopyWithData data) => PostModel(
      brand: data.get(#brand, or: $value.brand),
      suppprt: data.get(#suppprt, or: $value.suppprt),
      image: data.get(#image, or: $value.image));

  @override
  PostModelCopyWith<$R2, PostModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PostModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
