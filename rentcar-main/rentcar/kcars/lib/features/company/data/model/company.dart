import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/company/data/model/contact.dart';
import 'package:kcars/features/company/data/model/location.dart';
import 'package:kcars/features/review/data/model/company_review.dart';
part 'company.mapper.dart';

@MappableClass()
class Company with CompanyMappable, CleanMapMixin {
  final String id;
  final String name;
  final String? desc;
  final String? image;
  final DateTime? expiresAt;
  final DateTime? activeDate;
  final DateTime? joinedAt;
  final double? review;
  final int? rate;
  final List<Contact>? contacts;
  final Location? location;
  final Profile? profile;
  final CompanyReview? reviews;
  final bool? reviewCompany;
  final int? cars;
  final bool? available;
  final int? serial;
  final String? companyId;
  final String? contact;
  final String? coverImage;
  final int? contacted;
  final bool? international;
  final bool? delivery;
  final int? total;
  Company({
    required this.id,
    required this.name,
    this.desc,
    this.image,
    this.expiresAt,
    this.activeDate,
    this.review,
    this.rate,
    this.contacts,
    this.location,
    this.profile,
    this.reviews,
    this.reviewCompany,
    this.cars,
    this.joinedAt,
    this.available,
    this.serial,
    this.companyId,
    this.contact,
    this.coverImage,
    this.contacted,
    this.international,
    this.delivery,
    this.total,
  });

  Company toDiff(Company original) {
    return Company(
      id: original.id,
      name: name == original.name ? "" : name,
      desc: desc == original.desc ? null : desc,
      joinedAt: null,
      companyId: null,

      location: location?.copyWith(
        id: null,
        town: null,
        city: null,
        lat: original.location?.lat == location?.lat ? -1 : location?.lat,
        long: original.location?.long == location?.long ? -1 : location?.long,
        cityId: original.location?.cityId == location?.cityId
            ? null
            : location?.cityId,
        townId: original.location?.townId == location?.townId
            ? null
            : location?.townId,
        createdAt: null,
        radiusKm: null,
      ),
      profile: profile,
      activeDate: (isSameDate(activeDate!, original.activeDate!))
          ? null
          : activeDate,
      expiresAt: (isSameDate(expiresAt!, original.expiresAt!))
          ? null
          : expiresAt,
      available: available == original.available ? null : available,
      contact: contact == original.contact ? null : contact,
      international: international == original.international
          ? null
          : international,
      delivery: delivery == original.delivery ? null : delivery,
      contacted: null,
    );
  }
}

bool isSameDate(DateTime a, DateTime b) =>
    a.toUtc().isAtSameMomentAs(b.toUtc());
