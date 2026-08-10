import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/auth/data/model/permissions.dart';
import 'package:kcars/features/auth/data/model/role.dart';

part 'profile.mapper.dart';

@MappableClass()
class Profile with ProfileMappable {
  final String? id;
  final int? serial;
  final String email;
  final String? phoneNumber;
  final String userId;
  final String? image;
  final DateTime? joinedAt;
  final String name;
  final String? userName;
  final DateTime? emailVerifiedAt;
  final DateTime? phoneVerifiedAt;
  final Role role;
  final List<Permissions> permissions;
  final String? countryCode;
  final Company? company;
  final String? accessToken;
  final String? refreshToken;
  const Profile({
    this.id,
    this.serial,
    required this.userId,
    required this.name,
    this.userName,
    required this.email,
    this.joinedAt,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    required this.phoneNumber,
    this.image,
    required this.role,
    required this.countryCode,
    required this.permissions,
    this.company,
    this.accessToken,
    this.refreshToken,
  });
}
