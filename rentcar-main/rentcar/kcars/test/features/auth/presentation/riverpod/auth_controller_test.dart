import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kcars/features/auth/data/model/auth.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/auth/data/model/session.dart';
import 'package:kcars/features/auth/presentation/riverpod/auth_controller.dart';
import 'package:kcars/features/auth/presentation/riverpod/auth_states.dart';
import 'package:kcars/features/auth/presentation/riverpod/current_user_controller.dart';
import 'package:kcars/features/car/data/model/post_location.dart';
import 'package:kcars/features/car/presentation/riverpod/brand_cars.dart';
import 'package:kcars/features/car/presentation/riverpod/recently_viewed.dart';
import 'package:kcars/features/car/presentation/riverpod/suggested_controller.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../helper_tests.dart';
import '../../auth_test_data.dart';
import '../../fake_providers/fake_provider.dart';
import 'helper.dart';

class FakeCurrentUserController extends CurrentUserController {
  late TsetData _data;

  @override
  FutureOr<Profile?> build() async {
    _data = TsetData();
    return null;
  }

  @override
  Future<void> updateName(String name) async {
    state = AsyncValue.data(_data.profile.copyWith(name: name));
  }

  @override
  Future<void> updateEmail(String email) async {
    state = AsyncValue.data(_data.profile.copyWith(name: email));
  }

  @override
  Future<void> updateProfilePic(String image) async {
    state = AsyncValue.data(_data.profile.copyWith(image: image));
  }

  @override
  Future<void> updatePhone(Auth param) async {
    state = AsyncValue.data(
      _data.profile.copyWith(
        countryCode: param.countryCode,
        phoneNumber: param.phoneNumber,
      ),
    );
  }

  @override
  Future<void> verifyEmail(String email) async {
    state = AsyncValue.data(_data.profile);
  }

  @override
  Future<void> logout() async {
    state = AsyncValue.data(null);
  }

  @override
  Future<void> setUserData(Profile profile) async {
    state = AsyncValue.data(profile);
  }
}

void main() {
  late AuthRepoHelper h;
  late FakeCurrentUserController fakeCurrentUserController;
  late ProviderContainer container;
  // WidgetsFlutterBinding.ensureInitialized();
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  const MethodChannel oneSignalChannel = MethodChannel('OneSignal');
  const MethodChannel oneSignalUserChannel = MethodChannel(
    'OneSignal#user',
  ); // ✅ this is new

  setUpAll(() {
    registerEitherListFallback<Profile>();
    registerEitherVoidFallback();
    registerEitherFallback<Profile>();

    binding.defaultBinaryMessenger.setMockMethodCallHandler(oneSignalChannel, (
      MethodCall methodCall,
    ) async {
      switch (methodCall.method) {
        case 'login':
        case 'logout':
          return {};
        default:
          return {};
      }
    });

    // Mock OneSignal user channel - THIS IS CRUCIAL
    binding.defaultBinaryMessenger.setMockMethodCallHandler(
      oneSignalUserChannel,
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'getTags':
            // Return a non-null Map<dynamic, dynamic> exactly
            return <dynamic, dynamic>{
              'exampleTag': 'exampleValue',
              'anotherTag': 'anotherValue',
            };
          case 'addTagWithKey':
            // Returning null is fine for void-return methods
            return {};
          default:
            return {};
        }
      },
    );
  });
  tearDownAll(() {
    binding.defaultBinaryMessenger.setMockMethodCallHandler(
      oneSignalChannel,
      null,
    );
    binding.defaultBinaryMessenger.setMockMethodCallHandler(
      oneSignalUserChannel,
      null,
    );
  });
  setUp(() {
    h = AuthRepoHelper();
    fakeCurrentUserController = FakeCurrentUserController();
    container = ProviderContainer(
      overrides: [
        authControllerProvider.overrideWith(() {
          return AuthController.test(
            authRepo: h.mockAuthRepo,
            deviceInfo: h.mockDeviceInfo,
            secureStorage: h.mockSecureStorage,
          );
        }),
        currentUserControllerProvider.overrideWith(
          () => fakeCurrentUserController,
        ),
        recentlyViwedCarProvider.overrideWith(
          () => FakeRecentlyViewedProvider(),
        ),
        brandCarsProvider.overrideWith(() => FakeBrandCarsProvider()),
        suggestedCarProvider(
          PostLocation(),
        ).overrideWith(() => FakeSuggestionProvider()),
      ],
    );
  });
  tearDown(() {
    container.dispose();
  });
  group("Auth Controller Authentication", () {
    test("Should return Profile when login success", () async {
      final session = Session();

      when(h.mockDeviceInfo.getDeviceInfo()).thenAnswer((_) async => session);

      final expectedAuth = h.data.auth.copyWith(
        session: session,
        prefLang: "en",
      );

      when(
        h.mockAuthRepo.login(any),
      ).thenAnswer((_) async => Right(h.data.profile));

      when(h.mockSecureStorage.setData(any)).thenAnswer((_) async => true);
      when(
        h.mockSecureStorage.setSession(
          accessToken: anyNamed("accessToken"),
          refreshToekn: anyNamed("refreshToekn"),
        ),
      ).thenAnswer((_) async => true);

      final controller = container.read(authControllerProvider.notifier);

      expect(controller.state, isA<AuthInitial>());

      final future = controller.login(expectedAuth);

      expect(controller.state, isA<AuthLoading>());

      await future;

      expect(controller.state, isA<AuthCompleted>());
      expect((controller.state as AuthCompleted).profile, h.data.profile);
      await fakeCurrentUserController.setUserData(h.data.profile);
      expect((fakeCurrentUserController.state.value), h.data.profile);
      final setToken = await h.mockSecureStorage.setSession(
        accessToken: h.data.profile.accessToken,
        refreshToekn: h.data.profile.refreshToken,
      );
      // await OneSignal.login("A");
      // await OneSignal.User.getTags();
      // await OneSignal.User.addTagWithKey("appLang", "en");
      expect(setToken, true);
      verify(h.mockAuthRepo.login(expectedAuth)).called(1);
      verify(h.mockDeviceInfo.getDeviceInfo()).called(1);
      verify(
        h.mockSecureStorage.setData(any),
      ).called(1); // to confirm it was called
    });

    test("Should Return Profile when signup success", () async {
      final session = Session();

      final expectedAuth = h.data.auth.copyWith(
        session: session,
        prefLang: "en",
      );
      when(
        h.mockAuthRepo.signup(any),
      ).thenAnswer((_) async => Right(h.data.profile));

      when(h.mockDeviceInfo.getDeviceInfo()).thenAnswer((_) async => session);
      when(
        h.mockSecureStorage.setData(any),
      ).thenAnswer((_) async => Future.value(true));

      when(
        h.mockSecureStorage.setSession(
          accessToken: anyNamed("accessToken"),
          refreshToekn: anyNamed("refreshToekn"),
        ),
      ).thenAnswer((_) async => true);

      final controller = container.read(authControllerProvider.notifier);
      expect(controller.state, isA<AuthInitial>());
      final future = controller.signup(h.data.auth);
      expect(controller.state, isA<SignupLoading>());
      await future;
      expect(controller.state, isA<SignupCompleted>());
      expect((controller.state as SignupCompleted).profile, h.data.profile);
      await fakeCurrentUserController.setUserData(h.data.profile);

      expect((fakeCurrentUserController.state.value), h.data.profile);
      final setToken = await h.mockSecureStorage.setSession(
        accessToken: h.data.profile.accessToken,
        refreshToekn: h.data.profile.refreshToken,
      );

      expect(setToken, true);
      verify(h.mockAuthRepo.signup(expectedAuth)).called(1);
      verify(h.mockDeviceInfo.getDeviceInfo()).called(1);
      verify(h.mockSecureStorage.setData(any)).called(1);
    });

    test("Should Logout user", () async {
      final auth = h.data.auth.copyWith(allDevices: true);
      when(h.mockAuthRepo.logout(any)).thenAnswer((_) async => Right(null));
      when(h.mockSecureStorage.deleteAll()).thenAnswer((_) async {});
      final contrller = container.read(authControllerProvider.notifier);
      expect(contrller.state, isA<AuthInitial>());
      final future = contrller.logout(auth);

      expect(contrller.state, isA<LogoutLoading>());
      await future;
      expect(contrller.state, isA<LogoutCompleted>());
      verify(h.mockAuthRepo.logout(auth)).called(1);
      verify(h.mockSecureStorage.deleteAll()).called(1);
    });

    test("Should update account name", () async {
      final auth = h.data.auth.copyWith(name: "test");
      when(h.mockAuthRepo.updateName(any)).thenAnswer((_) async => Right(null));

      final controller = container.read(authControllerProvider.notifier);
      expect(controller.state, isA<AuthInitial>());
      final future = controller.updateName(auth);
      expect(controller.state, isA<UpdateNameLoading>());
      await future;
      expect(controller.state, isA<UpdateNameCompleted>());

      await fakeCurrentUserController.updateName("test");
      expect(fakeCurrentUserController.state.value?.name, equals("test"));

      verify(h.mockAuthRepo.updateName(auth)).called(1);
    });

    test("Should Updae [Email]", () async {
      final auth = h.data.auth.copyWith(
        countryCode: "+964",
        phoneNumber: "12345678",
      );
      when(
        h.mockAuthRepo.updatePhoneNumber(any),
      ).thenAnswer((_) async => Right(null));

      final controller = container.read(authControllerProvider.notifier);
      expect(controller.state, isA<AuthInitial>());
      final future = controller.updatePhoneNumber(auth);
      expect(controller.state, isA<UpdatePhoneLoading>());
      await future;
      expect(controller.state, isA<UpdatePhoneCompleted>());

      await fakeCurrentUserController.updatePhone(auth);
      expect(
        fakeCurrentUserController.state.value?.phoneNumber,
        equals("12345678"),
      );
      expect(
        fakeCurrentUserController.state.value?.countryCode,
        equals("+964"),
      );

      verify(h.mockAuthRepo.updatePhoneNumber(auth)).called(1);
    });
  });

  group("Verify Email", () {
    test("Should  Send OTP to [Email]", () async {
      final auth = h.data.auth;
      when(
        h.mockAuthRepo.verifyEmailSendOtp(any),
      ).thenAnswer((_) async => Right(null));

      final controller = container.read(authControllerProvider.notifier);
      expect(controller.state, isA<AuthInitial>());
      final future = controller.verifyEmailSendOtp(auth);
      expect(controller.state, isA<VerifyEamilSendOtpLoading>());
      await future;
      expect(controller.state, isA<VerifyEamilSendOtpCompleted>());

      verify(h.mockAuthRepo.verifyEmailSendOtp(auth)).called(1);
    });

    test("Should Verify OT of [Email]", () async {
      final auth = h.data.auth.copyWith(code: "123456");
      when(
        h.mockAuthRepo.verifyEmailVerifyOtp(any),
      ).thenAnswer((_) async => Right(null));

      final controller = container.read(authControllerProvider.notifier);
      expect(controller.state, isA<AuthInitial>());
      final future = controller.verifyEamilOtp(auth);
      expect(controller.state, isA<VerifyEamilVerifytpLoading>());
      await future;
      expect(controller.state, isA<VerifyEamilVerifytpCompleted>());
      await fakeCurrentUserController.verifyEmail(auth.email!);
      expect(fakeCurrentUserController.state.value?.email, auth.email);
      verify(
        h.mockAuthRepo.verifyEmailVerifyOtp(
          argThat(
            predicate<Auth>(
              (a) => a.email == auth.email && a.code == auth.code,
              "Send OTP with correct email",
            ),
          ),
        ),
      ).called(1);
    });
  });

  group("Reset Password", () {
    test("Should Send OTP to [Email]", () async {
      final auth = h.data.auth;
      when(
        h.mockAuthRepo.resetSendOtp(any),
      ).thenAnswer((_) async => Right(null));

      final controller = container.read(authControllerProvider.notifier);
      expect(controller.state, isA<AuthInitial>());
      final future = controller.resetSendOtp(auth);
      expect(controller.state, isA<ResetSendOtpLoading>());
      await future;
      expect(controller.state, isA<ResetSendOtpCompleted>());

      verify(
        h.mockAuthRepo.resetSendOtp(
          argThat(
            predicate<Auth>(
              (a) => a.email == auth.email,
              "Send OTP with correct email",
            ),
          ),
        ),
      ).called(1);
    });

    test("Should Verify OTP of [Email]", () async {
      final auth = h.data.auth.copyWith(code: "123456");
      when(
        h.mockAuthRepo.resetVerifyOtp(any),
      ).thenAnswer((_) async => Right(null));

      final controller = container.read(authControllerProvider.notifier);
      expect(controller.state, isA<AuthInitial>());
      final future = controller.resetVerifyOtp(auth);
      expect(controller.state, isA<ResetVerifyOtpLoading>());
      await future;
      expect(controller.state, isA<ResetVerifyOtpCompleted>());

      verify(
        h.mockAuthRepo.resetVerifyOtp(
          argThat(
            predicate<Auth>(
              (a) => a.email == auth.email && a.code == auth.code,
              'Verify with correct email and code',
            ),
          ),
        ),
      ).called(1);
    });

    test("Should Reset Password", () async {
      final auth = h.data.auth.copyWith(code: "123456");

      when(
        h.mockAuthRepo.resetPassword(any),
      ).thenAnswer((_) async => Right(null));

      final controller = container.read(authControllerProvider.notifier);
      expect(controller.state, isA<AuthInitial>());
      final future = controller.resetPassword(auth);
      expect(controller.state, isA<ResetPasswordLoading>());
      await future;
      expect(controller.state, isA<ResetPasswordCompleted>());

      verify(
        h.mockAuthRepo.resetPassword(
          argThat(
            predicate<Auth>(
              (a) => a.email == auth.email && a.code == auth.code,
              'Reset with correct email and code',
            ),
          ),
        ),
      ).called(1);
    });
    group("Account management", () {
      test("Should Logout", () async {
        final auth = h.data.auth.copyWith(allDevices: true);
        when(h.mockAuthRepo.logout(any)).thenAnswer((_) async => Right(null));

        final controller = container.read(authControllerProvider.notifier);
        expect(controller.state, isA<AuthInitial>());
        final future = controller.logout(auth);
        expect(controller.state, isA<LogoutLoading>());
        await future;
        expect(controller.state, isA<LogoutCompleted>());
        await fakeCurrentUserController.logout();
        expect(fakeCurrentUserController.state.value, null);
        verify(h.mockAuthRepo.logout(auth)).called(1);
      });
    });
  });
}
