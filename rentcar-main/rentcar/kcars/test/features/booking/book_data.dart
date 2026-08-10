import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/auth/data/model/role.dart';
import 'package:kcars/features/booking/data/model/book.dart';
import 'package:kcars/features/booking/data/model/enums.dart';
import 'package:kcars/features/booking/data/model/promo_code.dart';
import 'package:kcars/features/booking/data/model/promotion_result.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:kcars/features/car/data/model/paln.dart';
import 'package:kcars/features/car/data/model/rental_plan.dart';
import 'package:kcars/features/company/data/model/company.dart';

import '../car/utils/car_test_data.dart';

class BookData {
  static Book book() => Book(
    id: "AB123",
    startDate: DateTime.parse("2025-06-07T14:36:06.200Z"),
    endDate: DateTime.parse("2025-07-07T14:36:06.200Z"),
    basePrice: 0,
    totalPrice: 0,
    finalPrice: 0,
    status: BookStatus.pending,
    duration: 20,
    bookedAt: DateTime.parse("2025-06-07T13:36:06.200Z"),
    updatedAt: DateTime.parse("2025-06-07T13:36:06.200Z"),
    cancelReason: "test",
    car: CarTestData.car(),
    rentalPlan: RentalPlan(
      id: "A",
      available: true,
      carId: "A",
      price: 0,
      max: 12,
      min: 1,
      plan: plan(),
    ),
    company: Company(id: "A", name: "Test", review: 0, rate: 0),
    plan: plan(),
    promotion: CarTestData.promotion(),
  );

  static Book companyBook() => book().copyWith(
    profile: Profile(
      userId: "A",
      name: "A",
      email: "test@gmail.com",
      phoneNumber: "7701234567",
      role: Role(roleName: "user"),
      countryCode: "+964",
      permissions: [],
    ),
  );

  static Plan plan() => Plan(
    id: "A",
    en: "test",
    ku: "test",
    ar: "test",
    periodType: RentalPeriodType.hourly,
    sort: 1,
  );

  static PromotionResult promotionResult() => PromotionResult(
    discount: 20000,
    basePrice: 25000,
    totalPrice: 250000,
    finalPrice: 230000,
    periods: 10,
  );

  static PromoCode promoCode() => PromoCode(
    code: 'A',
    carId: 'A',
    companyId: 'A',
    rentalPlanId: 'A',
    planId: 'A',
    startDate: DateTime.now(),
    endDate: DateTime.now(),
  );
}
