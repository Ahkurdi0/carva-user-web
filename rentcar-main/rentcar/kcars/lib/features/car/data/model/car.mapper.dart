// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'car.dart';

class CarMapper extends ClassMapperBase<Car> {
  CarMapper._();

  static CarMapper? _instance;
  static CarMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CarMapper._());
      ImagesMapper.ensureInitialized();
      BrandMapper.ensureInitialized();
      CarTypeMapper.ensureInitialized();
      FeatureMapper.ensureInitialized();
      CompanyMapper.ensureInitialized();
      CarLocationMapper.ensureInitialized();
      PromotionMapper.ensureInitialized();
      RentalPlanMapper.ensureInitialized();
      BookedDatesMapper.ensureInitialized();
      CarReviewMapper.ensureInitialized();
      RentalPeriodTypeMapper.ensureInitialized();
      FeaturedCarsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Car';

  static String _$id(Car v) => v.id;
  static const Field<Car, String> _f$id = Field('id', _$id);
  static String _$title(Car v) => v.title;
  static const Field<Car, String> _f$title = Field('title', _$title);
  static double? _$rate(Car v) => v.rate;
  static const Field<Car, double> _f$rate = Field('rate', _$rate, opt: true);
  static int? _$review(Car v) => v.review;
  static const Field<Car, int> _f$review = Field('review', _$review, opt: true);
  static int? _$trips(Car v) => v.trips;
  static const Field<Car, int> _f$trips = Field('trips', _$trips, opt: true);
  static DateTime _$listedAt(Car v) => v.listedAt;
  static const Field<Car, DateTime> _f$listedAt = Field('listedAt', _$listedAt);
  static List<Images>? _$images(Car v) => v.images;
  static const Field<Car, List<Images>> _f$images =
      Field('images', _$images, opt: true);
  static Brand? _$brand(Car v) => v.brand;
  static const Field<Car, Brand> _f$brand = Field('brand', _$brand, opt: true);
  static CarType? _$type(Car v) => v.type;
  static const Field<Car, CarType> _f$type = Field('type', _$type, opt: true);
  static Feature? _$feature(Car v) => v.feature;
  static const Field<Car, Feature> _f$feature =
      Field('feature', _$feature, opt: true);
  static Company? _$company(Car v) => v.company;
  static const Field<Car, Company> _f$company =
      Field('company', _$company, opt: true);
  static CarLocation? _$location(Car v) => v.location;
  static const Field<Car, CarLocation> _f$location =
      Field('location', _$location, opt: true);
  static bool? _$isViwed(Car v) => v.isViwed;
  static const Field<Car, bool> _f$isViwed =
      Field('isViwed', _$isViwed, opt: true);
  static bool? _$isFavorite(Car v) => v.isFavorite;
  static const Field<Car, bool> _f$isFavorite =
      Field('isFavorite', _$isFavorite, opt: true);
  static Promotion? _$promotion(Car v) => v.promotion;
  static const Field<Car, Promotion> _f$promotion =
      Field('promotion', _$promotion, opt: true);
  static List<RentalPlan>? _$rentalPlan(Car v) => v.rentalPlan;
  static const Field<Car, List<RentalPlan>> _f$rentalPlan =
      Field('rentalPlan', _$rentalPlan, opt: true);
  static List<BookedDates>? _$bookings(Car v) => v.bookings;
  static const Field<Car, List<BookedDates>> _f$bookings =
      Field('bookings', _$bookings, opt: true);
  static CarReview? _$reviews(Car v) => v.reviews;
  static const Field<Car, CarReview> _f$reviews =
      Field('reviews', _$reviews, opt: true);
  static bool? _$reviewCar(Car v) => v.reviewCar;
  static const Field<Car, bool> _f$reviewCar =
      Field('reviewCar', _$reviewCar, opt: true);
  static bool? _$available(Car v) => v.available;
  static const Field<Car, bool> _f$available =
      Field('available', _$available, opt: true);
  static String? _$brandId(Car v) => v.brandId;
  static const Field<Car, String> _f$brandId =
      Field('brandId', _$brandId, opt: true);
  static String? _$typeId(Car v) => v.typeId;
  static const Field<Car, String> _f$typeId =
      Field('typeId', _$typeId, opt: true);
  static int? _$serial(Car v) => v.serial;
  static const Field<Car, int> _f$serial = Field('serial', _$serial, opt: true);
  static String? _$carId(Car v) => v.carId;
  static const Field<Car, String> _f$carId = Field('carId', _$carId, opt: true);
  static int? _$viewed(Car v) => v.viewed;
  static const Field<Car, int> _f$viewed = Field('viewed', _$viewed, opt: true);
  static RentalPeriodType? _$displayPlan(Car v) => v.displayPlan;
  static const Field<Car, RentalPeriodType> _f$displayPlan =
      Field('displayPlan', _$displayPlan, opt: true);
  static FeaturedCars? _$featuredCars(Car v) => v.featuredCars;
  static const Field<Car, FeaturedCars> _f$featuredCars =
      Field('featuredCars', _$featuredCars, opt: true);
  static DateTime? _$deletedAt(Car v) => v.deletedAt;
  static const Field<Car, DateTime> _f$deletedAt =
      Field('deletedAt', _$deletedAt, opt: true);

  @override
  final MappableFields<Car> fields = const {
    #id: _f$id,
    #title: _f$title,
    #rate: _f$rate,
    #review: _f$review,
    #trips: _f$trips,
    #listedAt: _f$listedAt,
    #images: _f$images,
    #brand: _f$brand,
    #type: _f$type,
    #feature: _f$feature,
    #company: _f$company,
    #location: _f$location,
    #isViwed: _f$isViwed,
    #isFavorite: _f$isFavorite,
    #promotion: _f$promotion,
    #rentalPlan: _f$rentalPlan,
    #bookings: _f$bookings,
    #reviews: _f$reviews,
    #reviewCar: _f$reviewCar,
    #available: _f$available,
    #brandId: _f$brandId,
    #typeId: _f$typeId,
    #serial: _f$serial,
    #carId: _f$carId,
    #viewed: _f$viewed,
    #displayPlan: _f$displayPlan,
    #featuredCars: _f$featuredCars,
    #deletedAt: _f$deletedAt,
  };

  static Car _instantiate(DecodingData data) {
    return Car(
        id: data.dec(_f$id),
        title: data.dec(_f$title),
        rate: data.dec(_f$rate),
        review: data.dec(_f$review),
        trips: data.dec(_f$trips),
        listedAt: data.dec(_f$listedAt),
        images: data.dec(_f$images),
        brand: data.dec(_f$brand),
        type: data.dec(_f$type),
        feature: data.dec(_f$feature),
        company: data.dec(_f$company),
        location: data.dec(_f$location),
        isViwed: data.dec(_f$isViwed),
        isFavorite: data.dec(_f$isFavorite),
        promotion: data.dec(_f$promotion),
        rentalPlan: data.dec(_f$rentalPlan),
        bookings: data.dec(_f$bookings),
        reviews: data.dec(_f$reviews),
        reviewCar: data.dec(_f$reviewCar),
        available: data.dec(_f$available),
        brandId: data.dec(_f$brandId),
        typeId: data.dec(_f$typeId),
        serial: data.dec(_f$serial),
        carId: data.dec(_f$carId),
        viewed: data.dec(_f$viewed),
        displayPlan: data.dec(_f$displayPlan),
        featuredCars: data.dec(_f$featuredCars),
        deletedAt: data.dec(_f$deletedAt));
  }

  @override
  final Function instantiate = _instantiate;

  static Car fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Car>(map);
  }

  static Car fromJson(String json) {
    return ensureInitialized().decodeJson<Car>(json);
  }
}

mixin CarMappable {
  String toJson() {
    return CarMapper.ensureInitialized().encodeJson<Car>(this as Car);
  }

  Map<String, dynamic> toMap() {
    return CarMapper.ensureInitialized().encodeMap<Car>(this as Car);
  }

  CarCopyWith<Car, Car, Car> get copyWith =>
      _CarCopyWithImpl<Car, Car>(this as Car, $identity, $identity);
  @override
  String toString() {
    return CarMapper.ensureInitialized().stringifyValue(this as Car);
  }

  @override
  bool operator ==(Object other) {
    return CarMapper.ensureInitialized().equalsValue(this as Car, other);
  }

  @override
  int get hashCode {
    return CarMapper.ensureInitialized().hashValue(this as Car);
  }
}

extension CarValueCopy<$R, $Out> on ObjectCopyWith<$R, Car, $Out> {
  CarCopyWith<$R, Car, $Out> get $asCar =>
      $base.as((v, t, t2) => _CarCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CarCopyWith<$R, $In extends Car, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Images, ImagesCopyWith<$R, Images, Images>>? get images;
  BrandCopyWith<$R, Brand, Brand>? get brand;
  CarTypeCopyWith<$R, CarType, CarType>? get type;
  FeatureCopyWith<$R, Feature, Feature>? get feature;
  CompanyCopyWith<$R, Company, Company>? get company;
  CarLocationCopyWith<$R, CarLocation, CarLocation>? get location;
  PromotionCopyWith<$R, Promotion, Promotion>? get promotion;
  ListCopyWith<$R, RentalPlan, RentalPlanCopyWith<$R, RentalPlan, RentalPlan>>?
      get rentalPlan;
  ListCopyWith<$R, BookedDates,
      BookedDatesCopyWith<$R, BookedDates, BookedDates>>? get bookings;
  CarReviewCopyWith<$R, CarReview, CarReview>? get reviews;
  FeaturedCarsCopyWith<$R, FeaturedCars, FeaturedCars>? get featuredCars;
  $R call(
      {String? id,
      String? title,
      double? rate,
      int? review,
      int? trips,
      DateTime? listedAt,
      List<Images>? images,
      Brand? brand,
      CarType? type,
      Feature? feature,
      Company? company,
      CarLocation? location,
      bool? isViwed,
      bool? isFavorite,
      Promotion? promotion,
      List<RentalPlan>? rentalPlan,
      List<BookedDates>? bookings,
      CarReview? reviews,
      bool? reviewCar,
      bool? available,
      String? brandId,
      String? typeId,
      int? serial,
      String? carId,
      int? viewed,
      RentalPeriodType? displayPlan,
      FeaturedCars? featuredCars,
      DateTime? deletedAt});
  CarCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CarCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Car, $Out>
    implements CarCopyWith<$R, Car, $Out> {
  _CarCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Car> $mapper = CarMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Images, ImagesCopyWith<$R, Images, Images>>? get images =>
      $value.images != null
          ? ListCopyWith($value.images!, (v, t) => v.copyWith.$chain(t),
              (v) => call(images: v))
          : null;
  @override
  BrandCopyWith<$R, Brand, Brand>? get brand =>
      $value.brand?.copyWith.$chain((v) => call(brand: v));
  @override
  CarTypeCopyWith<$R, CarType, CarType>? get type =>
      $value.type?.copyWith.$chain((v) => call(type: v));
  @override
  FeatureCopyWith<$R, Feature, Feature>? get feature =>
      $value.feature?.copyWith.$chain((v) => call(feature: v));
  @override
  CompanyCopyWith<$R, Company, Company>? get company =>
      $value.company?.copyWith.$chain((v) => call(company: v));
  @override
  CarLocationCopyWith<$R, CarLocation, CarLocation>? get location =>
      $value.location?.copyWith.$chain((v) => call(location: v));
  @override
  PromotionCopyWith<$R, Promotion, Promotion>? get promotion =>
      $value.promotion?.copyWith.$chain((v) => call(promotion: v));
  @override
  ListCopyWith<$R, RentalPlan, RentalPlanCopyWith<$R, RentalPlan, RentalPlan>>?
      get rentalPlan => $value.rentalPlan != null
          ? ListCopyWith($value.rentalPlan!, (v, t) => v.copyWith.$chain(t),
              (v) => call(rentalPlan: v))
          : null;
  @override
  ListCopyWith<$R, BookedDates,
          BookedDatesCopyWith<$R, BookedDates, BookedDates>>?
      get bookings => $value.bookings != null
          ? ListCopyWith($value.bookings!, (v, t) => v.copyWith.$chain(t),
              (v) => call(bookings: v))
          : null;
  @override
  CarReviewCopyWith<$R, CarReview, CarReview>? get reviews =>
      $value.reviews?.copyWith.$chain((v) => call(reviews: v));
  @override
  FeaturedCarsCopyWith<$R, FeaturedCars, FeaturedCars>? get featuredCars =>
      $value.featuredCars?.copyWith.$chain((v) => call(featuredCars: v));
  @override
  $R call(
          {String? id,
          String? title,
          Object? rate = $none,
          Object? review = $none,
          Object? trips = $none,
          DateTime? listedAt,
          Object? images = $none,
          Object? brand = $none,
          Object? type = $none,
          Object? feature = $none,
          Object? company = $none,
          Object? location = $none,
          Object? isViwed = $none,
          Object? isFavorite = $none,
          Object? promotion = $none,
          Object? rentalPlan = $none,
          Object? bookings = $none,
          Object? reviews = $none,
          Object? reviewCar = $none,
          Object? available = $none,
          Object? brandId = $none,
          Object? typeId = $none,
          Object? serial = $none,
          Object? carId = $none,
          Object? viewed = $none,
          Object? displayPlan = $none,
          Object? featuredCars = $none,
          Object? deletedAt = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (title != null) #title: title,
        if (rate != $none) #rate: rate,
        if (review != $none) #review: review,
        if (trips != $none) #trips: trips,
        if (listedAt != null) #listedAt: listedAt,
        if (images != $none) #images: images,
        if (brand != $none) #brand: brand,
        if (type != $none) #type: type,
        if (feature != $none) #feature: feature,
        if (company != $none) #company: company,
        if (location != $none) #location: location,
        if (isViwed != $none) #isViwed: isViwed,
        if (isFavorite != $none) #isFavorite: isFavorite,
        if (promotion != $none) #promotion: promotion,
        if (rentalPlan != $none) #rentalPlan: rentalPlan,
        if (bookings != $none) #bookings: bookings,
        if (reviews != $none) #reviews: reviews,
        if (reviewCar != $none) #reviewCar: reviewCar,
        if (available != $none) #available: available,
        if (brandId != $none) #brandId: brandId,
        if (typeId != $none) #typeId: typeId,
        if (serial != $none) #serial: serial,
        if (carId != $none) #carId: carId,
        if (viewed != $none) #viewed: viewed,
        if (displayPlan != $none) #displayPlan: displayPlan,
        if (featuredCars != $none) #featuredCars: featuredCars,
        if (deletedAt != $none) #deletedAt: deletedAt
      }));
  @override
  Car $make(CopyWithData data) => Car(
      id: data.get(#id, or: $value.id),
      title: data.get(#title, or: $value.title),
      rate: data.get(#rate, or: $value.rate),
      review: data.get(#review, or: $value.review),
      trips: data.get(#trips, or: $value.trips),
      listedAt: data.get(#listedAt, or: $value.listedAt),
      images: data.get(#images, or: $value.images),
      brand: data.get(#brand, or: $value.brand),
      type: data.get(#type, or: $value.type),
      feature: data.get(#feature, or: $value.feature),
      company: data.get(#company, or: $value.company),
      location: data.get(#location, or: $value.location),
      isViwed: data.get(#isViwed, or: $value.isViwed),
      isFavorite: data.get(#isFavorite, or: $value.isFavorite),
      promotion: data.get(#promotion, or: $value.promotion),
      rentalPlan: data.get(#rentalPlan, or: $value.rentalPlan),
      bookings: data.get(#bookings, or: $value.bookings),
      reviews: data.get(#reviews, or: $value.reviews),
      reviewCar: data.get(#reviewCar, or: $value.reviewCar),
      available: data.get(#available, or: $value.available),
      brandId: data.get(#brandId, or: $value.brandId),
      typeId: data.get(#typeId, or: $value.typeId),
      serial: data.get(#serial, or: $value.serial),
      carId: data.get(#carId, or: $value.carId),
      viewed: data.get(#viewed, or: $value.viewed),
      displayPlan: data.get(#displayPlan, or: $value.displayPlan),
      featuredCars: data.get(#featuredCars, or: $value.featuredCars),
      deletedAt: data.get(#deletedAt, or: $value.deletedAt));

  @override
  CarCopyWith<$R2, Car, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CarCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CarUpdateMapper extends ClassMapperBase<CarUpdate> {
  CarUpdateMapper._();

  static CarUpdateMapper? _instance;
  static CarUpdateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CarUpdateMapper._());
      BrandMapper.ensureInitialized();
      CarTypeMapper.ensureInitialized();
      FeatureMapper.ensureInitialized();
      CarLocationMapper.ensureInitialized();
      RentalPlanMapper.ensureInitialized();
      RentalPeriodTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CarUpdate';

  static String? _$id(CarUpdate v) => v.id;
  static const Field<CarUpdate, String> _f$id = Field('id', _$id, opt: true);
  static String? _$title(CarUpdate v) => v.title;
  static const Field<CarUpdate, String> _f$title =
      Field('title', _$title, opt: true);
  static Brand? _$brand(CarUpdate v) => v.brand;
  static const Field<CarUpdate, Brand> _f$brand =
      Field('brand', _$brand, opt: true);
  static CarType? _$type(CarUpdate v) => v.type;
  static const Field<CarUpdate, CarType> _f$type =
      Field('type', _$type, opt: true);
  static Feature? _$feature(CarUpdate v) => v.feature;
  static const Field<CarUpdate, Feature> _f$feature =
      Field('feature', _$feature, opt: true);
  static CarLocation? _$location(CarUpdate v) => v.location;
  static const Field<CarUpdate, CarLocation> _f$location =
      Field('location', _$location, opt: true);
  static List<RentalPlan>? _$rentalPlan(CarUpdate v) => v.rentalPlan;
  static const Field<CarUpdate, List<RentalPlan>> _f$rentalPlan =
      Field('rentalPlan', _$rentalPlan, opt: true);
  static String? _$typeId(CarUpdate v) => v.typeId;
  static const Field<CarUpdate, String> _f$typeId =
      Field('typeId', _$typeId, opt: true);
  static String? _$brandId(CarUpdate v) => v.brandId;
  static const Field<CarUpdate, String> _f$brandId =
      Field('brandId', _$brandId, opt: true);
  static bool? _$available(CarUpdate v) => v.available;
  static const Field<CarUpdate, bool> _f$available =
      Field('available', _$available, opt: true);
  static RentalPeriodType? _$displayPlan(CarUpdate v) => v.displayPlan;
  static const Field<CarUpdate, RentalPeriodType> _f$displayPlan =
      Field('displayPlan', _$displayPlan, opt: true);

  @override
  final MappableFields<CarUpdate> fields = const {
    #id: _f$id,
    #title: _f$title,
    #brand: _f$brand,
    #type: _f$type,
    #feature: _f$feature,
    #location: _f$location,
    #rentalPlan: _f$rentalPlan,
    #typeId: _f$typeId,
    #brandId: _f$brandId,
    #available: _f$available,
    #displayPlan: _f$displayPlan,
  };

  static CarUpdate _instantiate(DecodingData data) {
    return CarUpdate(
        id: data.dec(_f$id),
        title: data.dec(_f$title),
        brand: data.dec(_f$brand),
        type: data.dec(_f$type),
        feature: data.dec(_f$feature),
        location: data.dec(_f$location),
        rentalPlan: data.dec(_f$rentalPlan),
        typeId: data.dec(_f$typeId),
        brandId: data.dec(_f$brandId),
        available: data.dec(_f$available),
        displayPlan: data.dec(_f$displayPlan));
  }

  @override
  final Function instantiate = _instantiate;

  static CarUpdate fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CarUpdate>(map);
  }

  static CarUpdate fromJson(String json) {
    return ensureInitialized().decodeJson<CarUpdate>(json);
  }
}

mixin CarUpdateMappable {
  String toJson() {
    return CarUpdateMapper.ensureInitialized()
        .encodeJson<CarUpdate>(this as CarUpdate);
  }

  Map<String, dynamic> toMap() {
    return CarUpdateMapper.ensureInitialized()
        .encodeMap<CarUpdate>(this as CarUpdate);
  }

  CarUpdateCopyWith<CarUpdate, CarUpdate, CarUpdate> get copyWith =>
      _CarUpdateCopyWithImpl<CarUpdate, CarUpdate>(
          this as CarUpdate, $identity, $identity);
  @override
  String toString() {
    return CarUpdateMapper.ensureInitialized()
        .stringifyValue(this as CarUpdate);
  }

  @override
  bool operator ==(Object other) {
    return CarUpdateMapper.ensureInitialized()
        .equalsValue(this as CarUpdate, other);
  }

  @override
  int get hashCode {
    return CarUpdateMapper.ensureInitialized().hashValue(this as CarUpdate);
  }
}

extension CarUpdateValueCopy<$R, $Out> on ObjectCopyWith<$R, CarUpdate, $Out> {
  CarUpdateCopyWith<$R, CarUpdate, $Out> get $asCarUpdate =>
      $base.as((v, t, t2) => _CarUpdateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CarUpdateCopyWith<$R, $In extends CarUpdate, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  BrandCopyWith<$R, Brand, Brand>? get brand;
  CarTypeCopyWith<$R, CarType, CarType>? get type;
  FeatureCopyWith<$R, Feature, Feature>? get feature;
  CarLocationCopyWith<$R, CarLocation, CarLocation>? get location;
  ListCopyWith<$R, RentalPlan, RentalPlanCopyWith<$R, RentalPlan, RentalPlan>>?
      get rentalPlan;
  $R call(
      {String? id,
      String? title,
      Brand? brand,
      CarType? type,
      Feature? feature,
      CarLocation? location,
      List<RentalPlan>? rentalPlan,
      String? typeId,
      String? brandId,
      bool? available,
      RentalPeriodType? displayPlan});
  CarUpdateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CarUpdateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CarUpdate, $Out>
    implements CarUpdateCopyWith<$R, CarUpdate, $Out> {
  _CarUpdateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CarUpdate> $mapper =
      CarUpdateMapper.ensureInitialized();
  @override
  BrandCopyWith<$R, Brand, Brand>? get brand =>
      $value.brand?.copyWith.$chain((v) => call(brand: v));
  @override
  CarTypeCopyWith<$R, CarType, CarType>? get type =>
      $value.type?.copyWith.$chain((v) => call(type: v));
  @override
  FeatureCopyWith<$R, Feature, Feature>? get feature =>
      $value.feature?.copyWith.$chain((v) => call(feature: v));
  @override
  CarLocationCopyWith<$R, CarLocation, CarLocation>? get location =>
      $value.location?.copyWith.$chain((v) => call(location: v));
  @override
  ListCopyWith<$R, RentalPlan, RentalPlanCopyWith<$R, RentalPlan, RentalPlan>>?
      get rentalPlan => $value.rentalPlan != null
          ? ListCopyWith($value.rentalPlan!, (v, t) => v.copyWith.$chain(t),
              (v) => call(rentalPlan: v))
          : null;
  @override
  $R call(
          {Object? id = $none,
          Object? title = $none,
          Object? brand = $none,
          Object? type = $none,
          Object? feature = $none,
          Object? location = $none,
          Object? rentalPlan = $none,
          Object? typeId = $none,
          Object? brandId = $none,
          Object? available = $none,
          Object? displayPlan = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (title != $none) #title: title,
        if (brand != $none) #brand: brand,
        if (type != $none) #type: type,
        if (feature != $none) #feature: feature,
        if (location != $none) #location: location,
        if (rentalPlan != $none) #rentalPlan: rentalPlan,
        if (typeId != $none) #typeId: typeId,
        if (brandId != $none) #brandId: brandId,
        if (available != $none) #available: available,
        if (displayPlan != $none) #displayPlan: displayPlan
      }));
  @override
  CarUpdate $make(CopyWithData data) => CarUpdate(
      id: data.get(#id, or: $value.id),
      title: data.get(#title, or: $value.title),
      brand: data.get(#brand, or: $value.brand),
      type: data.get(#type, or: $value.type),
      feature: data.get(#feature, or: $value.feature),
      location: data.get(#location, or: $value.location),
      rentalPlan: data.get(#rentalPlan, or: $value.rentalPlan),
      typeId: data.get(#typeId, or: $value.typeId),
      brandId: data.get(#brandId, or: $value.brandId),
      available: data.get(#available, or: $value.available),
      displayPlan: data.get(#displayPlan, or: $value.displayPlan));

  @override
  CarUpdateCopyWith<$R2, CarUpdate, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CarUpdateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
