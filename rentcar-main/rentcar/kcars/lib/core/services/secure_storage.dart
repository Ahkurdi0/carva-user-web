import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kcars/features/auth/data/model/profile.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  Future<bool> setData(Profile userData) async {
    try {
      await _storage.write(key: "kcarsuser", value: userData.toJson());
      return true;
    } catch (_) {
      return false;
    }
  }

  Future getUserData() async {
    try {
      final String? data = await _storage.read(key: "kcarsuser");

      if (data != null) {
        return ProfileMapper.fromJson(data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> setSession({
    required String accessToken,
    required String refreshToekn,
  }) async {
    try {
      await _storage.write(key: "kcarsAccessToken", value: accessToken);
      await _storage.write(key: "kcarsRefreshToken", value: refreshToekn);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<String?> getAcessToken() async {
    try {
      final accessToken = await _storage.read(key: "kcarsAccessToken");

      return accessToken;
    } catch (_) {
      return null;
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      final refreshToken = await _storage.read(key: "kcarsRefreshToken");

      return refreshToken;
    } catch (_) {
      return null;
    }
  }

  Future<void> setTokenExpiry(String expireTime) async {
    try {
      await _storage.write(key: "tokenExpireTime", value: expireTime);
    } catch (_) {}
  }

  Future<String?> getTokenExpiry() async {
    try {
      final expire = await _storage.read(key: "tokenExpireTime");
      return expire;
    } catch (_) {
      return null;
    }
  }

  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);
  Future<String?> read(String key) => _storage.read(key: key);
  Future<void> delete(String key) => _storage.delete(key: key);
  Future<void> deleteAll() => _storage.deleteAll();
}
