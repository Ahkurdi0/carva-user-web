// test/helpers/auth_test_data.dart

import 'package:kcars/features/auth/data/model/auth.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/auth/data/model/role.dart';
import 'package:kcars/features/auth/data/model/session.dart';

class TsetData {
  final auth = Auth(email: 'test@gmail.com', password: '123456789');

  final profile = Profile(
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

  final session = Session();
}
