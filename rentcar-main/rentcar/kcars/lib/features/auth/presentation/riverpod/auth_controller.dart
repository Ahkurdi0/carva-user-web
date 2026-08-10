import 'package:kcars/core/services/device_info_service.dart';
import 'package:kcars/core/services/secure_storage.dart';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/features/auth/data/model/auth.dart';
import 'package:kcars/features/auth/domain/repository/auth_repo.dart';
import 'package:kcars/features/auth/presentation/riverpod/auth_states.dart';
import 'package:kcars/features/auth/presentation/riverpod/current_user_controller.dart';
import 'package:kcars/features/car/presentation/riverpod/brand_cars.dart';
import 'package:kcars/features/car/presentation/riverpod/cars.dart';
import 'package:kcars/features/car/presentation/riverpod/nearby_cars.dart';
import 'package:kcars/features/car/presentation/riverpod/recently_viewed.dart';
import 'package:kcars/features/car/presentation/riverpod/suggested_controller.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  late final AuthRepo _authRepo;
  late final SecureStorage _secureStorage;
  late final DeviceInfoSerice _deviceInfo;

  AuthController._(this._authRepo, this._secureStorage, this._deviceInfo);

  factory AuthController.test({
    required AuthRepo authRepo,
    required SecureStorage secureStorage,
    required DeviceInfoSerice deviceInfo,
  }) {
    return AuthController._(authRepo, secureStorage, deviceInfo);
  }

  // Default constructor for production with get_it
  AuthController()
    : _authRepo = sl<AuthRepo>(),
      _secureStorage = sl<SecureStorage>(),
      _deviceInfo = sl<DeviceInfoSerice>();

  @override
  AuthStates build() {
    return AuthInitial();
  }

  Future<void> login(Auth param) async {
    state = AuthLoading();
    final session = await _deviceInfo.getDeviceInfo();

    param = param.copyWith(session: session, prefLang: param.prefLang);
    final result = await _authRepo.login(param);
    await result.fold<Future<void>>(
      (l) async {
        state = AuthFailed(l.message);
      },
      (r) async {
        await _secureStorage.setData(r);
        if (r.accessToken != null && r.refreshToken != null) {
          await _secureStorage.setSession(
            accessToken: r.accessToken!,
            refreshToekn: r.refreshToken!,
          );

          // final expiryDate = JwtDecoder.getExpirationDate(r.accessToken!);
          // await _secureStorage.setTokenExpiry(expiryDate.toIso8601String());
        }
        await ref.read(currentUserControllerProvider.notifier).setUserData(r);
        ref.invalidate(suggestedCarProvider);
        ref.invalidate(brandCarsProvider);
        ref.invalidate(recentlyViwedCarProvider);
        ref.invalidate(nearbayCarsProvider);
        ref.invalidate(carsProvider);
        await OneSignal.login(r.userId);
        await OneSignal.User.getTags();
        await OneSignal.User.addTagWithKey("appLang", param.prefLang ?? "en");
        state = AuthCompleted(r);
      },
    );
  }

  Future<void> signup(Auth param) async {
    state = const SignupLoading();
    final session = await _deviceInfo.getDeviceInfo();
    final newparam = param.copyWith(
      session: session,
      prefLang: "en",
      platform: session?.platform,
    );
    final result = await _authRepo.signup(newparam);
    await result.fold<Future<void>>(
      (l) async => state = SignupFailed(l.message),
      (r) async {
        await _secureStorage.setData(r);
        await ref.read(currentUserControllerProvider.notifier).setUserData(r);
        if (r.accessToken != null && r.refreshToken != null) {
          await _secureStorage.setSession(
            accessToken: r.accessToken!,
            refreshToekn: r.refreshToken!,
          );
        }
        ref.invalidate(suggestedCarProvider);
        ref.invalidate(brandCarsProvider);
        ref.invalidate(recentlyViwedCarProvider);
        ref.invalidate(nearbayCarsProvider);
        ref.invalidate(carsProvider);
        await OneSignal.login(r.userId);
        await OneSignal.User.getTags();
        await OneSignal.User.addTagWithKey("appLang", param.prefLang ?? "en");
        state = SignupCompleted(r);
      },
    );
  }

  Future<void> logout(Auth pram) async {
    state = const LogoutLoading();

    await _authRepo.logout(pram);
    await _secureStorage.deleteAll();

    ref.read(currentUserControllerProvider.notifier).logout();
    await OneSignal.logout();
    ref.invalidate(suggestedCarProvider);
    ref.invalidate(brandCarsProvider);
    ref.invalidate(nearbayCarsProvider);
    ref.invalidate(carsProvider);
    // ref.invalidate(recentlyViwedCarProvider);
    state = LogoutCompleted();
  }

  Future<void> deleteAccount() async {
    state = const DeleteAccountLoading();
    final result = await _authRepo.deleteAccount();
    await result.fold<Future<void>>(
      (l) async => state = DeleteAccountFailed(l.message),
      (r) async {
        await _secureStorage.deleteAll();
        await OneSignal.logout();
        state = const DeleteAccountCompleted();
      },
    );
  }

  Future<void> updateProfilePicture(Auth param) async {
    state = const UpdateProfilePicLoading();
    final result = await _authRepo.updateProfilePicture(param);
    result.fold((l) => state = UpdateProfilePicFailed(l.message), (r) async {
      await ref
          .read(currentUserControllerProvider.notifier)
          .updateProfilePic(r.imageUrl!);
      state = UpdateProfilePicCompleted();
    });
  }

  Future<void> updatePhoneNumber(Auth param) async {
    state = const UpdatePhoneLoading();
    final result = await _authRepo.updatePhoneNumber(param);
    await result.fold((l) async => state = UpdatePhoneFailed(l.message), (
      r,
    ) async {
      await ref.read(currentUserControllerProvider.notifier).updatePhone(param);
      state = const UpdatePhoneCompleted();
    });
  }

  Future<void> updateEmailSendOtp(Auth param) async {
    state = const UpdateEmailSendOtpLoading();
    final result = await _authRepo.updateEmailSendOtp(param);
    await result.fold<Future<void>>(
      (l) async => state = UpdateEmailSendOtpFailed(l.message),
      (r) async => state = const UpdateEmailSendOtpCompleted(),
    );
  }

  Future<void> updateEmailVerifyOtp(Auth param) async {
    state = const UpdateEmailVerifyOtpLoading();
    final result = await _authRepo.updateEmailVerifyOtp(param);
    await result.fold<Future<void>>(
      (l) async => state = UpdateEmailVerifyOtpFailed(l.message),
      (r) async {
        await ref
            .read(currentUserControllerProvider.notifier)
            .updateEmail(param.email!);
        state = const UpdateEmailVerifyOtpCompleted();
      },
    );
  }

  Future<void> updatePassword(Auth param) async {
    state = const UpdatePasswordLoading();
    final result = await _authRepo.updatePassword(param);
    await result.fold<Future<void>>(
      (l) async => state = UpdatePasswordFailed(l.message),
      (r) async => state = const UpdatePasswordCompleted(),
    );
  }

  Future<void> resetSendOtp(Auth param) async {
    state = const ResetSendOtpLoading();
    final result = await _authRepo.resetSendOtp(param);
    await result.fold<Future<void>>(
      (l) async => state = ResetSendOtpFailed(l.message),
      (r) async => state = const ResetSendOtpCompleted(),
    );
  }

  Future<void> resetVerifyOtp(Auth param) async {
    state = const ResetVerifyOtpLoading();
    final result = await _authRepo.resetVerifyOtp(param);
    result.fold(
      (l) => state = ResetVerifyOtpFailed(l.message),
      (r) => state = const ResetVerifyOtpCompleted(),
    );
  }

  Future<void> resetPassword(Auth param) async {
    state = const ResetPasswordLoading();
    final result = await _authRepo.resetPassword(param);
    result.fold(
      (l) => state = ResetPasswordFailed(l.message),
      (r) => state = const ResetPasswordCompleted(),
    );
  }

  Future<void> verifyEmailSendOtp(Auth param) async {
    state = const VerifyEamilSendOtpLoading();
    final result = await _authRepo.verifyEmailSendOtp(param);
    result.fold(
      (l) => state = VerifyEamilSendOtpFailed(l.message),
      (r) => state = const VerifyEamilSendOtpCompleted(),
    );
  }

  Future<void> verifyEamilOtp(Auth param) async {
    state = const VerifyEamilVerifytpLoading();
    final result = await _authRepo.verifyEmailVerifyOtp(param);
    await result.fold<Future<void>>(
      (l) async => state = VerifyEamilVerifytpFailed(l.message),
      (r) async {
        await ref
            .read(currentUserControllerProvider.notifier)
            .verifyEmail(param.email!);
        state = const VerifyEamilVerifytpCompleted();
      },
    );
  }

  Future<void> updateName(Auth param) async {
    state = const UpdateNameLoading();
    final result = await _authRepo.updateName(param);
    await result.fold<Future<void>>(
      (l) async => state = UpdateNameFailed(l.message),
      (r) async {
        await ref
            .read(currentUserControllerProvider.notifier)
            .updateName(param.name!);
        state = const UpdateNameCompleted();
      },
    );
  }

  Future<void> updatePrefLang(Auth param) async {
    state = const UpdatePrefLangLoading();
    final result = await _authRepo.updatePreflang(param);
    result.fold((l) => state = UpdatePrefLangFailed(l.message), (r) async {
      state = const UpdatePrefLangCompleted();
    });
  }

  Future<void> refreesh({bool isCheking = false}) async {
    state = const UpdatePrefLangLoading();
    final result = await _authRepo.refreshProfile();
    result.fold((l) => state = UpdatePrefLangFailed(l.message), (r) async {
      await ref.read(currentUserControllerProvider.notifier).setUserData(r);
      state = const UpdatePrefLangCompleted();
    });
  }

  Future<void> setOnBoarding() async {
    state = SetOnBoardingLoading();
    try {
      await _secureStorage.write("onboarding", "true");
      state = SetOnBoardingCompleted();
    } catch (e) {
      state = SetOnBoardingFailed(e.toString());
    }
  }
}
