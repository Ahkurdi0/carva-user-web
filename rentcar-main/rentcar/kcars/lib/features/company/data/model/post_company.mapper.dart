// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'post_company.dart';

class PostCompanyMapper extends ClassMapperBase<PostCompany> {
  PostCompanyMapper._();

  static PostCompanyMapper? _instance;
  static PostCompanyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PostCompanyMapper._());
      CompanyMapper.ensureInitialized();
      ContactMapper.ensureInitialized();
      LocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PostCompany';

  static File? _$image(PostCompany v) => v.image;
  static const Field<PostCompany, File> _f$image =
      Field('image', _$image, opt: true);
  static File? _$coverImage(PostCompany v) => v.coverImage;
  static const Field<PostCompany, File> _f$coverImage =
      Field('coverImage', _$coverImage, opt: true);
  static Company? _$company(PostCompany v) => v.company;
  static const Field<PostCompany, Company> _f$company =
      Field('company', _$company, opt: true);
  static List<Contact>? _$newContacts(PostCompany v) => v.newContacts;
  static const Field<PostCompany, List<Contact>> _f$newContacts =
      Field('newContacts', _$newContacts, opt: true);
  static List<Contact>? _$deletedContacts(PostCompany v) => v.deletedContacts;
  static const Field<PostCompany, List<Contact>> _f$deletedContacts =
      Field('deletedContacts', _$deletedContacts, opt: true);
  static Location? _$location(PostCompany v) => v.location;
  static const Field<PostCompany, Location> _f$location =
      Field('location', _$location, opt: true);

  @override
  final MappableFields<PostCompany> fields = const {
    #image: _f$image,
    #coverImage: _f$coverImage,
    #company: _f$company,
    #newContacts: _f$newContacts,
    #deletedContacts: _f$deletedContacts,
    #location: _f$location,
  };

  static PostCompany _instantiate(DecodingData data) {
    return PostCompany(
        image: data.dec(_f$image),
        coverImage: data.dec(_f$coverImage),
        company: data.dec(_f$company),
        newContacts: data.dec(_f$newContacts),
        deletedContacts: data.dec(_f$deletedContacts),
        location: data.dec(_f$location));
  }

  @override
  final Function instantiate = _instantiate;

  static PostCompany fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PostCompany>(map);
  }

  static PostCompany fromJson(String json) {
    return ensureInitialized().decodeJson<PostCompany>(json);
  }
}

mixin PostCompanyMappable {
  String toJson() {
    return PostCompanyMapper.ensureInitialized()
        .encodeJson<PostCompany>(this as PostCompany);
  }

  Map<String, dynamic> toMap() {
    return PostCompanyMapper.ensureInitialized()
        .encodeMap<PostCompany>(this as PostCompany);
  }

  PostCompanyCopyWith<PostCompany, PostCompany, PostCompany> get copyWith =>
      _PostCompanyCopyWithImpl<PostCompany, PostCompany>(
          this as PostCompany, $identity, $identity);
  @override
  String toString() {
    return PostCompanyMapper.ensureInitialized()
        .stringifyValue(this as PostCompany);
  }

  @override
  bool operator ==(Object other) {
    return PostCompanyMapper.ensureInitialized()
        .equalsValue(this as PostCompany, other);
  }

  @override
  int get hashCode {
    return PostCompanyMapper.ensureInitialized().hashValue(this as PostCompany);
  }
}

extension PostCompanyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PostCompany, $Out> {
  PostCompanyCopyWith<$R, PostCompany, $Out> get $asPostCompany =>
      $base.as((v, t, t2) => _PostCompanyCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PostCompanyCopyWith<$R, $In extends PostCompany, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CompanyCopyWith<$R, Company, Company>? get company;
  ListCopyWith<$R, Contact, ContactCopyWith<$R, Contact, Contact>>?
      get newContacts;
  ListCopyWith<$R, Contact, ContactCopyWith<$R, Contact, Contact>>?
      get deletedContacts;
  LocationCopyWith<$R, Location, Location>? get location;
  $R call(
      {File? image,
      File? coverImage,
      Company? company,
      List<Contact>? newContacts,
      List<Contact>? deletedContacts,
      Location? location});
  PostCompanyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PostCompanyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PostCompany, $Out>
    implements PostCompanyCopyWith<$R, PostCompany, $Out> {
  _PostCompanyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PostCompany> $mapper =
      PostCompanyMapper.ensureInitialized();
  @override
  CompanyCopyWith<$R, Company, Company>? get company =>
      $value.company?.copyWith.$chain((v) => call(company: v));
  @override
  ListCopyWith<$R, Contact, ContactCopyWith<$R, Contact, Contact>>?
      get newContacts => $value.newContacts != null
          ? ListCopyWith($value.newContacts!, (v, t) => v.copyWith.$chain(t),
              (v) => call(newContacts: v))
          : null;
  @override
  ListCopyWith<$R, Contact, ContactCopyWith<$R, Contact, Contact>>?
      get deletedContacts => $value.deletedContacts != null
          ? ListCopyWith($value.deletedContacts!,
              (v, t) => v.copyWith.$chain(t), (v) => call(deletedContacts: v))
          : null;
  @override
  LocationCopyWith<$R, Location, Location>? get location =>
      $value.location?.copyWith.$chain((v) => call(location: v));
  @override
  $R call(
          {Object? image = $none,
          Object? coverImage = $none,
          Object? company = $none,
          Object? newContacts = $none,
          Object? deletedContacts = $none,
          Object? location = $none}) =>
      $apply(FieldCopyWithData({
        if (image != $none) #image: image,
        if (coverImage != $none) #coverImage: coverImage,
        if (company != $none) #company: company,
        if (newContacts != $none) #newContacts: newContacts,
        if (deletedContacts != $none) #deletedContacts: deletedContacts,
        if (location != $none) #location: location
      }));
  @override
  PostCompany $make(CopyWithData data) => PostCompany(
      image: data.get(#image, or: $value.image),
      coverImage: data.get(#coverImage, or: $value.coverImage),
      company: data.get(#company, or: $value.company),
      newContacts: data.get(#newContacts, or: $value.newContacts),
      deletedContacts: data.get(#deletedContacts, or: $value.deletedContacts),
      location: data.get(#location, or: $value.location));

  @override
  PostCompanyCopyWith<$R2, PostCompany, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PostCompanyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
