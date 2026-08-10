import 'package:kcars/features/auth/data/model/auth.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/auth/data/model/role.dart';
import 'package:kcars/features/auth/data/repository/auth_repo_impl.dart';

import 'auth_repo_impl.mocks.mocks.dart'; // import generated mocks

class AuthRepoTest {
  final MockAuthRemote mockAuthRemote = MockAuthRemote();
  late final AuthRepoImpl authRepo;

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

  // final auth = Auth(email: "test@gmail.com", password: "123456789");
  AuthRepoTest() {
    authRepo = AuthRepoImpl(mockAuthRemote);
  }
}
