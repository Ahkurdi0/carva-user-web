// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'update_company.dart';

class UpdateCompanyMapper extends ClassMapperBase<UpdateCompany> {
  UpdateCompanyMapper._();

  static UpdateCompanyMapper? _instance;
  static UpdateCompanyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UpdateCompanyMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UpdateCompany';

  static String? _$image(UpdateCompany v) => v.image;
  static const Field<UpdateCompany, String> _f$image =
      Field('image', _$image, opt: true);
  static String? _$coverImage(UpdateCompany v) => v.coverImage;
  static const Field<UpdateCompany, String> _f$coverImage =
      Field('coverImage', _$coverImage, opt: true);

  @override
  final MappableFields<UpdateCompany> fields = const {
    #image: _f$image,
    #coverImage: _f$coverImage,
  };

  static UpdateCompany _instantiate(DecodingData data) {
    return UpdateCompany(
        image: data.dec(_f$image), coverImage: data.dec(_f$coverImage));
  }

  @override
  final Function instantiate = _instantiate;

  static UpdateCompany fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UpdateCompany>(map);
  }

  static UpdateCompany fromJson(String json) {
    return ensureInitialized().decodeJson<UpdateCompany>(json);
  }
}

mixin UpdateCompanyMappable {
  String toJson() {
    return UpdateCompanyMapper.ensureInitialized()
        .encodeJson<UpdateCompany>(this as UpdateCompany);
  }

  Map<String, dynamic> toMap() {
    return UpdateCompanyMapper.ensureInitialized()
        .encodeMap<UpdateCompany>(this as UpdateCompany);
  }

  UpdateCompanyCopyWith<UpdateCompany, UpdateCompany, UpdateCompany>
      get copyWith => _UpdateCompanyCopyWithImpl<UpdateCompany, UpdateCompany>(
          this as UpdateCompany, $identity, $identity);
  @override
  String toString() {
    return UpdateCompanyMapper.ensureInitialized()
        .stringifyValue(this as UpdateCompany);
  }

  @override
  bool operator ==(Object other) {
    return UpdateCompanyMapper.ensureInitialized()
        .equalsValue(this as UpdateCompany, other);
  }

  @override
  int get hashCode {
    return UpdateCompanyMapper.ensureInitialized()
        .hashValue(this as UpdateCompany);
  }
}

extension UpdateCompanyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UpdateCompany, $Out> {
  UpdateCompanyCopyWith<$R, UpdateCompany, $Out> get $asUpdateCompany =>
      $base.as((v, t, t2) => _UpdateCompanyCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UpdateCompanyCopyWith<$R, $In extends UpdateCompany, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? image, String? coverImage});
  UpdateCompanyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UpdateCompanyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UpdateCompany, $Out>
    implements UpdateCompanyCopyWith<$R, UpdateCompany, $Out> {
  _UpdateCompanyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UpdateCompany> $mapper =
      UpdateCompanyMapper.ensureInitialized();
  @override
  $R call({Object? image = $none, Object? coverImage = $none}) =>
      $apply(FieldCopyWithData({
        if (image != $none) #image: image,
        if (coverImage != $none) #coverImage: coverImage
      }));
  @override
  UpdateCompany $make(CopyWithData data) => UpdateCompany(
      image: data.get(#image, or: $value.image),
      coverImage: data.get(#coverImage, or: $value.coverImage));

  @override
  UpdateCompanyCopyWith<$R2, UpdateCompany, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UpdateCompanyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
