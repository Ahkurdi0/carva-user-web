import 'package:kcars/features/auth/data/model/permission.dart';
import 'package:kcars/features/auth/data/model/permissions.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/auth/data/model/role.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/company/data/model/location.dart';
import 'package:kcars/features/user/data/model/account_status.dart';
import 'package:kcars/features/user/data/model/post_role.dart';
import 'package:kcars/features/user/data/model/user_cursor.dart';

class UserData {
  static Profile profile() => Profile(
    id: 'AAAABBBBDD',
    userId: '1',
    name: 'Test User',
    email: 'test@gmail.com',
    phoneNumber: '',
    countryCode: '',
    accessToken: 'AABBDD',
    refreshToken: 'AABBDD',
    role: Role(roleId: 'AABBDD', roleName: 'user'),
    permissions: [],
  );

  static Profile profileWithCompany() => profile().copyWith(company: company());
  static Permissions permissions() => Permissions(
    permission: Permission(
      permissionId: 'A',
      permissionName: 'user',
      description: 'user_access',
    ),
  );
  static Company company() => Company(
    id: 'AABBDD',
    name: 'Test Company',
    image: 'https://kcars.com/1.png',
    activeDate: DateTime.parse("2025-06-07T14:36:06.200Z"),
    contacts: List.empty(),
    desc: "A",
    location: Location(id: "A", lat: 0, long: 0),
    rate: 0,
    review: 0,
    expiresAt: DateTime.parse("2025-06-07T14:36:06.200Z"),
  );

  static UserCursor userCursor() => UserCursor(roleName: 'user', cursor: "A");

  static AccountStatus accountStatus() => AccountStatus(
    id: "A",
    userId: "A",
    title: "Test",
    description: "Test",
    bannedAt: DateTime.parse("2025-06-07T14:36:06.200Z"),
    bannedUntil: DateTime.parse("2025-06-07T14:36:06.200Z"),
    profile: profile(),
  );
  static Role role() => Role(roleId: "A", roleName: "user");

  static PostRole postRole() =>
      PostRole(userId: "A", role: role(), permissions: [permissions()]);
}
