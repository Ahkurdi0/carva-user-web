// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'company_statistic.dart';

class CompanyStatisticMapper extends ClassMapperBase<CompanyStatistic> {
  CompanyStatisticMapper._();

  static CompanyStatisticMapper? _instance;
  static CompanyStatisticMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CompanyStatisticMapper._());
      CompanyMapper.ensureInitialized();
      ContactedTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CompanyStatistic';

  static Company? _$company(CompanyStatistic v) => v.company;
  static const Field<CompanyStatistic, Company> _f$company =
      Field('company', _$company, opt: true);
  static List<ContactedType>? _$types(CompanyStatistic v) => v.types;
  static const Field<CompanyStatistic, List<ContactedType>> _f$types =
      Field('types', _$types, opt: true);

  @override
  final MappableFields<CompanyStatistic> fields = const {
    #company: _f$company,
    #types: _f$types,
  };

  static CompanyStatistic _instantiate(DecodingData data) {
    return CompanyStatistic(
        company: data.dec(_f$company), types: data.dec(_f$types));
  }

  @override
  final Function instantiate = _instantiate;

  static CompanyStatistic fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CompanyStatistic>(map);
  }

  static CompanyStatistic fromJson(String json) {
    return ensureInitialized().decodeJson<CompanyStatistic>(json);
  }
}

mixin CompanyStatisticMappable {
  String toJson() {
    return CompanyStatisticMapper.ensureInitialized()
        .encodeJson<CompanyStatistic>(this as CompanyStatistic);
  }

  Map<String, dynamic> toMap() {
    return CompanyStatisticMapper.ensureInitialized()
        .encodeMap<CompanyStatistic>(this as CompanyStatistic);
  }

  CompanyStatisticCopyWith<CompanyStatistic, CompanyStatistic, CompanyStatistic>
      get copyWith =>
          _CompanyStatisticCopyWithImpl<CompanyStatistic, CompanyStatistic>(
              this as CompanyStatistic, $identity, $identity);
  @override
  String toString() {
    return CompanyStatisticMapper.ensureInitialized()
        .stringifyValue(this as CompanyStatistic);
  }

  @override
  bool operator ==(Object other) {
    return CompanyStatisticMapper.ensureInitialized()
        .equalsValue(this as CompanyStatistic, other);
  }

  @override
  int get hashCode {
    return CompanyStatisticMapper.ensureInitialized()
        .hashValue(this as CompanyStatistic);
  }
}

extension CompanyStatisticValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CompanyStatistic, $Out> {
  CompanyStatisticCopyWith<$R, CompanyStatistic, $Out>
      get $asCompanyStatistic => $base
          .as((v, t, t2) => _CompanyStatisticCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CompanyStatisticCopyWith<$R, $In extends CompanyStatistic, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CompanyCopyWith<$R, Company, Company>? get company;
  ListCopyWith<$R, ContactedType,
      ContactedTypeCopyWith<$R, ContactedType, ContactedType>>? get types;
  $R call({Company? company, List<ContactedType>? types});
  CompanyStatisticCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CompanyStatisticCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CompanyStatistic, $Out>
    implements CompanyStatisticCopyWith<$R, CompanyStatistic, $Out> {
  _CompanyStatisticCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CompanyStatistic> $mapper =
      CompanyStatisticMapper.ensureInitialized();
  @override
  CompanyCopyWith<$R, Company, Company>? get company =>
      $value.company?.copyWith.$chain((v) => call(company: v));
  @override
  ListCopyWith<$R, ContactedType,
          ContactedTypeCopyWith<$R, ContactedType, ContactedType>>?
      get types => $value.types != null
          ? ListCopyWith($value.types!, (v, t) => v.copyWith.$chain(t),
              (v) => call(types: v))
          : null;
  @override
  $R call({Object? company = $none, Object? types = $none}) =>
      $apply(FieldCopyWithData({
        if (company != $none) #company: company,
        if (types != $none) #types: types
      }));
  @override
  CompanyStatistic $make(CopyWithData data) => CompanyStatistic(
      company: data.get(#company, or: $value.company),
      types: data.get(#types, or: $value.types));

  @override
  CompanyStatisticCopyWith<$R2, CompanyStatistic, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CompanyStatisticCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ContactedTypeMapper extends ClassMapperBase<ContactedType> {
  ContactedTypeMapper._();

  static ContactedTypeMapper? _instance;
  static ContactedTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContactedTypeMapper._());
      ContactTypesMapper.ensureInitialized();
      ContactTypesDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ContactedType';

  static ContactTypes _$type(ContactedType v) => v.type;
  static const Field<ContactedType, ContactTypes> _f$type =
      Field('type', _$type);
  static List<ContactTypesData> _$data(ContactedType v) => v.data;
  static const Field<ContactedType, List<ContactTypesData>> _f$data =
      Field('data', _$data);
  static int? _$total(ContactedType v) => v.total;
  static const Field<ContactedType, int> _f$total =
      Field('total', _$total, opt: true);

  @override
  final MappableFields<ContactedType> fields = const {
    #type: _f$type,
    #data: _f$data,
    #total: _f$total,
  };

  static ContactedType _instantiate(DecodingData data) {
    return ContactedType(
        type: data.dec(_f$type),
        data: data.dec(_f$data),
        total: data.dec(_f$total));
  }

  @override
  final Function instantiate = _instantiate;

  static ContactedType fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ContactedType>(map);
  }

  static ContactedType fromJson(String json) {
    return ensureInitialized().decodeJson<ContactedType>(json);
  }
}

mixin ContactedTypeMappable {
  String toJson() {
    return ContactedTypeMapper.ensureInitialized()
        .encodeJson<ContactedType>(this as ContactedType);
  }

  Map<String, dynamic> toMap() {
    return ContactedTypeMapper.ensureInitialized()
        .encodeMap<ContactedType>(this as ContactedType);
  }

  ContactedTypeCopyWith<ContactedType, ContactedType, ContactedType>
      get copyWith => _ContactedTypeCopyWithImpl<ContactedType, ContactedType>(
          this as ContactedType, $identity, $identity);
  @override
  String toString() {
    return ContactedTypeMapper.ensureInitialized()
        .stringifyValue(this as ContactedType);
  }

  @override
  bool operator ==(Object other) {
    return ContactedTypeMapper.ensureInitialized()
        .equalsValue(this as ContactedType, other);
  }

  @override
  int get hashCode {
    return ContactedTypeMapper.ensureInitialized()
        .hashValue(this as ContactedType);
  }
}

extension ContactedTypeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ContactedType, $Out> {
  ContactedTypeCopyWith<$R, ContactedType, $Out> get $asContactedType =>
      $base.as((v, t, t2) => _ContactedTypeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ContactedTypeCopyWith<$R, $In extends ContactedType, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, ContactTypesData,
          ContactTypesDataCopyWith<$R, ContactTypesData, ContactTypesData>>
      get data;
  $R call({ContactTypes? type, List<ContactTypesData>? data, int? total});
  ContactedTypeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ContactedTypeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ContactedType, $Out>
    implements ContactedTypeCopyWith<$R, ContactedType, $Out> {
  _ContactedTypeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ContactedType> $mapper =
      ContactedTypeMapper.ensureInitialized();
  @override
  ListCopyWith<$R, ContactTypesData,
          ContactTypesDataCopyWith<$R, ContactTypesData, ContactTypesData>>
      get data => ListCopyWith(
          $value.data, (v, t) => v.copyWith.$chain(t), (v) => call(data: v));
  @override
  $R call(
          {ContactTypes? type,
          List<ContactTypesData>? data,
          Object? total = $none}) =>
      $apply(FieldCopyWithData({
        if (type != null) #type: type,
        if (data != null) #data: data,
        if (total != $none) #total: total
      }));
  @override
  ContactedType $make(CopyWithData data) => ContactedType(
      type: data.get(#type, or: $value.type),
      data: data.get(#data, or: $value.data),
      total: data.get(#total, or: $value.total));

  @override
  ContactedTypeCopyWith<$R2, ContactedType, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ContactedTypeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ContactTypesDataMapper extends ClassMapperBase<ContactTypesData> {
  ContactTypesDataMapper._();

  static ContactTypesDataMapper? _instance;
  static ContactTypesDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContactTypesDataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ContactTypesData';

  static int? _$month(ContactTypesData v) => v.month;
  static const Field<ContactTypesData, int> _f$month =
      Field('month', _$month, opt: true);
  static int? _$year(ContactTypesData v) => v.year;
  static const Field<ContactTypesData, int> _f$year =
      Field('year', _$year, opt: true);
  static int? _$count(ContactTypesData v) => v.count;
  static const Field<ContactTypesData, int> _f$count =
      Field('count', _$count, opt: true);

  @override
  final MappableFields<ContactTypesData> fields = const {
    #month: _f$month,
    #year: _f$year,
    #count: _f$count,
  };

  static ContactTypesData _instantiate(DecodingData data) {
    return ContactTypesData(
        month: data.dec(_f$month),
        year: data.dec(_f$year),
        count: data.dec(_f$count));
  }

  @override
  final Function instantiate = _instantiate;

  static ContactTypesData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ContactTypesData>(map);
  }

  static ContactTypesData fromJson(String json) {
    return ensureInitialized().decodeJson<ContactTypesData>(json);
  }
}

mixin ContactTypesDataMappable {
  String toJson() {
    return ContactTypesDataMapper.ensureInitialized()
        .encodeJson<ContactTypesData>(this as ContactTypesData);
  }

  Map<String, dynamic> toMap() {
    return ContactTypesDataMapper.ensureInitialized()
        .encodeMap<ContactTypesData>(this as ContactTypesData);
  }

  ContactTypesDataCopyWith<ContactTypesData, ContactTypesData, ContactTypesData>
      get copyWith =>
          _ContactTypesDataCopyWithImpl<ContactTypesData, ContactTypesData>(
              this as ContactTypesData, $identity, $identity);
  @override
  String toString() {
    return ContactTypesDataMapper.ensureInitialized()
        .stringifyValue(this as ContactTypesData);
  }

  @override
  bool operator ==(Object other) {
    return ContactTypesDataMapper.ensureInitialized()
        .equalsValue(this as ContactTypesData, other);
  }

  @override
  int get hashCode {
    return ContactTypesDataMapper.ensureInitialized()
        .hashValue(this as ContactTypesData);
  }
}

extension ContactTypesDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ContactTypesData, $Out> {
  ContactTypesDataCopyWith<$R, ContactTypesData, $Out>
      get $asContactTypesData => $base
          .as((v, t, t2) => _ContactTypesDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ContactTypesDataCopyWith<$R, $In extends ContactTypesData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? month, int? year, int? count});
  ContactTypesDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ContactTypesDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ContactTypesData, $Out>
    implements ContactTypesDataCopyWith<$R, ContactTypesData, $Out> {
  _ContactTypesDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ContactTypesData> $mapper =
      ContactTypesDataMapper.ensureInitialized();
  @override
  $R call(
          {Object? month = $none,
          Object? year = $none,
          Object? count = $none}) =>
      $apply(FieldCopyWithData({
        if (month != $none) #month: month,
        if (year != $none) #year: year,
        if (count != $none) #count: count
      }));
  @override
  ContactTypesData $make(CopyWithData data) => ContactTypesData(
      month: data.get(#month, or: $value.month),
      year: data.get(#year, or: $value.year),
      count: data.get(#count, or: $value.count));

  @override
  ContactTypesDataCopyWith<$R2, ContactTypesData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ContactTypesDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
