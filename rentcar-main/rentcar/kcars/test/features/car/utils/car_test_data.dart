import 'package:image_picker/image_picker.dart';
import 'package:kcars/features/car/data/model/booked_dates.dart';
import 'package:kcars/features/car/data/model/brand.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/car_cursor.dart';
import 'package:kcars/features/car/data/model/car_location.dart';
import 'package:kcars/features/car/data/model/car_post.dart';
import 'package:kcars/features/car/data/model/car_type.dart';
import 'package:kcars/features/car/data/model/city.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:kcars/features/car/data/model/feature.dart';
import 'package:kcars/features/car/data/model/image.dart';
import 'package:kcars/features/car/data/model/paln.dart';
import 'package:kcars/features/car/data/model/promotion.dart';
import 'package:kcars/features/car/data/model/rental_plan.dart';
import 'package:kcars/features/car/data/model/town.dart';
import 'package:kcars/features/company/data/model/company.dart';

class CarTestData {
  static Promotion promotion() => Promotion(
    id: "A",
    carId: "A",
    companyId: "A",
    priceType: PromotionPriceType.percentage,
    type: PromotionType.car,
    value: 20,
    startDate: DateTime.parse("2025-06-07T14:36:06.200Z"),
    endDate: DateTime.parse("2025-08-07T14:36:06.200Z"),
    usesCount: 0,
    maxUsePerUser: 100,
    available: true,
  );
  static PromotionUpdate updatePromotion() => PromotionUpdate(
    id: "A",
    carId: "A",
    priceType: PromotionPriceType.percentage,
    type: PromotionType.car,
    value: 20,
    startDate: DateTime.parse("2025-06-07T14:36:06.200Z"),
    endDate: DateTime.parse("2025-08-07T14:36:06.200Z"),
    usesCount: 0,
    maxUsePerUser: 100,
    available: true,
  );

  static Car car({Promotion? promo}) => Car(
    id: "A",
    title: "title",
    listedAt: DateTime.parse("2025-06-07T14:36:06.200Z"),
    trips: 1,
    review: 1,
    rate: 0,
    company: Company(id: "C", name: "test", review: 0, rate: 0),
    brand: Brand(
      id: "A",
      en: "test",
      ku: "A",
      ar: "A",
      image: "",
      sort: 0,
      cars: [],
    ),
    images: [
      Images(
        image: "http://kcars.com/1.jpg",
        id: "A",
        carId: "A",
        sort: 1,
        companyId: "A",
      ),
    ],
    feature: Feature(
      id: "A",
      carId: "A",
      year: 2025,
      fuel: Fuel.diesel,
      transmission: Transmission.automatic,
      seat: 1,
      hp: 1,
      speed: 1,
      type: CarType(id: "A", en: "suv", ar: "suv", ku: "suv"),
    ),
    location: CarLocation(
      lat: 0,
      long: 0,
      companyId: "C",
      townId: "T",
      radiusKm: 1,
      city: City(id: "A", en: "Test", ku: "Test", ar: "Test"),
      town: Town(id: "T", en: "test", ku: "test", ar: "test"),
    ),
    type: CarType(
      id: "A",
      en: "en",
      ar: "ar",
      ku: "ku",
      sort: 1,
      car: [],
      available: true,
    ),
    isFavorite: false,
    isViwed: false,
    promotion: promo ?? promotion(),
  );
  static CarUpdate carUpdate({Promotion? promo}) => CarUpdate(
    id: "A",
    title: "title",
    brand: Brand(
      id: "A",
      en: "test",
      ku: "A",
      ar: "A",
      image: "",
      sort: 0,
      cars: [],
    ),
    feature: Feature(
      id: "A",
      carId: "A",
      year: 2025,
      fuel: Fuel.diesel,
      transmission: Transmission.automatic,
      seat: 1,
      hp: 1,
      speed: 1,
      type: CarType(id: "A", en: "suv", ar: "suv", ku: "suv"),
    ),
    location: CarLocation(
      lat: 0,
      long: 0,
      companyId: "C",
      townId: "T",
      radiusKm: 1,
      city: City(id: "A", en: "Test", ku: "Test", ar: "Test"),
      town: Town(id: "T", en: "test", ku: "test", ar: "test"),
    ),
    type: CarType(
      id: "A",
      en: "en",
      ar: "ar",
      ku: "ku",
      sort: 1,
      car: [],
      available: true,
    ),
  );
  static Car detailsCar() => car().copyWith(
    bookings: [
      BookedDates(
        startDate: DateTime.parse("2025-06-07T14:36:06.200Z"),
        endDate: DateTime.parse("2025-06-07T14:36:06.200Z"),
      ),
      BookedDates(
        startDate: DateTime.parse("2025-07-07T14:36:06.200Z"),
        endDate: DateTime.parse("2025-08-07T14:36:06.200Z"),
      ),
    ],
    rentalPlan: [
      RentalPlan(
        id: "A",
        price: 2500,
        max: 12,
        min: 1,
        carId: "A",
        periodType: RentalPeriodType.hourly,
        plan: Plan(
          id: "A",
          en: "test",
          ku: "test",
          ar: "test",
          periodType: RentalPeriodType.hourly,
          sort: 1,
        ),
      ),
    ],
  );

  static CarPost carPost() => CarPost(
    car: carUpdate(),
    deletedImages: [],
    deletedRentalPlans: [],
    images: [
      XFile('test/assets/car.png'),
      XFile('test/assets/car.png'),
      XFile('test/assets/car.png'),
    ],
  );

  static Brand brandCars() => Brand(
    id: "A",
    en: "E",
    ku: "K",
    ar: "A",
    image: "https://kcars.com/bmw.png",
    cars: [car()],
  );

  static CarsCursor carsCursor() => CarsCursor(cursor: "A", companyId: "A");
}
