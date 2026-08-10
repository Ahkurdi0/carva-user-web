import 'package:kcars/core/services/secure_storage.dart';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/auth/data/model/auth.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_user_controller.g.dart';

@riverpod
class CurrentUserController extends _$CurrentUserController {
  late SecureStorage _secureStorage;
  @override
  FutureOr<Profile?> build() async {
    _secureStorage = sl<SecureStorage>();
    final Profile? user = await _secureStorage.getUserData();

    return user;
  }

  Future<void> updateName(String name) async {
    final newState = state.value?.copyWith(name: name);
    if (newState != null) {
      await _secureStorage.setData(newState);
    }
    state = AsyncData(newState);
  }

  Future<void> setUserData(Profile profile) async {
    await _secureStorage.setData(profile);
    state = AsyncData(profile);
  }

  void logout() async {
    state = AsyncData(null);
  }

  Future<void> updateProfilePic(String image) async {
    final newState = state.value?.copyWith(image: image);
    if (newState != null) {
      await _secureStorage.setData(newState);
    }
    state = AsyncData(newState);
  }

  Future<void> updateEmail(String email) async {
    final newState = state.value?.copyWith(email: email);
    if (newState != null) {
      await _secureStorage.setData(newState);
    }
    state = AsyncData(newState);
  }

  Future<void> updatePhone(Auth param) async {
    final newState = state.value?.copyWith(
      phoneNumber: param.phoneNumber,
      countryCode: param.countryCode,
    );
    if (newState != null) {
      await _secureStorage.setData(newState);
    }
    state = AsyncData(newState);
  }

  Future<void> verifyEmail(String email) async {
    final newState = state.value?.copyWith(
      email: email,
      emailVerifiedAt: DateTime.now(),
    );
    if (newState != null) {
      await _secureStorage.setData(newState);
    }
    state = AsyncData(newState);
  }
}
