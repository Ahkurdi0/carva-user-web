import '../../auth_test_data.dart';
import 'auth_controller.mocks.mocks.dart';

class AuthRepoHelper {
  final MockAuthRepo mockAuthRepo = MockAuthRepo();
  final MockSecureStorage mockSecureStorage = MockSecureStorage();
  final MockDeviceInfoSerice mockDeviceInfo = MockDeviceInfoSerice();
  final TsetData data = TsetData();
}
