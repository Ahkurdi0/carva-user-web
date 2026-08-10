import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/auth/data/model/role.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/review/data/model/car_review.dart';
import 'package:kcars/features/review/data/model/car_review_flag.dart';
import 'package:kcars/features/review/data/model/company_review.dart';
import 'package:kcars/features/review/data/model/company_review_flag.dart';
import 'package:kcars/features/review/data/model/cursor_review.dart';
import 'package:kcars/features/review/data/model/enums.dart';
import 'package:kcars/features/review/data/model/review_flag.dart';
import 'package:kcars/features/review/data/model/review_post.dart';
import 'package:kcars/features/review/data/model/updare_review.dart';

class ReviewData {
  static CarReview carReview() => CarReview(
    id: 'A',
    desc: 'A',
    rate: 1,
    reviewedAt: DateTime.parse("2025-06-07T14:36:06.200Z"),
    profile: profile(),
    status: ReviewStatus.pending,
  );
  static AllCursorReview allCursorReview() => AllCursorReview();
  static CarReview allCarReviews() =>
      carReview().copyWith(company: company(), car: car());

  static Profile profile() => Profile(
    id: 'A',
    userId: '1',
    name: 'Test',
    email: 'test@gmail.com',
    phoneNumber: '7701234567',
    countryCode: '+964',
    role: Role(roleName: 'user'),
    permissions: [],
  );

  static Company company() => Company(
    id: 'AAAABBBBDD',
    name: 'Test Company',
    review: 0,
    rate: 0,
    image: 'kcars.com/company.png',
    desc: "Best",
  );

  static CompanyReview companyReview() => CompanyReview(
    id: 'A',
    desc: 'A',
    rate: 1,
    company: company(),
    profile: profile(),
    status: ReviewStatus.pending,
    reviewedAt: DateTime.parse("2025-06-07T14:36:06.200Z"),
    updatedAt: DateTime.parse("2025-06-07T14:36:06.200Z"),
  );
  static CompanyReview allCompanyReviews() => companyReview().copyWith(
    company: companyReview().company?.copyWith(profile: profile()),
  );

  static Car car() => Car(
    id: "A",
    title: "A",
    rate: 0,
    review: 0,
    trips: 0,
    listedAt: DateTime.parse("2025-06-07T14:36:06.200Z"),
  );

  static CarReviewFlag carReviewFlags() => CarReviewFlag(
    id: "A",
    reviewId: 'A',
    flaggedAt: DateTime.parse("2025-06-07T14:36:06.200Z"),
    car: car(),
    review: carReview(),
  );

  static CompanyReviewFlag companyReviewFlags() => CompanyReviewFlag(
    id: "A",
    flaggedAt: DateTime.parse("2025-06-07T14:36:06.200Z"),
    company: company(),
    review: companyReview(),
  );

  static CursorReview cursorReview() => CursorReview(cursor: 'A', id: "A");
  static CursorReviewFlags cursorReviewFlag() => CursorReviewFlags(cursor: 'A');
  static UpdateReview updateReview() =>
      UpdateReview(id: 'A', status: ReviewStatus.accepted);
  static ReviewPost reviewPost() =>
      ReviewPost(carId: "A", rate: 1, desc: "A", companyId: "A");

  static ReviewFlag reviewFlag() =>
      ReviewFlag(reviewId: "A", carId: "A", companyId: "A");
}
