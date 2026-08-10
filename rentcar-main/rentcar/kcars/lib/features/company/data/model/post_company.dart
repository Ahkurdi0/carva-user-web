import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/company/data/model/contact.dart';
import 'package:kcars/features/company/data/model/location.dart';
part 'post_company.mapper.dart';

@MappableClass()
class PostCompany with PostCompanyMappable {
  final File? image;
  final File? coverImage;
  final Company? company;
  final List<Contact>? newContacts;
  final List<Contact>? deletedContacts;
  final Location? location;

  PostCompany({
    this.image,
    this.coverImage,
    this.company,
    this.newContacts,
    this.deletedContacts,
    this.location,
  });
}
