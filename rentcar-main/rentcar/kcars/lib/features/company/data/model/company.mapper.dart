// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'company.dart';

class CompanyMapper extends ClassMapperBase<Company> {
  CompanyMapper._();

  static CompanyMapper? _instance;
  static CompanyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CompanyMapper._());
      ContactMapper.ensureInitialized();
      LocationMapper.ensureInitialized();
      ProfileMapper.ensureInitialized();
      CompanyReviewMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Company';

  static String _$id(Company v) => v.id;
  static const Field<Company, String> _f$id = Field('id', _$id);
  static String _$name(Company v) => v.name;
  static const Field<Company, String> _f$name = Field('name', _$name);
  static String? _$desc(Company v) => v.desc;
  static const Field<Company, String> _f$desc =
      Field('desc', _$desc, opt: true);
  static String? _$image(Company v) => v.image;
  static const Field<Company, String> _f$image =
      Field('image', _$image, opt: true);
  static DateTime? _$expiresAt(Company v) => v.expiresAt;
  static const Field<Company, DateTime> _f$expiresAt =
      Field('expiresAt', _$expiresAt, opt: true);
  static DateTime? _$activeDate(Company v) => v.activeDate;
  static const Field<Company, DateTime> _f$activeDate =
      Field('activeDate', _$activeDate, opt: true);
  static double? _$review(Company v) => v.review;
  static const Field<Company, double> _f$review =
      Field('review', _$review, opt: true);
  static int? _$rate(Company v) => v.rate;
  static const Field<Company, int> _f$rate = Field('rate', _$rate, opt: true);
  static List<Contact>? _$contacts(Company v) => v.contacts;
  static const Field<Company, List<Contact>> _f$contacts =
      Field('contacts', _$contacts, opt: true);
  static Location? _$location(Company v) => v.location;
  static const Field<Company, Location> _f$location =
      Field('location', _$location, opt: true);
  static Profile? _$profile(Company v) => v.profile;
  static const Field<Company, Profile> _f$profile =
      Field('profile', _$profile, opt: true);
  static CompanyReview? _$reviews(Company v) => v.reviews;
  static const Field<Company, CompanyReview> _f$reviews =
      Field('reviews', _$reviews, opt: true);
  static bool? _$reviewCompany(Company v) => v.reviewCompany;
  static const Field<Company, bool> _f$reviewCompany =
      Field('reviewCompany', _$reviewCompany, opt: true);
  static int? _$cars(Company v) => v.cars;
  static const Field<Company, int> _f$cars = Field('cars', _$cars, opt: true);
  static DateTime? _$joinedAt(Company v) => v.joinedAt;
  static const Field<Company, DateTime> _f$joinedAt =
      Field('joinedAt', _$joinedAt, opt: true);
  static bool? _$available(Company v) => v.available;
  static const Field<Company, bool> _f$available =
      Field('available', _$available, opt: true);
  static int? _$serial(Company v) => v.serial;
  static const Field<Company, int> _f$serial =
      Field('serial', _$serial, opt: true);
  static String? _$companyId(Company v) => v.companyId;
  static const Field<Company, String> _f$companyId =
      Field('companyId', _$companyId, opt: true);
  static String? _$contact(Company v) => v.contact;
  static const Field<Company, String> _f$contact =
      Field('contact', _$contact, opt: true);
  static String? _$coverImage(Company v) => v.coverImage;
  static const Field<Company, String> _f$coverImage =
      Field('coverImage', _$coverImage, opt: true);
  static int? _$contacted(Company v) => v.contacted;
  static const Field<Company, int> _f$contacted =
      Field('contacted', _$contacted, opt: true);
  static bool? _$international(Company v) => v.international;
  static const Field<Company, bool> _f$international =
      Field('international', _$international, opt: true);
  static bool? _$delivery(Company v) => v.delivery;
  static const Field<Company, bool> _f$delivery =
      Field('delivery', _$delivery, opt: true);
  static int? _$total(Company v) => v.total;
  static const Field<Company, int> _f$total =
      Field('total', _$total, opt: true);

  @override
  final MappableFields<Company> fields = const {
    #id: _f$id,
    #name: _f$name,
    #desc: _f$desc,
    #image: _f$image,
    #expiresAt: _f$expiresAt,
    #activeDate: _f$activeDate,
    #review: _f$review,
    #rate: _f$rate,
    #contacts: _f$contacts,
    #location: _f$location,
    #profile: _f$profile,
    #reviews: _f$reviews,
    #reviewCompany: _f$reviewCompany,
    #cars: _f$cars,
    #joinedAt: _f$joinedAt,
    #available: _f$available,
    #serial: _f$serial,
    #companyId: _f$companyId,
    #contact: _f$contact,
    #coverImage: _f$coverImage,
    #contacted: _f$contacted,
    #international: _f$international,
    #delivery: _f$delivery,
    #total: _f$total,
  };

  static Company _instantiate(DecodingData data) {
    return Company(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        desc: data.dec(_f$desc),
        image: data.dec(_f$image),
        expiresAt: data.dec(_f$expiresAt),
        activeDate: data.dec(_f$activeDate),
        review: data.dec(_f$review),
        rate: data.dec(_f$rate),
        contacts: data.dec(_f$contacts),
        location: data.dec(_f$location),
        profile: data.dec(_f$profile),
        reviews: data.dec(_f$reviews),
        reviewCompany: data.dec(_f$reviewCompany),
        cars: data.dec(_f$cars),
        joinedAt: data.dec(_f$joinedAt),
        available: data.dec(_f$available),
        serial: data.dec(_f$serial),
        companyId: data.dec(_f$companyId),
        contact: data.dec(_f$contact),
        coverImage: data.dec(_f$coverImage),
        contacted: data.dec(_f$contacted),
        international: data.dec(_f$international),
        delivery: data.dec(_f$delivery),
        total: data.dec(_f$total));
  }

  @override
  final Function instantiate = _instantiate;

  static Company fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Company>(map);
  }

  static Company fromJson(String json) {
    return ensureInitialized().decodeJson<Company>(json);
  }
}

mixin CompanyMappable {
  String toJson() {
    return CompanyMapper.ensureInitialized()
        .encodeJson<Company>(this as Company);
  }

  Map<String, dynamic> toMap() {
    return CompanyMapper.ensureInitialized()
        .encodeMap<Company>(this as Company);
  }

  CompanyCopyWith<Company, Company, Company> get copyWith =>
      _CompanyCopyWithImpl<Company, Company>(
          this as Company, $identity, $identity);
  @override
  String toString() {
    return CompanyMapper.ensureInitialized().stringifyValue(this as Company);
  }

  @override
  bool operator ==(Object other) {
    return CompanyMapper.ensureInitialized()
        .equalsValue(this as Company, other);
  }

  @override
  int get hashCode {
    return CompanyMapper.ensureInitialized().hashValue(this as Company);
  }
}

extension CompanyValueCopy<$R, $Out> on ObjectCopyWith<$R, Company, $Out> {
  CompanyCopyWith<$R, Company, $Out> get $asCompany =>
      $base.as((v, t, t2) => _CompanyCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CompanyCopyWith<$R, $In extends Company, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Contact, ContactCopyWith<$R, Contact, Contact>>?
      get contacts;
  LocationCopyWith<$R, Location, Location>? get location;
  ProfileCopyWith<$R, Profile, Profile>? get profile;
  CompanyReviewCopyWith<$R, CompanyReview, CompanyReview>? get reviews;
  $R call(
      {String? id,
      String? name,
      String? desc,
      String? image,
      DateTime? expiresAt,
      DateTime? activeDate,
      double? review,
      int? rate,
      List<Contact>? contacts,
      Location? location,
      Profile? profile,
      CompanyReview? reviews,
      bool? reviewCompany,
      int? cars,
      DateTime? joinedAt,
      bool? available,
      int? serial,
      String? companyId,
      String? contact,
      String? coverImage,
      int? contacted,
      bool? international,
      bool? delivery,
      int? total});
  CompanyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CompanyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Company, $Out>
    implements CompanyCopyWith<$R, Company, $Out> {
  _CompanyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Company> $mapper =
      CompanyMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Contact, ContactCopyWith<$R, Contact, Contact>>?
      get contacts => $value.contacts != null
          ? ListCopyWith($value.contacts!, (v, t) => v.copyWith.$chain(t),
              (v) => call(contacts: v))
          : null;
  @override
  LocationCopyWith<$R, Location, Location>? get location =>
      $value.location?.copyWith.$chain((v) => call(location: v));
  @override
  ProfileCopyWith<$R, Profile, Profile>? get profile =>
      $value.profile?.copyWith.$chain((v) => call(profile: v));
  @override
  CompanyReviewCopyWith<$R, CompanyReview, CompanyReview>? get reviews =>
      $value.reviews?.copyWith.$chain((v) => call(reviews: v));
  @override
  $R call(
          {String? id,
          String? name,
          Object? desc = $none,
          Object? image = $none,
          Object? expiresAt = $none,
          Object? activeDate = $none,
          Object? review = $none,
          Object? rate = $none,
          Object? contacts = $none,
          Object? location = $none,
          Object? profile = $none,
          Object? reviews = $none,
          Object? reviewCompany = $none,
          Object? cars = $none,
          Object? joinedAt = $none,
          Object? available = $none,
          Object? serial = $none,
          Object? companyId = $none,
          Object? contact = $none,
          Object? coverImage = $none,
          Object? contacted = $none,
          Object? international = $none,
          Object? delivery = $none,
          Object? total = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (desc != $none) #desc: desc,
        if (image != $none) #image: image,
        if (expiresAt != $none) #expiresAt: expiresAt,
        if (activeDate != $none) #activeDate: activeDate,
        if (review != $none) #review: review,
        if (rate != $none) #rate: rate,
        if (contacts != $none) #contacts: contacts,
        if (location != $none) #location: location,
        if (profile != $none) #profile: profile,
        if (reviews != $none) #reviews: reviews,
        if (reviewCompany != $none) #reviewCompany: reviewCompany,
        if (cars != $none) #cars: cars,
        if (joinedAt != $none) #joinedAt: joinedAt,
        if (available != $none) #available: available,
        if (serial != $none) #serial: serial,
        if (companyId != $none) #companyId: companyId,
        if (contact != $none) #contact: contact,
        if (coverImage != $none) #coverImage: coverImage,
        if (contacted != $none) #contacted: contacted,
        if (international != $none) #international: international,
        if (delivery != $none) #delivery: delivery,
        if (total != $none) #total: total
      }));
  @override
  Company $make(CopyWithData data) => Company(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      desc: data.get(#desc, or: $value.desc),
      image: data.get(#image, or: $value.image),
      expiresAt: data.get(#expiresAt, or: $value.expiresAt),
      activeDate: data.get(#activeDate, or: $value.activeDate),
      review: data.get(#review, or: $value.review),
      rate: data.get(#rate, or: $value.rate),
      contacts: data.get(#contacts, or: $value.contacts),
      location: data.get(#location, or: $value.location),
      profile: data.get(#profile, or: $value.profile),
      reviews: data.get(#reviews, or: $value.reviews),
      reviewCompany: data.get(#reviewCompany, or: $value.reviewCompany),
      cars: data.get(#cars, or: $value.cars),
      joinedAt: data.get(#joinedAt, or: $value.joinedAt),
      available: data.get(#available, or: $value.available),
      serial: data.get(#serial, or: $value.serial),
      companyId: data.get(#companyId, or: $value.companyId),
      contact: data.get(#contact, or: $value.contact),
      coverImage: data.get(#coverImage, or: $value.coverImage),
      contacted: data.get(#contacted, or: $value.contacted),
      international: data.get(#international, or: $value.international),
      delivery: data.get(#delivery, or: $value.delivery),
      total: data.get(#total, or: $value.total));

  @override
  CompanyCopyWith<$R2, Company, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CompanyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
