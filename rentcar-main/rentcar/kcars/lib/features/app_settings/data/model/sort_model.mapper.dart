// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'sort_model.dart';

class SortModelMapper extends ClassMapperBase<SortModel> {
  SortModelMapper._();

  static SortModelMapper? _instance;
  static SortModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SortModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SortModel';

  static String _$id(SortModel v) => v.id;
  static const Field<SortModel, String> _f$id = Field('id', _$id);
  static int _$sort(SortModel v) => v.sort;
  static const Field<SortModel, int> _f$sort = Field('sort', _$sort);

  @override
  final MappableFields<SortModel> fields = const {
    #id: _f$id,
    #sort: _f$sort,
  };

  static SortModel _instantiate(DecodingData data) {
    return SortModel(id: data.dec(_f$id), sort: data.dec(_f$sort));
  }

  @override
  final Function instantiate = _instantiate;

  static SortModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SortModel>(map);
  }

  static SortModel fromJson(String json) {
    return ensureInitialized().decodeJson<SortModel>(json);
  }
}

mixin SortModelMappable {
  String toJson() {
    return SortModelMapper.ensureInitialized()
        .encodeJson<SortModel>(this as SortModel);
  }

  Map<String, dynamic> toMap() {
    return SortModelMapper.ensureInitialized()
        .encodeMap<SortModel>(this as SortModel);
  }

  SortModelCopyWith<SortModel, SortModel, SortModel> get copyWith =>
      _SortModelCopyWithImpl<SortModel, SortModel>(
          this as SortModel, $identity, $identity);
  @override
  String toString() {
    return SortModelMapper.ensureInitialized()
        .stringifyValue(this as SortModel);
  }

  @override
  bool operator ==(Object other) {
    return SortModelMapper.ensureInitialized()
        .equalsValue(this as SortModel, other);
  }

  @override
  int get hashCode {
    return SortModelMapper.ensureInitialized().hashValue(this as SortModel);
  }
}

extension SortModelValueCopy<$R, $Out> on ObjectCopyWith<$R, SortModel, $Out> {
  SortModelCopyWith<$R, SortModel, $Out> get $asSortModel =>
      $base.as((v, t, t2) => _SortModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SortModelCopyWith<$R, $In extends SortModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, int? sort});
  SortModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SortModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SortModel, $Out>
    implements SortModelCopyWith<$R, SortModel, $Out> {
  _SortModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SortModel> $mapper =
      SortModelMapper.ensureInitialized();
  @override
  $R call({String? id, int? sort}) => $apply(FieldCopyWithData(
      {if (id != null) #id: id, if (sort != null) #sort: sort}));
  @override
  SortModel $make(CopyWithData data) => SortModel(
      id: data.get(#id, or: $value.id), sort: data.get(#sort, or: $value.sort));

  @override
  SortModelCopyWith<$R2, SortModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SortModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
