import 'dart:io';

import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/auth/data/model/role.dart';
import 'package:kcars/features/company/data/model/company_cursor.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/company/data/model/contact.dart';
import 'package:kcars/features/company/data/model/enums.dart';
import 'package:kcars/features/company/data/model/location.dart';
import 'package:kcars/features/company/data/model/post_company.dart';
import 'package:kcars/features/company/data/model/update_company.dart';

class CompanyData {
  static Company company() => Company(
    id: "A",
    name: "Test",
    image: "https://kcars.com/1.png",
    review: 0,
    rate: 0,
    contacts: [contact()],
    desc: "Test",
    profile: profile(),
    activeDate: DateTime.parse("2025-06-07T14:36:06.200Z"),
    expiresAt: DateTime.parse("2025-06-07T14:36:06.200Z"),
    location: Location(id: "A", lat: 0, long: 0),
  );
  static Profile profile() => Profile(
    userId: "A",
    name: "A",
    email: "test@gmail.com",
    phoneNumber: "0",
    role: Role(roleName: "user"),
    countryCode: "+964",
    permissions: [],
  );
  static Contact contact() => Contact(
    id: "A",
    countrCode: "+964",
    value: "7701234568",
    sort: 0,
    available: true,
    type: ContactTypes.phone,
  );
  static PostCompany postCompany() => PostCompany(
    company: Company(id: "A", name: "ABC", desc: "Best car ever"),
    image: File('test/assets/car.png'),
    newContacts: [Contact(value: "A")],
    deletedContacts: [Contact(id: "B")],
    location: Location(lat: 0, long: 0),
  );
  static CompanyCursor companyCursor() =>
      CompanyCursor(cursor: "A", id: "A", expired: true);

  static UpdateCompany? updateCompany() => UpdateCompany(
    image: "https://kcars.com/1.png",
    coverImage: "https://kcars.com/1.png",
  );
}
