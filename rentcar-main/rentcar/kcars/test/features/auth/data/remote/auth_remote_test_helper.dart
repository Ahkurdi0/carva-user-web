import 'package:kcars/features/auth/data/model/auth.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/auth/data/model/role.dart';
import 'package:kcars/features/auth/data/remote/auth_remote.dart';

import 'auth_remote.mocks.mocks.dart';

class AuthRemoteTests {
  final mockApiService = MockApiService();
  late final AuthRemoteImpl authRemote;

  final auth = Auth(email: 'test@gmail.com', password: '123456789');

  final profile = Profile(
    id: 'AAAABBBBDD',
    userId: '1',
    name: 'Tester',
    email: 'test@gmail.com',
    phoneNumber: '77012345678',
    role: Role(roleId: 'AABBDD', roleName: 'user'),
    countryCode: '+964',
    permissions: [],
    accessToken: 'AABBDD',
    refreshToken: 'AABBDD',
  );

  AuthRemoteTests() {
    authRemote = AuthRemoteImpl(mockApiService);
  }
}
