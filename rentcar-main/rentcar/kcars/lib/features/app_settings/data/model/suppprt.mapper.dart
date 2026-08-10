// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'suppprt.dart';

class SupportMapper extends ClassMapperBase<Support> {
  SupportMapper._();

  static SupportMapper? _instance;
  static SupportMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SupportMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Support';

  static String? _$id(Support v) => v.id;
  static const Field<Support, String> _f$id = Field('id', _$id, opt: true);
  static String _$en(Support v) => v.en;
  static const Field<Support, String> _f$en = Field('en', _$en);
  static String _$ku(Support v) => v.ku;
  static const Field<Support, String> _f$ku = Field('ku', _$ku);
  static String _$ar(Support v) => v.ar;
  static const Field<Support, String> _f$ar = Field('ar', _$ar);
  static String _$content(Support v) => v.content;
  static const Field<Support, String> _f$content = Field('content', _$content);
  static String? _$image(Support v) => v.image;
  static const Field<Support, String> _f$image =
      Field('image', _$image, opt: true);
  static int? _$sort(Support v) => v.sort;
  static const Field<Support, int> _f$sort = Field('sort', _$sort, opt: true);
  static bool? _$available(Support v) => v.available;
  static const Field<Support, bool> _f$available =
      Field('available', _$available, opt: true);
  static DateTime? _$postedAt(Support v) => v.postedAt;
  static const Field<Support, DateTime> _f$postedAt =
      Field('postedAt', _$postedAt, opt: true);

  @override
  final MappableFields<Support> fields = const {
    #id: _f$id,
    #en: _f$en,
    #ku: _f$ku,
    #ar: _f$ar,
    #content: _f$content,
    #image: _f$image,
    #sort: _f$sort,
    #available: _f$available,
    #postedAt: _f$postedAt,
  };

  static Support _instantiate(DecodingData data) {
    return Support(
        id: data.dec(_f$id),
        en: data.dec(_f$en),
        ku: data.dec(_f$ku),
        ar: data.dec(_f$ar),
        content: data.dec(_f$content),
        image: data.dec(_f$image),
        sort: data.dec(_f$sort),
        available: data.dec(_f$available),
        postedAt: data.dec(_f$postedAt));
  }

  @override
  final Function instantiate = _instantiate;

  static Support fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Support>(map);
  }

  static Support fromJson(String json) {
    return ensureInitialized().decodeJson<Support>(json);
  }
}

mixin SupportMappable {
  String toJson() {
    return SupportMapper.ensureInitialized()
        .encodeJson<Support>(this as Support);
  }

  Map<String, dynamic> toMap() {
    return SupportMapper.ensureInitialized()
        .encodeMap<Support>(this as Support);
  }

  SupportCopyWith<Support, Support, Support> get copyWith =>
      _SupportCopyWithImpl<Support, Support>(
          this as Support, $identity, $identity);
  @override
  String toString() {
    return SupportMapper.ensureInitialized().stringifyValue(this as Support);
  }

  @override
  bool operator ==(Object other) {
    return SupportMapper.ensureInitialized()
        .equalsValue(this as Support, other);
  }

  @override
  int get hashCode {
    return SupportMapper.ensureInitialized().hashValue(this as Support);
  }
}

extension SupportValueCopy<$R, $Out> on ObjectCopyWith<$R, Support, $Out> {
  SupportCopyWith<$R, Support, $Out> get $asSupport =>
      $base.as((v, t, t2) => _SupportCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SupportCopyWith<$R, $In extends Support, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? en,
      String? ku,
      String? ar,
      String? content,
      String? image,
      int? sort,
      bool? available,
      DateTime? postedAt});
  SupportCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SupportCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Support, $Out>
    implements SupportCopyWith<$R, Support, $Out> {
  _SupportCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Support> $mapper =
      SupportMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          String? en,
          String? ku,
          String? ar,
          String? content,
          Object? image = $none,
          Object? sort = $none,
          Object? available = $none,
          Object? postedAt = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (en != null) #en: en,
        if (ku != null) #ku: ku,
        if (ar != null) #ar: ar,
        if (content != null) #content: content,
        if (image != $none) #image: image,
        if (sort != $none) #sort: sort,
        if (available != $none) #available: available,
        if (postedAt != $none) #postedAt: postedAt
      }));
  @override
  Support $make(CopyWithData data) => Support(
      id: data.get(#id, or: $value.id),
      en: data.get(#en, or: $value.en),
      ku: data.get(#ku, or: $value.ku),
      ar: data.get(#ar, or: $value.ar),
      content: data.get(#content, or: $value.content),
      image: data.get(#image, or: $value.image),
      sort: data.get(#sort, or: $value.sort),
      available: data.get(#available, or: $value.available),
      postedAt: data.get(#postedAt, or: $value.postedAt));

  @override
  SupportCopyWith<$R2, Support, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SupportCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
